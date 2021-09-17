# Lily Xu
# January 2018
# LIINES AMES

import xml.etree.cElementTree as ET

from geometry.Point import Point

class ElecGenUnit(Point):
    def __init__(self, attributes, coordinate, name='ElecGenUnit'):
        self.name = name
        self.type = 'instance'
        self.attributes = attributes
        self.coordinate = coordinate
        self.attrib_name = ''
        self.attrib_origin = ''
        self.attrib_dest = ''
        self.attrib_ref = ''

    def get_coordinate(self):
        # return self.coordinate
        return self.coordinate.coordinate