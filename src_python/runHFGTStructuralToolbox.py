"""
This file simply calls the hfgt_structural_analysis function from the CLI.
I (MS) have included it so that people who wish to run the
toolbox the same way as before uv was added can still do so.
"""
import sys

from hfgt_toolbox.cli.main import hfgt_structural_analysis

if __name__ == '__main__':
    hfgt_structural_analysis(*sys.argv[1:])