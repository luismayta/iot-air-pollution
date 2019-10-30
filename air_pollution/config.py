# -*- coding: utf-8 -*-
from environs import Env

env = Env()
env.read_env()


class Config:
    HOST = env.str("HOST_MQTT")
    ROOT_CA_PATH = env.str("ROOT_CA_PATH")
    CERTIFICATE_PATH = env.str("CERTIFICATE_PATH")
    PRIVATE_KEY_PATH = env.str("PRIVATE_KEY_PATH")
    DB_URL = env.str("DB_URL")


class StagingConfig(Config):
    """Config for staging."""

    ENVIRONMENT = "STAGING"


class ProductionConfig(Config):
    """Config for production."""

    ENVIRONMENT = "PRODUCTION"


class DevelopmentConfig(Config):
    """Config for Development."""

    ENVIRONMENT = "DEVELOPMENT"
    DEBUG = True


class TestingConfig(Config):
    """Config for Testing."""

    ENVIRONMENT = "DEVELOPMENT"
    DEBUG = True
    TESTING = True


configs = {
    "dev": DevelopmentConfig,
    "testing": TestingConfig,
    "production": ProductionConfig,
    "staging": StagingConfig,
    "default": DevelopmentConfig,
}
