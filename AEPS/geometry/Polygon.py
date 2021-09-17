# Lily Xu
# January 2018
# LIINES AMES

# Class to represent a Polygon geometry

from lxml import etree as ET
from geometry.Geometry import Geometry

class Polygon(Geometry):
    def __init__(self):
        self.outer_coords = []
        self.inner_coords = []

    def __str__(self):
        output = []

        output.append('Outer coords:')
        if len(self.outer_coords) <= 4:
            output.append('  ' + str(self.outer_coords) + '\n')
        else:
            output.append('  ' + str(len(self.outer_coords)) + ' points\n')

        output.append('Inner coords:')
        if len(self.inner_coords) <= 4:
            output.append('  ' + str(self.inner_coords) + '\n')
        else:
            output.append('  ' + str(len(self.inner_coords)) + ' points\n')

        return ''.join(output)

    def add_xml_child(self, parent):
        instance = ET.SubElement(parent, self.name, {'type': self.type})
        coordinate_elem = ET.SubElement(instance, 'Coordinate')
        point_elem = ET.SubElement(coordinate_elem, 'Polygon').text = str(self.coordinate)

        attrib_elem = ET.SubElement(instance, 'Attributes')
        for attrib in self.attributes:
            if self.attributes[attrib]:
                attrib_type = type(self.attributes[attrib]).__name__
                ET.SubElement(attrib_elem, 'Attribute', name=attrib, type=attrib_type).text = str(self.attributes[attrib])
