# -*- coding: utf-8 -*-
from hamcrest import assert_that, not_none
from air_pollution.config import configs
import pytest

test_data_stage = ["dev", "testing", "production", "staging", "default"]


@pytest.mark.parametrize("stage", test_data_stage)
def test_get_stage(stage):
    """Validate return stage default."""
    response = configs[stage]
    assert_that(response, not_none)
