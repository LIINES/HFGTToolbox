# Lily Xu
# January 2018
# LIINES AMES

# Defines the instance class
# An instance is a single facility, incorporating points, lines, or polygons

from geometry.Geometry import types

class Instance:
    def __init__(self):
        self.name = ''
        self.attributes = {}
        self.type = types[0]
        self.geometry = None
        self.fileName = ''

    def __str__(self):
        output = []

        if self.name:
            output.append('   Instance name:\n')
            output.append('     %s \n' % self.name)
        else:
            output.append('   Instance is not named.\n')

        output.append('   Type:\n')
        output.append('     %s\n' % self.type)

        output.append('   Attributes:\n')
        for attribute in self.attributes:
            output.append('     %s: %s\n' % (str(attribute), str(self.attributes[attribute])))

        output.append('   Geometry:\n')
        output.append('     %s\n' % str(self.geometry))

        return ''.join(output)
