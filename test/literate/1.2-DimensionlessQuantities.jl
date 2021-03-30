include("header.jl")



#=
# Dimensionless quantities
In this notebook, we will learn about making quantities dimensionless,
and the physical significance of this.
=#

#=
#### Dimensionless plots
In the previous plots, we made plots in which the data had units. In other words,
they were *dimensional* data. This is often important, since it conveys that the
gap size and the flow speed.

However, from a *physics* standpoint, it is too specific, since it only shows
the plot for *one* choice of gap size (1 cm) and *one* choice of flow speed (1 m/s).

If, instead, we divide the velocity data `v` by flow speed `Uc` and divide the position
data `y` by gap size `H`, then we "scale out" the specific choices for these parameters.
=#
plot(v/Uc,y/H,xlim=(0,Inf),ylim=(0,Inf),xlabel=L"u(y)/U_c",ylabel=L"y/H",yticks=0:0.25:1)

#=
This is a dimensionless plot. The values on each axis have no units. There are
several advanages to this:
- There is no ambiguity about which system we used. It doesn't matter if
  the original parameters and values were in SI or imperial.
- The plot is *universal*: it holds for *every* gap size and *every* flow speed.
- Since the laws of physics regardless of our system of units, this sort of plot
  reveals the true physical relationships.

Actually, the statement regarding "no units" isn't quite true. There *are* units
on this plot. The units of position are "gap heights" and the units of velocity
are "centerline velocity". We can describe these as in the following example:
"the velocity at 0.2 gap heights from the lower wall is 0.64 times the centerline
velocity"). (Notice that we set the tick marks explicitly, to make sure the
centerline was on a tick.)
=#
#-
#=
We will come back to this point about dimensional vs. non-dimensional later.
However, let us conclude it for now by observing that a unit is a reference.
It is a standardized reference that we use to compare results with one another.
However, it is reference that we (humans) invented, so it is completely irrelevant
to physics. On the other hand, if we instead choose as a reference some parameter
in the problem itself, then we are much more likely to have a *physically
meaningful* reference. In this problem, the gap height is clearly physically
meaningful, so it serves as a natural *length scale*.
=#
#-
