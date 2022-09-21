# Electric Node Object
# Dakota Thompson

from lxml import etree as ET
from collections import OrderedDict

class ElecNode():
    def __init__(self, coordinate, attributes):
        """
        Init method for the ElecNode Opbject
        Parameters:
        - name: name of the instantiated ElecNode object as a string
        - attributes: list of electric node attributes to designate node properties
        - coordinate: tuple of the nodes gps coordinates
        - attrib_origin: name of a transportation process origin
        - attrib_dest: name of a transportation process destination
        - attrib_ref: name of a transportation process refinement
        """
        self.name = 'ElecNode'
        self.attributes = [attributes]
        self.coordinate = coordinate
        self.attrib_origin = ''
        self.attrib_dest = ''
        self.attrib_ref = ''

    def get_coordinate(self):
        """
        Return the node coordinates
        """
        return self.coordinate

    def add_xml_child_lfes(self, parent):
        """
        Add the node object and processes to the input XML structure
        Input:
        - parent: The root of the eTree to attatch the node object too inside the XML
        """
        machine = ET.SubElement(parent, 'Machine', OrderedDict([('name', self.name), ('gpsX', str(self.get_coordinate()[0])), ('gpsY', str(self.get_coordinate()[1]))]))
        if 'con' in self.attributes:
            method_form = ET.SubElement(machine, 'MethodxForm', OrderedDict([('name', 'consume electric power'), ('operand', 'electric power'), ('output', ''), ('status', 'true')]))
            method_port = ET.SubElement(machine, 'MethodxPort', OrderedDict([('name', 'store'), ('operand', 'electric power'), ('output', 'electric power'), ('origin', self.name), ('dest', self.name), ('ref', 'electric power'), ('status', 'true')]))
        if 'gen' in self.attributes:
            method_form = ET.SubElement(machine, 'MethodxForm', OrderedDict([('name', 'generate electric power'), ('operand', ''), ('output', 'electric power'), ('status', 'true')]))

