# Python-HFGT-Toolbox (Python Heterofunctional Graph Theory Toolbox)

## Requirements and installation

Before proceeding, ensure you have Python 3.11.9 (or newer) installed.

### Installing via a terminal window

To install and run the toolbox via a terminal window, open up a terminal window in the root directory of this repository. Then, install `uv`, which manages the Python dependencies of this repository:

    pip install uv

You can also see [here](https://docs.astral.sh/uv/getting-started/installation/) for an alternative method of installing `uv`. 

Once you have installed `uv` as above, you can install this package via the following:

    uv sync

### Installing within Pycharm/VSCode

The process of installing and running the Toolbox within an IDE (e.g. Pycharm or VSCode) is fairly similar to the above. You'll need to open this folder within your IDE, then open a terminal window. To do this:

- In **VSCode**, in the top-left menu go to `File -> Open Folder` and select the folder containing this repository (`python-hfgt-toolbox`). Open a new terminal window (if one is not already open) via `View -> Terminal`.
- In **Pycharm**, in the top-left menu go to `Open`, then select the folder containing this repository. Open a new terminal window via `View -> Tool Windows -> Terminal`.

Once your terminal window is open, you can follow the "Installing via a terminal window" commands above. All of the subsequent commands outlined in the following sections can be run within the terminal window inside the IDE.

### Additional requirements for Minimum Cost Flow problems

For the full functionality of the toolbox, namely to be able to process minimum cost flow problems (i.e. input files where `analysisMethod` = `HFNMCF`), you will also need to install:

 - Julia. See [here](https://docs.julialang.org/en/v1/manual/installation/).
 - IBM CPLEX. See [here](https://www.ibm.com/docs/en/icos/22.1.2?topic=cplex-installing).
 - Gurobi. See [here](https://support.gurobi.com/hc/en-us/articles/4534161999889-How-do-I-install-Gurobi-Optimizer).

Note that both CPLEX and Gurobi require licenses to use. They are optional dependencies - if they are not installed, you will still be able to use the `HiGHS` solver.

**Instantiating the Julia package**

Prior to running any `HFNMCF`-related toolbox analyses, you will need to instantiate the `HFNMCFTools` package to install all of the non-optional dependencies. To do this, open up the `src_julia` folder in a terminal window and run:

```julia
julia --project=HFNMCFTools -e "using Pkg; Pkg.instantiate()"
```

**IBM CPLEX**

To install the Julia library for CPLEX, install it into your *global* Julia environment via:

```julia
julia -e "using Pkg; Pkg.add(\"CPLEX\")"
```

**Gurobi**

To install the Julia library for Gurobi, install it into your *global* Julia environment via:

```julia
julia -e "using Pkg; Pkg.add(\"Gurobi\")"
```

If you need to install a specific version of `Gurobi` to match your local Gurobi license file, you can install a specific version of `Gurobi_jll` (e.g. `11.0.3`) via the following:

```julia
julia -e 'using Pkg; Pkg.add(name="Gurobi_jll", version="11.0.3")'
```

## Repository structure

```
python-hfgt-toolbox/
├── 1_Cleaned_Raw_Data            # Raw data directory
├── 2_PyHFGTInput_Data            # Default Input data directory
├── 3_PyHFGT_Output_Data          # Default Python output directory
├── 4_JuliaHFGT_Output_Data       # Default Julia output directory
├── docs/
│   ├── build/                    # The built HTML documentation files
│   ├── source/                   # The source used to build the documentation
│   └── README.md                 # Readme explaining documentation and process
├── examples/
│   ├── gis-dir-to-sysml/         # Example GIS directory to SysML dataset(s)
│   ├── gis-to-sysml/             # Example GIS to SysML dataset(s)
│   ├── hfgt-analysis/            # Example HFGT analysis dataset(s)
│   └── hfgt-structural-analysis/ # Example HFGT structural analysis dataset(s)
├── images/
├── license/
├── logs/                         # Logging output will be saved here
├── src_julia/                    # Julia code
├── src_python/hfgt-toolbox/
│   ├── cli/                      # Command Line Interface code
│   ├── HFGTToolbox.py            # Main Python file
│   └── logging.py                # Helper functions related to logging
└── tests/
    ├── resources/                # Data used within the tests
    ├── conftest.py               # Pytest fixtures
    ├── test_hfgt_toolbox.py      # Main test file
    └── utils.py                  # Test helpers/utility functions
```

## Running the toolbox

You can interact with the toolbox via `uv`. A list of available commands can be seen by running:

    uv run toolbox --help

More detail on these commands below.

### HFGT Analysis

You can run the Heterofunctional Graph Theory analysis by running `uv run toolbox hfgt-analysis <input_file>`. To see a full explanation, run:

    uv run toolbox hfgt-analysis --help

By default, the data will be exported to `data/3_PyHFGT_Output_Data` (for the data produced via the Python code) and `data/4_JuliaHFGT_Output_Data` (for the data produced via the Julia code). There are optional `output_directory` and `julia_output_directory` arguments that allow you to overwrite these.

#### Simple example

Here is an example of running a HFGT analysis:

    uv run toolbox hfgt-analysis \
        examples/hfgt-analysis/ExampleNetwork-Defaultxml-Base-2026-03-12.xml \
        examples/hfgt-analysis/output_python

Note - we have not overridden the `julia_output_directory` here (i.e. no need for a third argument) as this example is not a `HFNMCF` problem, and thus will not produce Julia output.

#### Example using Julia optimisation

Here is another example, this time with a `HFNMCF` analysis method. You will need to have instantiated the Julia package as described above prior to running it. It uses the `HiGHS` solver. To run it:

    uv run toolbox hfgt-analysis \
        examples/hfgt-analysis/ExampleNetworkNoOperandNetsHFNMCF-Defaultxml-Base-2026-03-12.xml \
        examples/hfgt-analysis/output_python \
        examples/hfgt-analysis/output_julia

⚠️ Note that the filenames used in these examples may differ from what is written here when you run these examples. If you get an error about the filename being incorrect, you'll need to have a look in the `examples/` folder and adjust the command to the actual filename. The reason for this is that the toolbox automatically archives files (i.e. moves them into an adjacent `Archive` folder), and then renames them, where the last 10 characters do not match the date of the most recent git commit. This goes for the HFGT Structural Analysis below as well.

### HFGT Structural Analysis

Running the HFGT Structural Analysis is similar to the above. To see a full explanation, run:

    uv run toolbox hfgt-structural-analysis --help
    
Here is an example of running a HFGT structural analysis:

    uv run toolbox hfgt-structural-analysis \
        examples/hfgt-structural-analysis/NEAC-freight-Defaultxml-Base-2026-03-12.xml \
        examples/hfgt-structural-analysis/output_python

### GIS to SysML

The toolbox can also convert GIS-based data (`.csv` or `.shp`) into a SysML-v2 compliant text file. For more information on how to run this command, type:

    uv run toolbox gis-to-sysml --help

For example, the following will convert the small example substations CSV dataset into a SysML file:

    uv run toolbox gis-to-sysml examples/gis-to-sysml/Transmission_Substations.csv examples/gis-to-sysml/model.sysml "name" "Substation"

### GIS Directory to SysML

You can also convert a directory of GIS files (`.csv` or `.shp`) into a single SysML file using the toolbox. For more information on how to run this command, type:

    uv run toolbox gis-dir-to-sysml --help 
    
Here is an example:

    uv run toolbox gis-dir-to-sysml examples/gis-dir-to-sysml examples/gis-dir-to-sysml/model.sysml "name" "Substation"

This will process all three `.csv` files in the directory and produce `model.sysml`.

## Logs

Logs created during the execution of the program are saved to `logs/`. These capture all levels of logging output, regardless of whether `verboseMode` is set to `true` in your input file.

## Running the tests

To run the Pytest suite:

    uv run pytest

To run with a coverage report (HTML report written to `/htmlcov/index.html`):

    uv run pytest --cov=hfgt_toolbox --cov-report=term-missing --cov-report=html

## Generating the documentation

To build the Sphinx documentation, first generate the API documentation via `sphinx-apidoc`:

    uv run sphinx-apidoc --module-first -f -o docs/source src_python --force --separate

Then build the documentation:

    uv run sphinx-build -b html docs/source docs/build