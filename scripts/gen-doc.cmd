:: Generates HTML docs
mkdir docs\source\_static
pyreverse --output-directory docs/source/_static --output html src/python_hfgt_toolbox src/config
pip-licenses -f md > docs\source\licenses.md
sphinx-apidoc -o docs\source src\
sphinx-build -b html docs\source docs\build
start docs\build\index.html
