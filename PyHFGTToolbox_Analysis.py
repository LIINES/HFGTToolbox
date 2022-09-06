import sys
import pickle
import time
from XML2LFES import *
from raw2FullLFES import *


if len(sys.argv) == 3:
    XMLFile = sys.argv[1]
    verboseMode = int(sys.argv[2])

    start_t = time.time()
    myLFES = XML2LFES(XMLFile, verboseMode)
    myLFES = raw2FullLFES(myLFES, verboseMode)
    end_t = time.time()
    print('total time taken: %f' % (end_t - start_t))

    afile = open(r'Pickles/myLFES.pkl', 'wb')
    pickle.dump(myLFES, afile)
    afile.close()

else:
    print('Please Input: inputXML verboseMode')
    # Usage:  python PyHFGTToolbox_Analysis.py '../../0-Data/1-IntermediateData/NY/2022-5-3/AMES_NY_Elec_NG_Oil_Coal_DOFs_Idx.xml' 3

    # 0=basic, 1=Parallel, 2=incidence, 3=Julia
    # XMLFile = "XMLs/AMES_NY_Elec_NG_Oil_Coal.xml"
    # XMLFile = "XMLs/AMES_NY_Elec_NG_Oil_Coal_DOFs_Idx.xml"
    # XMLFile = "XMLs/Example_Network.xml"


# file2 = open(r'Pickles/myLFES.pkl', 'rb')
# new_LFES = pickle.load(file2)
# file2.close()
