include("header.jl")

#=
# Fluid statics
In this notebook, we will learn
We will learn about
* About the specific weight of a fluid and how pressure increases with depth
* The concept of a fluid interface and a free surface
* How to perform basic calculations
=#

# ### Set up the module
using MAE103
#-
using Plots

#=
Fluid statics basically involves fluids that are not in motion (although we'll generalize
this later) It is described by a basic equation that governs the pressure,

$$\dfrac{\mathrm{d}p}{\mathrm{d}z} = -\rho g$$

where $\rho$ is the density of the fluid, $g$ is gravity, and $z$ is a coordinate
pointing vertically upward (i.e., $g$ is pointing in the $-z$ direction). The grouping
$\rho g$ is called the *specific weight* of the fluid, and is usually given the symbol
$\gamma$.

For example, for water, compare
=#
ρg = Density(Water)*Gravity()
# with
γ = SpecificWeight(Water)


#=
This equation shows us that pressure increases with depth, in the direction of gravity.
However, it is important to understand that it only tells us about *differences*
of pressure, not absolute pressure:

$$p_2 - p_1 = -\gamma (z_2 - z_2)$$

Notice that it doesn't matter how wide the fluid is. It could be in the ocean
or in a small tube. Only depth matters, since it is the weight of fluid *per unit
area* above a certain position that contributes to the pressure.
=#
#-
#=
To give an example of how we use this, let's first define the concept of a *free
surface*: the interface between a liquid and a gas. The most obvious example of
this is where liquid and air meet, like at the surface of the ocean or
in a bath of water. Gases are much less dense than liquids at standard conditions,
so they have much smaller specific weights.
=#
SpecificWeight(Air)
#=
This means that the pressure
variations in a static gas are much smaller than in a static liquid. As a result, it is safe to assume that (absolute) pressure in the gas is uniform, and
equal to some ambient value. For example, in air, we often assume it is 1 atm.
We often use the symbol $p_\infty$ for this ambient pressure:
=#
p∞ = Pressure(1u"atm")

#=
So let's get an appreciated for how much the pressure increases in water due to fluid
statics. For example, in 1 m of water, the pressure increases by
=#
dp = Pressure(SpecificWeight(Water)*1u"m")

#=
How much is this increase in atmospheres?
=#
value(dp,u"atm")
#=
so for every meter of depth, the pressure increases by 10 percent of one
atmosphere. This means we only need to go down to 10 meters (or 34 feet)
to increase the pressure by one atmosphere. That's not far at all.
=#

#-
#=
Because the fluid statics equation describes pressure differences, then it can be
used in a *cumulative* manner. In other words, to calculate the pressure at some
point, we add the contributions of all of the fluid (or fluids) above that point.
=#
#-
#=
### Example
A one-foot layer of glycerin lies below a 4-inch layer of water. The water is exposed
to pressurized air at $p_\infty = 3$ atm. Determine the pressure at the bottom of the glycerin
layer, in Pa.

We simply add the contributions in each layer, and the answer will be

$p = p_\infty + \gamma_w h_w + \gamma_g h_g$

where $\gamma_w$ is the specific weight of water, $h_g$ is the height of the
water layer, $\gamma_g$ the specific weight of glycerin, and $h_g$ the
height of this layer. As usual, we need to make sure that the units are consistent
with each other when we perform this calculation. For example, to get
the height of the water layer in meters,
=#
h_w = Height(4u"inch")

#=
But actually the tools in our notebooks do this all for us:
=#
Pressure(3u"atm" + SpecificWeight(Water)*4u"inch" + SpecificWeight(Glycerin)*1u"ft")
