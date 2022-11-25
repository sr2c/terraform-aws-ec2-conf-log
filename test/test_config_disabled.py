import pytest
import tftest


@pytest.fixture
def plan():
    tf = tftest.TerraformTest(tfdir="test/config_disabled")
    tf.setup()
    return tf.plan(output=True)


def test_config_disabled(plan):
    """Ensure that no S3 conf_buckets are present if disable_configuration_bucket is true
    """
    no_conf_buckets = True
    log_buckets = False
    ssm = False

    for resource in plan.resource_changes.values():
        if resource["type"] == "aws_s3_bucket":
            if resource["module_address"] == "module.conf_log.module.conf_bucket":
                no_conf_buckets = False
            elif resource["module_address"] == "module.conf_log.module.log_bucket":
                log_buckets = True
        elif resource["type"] == "aws_iam_role_policy_attachment" and resource["name"] == "ssm_core":
            ssm = True

    assert ssm and log_buckets and no_conf_buckets
