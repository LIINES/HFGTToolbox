from typing import Annotated, Optional
import typer
from hfgt_toolbox.HFGTToolbox import GIS2SysMLFile, GISDirectory2SysMLFile, runHFGTAnalysis


app = typer.Typer(
    name="HFGT Toolbox",
    help="Conduct analyses using the Heterofunctional Graph Theory Toolbox",
    add_completion=False,
)

@app.command()
def gis_to_sysml(
    input_filepath: Annotated[str, typer.Argument(
        help="the path of the input data file.", metavar="[e.g. examples/gis-to-sysml/Transmission_Substations.csv]")],
    output_filepath: Annotated[str, typer.Argument(
        help="the path of output the data.", metavar="[e.g. examples/gis-to-sysml/model.sysml]")],
    idx_column_name: Annotated[Optional[str], typer.Argument(
        help="The name of the index column (which uniquely identifies each row).", metavar="[e.g. name]")] = "id",
    my_class: Annotated[Optional[str], typer.Argument(
        help="This string will become the name of the class associated with GIS Data File.", metavar="[e.g. Substation]")] = "myClass",
):
    """
    Convert a file containing GIS data (in either CSV or Shapefile format) into a 
    single .sysml file. 

    Args:
        input_filepath (str): the path of the input data file.
        output_filepath (str): the path of output the data.
        idx_column_name (str): The name of the index column (which uniquely identifies
           each row).
        my_class (str): This string will become the name of the class
            associated with GIS Data File.
    """
    GIS2SysMLFile(input_filepath, output_filepath, my_class, idx_column_name)

@app.command()
def gis_dir_to_sysml(
    input_directory: Annotated[str, typer.Argument(
        help="the path of the input data directory.", metavar="[e.g. examples/gis-dir-to-sysml]")],
    output_filepath: Annotated[str, typer.Argument(
        help="the path of output the data.", metavar="[e.g. examples/gis-dir-to-sysml/model.sysml]")],
    idx_column_name: Annotated[Optional[str], typer.Argument(
        help="The name of the index column (which uniquely identifies each row).", metavar="[e.g. name]")] = "id",
    my_class: Annotated[Optional[str], typer.Argument(
        help="This string will become the name of the class associated with GIS Data File.", metavar="[e.g. Substation]")] = "myClass",   
):
    """
    Convert all GIS files (.csv and .shp) in the specified directory into to a single
    .sysml file.

    Each file is represented as a Package within the overarching 'Model'
    Package, with its own parts and part defs.
    Note that the class name needs to be the same for every file, and the
    idx_column name must also be the same for every file.

    Typer is used to allow this function to be called via command line without needing
    to deal with *args etc, checking the number of arguments, etc.

    Args:
        input_directory (str):  the path of the input data folder.
        output_filepath (str):  the path of output the data.
        idx_column_name (Optional, str): The name of the index column (which uniquely identifies
           each row).
        my_class (Optional, str): This string will become the name of the class
            associated with GIS Data File.
    """
    GISDirectory2SysMLFile(input_directory, output_filepath, my_class, idx_column_name)

@app.command()
def hfgt_analysis(
    input_filepath: Annotated[str, typer.Argument(
        help="The path of the input data file.", metavar="[e.g. examples/hfgt-analysis/ExampleNetwork-Defaultxml-Base-2026-02-08.xml]")],
    output_directory: Annotated[Optional[str], typer.Argument(
        help="The path in which to save the output data that is produced via the Python code.",
        metavar="[e.g. examples/hfgt-analysis/output_python]")] = "3_PyHFGT_Output_Data/",
    output_julia_directory: Annotated[Optional[str], typer.Argument(
        help="The path in which to save the output data that is produced via the Julia code.",
        metavar="[e.g. examples/hfgt-analysis/output_python]")] = "4_JuliaHFGT_Output_Data/",
    ):
    """Runs HFGT analysis using the provided input file path.
    
    Args:
        input_filepath (str): The path of the input data file.
        output_directory (Optional, str): The path in which to save the output data that is produced via the Python code.
        output_julia_directory (Optional, str): The path in which to save the output data that is produced via the Julia code.

    """
    myLFES = runHFGTAnalysis(input_filepath, output_directory, output_julia_directory)

@app.command()
def hfgt_structural_analysis(
    input_filepath: Annotated[str, typer.Argument(
        help="The path of the input data file.", metavar="[e.g. examples/hfgt-structural-analysis/3_NEAC-freight-Defaultxml-Base-2026-02-17.xml]")],
    output_directory: Annotated[Optional[str], typer.Argument(
        help="The path in which to save the output data that is produced via the Python code.",
        metavar="[e.g. examples/hfgt-structural-analysis/output_python]")] = "3_PyHFGT_Output_Data/",
    output_julia_directory: Annotated[Optional[str], typer.Argument(
        help="The path in which to save the output data that is produced via the Julia code.",
        metavar="[e.g. examples/hfgt-structural-analysis/output_python]")] = "4_JuliaHFGT_Output_Data/",
):
    """Runs HFGT structural analysis using the provided input file path.
    
    Args:
        input_filepath (str): The path of the input data file.
        output_directory (Optional, str): The path in which to save the output data that is produced via the Python code.
        output_julia_directory (Optional, str): The path in which to save the output data that is produced via the Julia code.
    
    """  
    myLFES = runHFGTStructuralAnalysis(input_filepath, output_directory, output_julia_directory)

if __name__ == "__main__":
    app()