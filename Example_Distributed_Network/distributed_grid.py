# Dirstributed Grid Object
# Dakota Thompson
# Converting PES 123 node system to HFGT XML

from ElecNode import ElecNode
from ElecLine import ElecLine

import pandas as pd
from lxml import etree as ET
from collections import OrderedDict
import sys

class DistributedGrid():
    def __init__(self):
        """
        Init method for the Distributed Grid Opbject
        Parameters:
        - name: name of the instantiated grid object as a string
        - power_nodes: list of electric node object in the grid
        - lines: list of lines objects in the grid
        """
        self.name = 'DistributedGrid'
        self.power_nodes = []
        self.lines = []

    def read_in_csv(self, files, rootDir=''):
        """
        CSV to Python
        Convert the node and line csv files into a distribution grid object
        inputs:
        - files: a list of strings that specify the .csv files to use.
        - root_dir (optional): a string specifying the relative path to the
           folder containing the above files. will be prefixed to each filename
        """
        print('Read in csv data...')
        for file in files:
            data1 = pd.read_csv(rootDir + file, index_col=False)
            # if 'NodeID' in data1.keys()[0]:
            if 'node' in file:
                print('Handeling Nodes')
                for k1 in data1.iterrows():
                    new_node = ElecNode((k1[1].X,k1[1].Y), k1[1].type)
                    new_node.name = str(k1[1].NodeID)
                    self.power_nodes.append(new_node)
            # elif 'Node_A' in data1.keys()[0]:
            elif 'line' in file:
                print('Handeling Lines')
                for k1 in data1.iterrows():
                    new_line = ElecLine(k1[1].Node_A,k1[1].Node_B)
                    new_line.name = str(k1[0])
                    new_line.attrib_ref = 'electric power'
                    self.lines.append(new_line)

    def add_lines(self, file, rootDir=''):
        """
        Add meshed distribution lines to the grid.
        From a CSV stating the origin and destination add additional lines to the grid
        inputs:
        - files: a list of strings that specify the .csv files to use.
        - root_dir (optional): a string specifying the relative path to the
           folder containing the above files. will be prefixed to each filename
        """
        data = pd.read_csv(rootDir + file, index_col=False)
        idx = 0
        for k1 in data.iterrows():
            new_line = ElecLine(int(k1[1].Node_A), int(k1[1].Node_B))
            new_line.name = str(len(self.lines))
            new_line.attrib_ref = 'electric power'
            self.lines.append(new_line)
            idx = idx + 1

    def add_DG(self, file, rootDir=''):
        """
        Add distributed generation functionality to the grid.
        From a CSV stating node name, add generation functionality to the specified nodes
        inputs:
        - files: a list of strings that specify the .csv files to use.
        - root_dir (optional): a string specifying the relative path to the
           folder containing the above files. will be prefixed to each filename
        """
        data = pd.read_csv(rootDir + file, index_col=False)
        idx = 0
        for k1 in data.iterrows():
            for node in self.power_nodes:
                if str(k1[1].Node) == node.name:
                    node.attributes.append('gen')
                    idx = idx + 1

    def write_hfgt_xml(self, filename):
        """
        Write the resulting XML file fromt he distribution grid object
        inputs:
        - filename: A string giving the name of the resulting XML file.
        """
        print('Generating HFGT XML tree...')
        print('num machines: %d' % len(self.power_nodes))
        print('num transporters: %d' % len(self.lines))

        root = ET.Element('LFES', OrderedDict([('name', self.name), ('type', 'Distributed System'), ('dataState', 'raw')]))

        operand = ET.SubElement(root, 'Operand', OrderedDict([('name', 'electric power')]))

        for node in self.power_nodes:
            node.add_xml_child_lfes(root)

        for line in self.lines:
            line.add_xml_child_lfes(root)

        abstractions = ET.SubElement(root, 'Abstractions')
        # add all MethodxPorts
        abstraction = ET.SubElement(abstractions, 'MethodxPort', OrderedDict([('name', 'transport'), ('ref', 'electric power'), ('operand', 'electric power'), ('output', 'electric power')]))
        abstraction = ET.SubElement(abstractions, 'MethodxPort', OrderedDict([('name', 'store'), ('ref', 'electric power'), ('operand', 'electric power'), ('output', 'electric power')]))
        # add all MethodPairs
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'generate electric power'), ('ref1', ''), ('name2', 'transport'), ('ref2', 'electric power')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'transport'), ('ref1', 'electric power'), ('name2', 'transport'), ('ref2', 'electric power')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'transport'), ('ref1', 'electric power'), ('name2', 'consume electric power'), ('ref2', '')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'transport'), ('ref1', 'electric power'), ('name2', 'store'), ('ref2', 'electric power')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'store'), ('ref1', 'electric power'), ('name2', 'consume electric power'), ('ref2', '')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'store'), ('ref1', 'electric power'), ('name2', 'transport'), ('ref2', 'electric power')]))

        tree = ET.ElementTree(root)

        print('Writing HFGT XML file "{}"'.format(filename))
        tree.write(filename, encoding='utf-8', xml_declaration=True)


if __name__ == "__main__":
    grid = DistributedGrid()

    files_in = ['node_data.csv', 'line_data.csv']
    rootDir = ''

    grid.read_in_csv(files_in,rootDir)

    grid.add_lines('addedLines.csv', rootDir)  # Add 32 meshed lines
    grid.add_DG('addedDG.csv', rootDir)  # Add DG to 41 nodes

    # file_out = sys.argv[1]
    file_out = "example_distributed_network.xml"
    grid.write_hfgt_xml(file_out)


