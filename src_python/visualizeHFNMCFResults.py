"""
Copyright (c) 2018-2026 Engineering Systems Analytics LLC, Stevens Institute of Technology
@author: Amro M. Farid
@version: 4.6.9
@Note:  Version 4.0 is a major release constituting a full rewrite of the entire code base.
@Note:  See Bitbucket Commit History for an understanding the contributions of each author.
@Acknowledgement:  Thanks goes to Dr. Amro M. Farid, Dr. Wester C. H. Schoonenberg, and Dr. Dakota Thompson as the principal
                    authors of Versions 1, 2, 3 respectively.
@Modified: 04/05/2026
@ Provided under the Creative Commons 4.0 License
Developed with Python 3.11.9
"""
import pathlib as pl
import numpy as np
from scipy.sparse import coo_array
import hfgt_toolbox.HFGTToolbox as hfgt
import plotly.graph_objects as plotlyGO

from dash import Dash, dcc, html, Input, Output
def plotLineGraphTimeSeriesMatrix(A, myTitle="Line Graph Time Series Matrix Viewer", myLabels=None, rows_per_button = 10):
    """
    Plots a line time series matrix as a Plotly figure with dropdown and range slider.
    Shows a user specified (10 default) time series at a time, with a dropdown menu to select which 10 rows.

    Parameters
    ----------
    A : array-like, shape (n_rows, n_cols)
        Matrix of time series to plot.
    myLabels : list of str, optional
        Labels for each row in the legend. If None, defaults to "Row i".
    """
    A = np.asarray(A)
    n_rows, n_cols = A.shape
    t = np.arange(n_cols)

    # Default labels if none provided
    if myLabels is None:
        myLabels = [f"Row {i}" for i in range(n_rows)]
    elif len(myLabels) != n_rows:
        raise ValueError("Length of myLabels must match number of rows in A.")

      # show 10 time series at a time
    fig = plotlyGO.Figure()

    # Add all traces, but only first 10 visible initially
    for i in range(n_rows):
        fig.add_trace(
            plotlyGO.Scatter(
                x=t,
                y=A[i],
                mode="lines",
                name=myLabels[i],
                visible=(i < rows_per_button)
            )
        )

    # Create dropdown buttons for each set of 10 rows
    buttons = []
    for start in range(0, n_rows, rows_per_button):
        end = min(start + rows_per_button, n_rows)
        visible = [False] * n_rows
        for i in range(start, end):
            visible[i] = True
        buttons.append(
            dict(
                label=f"Rows {start}-{end-1}",
                method="update",
                args=[
                    {"visible": visible},
                    {"title": f"Rows {start} to {end-1}"}
                ]
            )
        )

    fig.update_layout(
        title= myTitle,
        autosize=True,
        height=800,
        xaxis=dict(
            title="Time",
            rangeslider=dict(visible=True),
            type="linear"
        ),
        yaxis=dict(title="Value"),
        updatemenus=[
            dict(
                buttons=buttons,
                direction="down",
                showactive=True,
                x=0,
                xanchor="left",
                y=1.07,
                yanchor="top"
            )
        ],
        legend=dict(
            x=1.02,
            y=1,
            xanchor="left",
            yanchor="top",
            orientation="v"
        ),
        margin=dict(l=70, r=160, t=100, b=70)
    )

    fig.show(config={"responsive": True})
def genExampleVisData(n=100, num_matrices=10):
    listOfNumpyMatrices = [np.random.randint(-10, 10, (n, 3)) for _ in range(num_matrices)]
    matrix_labels = [[f"A{i+1}", f"B{i+1}", f"C{i+1}"] for i in range(num_matrices)]
    matrix_names = [f"Matrix {i+1}" for i in range(num_matrices)]
    x = np.arange(n)
    return listOfNumpyMatrices, matrix_labels, matrix_names, x
def plotStackedBarChartsInSubplots(listOfNumpyMatrices, matrix_labels, matrix_names, timeStamps=None):
    if timeStamps is None:
        timeStamps = np.arange(listOfNumpyMatrices[0].shape[0])
    simHorizon = timeStamps.size
    num_matrices = len(listOfNumpyMatrices)
    app = Dash(__name__)
    # -------------------------
    # Layout
    # -------------------------
    app.layout = html.Div([
        # Four dropdowns and four graphs
        html.Div([
            html.Div([
                html.Div([
                    dcc.Dropdown(
                        id=f"dropdown-{i}",
                        options=[{"label": matrix_names[j], "value": j} for j in range(num_matrices)],
                        value=i,  # initial matrix for subplot i
                        clearable=False,
                        style={"width": "400px"}
                    )
                ], style={"margin-bottom": "0px", "margin-left": "20px"}),

                dcc.Graph(id=f"graph-{i}", style={"height": "300px"})

            ]) for i in range(4)
        ]),
        # Single shared RangeSlider
        html.Div([
            dcc.RangeSlider(
                id="x-range",
                min=0,
                max=simHorizon-1,
                step=1,
                value=[0, simHorizon-1],
                allowCross=False
            )
        ], style={"margin-top": "20px", "margin-left": "20px", "margin-right": "20px"})
    ], style={"width": "80%", "margin": "auto"})
    # -------------------------
    # Callback: update graphs
    # -------------------------
    @app.callback(
        [Output(f"graph-{i}", "figure") for i in range(4)],
        [Input(f"dropdown-{i}", "value") for i in range(4)] + [Input("x-range", "value")]
    )
    def update_graphs(drop1, drop2, drop3, drop4, x_range):
        dropdown_values = [drop1, drop2, drop3, drop4]
        xmin, xmax = x_range
        figs = []
        for i, selected_matrix_index in enumerate(dropdown_values):
            myMatrix = listOfNumpyMatrices[selected_matrix_index]
            myLabels = matrix_labels[selected_matrix_index]
            fig = plotlyGO.Figure()
            for j in range(myMatrix.shape[1]):
                fig.add_bar(x=timeStamps, y=myMatrix[:, j], name=myLabels[j])
            fig.update_layout(
                autosize=False,
                height=350,
                barmode="relative",
                margin=dict(l=50, r=150, t=0, b=50),
                legend=dict(x=1.02, y=1, xanchor="left", yanchor="top")
            )
            fig.update_yaxes(title_text=f"Y-axis {i+1}")
            fig.update_xaxes(range=[xmin, xmax])
            figs.append(fig)
        return figs
    return app

if __name__ == "__main__":

    # myLFES = hfgt.loadMyData(
    #     pl.Path('../4_JuliaHFGT_Output_Data/myLFES-H2NG-NetherlandsAMF-Defaultxml-Base-2026-04-11.json'))

    myLFES = hfgt.loadMyData(
        pl.Path('../4_JuliaHFGT_Output_Data/myLFES-EPS9-DCOPF-Defaultxml-Base-2026-04-11.json'))

    if myLFES.hasESN_STF1:
        plotLineGraphTimeSeriesMatrix(myLFES.engSysNet.XS.todense(), "Engineering System Net Places",
                                      myLFES.engSysNet.pnPlaces.name, myLFES.buffer.number)
        # plotLineGraphTimeSeriesMatrix(myLFES.engSysNet.XF.todense(), "Engineering System Net Enabled Places",
        #                               myLFES.engSysNet.pnPlaces.name, myLFES.buffer.number)
    if myLFES.hasESN_STF2:
        plotLineGraphTimeSeriesMatrix(myLFES.engSysNet.XE.todense(), "Engineering System Net Transition Places",
                                      myLFES.engSysNet.pnTransitions.name)
    if myLFES.hasESN_STF1 or myLFES.hasESN_STF2:
        plotLineGraphTimeSeriesMatrix(myLFES.engSysNet.Uneg.todense(), "Engineering System Net Input Firing Vectors",
                                      myLFES.engSysNet.pnTransitions.name)
    if myLFES.hasESN_Duration:
        plotLineGraphTimeSeriesMatrix(myLFES.engSysNet.Upos.todense(), "Engineering System Net Output Firing Vectors",
                                      myLFES.engSysNet.pnTransitions.name)

    # Test Case 1:  Generate Random Data
    # listOfNumpyMatrices, listOfLabelLists, listOfTitles, simHorizon = genExampleVisData()
    # app = plotStackedBarChartsInSubplots(listOfNumpyMatrices, listOfLabelLists, listOfTitles)
    # app.run(debug=True)


    # Test Case 2:  Generate Data from myLFES
    ZERO_TOL = 1e-3
    listOfNumpyMatrices = [0] * myLFES.engSysNet.pnPlaces.number
    listOfLabelLists    = [0] * myLFES.engSysNet.pnPlaces.number
    listOfTitles        = [0] * myLFES.engSysNet.pnPlaces.number
    idxXS = list(range(myLFES.engSysNet.pnPlaces.number))

    for k in range(myLFES.engSysNet.pnPlaces.number):
        # Only take the relevant row of the HFIT matrix
        M = (hfgt.sliceCOOMatrix(myLFES.engSysNet.MFull, [idxXS[k]])).T
        # Calculate the operand incremented by the firing vector
        MU = (M * myLFES.engSysNet.Uneg)
        # Get the indices of the nonzero rows.
        idxUE = np.nonzero(np.sum(np.abs(MU), axis=1) > ZERO_TOL)[0]
        listOfNumpyMatrices[k] = np.tile((hfgt.sliceCOOMatrix(MU, idxUE)).T.todense(), (24, 1))
        listOfLabelLists[k] = [myLFES.engSysNet.pnTransitions.name[idx] for idx in idxUE]

    app = plotStackedBarChartsInSubplots(listOfNumpyMatrices, listOfLabelLists, myLFES.engSysNet.pnPlaces.name)
    app.run(debug=True)
