# Lily Xu
# Dakota Thompson
# January 2018
# LIINES AMES

from lxml import etree as ET
from collections import OrderedDict

from geometry.Line import Line

class ElecLine(Line):
    def __init__(self, attributes, coordinate):
        self.name = 'ElecLine'
        self.type = 'instance'
        self.attributes = attributes
        self.coordinate = coordinate
        self.attrib_name = ''
        self.attrib_origin = ''
        self.attrib_dest = ''
        self.attrib_ref = ''

    def add_xml_child_lfes(self, parent):
        transporter = ET.SubElement(parent, 'Transporter', OrderedDict([('name', self.attrib_name)]))
        # add transmission capabilities in both directions
        method_port1 = ET.SubElement(transporter, 'MethodxPort', OrderedDict([('name', 'transport'), ('status', 'true'), ('origin', self.attrib_origin), ('dest', self.attrib_dest), ('operand','electric power at 132kV'), ('output','electric power at 132kV'), ('ref', self.attrib_ref)]))
        method_port2 = ET.SubElement(transporter, 'MethodxPort', OrderedDict([('name', 'transport'), ('status', 'true'), ('origin', self.attrib_dest), ('dest', self.attrib_origin), ('operand','electric power at 132kV'), ('output','electric power at 132kV'), ('ref', self.attrib_ref)]))
