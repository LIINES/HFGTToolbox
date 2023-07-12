import pytest

from python_hfgt_toolbox.PyHFGTToolbox_Analysis import run_analysis


class TestHFGTToolboxAnalysis:
    """
    Runs analysis on example network XML files.
    """

    def test_example_network_basic(self):
        """ Runs the example network from Chapter 4 of the HFGT book """
        pkl_file = run_analysis("data/XMLs/Example_Network.xml", 0)
        assert pkl_file.exists() and pkl_file.stat().st_size > 0

    def test_example_network_par(self):
        """ Runs the example network from Chapter 4 of the HFGT book """
        pkl_file = run_analysis("data/XMLs/Example_Network.xml", 1)
        assert pkl_file.exists() and pkl_file.stat().st_size > 0

    def test_example_network_inc(self):
        """ Runs the example network from Chapter 4 of the HFGT book """
        pkl_file = run_analysis("data/XMLs/Example_Network.xml", 2)
        assert pkl_file.exists() and pkl_file.stat().st_size > 0

    @pytest.mark.skip(reason="Needs Julia pre-installed")
    def test_example_network_DOFs(self):
        """ Runs another example network """
        pkl_file = run_analysis("data/XMLs/Example_Network_DOFs_Idx.xml", 3)
        assert pkl_file.exists() and pkl_file.stat().st_size > 0


if __name__ == '__main__':
    """ Run the test manually - useful for testing. Normally run with `pytest` """
    TestHFGTToolboxAnalysis().test_example_network_basic()
    TestHFGTToolboxAnalysis().test_example_network_par()
    TestHFGTToolboxAnalysis().test_example_network_inc()
    TestHFGTToolboxAnalysis().test_example_network_DOFs()
