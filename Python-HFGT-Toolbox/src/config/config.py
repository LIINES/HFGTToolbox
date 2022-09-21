'''
This is a config file (written in python) used for runtime configuration.
'''

import os
import sys

out_dir = './output'

# See https://github.com/Delgan/loguru#suitable-for-scripts-and-libraries
# From loguru import Record, RecordFile # See these classes for all the available format strings
# Usage:
# In a main function, configure using:
#   from loguru import logger
#   logger.configure(**logger_config.logging)
# Everywhere else, just import:
#   from loguru import logger
format_str = "<green>{time:YYYY-MM-DD HH:mm:ss.SSS}</green> | <level>{level: <8}</level> : <level>{message}</level> " \
             "(<cyan>{name}:{thread.name}:pid-{process}</cyan> \"<cyan>{file.path}</cyan>:<cyan>{line}</cyan>\")"
logging = {
    "handlers": [
        {"sink": sys.stdout, "level": "DEBUG",
            "diagnose": False, "format": format_str},
        {"sink": out_dir + f"/log{os.getpid()}.log", "enqueue": True, "mode": "a+", "level": "DEBUG", "colorize": False, "serialize": True, "diagnose": False, "rotation": "10 MB",
         "compression": "zip"}
    ]
}
