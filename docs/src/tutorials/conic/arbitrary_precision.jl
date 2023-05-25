# Copyright 2017, Iain Dunning, Joey Huchette, Miles Lubin, and contributors    #src
# This Source Code Form is subject to the terms of the Mozilla Public License   #src
# v.2.0. If a copy of the MPL was not distributed with this file, You can       #src
# obtain one at https://mozilla.org/MPL/2.0/.                                   #src

# # Arbitrary precision arithmetic

# The purpose of this tutorial is to explain how to use a solver which supports
# arithmetic using a number type other than `Float64`.

# This tutorial uses the following packages:

using JuMP
import Clarabel

# ## Creating a model

# To create a model with a number type other than `Float64`, use
# [`GenericModel{T}`](@ref) with an optimizer which supports the same number
# type:

model = GenericModel{BigFloat}(Clarabel.Optimizer{BigFloat})

# !!! tip
#     `Model()` is short-hand for `GenericModel{Float64}()`.

# ## Adding decision variables

# The syntax for adding decision variables is the same as a normal JuMP
# model, except that values are converted to `BigFloat`:

@variable(model, -1 <= x[1:2] <= sqrt(big"2"))

# Note that each `x` is now a [`GenericVariableRef{BigFloat}`](@ref), which
# means that the value of `x` in a solutionn will be a `BigFloat`.

# The lower and upper bounds of the decision variables are also `BigFloat`:

lower_bound(x[1])
#-
typeof(lower_bound(x[1]))

#-
upper_bound(x[2])
#-
typeof(upper_bound(x[2]))

# ## Adding constraints

# The syntax for adding constraints is the same as a normal JuMP model, except
# that coefficients are converted to `BigFloat`:

@constraint(model, c, x[1] == big"2" * x[2])

# The function is a [`GenericaAffExpr`](@ref) with `BigFloat` for the
# coefficient and variable types;

constraint = constraint_object(c)
typeof(constraint.func)

# and the set is a [`MOI.EqualTo{BigFloat}`](@ref):

typeof(constraint.set)

# ## Adding an objective

# The syntax for adding and objective is the same as a normal JuMP model, except
# that coefficients are converted to `BigFloat`:

@objective(model, Min, 3x[1]^2 + 2x[2]^2 - x[1] - big"4" * x[2])

#-

typeof(objective_function(model))

# ## Solving and inspecting the solution

# Here's the model we have built:

print(model)

# Let's solve and inspect the solution:

optimize!(model)
solution_summary(model)

# The value of each decision variable is a `BigFloat`:

value.(x)

# as well as other solution attributes like the objective value:

objective_value(model)

# and dual solution:

dual(c)

# This problem has an analytic solution of `x = [3//7, 3 // 14]`. Currently, our
# solution has an error of approximately `1e-9`:

value.(x) .- [3//7, 3//14]

# But by reducing the tolerances, we can obtain a more accurate solution:

set_attribute(model, "tol_gap_abs", 1e-32)
set_attribute(model, "tol_gap_rel", 1e-32)
optimize!(model)
value.(x) .- [3//7, 3//14]
