using RecipesBase
using ColorTypes
import PlotUtils: cgrad, palette, color_list
using LaTeXStrings
using UnitfulRecipes


@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S <: MAE103.FlowQuantity, T <: MAE103.FlowQuantity}
    value.(x), value.(y)
end
@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S <: MAE103.FlowQuantity, T}
    value.(x), y
end
@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S, T <: MAE103.FlowQuantity}
    x, value.(y)
end
