import logging

import google.cloud.logging


def get_logger(level: int = logging.DEBUG) -> logging.Logger:
    """Create a logger with the specified log level.

    Args:
    ----
        level (int, optional): The log level to set for the logger.
                               Defaults to logging.DEBUG.

    Returns:
    -------
        logging.Logger: The logger with the specified log level.

    """
    client = google.cloud.logging.Client()
    client.setup_logging()
    logger = logging.getLogger()
    logger.setLevel(level)

    return logger
