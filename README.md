# EgunOpt

## Geometry creation
The folder [code/geometry/v6](https://github.com/temf/EgunOpt/tree/main/code/geometry/v6) contains files that create the original geometry. The initial design needs to be input by hand using the [NURBS package](https://octave.sourceforge.io/nurbs/). It contains functions to create a number of primitive geometric objects; the simplest design flow for 2D geometries starts by describing the outline of the geometry using a number of NURBS curves (e.g. using `nrbline` or `nrbcirc`), then divides the relevant part of the geometry into patches bounded by 4 NURBS curves each, and finally creates the necessary NURBS surfaces via `nrbcoons` or `nrbruled`. Also 3D geometries may be created using, in particular, `nrbextrude`, `nrbrevolve` or `nrbruled`.
In a last step the geometry needs to be exported to a (text) file format compatible with [GeoPDEs](http://rafavzqz.github.io/geopdes/). An example for this process is given in `write_geometryfile_v6`.

## Geometry deformation
The folder [code/geometry/optimization](https://github.com/temf/EgunOpt/tree/main/code/geometry/optimization) contains files to create and handle the deformed geometry during optimization. The function `compute_bounds` finds the constraints on the control points of the original geometry. The function `create_nrb_opt_electrode` finds and outputs the NURBS curve that describes the initial shape for the optimization, subject to the least squares fit that is performed in `nlopt_fit`. The function `create_geometry_opt` computes and writes the optimized geometry to a file, such that further analyses can be performed (e.g. evaluating the objective functions during the optimization).

## IGA (Field solution)
We use the [GeoPDEs](http://rafavzqz.github.io/geopdes/) framework to compute the electrostatic field in an axisymmetric setting. The folder [code/setup](https://github.com/temf/EgunOpt/tree/main/code/setup) contains files that describe the problem in an abstract sense, e.g. boundary conditions, material parameters, basis function degrees and so on.

The functions that solve the problem are collected in [code/iga](https://github.com/temf/EgunOpt/tree/main/code/iga). Calling the function `mp_solve_electrostatics_axi2d` allows to solve 2D axisymmetric electrostatic problems as defined using `setup_problem` from the [code/setup](https://github.com/temf/EgunOpt/tree/main/code/setup) folder.
All functions in [code/iga](https://github.com/temf/EgunOpt/tree/main/code/iga) are based on the [GeoPDEs](http://rafavzqz.github.io/geopdes/) package and make use of other functionality provided by it. If other problem types (e.g. magnetostatics) are of interest, [GeoPDEs](http://rafavzqz.github.io/geopdes/) also provides a framework for solving them, thus the implementation is not problem dependent in that sense.

## Shape optimization
Aside from the constraints on the control points, we also consider a volume constraint that is handled by the functions in [code/volume-constraint](https://github.com/temf/EgunOpt/tree/main/code/volume-constraint). The decisive function is `volume_constraint` which returns the value of the constraint in a way compatible with our optimization package of choice [NLopt](http://github.com/stevengj/nlopt).
A second folder ([code/cost-function](https://github.com/temf/EgunOpt/tree/main/code/cost-function)) contains everything needed to specify and evaluate the objective function, again in a way compatible with [NLopt](http://github.com/stevengj/nlopt). The key function is `cost_function_abs_max` as this is the one used for the shape optimization.
The actual optimization is carried out by the script `nlopt_main` which calls the interface of the package with the previously described constraints and objective function.

## Visualization
To visualize the (optimized) geometry, the boundary conditions and solution of the electric field problem, as well as some quantities related to the particle tracking, a number of plotting functions are collected in [code/plot](https://github.com/temf/EgunOpt/tree/main/code/plot). Examples for some of them are provided in the `overview_main` script.

## File management
In order to save results or prepare them for plotting with [pgfplots](https://ctan.org/pkg/pgfplots?lang=en) a number of file writing functions are collected in [code/write](https://github.com/temf/EgunOpt/tree/main/code/write). The folder also includes the functions necessary to generate the input files for interfacing with the particle tracking software [ASTRA](https://www.desy.de/~mpyflo/).
All results are collected in the folder [code/results](https://github.com/temf/EgunOpt/tree/main/code/results).

## Particle tracking
The folder [code/astra](https://github.com/temf/EgunOpt/tree/main/code/astra) contains the script `astra_main`, which calls the interface to ASTRA. In order for the script to find all the necessary files, they need to be moved from the respective subfolders of [code/results](https://github.com/temf/EgunOpt/tree/main/code/results) to the main folder [code](https://github.com/temf/EgunOpt/tree/main/code). The program files for ASTRA also need to be placed in the main folder [code](https://github.com/temf/EgunOpt/tree/main/code).

## Geometry files
The folder [igs](https://github.com/temf/EgunOpt/tree/main/code/astra) contains the geometry files for the different components in IGES format.
