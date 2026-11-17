"""
This file simply calls the gis_dir_to_sysml function from the CLI.
I (MS) have included it so that people who wish to run the
toolbox the same way as before uv was added can still do so.
"""
import sys

from hfgt_toolbox.cli.main import gis_dir_to_sysml

if __name__ == '__main__':
    gis_dir_to_sysml(*sys.argv[1:])