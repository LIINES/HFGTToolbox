# Set the working dir to the project root
import os
import pathlib

from loguru import logger

proj_root = (pathlib.Path(__file__) / '../../..').resolve()
os.chdir(proj_root.resolve())
logger.debug(f'Working directory set to {proj_root}')
