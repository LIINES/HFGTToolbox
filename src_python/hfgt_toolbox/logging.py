"""Module to initialise loguru console and file loggers. Also provides
two log_entry_exit functions to assist with the traceability of the code.
@author Michael Stewart
"""
import os
import sys
from functools import wraps
from loguru import logger

# Remove all existing handlers to start fresh
logger.remove()

# Re-add stderr with INFO as the minimum threshold.
# This means that when verboseMode = false, only
# INFO logs and above will be printed to the console.
stderr_handler = logger.add(sys.stderr, level="INFO")

def add_file_logger(experiment_name: str):
    """
    Add a logger that outputs to logs/.
    These logs will capture all output.

    Args:
        experiment_name: The name of the experiment (input file),
            which will be appended to the log filename.

    """

    if os.getenv("ENABLE_FILE_LOGGING", "true").lower() == "true":
        logger.add(f"logs/log_{experiment_name}" + "___{time:YYYY-MM-DD-HH-mm-ss}.log", level="TRACE")

def update_logging_level(level: str):
    """Update the logging level of the stderr_handler to the
    desired level.

    Args:
        level (str): The logging level to update to, e.g. "DEBUG".
    """
    global stderr_handler
    # Remove the existing stderr_handler.
    # (It is immutable, so it needs to be removed
    # to update the logging level).
    try:
        logger.remove(stderr_handler)
    except ValueError:
        pass
    # Add a new stderr logger with DEBUG as the minimum threshold.
    # Note we do not redefine console_logger. This change only
    # happens once so redefining it is not necessary.
    stderr_handler = logger.add(sys.stderr, level=level)


def log_entry_exit_info(func):
    """Decorator that logs entry and exit of a function with indentation based
    on call depth. Intended to be a cleaner replacement for
    'print("I am entering/exiting...")' at the start and end of every function.
    
    This function was written by Microsoft Copilot.
    """
    @wraps(func)
    def wrapper(*args, **kwargs):
        logger.info(f"I am entering {func.__name__}()")
        try:
            result = func(*args, **kwargs)
        finally:
            logger.info(f"I am exiting {func.__name__}()")
        return result
    return wrapper

def log_entry_exit_trace(func):
    """Similar to log_entry_exit above.
    MS: I split these functions because originally, some functions
    had "if verboseMode: " around the "I am entering..." and "I am
    exiting..." print statements. Those functions use this
    function, whereas the ones that did not use log_entry_exit_info above.
    """
    @wraps(func)
    def wrapper(*args, **kwargs):
        logger.trace(f"I am entering {func.__name__}()")
        try:
            result = func(*args, **kwargs)
        finally:
            logger.trace(f"I am exiting {func.__name__}()")
        return result
    return wrapper