# Dakota Thompson
# LIINES AMES

import numpy as np
import scipy.io as sio
from lxml import etree as ET    # for reading in and writing out XML files
from collections import OrderedDict
from shapely.geometry import LineString
import snap

from geometry.InstanceLayer import InstanceLayer
from elec.ElecNode import ElecNode
from elec.ElecLine import ElecLine
from elec.ElecSubstation import ElecSubstation
from elec.ElecGenUnit import ElecGenUnit
from elec.ElecPowerPlant import ElecPowerPlant

# ElecGrid class for containing electric grid info as an object
class ElecGrid:
    def __init__(self):
        """
        Init method for the Electric Grid Opbject
        Parameters:
        - name: name of the instantiated grid object as a string
        - power_nodes: Electric node object for storing ;buffer resources
        - lines: list of transmission line objects in the grid
        """
        self.name = 'ElecGrid'
        self.power_nodes = ElecNode()
        self.lines = []

    def read_in_kml(self, files, rootDir=''):
        """
        KML to Python
        from GIS KML file data, read into Python ElecGrid object
        inputs:
        - files: a list of strings that specify the .kml files to use.
        - root_dir (optional): a string specifying the relative path to the
           folder containing the above files. will be prefixed to each filename
        """
        print('Entering read_in_kml...')
        # priority order:
        # - power plant
        # - generating unit
        # - substation

        buffer_map = {}
        # set up PowerPlants, which take precedence over GenUnits and substations
        for name in files:
            if 'PowerPlants' in name:
                filename = name
        print('Processing file %s' % filename)
        buffer_map, plant_count, storage_count = self.read_powerPlants(rootDir + filename, buffer_map)

        # set up GenUnits, which take precedence over substations
        for name in files:
            if 'Gen_Units' in name:
                filename = name
        print('Processing file %s' % filename)
        buffer_map = self.read_genUnits(rootDir + filename, buffer_map, plant_count, storage_count)

        # set up Substations in the elec grid
        for name in files:
            if 'Substations' in name:
                filename = name
        print('Processing file %s' % filename)
        buffer_map = self.read_substations(rootDir + filename, buffer_map)

        # set up Transmission Lines in the elec grid
        for name in files:
            if 'Transmission_Lines' in name:
                filename = name
        print('Processing file %s' % filename)
        self.read_transmissionLines(rootDir + filename, buffer_map)

        print('Leaving read_in_kml')

    def read_powerPlants(self, filename, buffer_map):
        """
        KML to Python power plants
        from GIS KML file data, read into Python power plant objects
        inputs:
        - files: a strings that specify the .kml file to use.
        - buffer_map: a set for storing buffer gps coordinates to avoid overlapping buffers
        """
        # Store initial info in Instance layer
        layer = InstanceLayer()
        layer.build_from_QGIS(ET.parse(filename))
        # Counter Variables
        plant_count = 0
        storage_count = 0
        skipped_power_plants = 0

        # Process each powerPlant instance
        for instance in layer.instances:
            if 'STATUS' in instance.attributes and instance.attributes['STATUS'] == 'NOT_OP':
                skipped_power_plants += 1
                continue
            if 'STATUS' not in instance.attributes:
                skipped_power_plants += 1
                continue

            # round coordinates to 4 decimal points for consistency
            coords = tuple([round(x, 4) for x in instance.geometry.coordinate])
            # avoid adding multiple repeating power plants
            if coords in buffer_map:
                skipped_power_plants += 1
                continue

            # Turn instance into PowerPlant
            instance.geometry.coordinate = coords
            new_instance = ElecPowerPlant(instance.attributes, instance.geometry)

            # Add powerPlant to elec Nodes object based on powerPlant type
            if 'PRIME_MVR1' in instance.attributes and instance.attributes['PRIME_MVR1'] == 'Pumped Storage':
                storage_count += 1
                new_instance.name = 'StoreCUnit'
                new_instance.attrib_name = 'Pump Storage ' + str(storage_count)
                self.power_nodes.add_store_c(new_instance)
            # stochastic generator: solar, wind
            elif 'PRIME_MVR1' in instance.attributes and (instance.attributes['PRIME_MVR1'] == 'Wind Turbine'
                                                          or instance.attributes['PRIME_MVR1'] == 'Solar'):
                plant_count += 1
                new_instance.name = 'GenSUnit'
                new_instance.attrib_name = 'Power Plant ' + str(plant_count)
                self.power_nodes.add_gen_s(new_instance)
            # controlled generator: all else, including water/hydro
            else:
                plant_count += 1
                new_instance.name = 'GenCUnit'
                new_instance.attrib_name = 'Power Plant ' + str(plant_count)
                self.power_nodes.add_gen_c(new_instance)
            buffer_map[coords] = new_instance.attrib_name

        return buffer_map, plant_count, storage_count

    def read_genUnits(self, filename, buffer_map, plant_count, storage_count):
        """
        KML to Python generation units
        from GIS KML file data, read into Python generation unit objects
        inputs:
        - files: a strings that specify the .kml file to use.
        - buffer_map: a set for storing buffer gps coordinates to avoid overlapping buffers
        """
        # Store initial info in Instance layer
        layer = InstanceLayer()
        layer.build_from_QGIS(ET.parse(filename))

        skipped_gen_units = 0
        # Process each genUnit instance
        for instance in layer.instances:
            # do not include instances that are not operating
            if instance.attributes['STATUS'] == 'RETIRED' or instance.attributes['STATUS'] == 'CANCELLED' \
               or instance.attributes['STATUS'] == 'STANDBY' \
               or instance.attributes['STATUS'] == 'SOLD AND DISMANTLED (WAS: SOLD TO AND OPERATED BY NON-UTILITY)' \
               or instance.attributes['STATUS'] == 'PROPOSED' \
               or instance.attributes['STATUS'] == 'PLANNED GENERATOR INDEFINITELY POSTPONED':
                skipped_gen_units += 1
                continue

            # round coordinates to 4 decimal points for consistency
            coords = tuple([round(x, 4) for x in instance.geometry.coordinate])
            # avoid adding multiple overlapping buffers
            if coords in buffer_map:
                skipped_gen_units += 1
                continue

            # Turn instance into genUnit
            instance.geometry.coordinate = coords
            new_instance = ElecGenUnit(instance.attributes, instance.geometry)

            # add genUnit to elecGrid powerNodes based on parameters
            # controlled storage: pumped storage
            if instance.attributes['PRIME_MVR'] == 'PUMPED STORAGE':
                storage_count += 1
                new_instance.name = 'StoreCUnit'
                new_instance.attrib_name = 'Pump Storage ' + str(storage_count)
                self.power_nodes.add_store_c(new_instance)
            # stochastic generator: solar, wind
            elif instance.attributes['PRIME_MVR'] == 'SOLAR' or instance.attributes['PRIME_MVR'] == 'WIND TURBINE':
                new_instance.name = 'GenSUnit'
                plant_count += 1
                new_instance.name = 'GenSUnit'
                new_instance.attrib_name = 'Power Plant ' + str(plant_count)
                self.power_nodes.add_gen_s(new_instance)
            # controlled generator: all else, including water/hydro
            else:
                new_instance.name = 'GenCUnit'
                plant_count += 1
                new_instance.name = 'GenCUnit'
                new_instance.attrib_name = 'Power Plant ' + str(plant_count)
                self.power_nodes.add_gen_c(new_instance)
            buffer_map[coords] = new_instance.attrib_name

        return buffer_map

    def read_substations(self, filename, buffer_map):
        """
        KML to Python substations
        from GIS KML file data, read into Python substation objects
        inputs:
        - files: a strings that specify the .kml file to use.
        - buffer_map: a set for storing buffer gps coordinates to avoid overlapping buffers
        """
        # Store initial info in Instance layer
        layer = InstanceLayer()
        layer.build_from_QGIS(ET.parse(filename))

        substation_count = 0
        skipped_substations = 0
        # Process each substation instance
        for instance in layer.instances:
            if 'STATUS' in instance.attributes and instance.attributes['STATUS'] == 'CN':
                skipped_substations += 1
                continue
            # if no unique identifier, skip
            if 'CHAR_ID' not in instance.attributes or instance.attributes['CHAR_ID'] == '-99' \
                    or instance.attributes['CHAR_ID'] == '-98':
                skipped_substations += 1
                continue

            # round coordinates to 4 decimal points for consistency
            coords = tuple([round(x, 4) for x in instance.geometry.coordinate])
            # check to avoid overlapping buffers
            if coords in buffer_map:
                skipped_substations += 1
                continue

            instance.geometry.coordinate = coords
            new_instance = ElecSubstation(instance.attributes, instance.geometry)
            new_instance.attrib_ref = 'electric power at 132kV'

            # Add substation to elecGrid in the powerNodes
            substation_count += 1
            new_instance.attrib_name = 'Substation ' + str(substation_count)
            self.power_nodes.add_substation(new_instance)
            buffer_map[coords] = new_instance.attrib_name

        return buffer_map

    def read_transmissionLines(self, filename, buffer_map):
        """
        KML to Python transmission lines
        from GIS KML file data, read into Python transmission line objects
        inputs:
        - files: a strings that specify the .kml file to use.
        - buffer_map: a set for storing buffer gps coordinates to avoid overlapping buffers
        """
        # Store initial info in Instance layer
        layer = InstanceLayer()
        layer.build_from_QGIS(ET.parse(filename))

        skippedLines = 0
        transmission_count = 0
        dup = 0
        for instance in layer.instances:
            # round GPS coords to 4 decimal points for consistency (list of tuples)
            coords = [tuple([round(y, 4) for y in x]) for x in instance.geometry.coordinate]
            instance.geometry = LineString(coords)
            new_instance = ElecLine(instance.attributes, instance.geometry)

            # Get origin and destination of line
            lineOrigin = new_instance.coordinate.coords[0]
            lineDest = new_instance.coordinate.coords[-1]

            # remove those without origins or destinations within buffers
            if lineOrigin == lineDest:
                skippedLines += 1
                continue
            if lineOrigin in buffer_map:
                new_instance.attrib_origin = buffer_map[lineOrigin]
            else:
                skippedLines += 1
                continue
            if lineDest in buffer_map:
                new_instance.attrib_dest = buffer_map[lineDest]
            else:
                skippedLines += 1
                continue

            # check to see if origin->dest or dest->origin already exists
            for line in self.lines:
                if (new_instance.attrib_origin == line.attrib_origin
                    and new_instance.attrib_dest == line.attrib_dest) \
                        or (new_instance.attrib_origin == line.attrib_dest
                            and new_instance.attrib_dest == line.attrib_origin):
                    dup = 1
                    break
            if dup == 1:
                dup = 0
                skippedLines += 1
                continue

            # Add transmission line to the elecGrid in the lines list
            transmission_count += 1
            new_instance.attrib_name = 'Transmission Line ' + str(transmission_count)
            new_instance.attrib_ref = 'electric power at 132kV'
            self.lines.append(new_instance)

    def remove_isolated(self):
        """
        Remove isolated nodes not connected to a transmission line from the electric grid
        """
        print('removing isolated nodes')
        ODList = []
        for line in self.lines:
            if line.attrib_origin not in ODList:
                ODList.append(line.attrib_origin)
            if line.attrib_dest not in ODList:
                ODList.append(line.attrib_dest)
        nodes = self.power_nodes.get_all()
        for node in nodes:
            if node.attrib_name not in ODList:
                self.power_nodes.del_node(node)

    def remove_subComps(self):
        """
        using the snap toolbox, create a graph of the electric grid and identify every component.
        Remove all subcomponents from the elec grid object.
        """
        print('removing sub clusters')
        # initialize vectors
        nodes_gpsX = np.zeros((self.power_nodes.get_num_all(), 1))
        nodes_gpsY = np.zeros((self.power_nodes.get_num_all(), 1))
        edges_origin = np.zeros((len(self.lines), 1))
        edges_dest = np.zeros((len(self.lines), 1))
        edges_value = np.ones((len(self.lines), 1))

        # add vertices to graph
        nodes_map = {}       # map node ID to node index
        i = 0
        for node in self.power_nodes.get_all():
            nodes_map[node.attrib_name] = i + 1
            nodes_gpsX[i, 0] = node.get_coordinate()[0]   # x-coordinate
            nodes_gpsY[i, 0] = node.get_coordinate()[1]   # y-coordinate
            i += 1

        # add edges to graph
        i = 0
        for line in self.lines:
            origin_id = line.attrib_origin
            dest_id = line.attrib_dest
            if origin_id in nodes_map and dest_id in nodes_map:
                edges_origin[i, 0] = nodes_map[origin_id]  # origin
                edges_dest[i, 0] = nodes_map[dest_id]      # destination
                edges_value[i, 0] = 1                      # value
                i += 1

        # create graph object
        graph = snap.TUNGraph.New()
        id = 0
        vertices = {}  # map node index to object
        for i in range(len(nodes_gpsX)):
            id = id + 1  # use node index as node ID, add 1 because Matlab indexes from 1 and Python from 0
            vertices[id] = i
            graph.AddNode(id)

        edgeID = 0
        for i in range(len(edges_origin)):
            origin_id = int(edges_origin[i])
            dest_id = int(edges_dest[i])
            value = float(edges_value[i])

            if origin_id in vertices and dest_id in vertices:
                edgeID = edgeID + 1
                graph.AddEdge(origin_id, dest_id)

        nodes = self.power_nodes.get_all()
        Components = snap.TCnComV()
        snap.GetWccs(graph, Components)
        del_nodes = []
        for k1 in range(1, len(Components)):
            for k2 in Components[k1]:
                del_nodes.append(nodes[k2-1])
        node_names = []
        for k3 in del_nodes:
            node_names.append(k3.attrib_name)
            self.power_nodes.del_node(k3)

        del_lines = []
        for line in self.lines:
            if line.attrib_origin in node_names:
                del_lines.append(line)
        for line in del_lines:
            self.lines.remove(line)

    def write_hfgt_xml(self, filename):
        """
        write out XML file in the specified HFGT XML format
        inputs:
        - filename: string giving the name of the output XML file
        """
        print('Generating HFGT XML tree...')

        root = ET.Element('LFES', OrderedDict([('name', self.name), ('type', 'Electric Grid'), ('dataState', 'raw')]))

        self.power_nodes.add_xml_child_hfgt(root)

        for line in self.lines:
            line.add_xml_child_lfes(root)

        ##### Define Abstraction here
        abstractions = ET.SubElement(root, 'Abstractions')
        ### output all MethodxForms and MethodxPorts
        abstraction = ET.SubElement(abstractions, 'MethodxPort', OrderedDict([('name', 'transport'), ('ref', 'electric power at 132kV')]))
        abstraction = ET.SubElement(abstractions, 'MethodxPort', OrderedDict([('name', 'store'), ('ref', 'electric power at 132kV')]))
        ### add all MethodPairs
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'generate electric power'), ('ref1', ''), ('name2', 'store'), ('ref2', 'electric power at 132kV')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'generate electric power'), ('ref1', ''), ('name2', 'transport'), ('ref2', 'electric power at 132kV')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'generate electric power'), ('ref1', ''), ('name2', 'consume electric power'), ('ref2', '')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'generate distributed electric power'), ('ref1', ''), ('name2', 'store'), ('ref2', 'electric power at 132kV')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'generate distributed electric power'), ('ref1', ''), ('name2', 'transport'),('ref2', 'electric power at 132kV')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'generate distributed electric power'), ('ref1', ''), ('name2', 'consume electric power'), ('ref2', '')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'transport'), ('ref1', 'electric power at 132kV'), ('name2', 'transport'), ('ref2', 'electric power at 132kV')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'transport'), ('ref1', 'electric power at 132kV'), ('name2', 'consume electric power'), ('ref2', '')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'transport'), ('ref1', 'electric power at 132kV'), ('name2', 'store'), ('ref2', 'electric power at 132kV')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'store'), ('ref1', 'electric power at 132kV'), ('name2', 'consume electric power'), ('ref2', '')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'store'), ('ref1', 'electric power at 132kV'), ('name2', 'transport'), ('ref2', 'electric power at 132kV')]))
        abstraction = ET.SubElement(abstractions, 'MethodPair', OrderedDict([('name1', 'store'), ('ref1', 'electric power at 132kV'), ('name2', 'store'), ('ref2', 'electric power at 132kV')]))

        ### Consolidate the tree
        tree = ET.ElementTree(root)

        print('Writing HFGT XML file "{}"...'.format(filename))
        tree.write(filename, encoding='utf-8', xml_declaration=True)