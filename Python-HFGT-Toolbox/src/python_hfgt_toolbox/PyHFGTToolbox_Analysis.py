import sys
import pickle
import time
import numpy as np
from pathlib import Path
from loguru import logger

from python_hfgt_toolbox.XML2LFES import XML2LFES
from python_hfgt_toolbox.raw2FullLFES import raw2FullLFES


def run_analysis(xml_file: str, verbose_mode: int, out_dir = 'output'):
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

    output_pkl = Path(f'{out_dir}/Pickles/myLFES.pkl')
    output_pkl.parent.mkdir(parents=True, exist_ok=True)
    with open(output_pkl, 'wb') as afile:
        pickle.dump(myLFES, afile)

    save_dir = Path("data/IncidenceMatrices")
    save_dir.mkdir(parents=True, exist_ok=True)
    if myLFES.MRT != 0:
        np.savetxt(f"{save_dir}/MRT.csv", np.transpose(np.append(myLFES.MRT.coords,[myLFES.MRT.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
    np.savetxt(f"{save_dir}/MRT_neg.csv", np.transpose(np.append(myLFES.MRT_neg.coords,[myLFES.MRT_neg.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
    np.savetxt(f"{save_dir}/MRT_pos.csv", np.transpose(np.append(myLFES.MRT_pos.coords,[myLFES.MRT_pos.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
    if myLFES.MRTproj != 0:
        np.savetxt(f"{save_dir}/MRTproj.csv", np.transpose(np.append(myLFES.MRTproj.coords,[myLFES.MRTproj.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
        np.savetxt(f"{save_dir}/MRTproj_neg.csv", np.transpose(np.append(myLFES.MRTproj_neg.coords,[myLFES.MRTproj_neg.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')
        np.savetxt(f"{save_dir}/MRTproj_pos.csv", np.transpose(np.append(myLFES.MRTproj_pos.coords,[myLFES.MRTproj_pos.data], axis=0)), delimiter=",", header="Operand,Buffer,DOF,Value",comments='')

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
