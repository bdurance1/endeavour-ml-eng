"""
TODO
"""

import logging.config

from constants.misc import LOGGER_NAME
from log_manager.format import ApplicationLogFormatter
from log_manager.format import DEFAULT_LOGGING_FORMAT

app_logger = logging.getLogger(LOGGER_NAME)

_log_level = logging.DEBUG

app_logger.setLevel(_log_level)
_std_log_formatter = logging.Formatter(DEFAULT_LOGGING_FORMAT)

_stream_channel = logging.StreamHandler()
_stream_channel.setLevel(_log_level)
_stream_channel.setFormatter(ApplicationLogFormatter())

app_logger.addHandler(_stream_channel)


def set_log_level(level: int) -> None:
    """
    Set's the applications log level.
    :param level:
    :return:
    """
    global _log_level
    _log_level = level
