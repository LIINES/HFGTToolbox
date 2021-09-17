# Dakota Thompson
# LIINES AMES

# Read KML files exported from QGIS into an Electric Grid object
# From the electric grid object, export a HFGT-compatible XML file
import sys
from elec.ElecGrid import ElecGrid

def elec_kml_to_hfgt_xml(file_out):
	"""
	Method to convert KML files into a HFGT compliant XML
	inputs:
	- file_out: name of the output xml file as a string
	"""
	exported_files = [
			'US_Elec_Gen_Units.kml',
			'US_Elec_PowerPlants.kml',
			'US_Elec_Substations.kml',
			'US_Elec_Transmission_Lines.kml',
			]
	# Directory to find the KML files listed above
	rootDir = ''

	# create an ElecGrid object
	grid = ElecGrid()
	# Populate the elecGrid from KML files
	grid.read_in_kml(exported_files, rootDir)
	# remove any isolated nodes
	grid.remove_isolated()
	# Remove any subcomponents
	grid.remove_subComps()
	# write the HFGT compliant XML
	grid.write_hfgt_xml(file_out)


if __name__ == "__main__":
	elec_file_out = sys.argv[1]
	elec_file_out = "AEPS_hfgt_xml.xml"
	elec_kml_to_hfgt_xml(elec_file_out)
