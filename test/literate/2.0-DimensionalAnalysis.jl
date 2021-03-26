include("header.jl")

#=
# Dimensional analysis example - pump flow
In this example, we will find an appropriate set of dimensionless parameters that
relate pressure increase across a pump to the flow rate through the pump. We start
with the basic expectation that pressure increase $\Delta p$ should depend on $D$
(the diameter of the pump), $\rho$ (the fluid density), $\omega$ (the rotational speed),
and $Q$ (the volume flow rate)

$$\Delta p = f(D,\rho,\omega,Q)$$

=#

# ### Set up the module
using MAE103
#-
using Plots
using JLD # to read/write data

#=
### Read in some raw data
First, we will read in some raw experimental data for a pump of diameter 12 in.
These data give the measured pressure rise (as *head increase*, $h_p$, units of meters)
vs volume flow rate (in units of cubic meters per second).

We will load in data for pump speeds of 250, 500 and 1000 rpm. For later convenience,
we will put all of these data into one data structure called `pumpdata`.
=#
pumpdata = load("pumpdata.jld")

#=
The data is in the form of a `Dict` (short for dictionary). For example,
to get the flow rates for speed 500 rpm,
=#
pumpdata["500rpm"]["Q"]

# and the associated head increases are
pumpdata["500rpm"]["head"]

#=
Let's plot this data
=#
scatter(xlabel=L"$Q$ (m$^3$/s)",ylabel=L"$h$ (m)",legend=true,xlims=(0,Inf),ylims=(0,Inf))
scatter!(pumpdata["250rpm"]["Q"],pumpdata["250rpm"]["head"],label="250 rpm")
scatter!(pumpdata["500rpm"]["Q"],pumpdata["500rpm"]["head"],label="500 rpm")
scatter!(pumpdata["1000rpm"]["Q"],pumpdata["1000rpm"]["head"],label="1000 rpm")
#=
The data don't appear very similar to each other, except for a rough shape.
And more importantly, these are only curves for three pump speeds. What if
we want to predict the performance at, say, 700 rpm?
=#
#-
#=
### Find a suitable set of dimensionless parameters ($\Pi$ groups)
Here, we should think of $\Delta p$ as the dependent variable and $Q$ as the
independent variable -- this is what defines a pump's characteristics. The other
quantities are the reference quantities. It is straightforward to come up with the
$\Pi$ groups:

$$\dfrac{\Delta p}{\rho \omega^2 D^2} = f \left( \dfrac{Q}{\omega D^3} \right)$$
=#
#-
#=
### Rewrite the first $\Pi$ group in terms of the pump's head gain, $h_p$.
From the energy equation, $h_p + p_1/\rho g = p_2/\rho g$, where $\Delta p = p_2 - p_1$.
Thus, we can rewrite the first $\Pi$ group in terms of $h_p$, so that the relationship is

$$\dfrac{g h_p}{\omega^2 D^2} = f \left( \dfrac{Q}{\omega D^3} \right)$$
=#

#=
### Calculate the $\Pi$ groups and plot them on the same plot
We will now use the raw dimensional data in `pumpdata` to calculate the
$\Pi$ groups. However, we need to make sure all of the quantities are in a common
system of units first. We have the pump data in SI units already. We will also
convert the pump speed and diameter to SI.
=#
D_in = 12
omega_rpm = [250,500,1000];

#=
For the conversion, we need a few conversion factors:
=#
g_mpersec2 = 9.81
rpm_to_radpersec = 2π/60
in_to_cm = 2.54
cm_to_m = 1/100

#=
Now get SI values for each of the parameters
=#
D = D_in*in_to_cm*cm_to_m
g = g_mpersec2
omega = omega_rpm*rpm_to_radpersec;


#=
We can now calculate the $\Pi$ groups. We will refer to these as `Q_nd`
and `head_nd` (`nd` for non-dimensional):
=#
omega = 250*rpm_to_radpersec
pumpdata["250rpm"]["Q_nd"] = pumpdata["250rpm"]["Q"]/(omega*D^3)
pumpdata["250rpm"]["head_nd"] = pumpdata["250rpm"]["head"]*g/(omega^2*D^2)
#-
omega = 500*rpm_to_radpersec
pumpdata["500rpm"]["Q_nd"] = pumpdata["500rpm"]["Q"]/(omega*D^3)
pumpdata["500rpm"]["head_nd"] = pumpdata["500rpm"]["head"]*g/(omega^2*D^2)
#-
omega = 1000*rpm_to_radpersec
pumpdata["1000rpm"]["Q_nd"] = pumpdata["1000rpm"]["Q"]/(omega*D^3)
pumpdata["1000rpm"]["head_nd"] = pumpdata["1000rpm"]["head"]*g/(omega^2*D^2)

#=
Now plot these
=#

scatter(xlabel=L"$Q/\omega D^3$",ylabel=L"$gh/\omega^2 D^2$",legend=:bottomleft,xlims=(0,0.1),ylims=(0,0.25))
scatter!(pumpdata["250rpm"]["Q_nd"],pumpdata["250rpm"]["head_nd"],label="250 rpm")
scatter!(pumpdata["500rpm"]["Q_nd"],pumpdata["500rpm"]["head_nd"],label="500 rpm")
scatter!(pumpdata["1000rpm"]["Q_nd"],pumpdata["1000rpm"]["head_nd"],label="1000 rpm")

#=
The data collapse onto a single curve. This reveals the power of dimensional
analysis! One would follow up by generating a statistical correlation
between the two dimensionless parameters. Then, we could use this correlation
to predict performance at any pump speed or pump diameter!
=#

#savefig("pumpplot.pdf")
