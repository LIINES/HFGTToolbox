# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

import os 
import sys 
sys.path.insert(0, os.path.abspath("../../"))
sys.path.insert(0, os.path.abspath("../../../"))

project = 'HFGTToolbox'
copyright = '2025, Prof Amro Farid'
author = 'Prof Amro Farid'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ['sphinx.ext.autodoc', "sphinx.ext.napoleon", 'sphinx_autodoc_typehints']

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# sphinx-autodoc-typehints options
autodoc_typehints = "none"
always_document_param_types = True
typehints_defaults = "comma"

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = "sphinx_rtd_theme"
html_static_path = ['_static']


