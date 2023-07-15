import sys
import pickle
import time
import numpy as np
from pathlib import Path
from loguru import logger

import json
import copy

from python_hfgt_toolbox.XML2LFES import XML2LFES
from python_hfgt_toolbox.raw2FullLFES import raw2FullLFES


def run_analysis(xml_file: str, verbose_mode: int, out_dir = 'data/Pickles/myLFES.pkl'):
    """
    Runs HFGT analysis using the provided XML file.

    :param xml_file: XML file to use for analysis
    :param verbose_mode: 0=Basic, 1=Parallel, 2=Incidence, 3=Julia
    :param out_dir: output directory to save resulting pickle.  Default is ./output
    :return: absolute path to which the pickle was saved
    """

    start_t = time.time()
    xml_path = Path(xml_file)
    if not xml_path.exists():
        logger.error(f"XML file {Path(xml_path).absolute()} does not exist!")
        return None

    myLFES = XML2LFES(str(xml_path.absolute()), verbose_mode)
    myLFES = raw2FullLFES(myLFES, verbose_mode)
    end_t = time.time()
    print('total time taken: %f' % (end_t - start_t))

    output_pkl = Path(out_dir)
    output_pkl.parent.mkdir(parents=True, exist_ok=True)
    with open(output_pkl, 'wb') as afile:
        pickle.dump(myLFES, afile)

    outputLFES = copy.deepcopy(myLFES)
    output_json = open('data/Pickles/myLFES.json', 'w')
    json.dump(outputLFES.returnJSON(), output_json)
    output_json.close()


    ### Additional matrix outputs saved to CSV files puled from the LFES object ###

    save_dir = Path("data/")
    save_dir.mkdir(parents=True, exist_ok=True)
    if myLFES.MRT != 0:
        np.savetxt(f"{save_dir}/IncidenceMatrices/MRT.csv", np.transpose(np.append(myLFES.MRT.coords,[myLFES.MRT.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
    np.savetxt(f"{save_dir}/IncidenceMatrices/MRT_neg.csv", np.transpose(np.append(myLFES.MRT_neg.coords,[myLFES.MRT_neg.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
    np.savetxt(f"{save_dir}/IncidenceMatrices/MRT_pos.csv", np.transpose(np.append(myLFES.MRT_pos.coords,[myLFES.MRT_pos.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
    if myLFES.MRTproj != 0:
        np.savetxt(f"{save_dir}/IncidenceMatrices/MRTproj.csv", np.transpose(np.append(myLFES.MRTproj.coords,[myLFES.MRTproj.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
        np.savetxt(f"{save_dir}/IncidenceMatrices/MRTproj_neg.csv", np.transpose(np.append(myLFES.MRTproj_neg.coords,[myLFES.MRTproj_neg.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
        np.savetxt(f"{save_dir}/IncidenceMatrices/MRTproj_pos.csv", np.transpose(np.append(myLFES.MRTproj_pos.coords,[myLFES.MRTproj_pos.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')

    if verbose_mode < 3:
        np.savetxt(f"{save_dir}/LookUpTable/Operands.csv",np.transpose([range(myLFES.numOperands), myLFES.setOperands]), delimiter=",", header="Index,Operands",comments='', fmt="%s")
        np.savetxt(f"{save_dir}/LookUpTable/Buffers.csv",np.transpose([range(myLFES.numBuffers), np.append(myLFES.machines.name,myLFES.indBuffers.name)]), delimiter=",", header="Index,Buffers",comments='', fmt="%s")

        idxAS = np.nonzero(myLFES.AS.T)
        DOFs = []
        idxDOFs = []
        idxDOFsProj = []
        for k1 in range(len(idxAS[0])):
            if idxAS[0][k1] < myLFES.numMachines:
                resource = myLFES.machines.name[idxAS[0][k1]]
            elif idxAS[0][k1] < myLFES.numBuffers:
                resource = myLFES.indBuffers.name[idxAS[0][k1]-myLFES.numMachines]
            else:
                resource = myLFES.transporters.name[idxAS[0][k1]-myLFES.numBuffers]

            if idxAS[1][k1] < myLFES.numTransformProcess:
                process = myLFES.setTransformProcess[idxAS[1][k1]]
            else:
                process = myLFES.setTransportRefProcess[idxAS[1][k1]-myLFES.numTransformProcess]

            DOFs.append(resource + ': ' + process)
            idxDOFs.append(idxAS[0][k1] * myLFES.numProcesses + idxAS[1][k1])
            idxDOFsProj.append(k1)

        np.savetxt(f"{save_dir}/LookUpTable/DOFs.csv",np.transpose([idxDOFsProj, idxDOFs, DOFs]), delimiter=",", header="ProjectedIndex,Index,DOF",comments='', fmt="%s")

    return output_pkl.absolute()



if __name__ == '__main__':

    if len(sys.argv) == 3:
        xml_file = sys.argv[1]
        verbose_mode = int(sys.argv[2])
        run_analysis(xml_file, verbose_mode)
    else:
        print('Usage: python.exe src/python_hfgt_toolbox/PyHFGTToolbox_Analysis.py <input_xml_path> <verbose_mode_(0, 1, 2, or 3)')

        # verboseModes:
        # 0=basic, 1=Parallel, 2=incidence, 3=Julia

        # file2 = open(r'Pickles/myLFES.pkl', 'rb')
        # new_LFES = pickle.load(file2)
        # file2.close()
