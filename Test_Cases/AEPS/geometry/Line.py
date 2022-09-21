# Lily Xu
# January 2018
# LIINES AMES

# Class to represent a Line geometry

from lxml import etree as ET
from geometry.Geometry import Geometry

class Line(Geometry):
    def __init__(self):
        self.coordinate = []

    def __str__(self):
        if len(self.coordinate) <= 4:
            return str(self.coordinate)
        else:
            return str(len(self.coordinate)) + ' points'

    def add_xml_child(self, parent):
        instance = ET.SubElement(parent, self.name, {'type': self.type})
        coordinate_elem = ET.SubElement(instance, 'Coordinate')
        point_elem = ET.SubElement(coordinate_elem, 'Line').text = str(self.coordinate)

        attrib_elem = ET.SubElement(instance, 'Attributes')
        for attrib in self.attributes:
            if self.attributes[attrib]:
                attrib_type = type(self.attributes[attrib]).__name__
                ET.SubElement(attrib_elem, 'Attribute', name=attrib, type=attrib_type).text = str(self.attributes[attrib])
