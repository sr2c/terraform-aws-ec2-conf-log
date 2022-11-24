import pytest
import tftest
from pathlib import Path


@pytest.fixture
def plan():
    file_path = Path(__file__).resolve()
    base_dir = file_path.parent.parent.absolute()
    tf = tftest.TerraformTest(tfdir="test/disabled")
    tf.setup()
    return tf.plan(output=True)


def test_plan(plan):
    """Ensure that no resources are created when the module is disabled
    """
    assert len(plan.resources) == 0
