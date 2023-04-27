# [Nonlinear Modeling](@id NonlinearAPI)

More information can be found in the [Nonlinear Modeling](@ref) section of the
manual.

## User-defined functions

```@docs
@register
add_user_defined_function
UserDefinedFunction
```

## Derivatives

```@docs
NLPEvaluator
```

## Legacy interface

```@docs
@NLconstraint
@NLconstraints
@NLexpression
@NLexpressions
@NLobjective
@NLparameter
@NLparameters
NonlinearExpression
NonlinearParameter
nonlinear_model
add_nonlinear_expression
add_nonlinear_constraint
set_nonlinear_objective
num_nonlinear_constraints
all_nonlinear_constraints
nonlinear_dual_start_value
set_nonlinear_dual_start_value
value(::JuMP.NonlinearParameter)
set_value(::JuMP.NonlinearParameter, ::Number)
register
```
