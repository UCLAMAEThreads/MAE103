include("header.jl")

#=
# Flow quantities and units
In this notebook, we will discuss *fluid properties* and *flow quantities*,
and the systems of units we use for them. We will also introduce some syntax
we will use in this notebook and those that follow for dealing with units.
=#

# ### Set up the module
using MAE103

#=
We will generally focus on SI units, and these will be the default system
for displaying quantities. However, we also need to be familiar
with Imperial (sometimes called "English") units, which arise in many
situations in engineering. In the examples below, we will show that the tools
in these notebooks allow us to easily convert from one system to another.

For any quantity, we can see what the default units are by using `default_unit`.
For example, for pressure,
=#
default_unit(Pressure)
#-
#=
### Fluid properties
Let's start by discussing the basic properties of a fluid. The **density**
provides a measure of the amount of fluid material per unit volume.
=#
default_unit(Density)
#=
For example, 
=#
