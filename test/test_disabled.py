import pytest
import tftest


@pytest.fixture
def plan():
    tf = tftest.TerraformTest(tfdir="test/tf")
    tf.setup()
    return tf.plan(output=True, tf_vars={
        "enabled": "false",
        "config_disabled": "true",
        "log_disabled": "true",
        "ssm_disabled": "true"
    })


def test_plan(plan):
    """Ensure that no resources are created when the module is disabled
    """
    assert len(plan.resource_changes) == 0
