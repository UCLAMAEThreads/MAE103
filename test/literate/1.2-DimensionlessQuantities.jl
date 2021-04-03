include("header.jl")


#=
# Dimensionless quantities
In this notebook, we will learn about making quantities dimensionless,
and the physical significance of this.
=#

# ### Set up the module
using MAE103
#-
using Plots

#=
In the previous notebook, we made a plot of the velocity field in a gap
between two walls. We'll regenerate the plot here for reference:
=#
u(y,Uc,H) = 4*Uc/H^2*y*(H-y)
H = 1u"cm"
Uc = 1u"m/s"
y = range(0u"cm",H,length=101)
v = u.(y,Uc,H)
plot(v,y,xlim=(0,Inf),ylim=(0,Inf),xlabel=L"u(y)",ylabel=L"y")

#=
In this plot, the data have units---they are *dimensional* data.
This is useful, since the plot not only conveys the velocities, but
also the gap size and the flow speed.

Let us also note that the plot is quite specific, since it only shows
the plot for *one* choice of gap size (1 cm) and *one* choice of flow speed (1 m/s).
Of course, it is not difficult for us to get plots at different gap sizes
and flow speeds by simply changing the parameters.

But suppose that these data were measured in an experiment. For the experiment,
let's say we constructed one gap $H$, we applied one flow speed $U_c$, and
we measured the resulting profile of fluid velocity across the gap. Then this plot,
at these specific conditions, would not be directly useful to someone else who would like
to know the velocity profile in a different size gap at a different flow speed.

If, instead, we divide the velocity data `v` by flow speed `Uc` and divide the position
data `y` by gap size `H`, then we "scale out" the specific choices for these parameters:
=#
plot(v/Uc,y/H,xlim=(0,Inf),ylim=(0,Inf),xlabel=L"u(y)/U_c",ylabel=L"y/H",yticks=0:0.25:1)

#=
This is a *dimensionless plot*. The values on each axis have no units. It is more
directly useful to another person, because they can read off
the values for a particular position *as a fraction of gap height*,
and find the velocity *as a fraction of the centerline velocity*. Then, they can
"scale" this plot to their own situation.
=#

#-
#=
### Unit as a reference quantity.
The principle of "scaling out" the parameters is very important. But before we
go deeper into this, let us make an observation on units.

A unit is a reference value, and this reference is standardized so we can communicate
results with one another on a common foundation. What does it mean to be a reference?

When we measure something, we are basically comparing that something with another
thing that has been calibrated on a particular unit system. A ruler is the easiest
example of this: the ruler was constructed by marking off lines on a stick,
with each line determined from some other reference that the ruler manufacturer used.
Ultimately, all of these measurement tools refer back to some ultimate standard
for the unit (e.g. for a meter, it is length of the path travelled by light in a
vacuum in 1/(299,792,458) of a second.)

It is important to remember that the quantity we're measuring is not intrinsically
tied to any unit. It is more abstract than that. And when we measure it and make
our comparison, we are basically taking a ratio of the quantity with the standard
unit. For example, when we say the gap $H$ is 0.1 cm high, we could also write this
as
$$\dfrac{H}{1\,\mathrm{cm}} = 0.1$$

However, it is a reference that we (humans) invented, so it is completely irrelevant
to physics. On the other hand, if we instead choose as a reference some parameter
in the problem itself, then we are much more likely to have a *physically
meaningful* reference. In this problem, the gap height is clearly physically
meaningful, so it serves as a natural *length scale*. The centerline velocity
is a natural *velocity scale*.

Actually, the statement that the dimensionless velocity plot has "no units" isn't
quite true. There *are* units on this plot. The units of position are "gap heights"
and the units of velocity are "centerline velocities". We can say, for example,
the: "the velocity at 0.2 gap heights from the lower wall is 0.64 times the centerline
velocity").
=#


#-

#=
In summary, there are several advantages to the dimensionless view:
- There is no ambiguity about which system we used. It doesn't matter if
  the original parameters and values were in SI or imperial.
- Since the laws of physics hold regardless of our system of units, this sort of plot
    reveals true physical relationships between velocity and location.
- The dimensionless relationship is *universal*: it holds for *every* gap size and
  *every* flow speed. We know that this is true here because the exact velocity
  field was actually known to us:

  $$u(y) = \frac{4U_c}{H^2} y (H - y)$$

  But let's divide this by $U_c$ and group $y$ with $H$:

  $$\dfrac{u}{U_c} = 4 \dfrac{y}{H}\left(1 - \dfrac{y}{H})$$

  This shows that $u/U_c$ depends on $y/H$ *and nothing
else*. There are no "free" parameters in this dimensionless relationship. We
will return to this point in the next notebook.
- We are lucky here because we already knew the mathematical equation. In most
cases, we aren't this lucky. But as we will discuss in the next notebook, once we
  ascertain the number of
  dimensionless quantities that fully describe a relationship, we can develop an
  *empirical correlation of data*. But this correlation should only be pursued
  on dimensionless data.     
=#
