import pytest
import tftest


@pytest.fixture
def plan():
    tf = tftest.TerraformTest(tfdir="test/disabled")
    tf.setup()
    return tf.plan(output=True)


def test_plan(plan):
    """Ensure that no resources are created when the module is disabled
    """
    assert len(plan.resource_changes) == 0
