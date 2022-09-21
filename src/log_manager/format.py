"""
TODO
"""

import logging

class ApplicationLogFormatter(logging.Formatter):
    """
    TODO
    """

    info_format: str = None
    debug_format: str = None

    def __init__(self):
        super().__init__(fmt=DEFAULT_LOGGING_FORMAT, datefmt=None, style='%')

    def format(self, record: logging.LogRecord) -> str:
        format_original = self._style._fmt

        if record.levelno == logging.DEBUG:
            self._style._fmt = DEBUG_LOGGING_FORMAT

        result = logging.Formatter.format(self, record)

        self._style._fmt = format_original
        return result


DEBUG_LOGGING_FORMAT = "%(asctime)s :: %(name)s :: %(levelname)s :: " \
    "[ file %(filename)s: line %(lineno)s : function %(funcName)s ] :: %(message)s"
DEFAULT_LOGGING_FORMAT = "%(asctime)s :: %(name)s :: %(levelname)s :: %(message)s"
