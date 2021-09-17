# Electric Line Object
# Dakota Thompson

from lxml import etree as ET
from collections import OrderedDict

class ElecLine():
    def __init__(self, origin, dest):
        """
        Init method for the ElecLine Opbject
        Parameters:
        - name: name of the instantiated ElecLine object as a string
        - attrib_origin: name of the node at the line's origin
        - attrib_dest: name of the node at the line's destination
        - attrib_ref: name of the line's transportation process refinement
        """
        self.name = 'ElecLine'
        self.attrib_origin = str(origin)
        self.attrib_dest = str(dest)
        self.attrib_ref = ''

    def add_xml_child_lfes(self, parent):
        """
        Add the line object and processes to the input XML structure
        Input:
        - parent: The root of the eTree to attach the line object too inside the XML
        """
        transporter = ET.SubElement(parent, 'Transporter', OrderedDict([('name', self.name)]))
        # add transmission capabilities in both directions
        method_port1 = ET.SubElement(transporter, 'MethodxPort', OrderedDict([('name', 'transport'), ('status', 'true'), ('origin', self.attrib_origin), ('dest', self.attrib_dest), ('operand','electric power'), ('output','electric power'), ('ref', 'electric power')]))
        method_port2 = ET.SubElement(transporter, 'MethodxPort', OrderedDict([('name', 'transport'), ('status', 'true'), ('origin', self.attrib_dest), ('dest', self.attrib_origin), ('operand','electric power'), ('output','electric power'), ('ref', 'electric power')]))
