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
Let's start by discussing the basic properties of a fluid.

#### Density
The **density** provides a measure of the amount of fluid material per unit volume.
It is measured in units of mass/volume:
=#
default_unit(Density)

#=
For example, the density of water at a reference temperature of 15.6 degrees C is
=#
Density(Water)

#=
and for air at temperature of 15 degrees C and pressure of 1 atmosphere is
=#
Density(Air)

#=
Notice that water is around 800 times denser than air. This fact is very important
in fluid mechanics!
=#

#=
Remember that the density of gases, like air, depend on pressure and temperature (by
the ideal gas law), so this density is sensitive to the conditions. Liquid
density is not as sensitive.

However, the density of seawater is larger (at average salt concentration)
is larger than that of freshwater
=#
Density(Seawater)


#=
What if we want to set the density in other units? For example, in imperial
units, we would usually set it with lb/ft^3. (In the notebooks, we use `lb` for
pound (mass), and `lbf` is used for pound (force).) To set the units of a quanity,
rather than rely on the default units, we use the syntax to follow the number with
 `u"units"`. It will automatically convert it to the default units. For example, 2 lb/ft^3:
=#
Density(2u"lb/ft^3")

#=
and to report the value of a quantity in other units, we use the `value`
function. For example, to get the density of water in lb/ft^3:
=#
value(Density(Water),u"lb/ft^3")

#=
#### Pressure
Pressure represents the average force that the molecules exert per unit
area of surface. It is important to understand that pressure acts the same in every
direction. That is, it is an *isotropic* quantity. This means that, no matter
what the orientation of the surface, the pressure acts the same on it, and further,
it only acts *perpendicular* to the surface.

The default SI unit of pressure is the *Pascal* (Pa, equal to 1 N/m^2, or 1 kg/m/s^2).
=#
Pressure(20)

#=
But there are many other units for pressure in use. Some common ones. The
atmosphere (atm) represents the standard ambient pressure.
=#
p = Pressure(1u"atm")
#=
So 1 atm is about 101325 Pa, or 101.325 kPa. Let's see this written in other units
=#
value(p,u"psi")
#-
value(p,u"mmHg")
