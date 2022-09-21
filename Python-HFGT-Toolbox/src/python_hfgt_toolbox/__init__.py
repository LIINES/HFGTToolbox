# Set the working dir to the project root
import os
import pathlib

proj_root = (pathlib.Path(__file__) / '../../..').resolve()
os.chdir(proj_root.resolve())
