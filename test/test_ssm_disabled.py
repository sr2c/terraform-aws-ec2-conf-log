import pytest
import tftest


@pytest.fixture
def plan():
    tf = tftest.TerraformTest(tfdir="test/ssm_disabled")
    tf.setup()
    return tf.plan(output=True)


def test_ssm_disabled(plan):
    """Ensure that no S3 SSM policy attachments are present if disable_ssm is true
    """

    log_buckets = False
    conf_buckets = False
    no_ssm = True

    for resource in plan.resource_changes.values():
        if resource["type"] == "aws_s3_bucket":
            if resource["module_address"] == "module.conf_log.module.log_bucket":
                log_buckets = True
            if resource["module_address"] == "module.conf_log.module.conf_bucket":
                conf_buckets = True
        elif resource["type"] == "aws_iam_role_policy_attachment" and resource["name"] == "ssm_core":
            no_ssm = False

    assert no_ssm and conf_buckets and log_buckets
