import pytest
import tftest


@pytest.fixture
def plan():
    tf = tftest.TerraformTest(tfdir="test/tf")
    tf.setup()
    return tf.plan(output=True, tf_vars={
        "enabled": "true",
        "config_disabled": "false",
        "log_disabled": "true",
        "ssm_disabled": "false"
    })


def test_log_disabled(plan):
    """Ensure that no S3 log_buckets are present if disable_log_bucket is true
    """

    no_log_buckets = True
    conf_buckets = False
    ssm = False

    for resource in plan.resource_changes.values():
        if resource["type"] == "aws_s3_bucket":
            if resource["module_address"] == "module.conf_log.module.log_bucket":
                no_log_buckets = False
            if resource["module_address"] == "module.conf_log.module.conf_bucket":
                conf_buckets = True
        elif resource["type"] == "aws_iam_role_policy_attachment" and resource["name"] == "ssm_core":
            ssm = True

    assert ssm and conf_buckets and no_log_buckets
