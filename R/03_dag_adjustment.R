# ==============================================================================
# 03_dag_adjustment.R
# Directed acyclic graphs and minimal adjustment sets with `dagitty`
# ------------------------------------------------------------------------------
# Weeks 2–3 introduced DAGs, back-door paths, confounders, mediators and
# colliders. `dagitty` automates the back-door criterion: give it the graph and
# it returns the set(s) of variables you must adjust for to identify the effect
# of an exposure on an outcome.
#
# Install once (uncomment the line below):
#   install.packages("dagitty")
# ==============================================================================

library(dagitty)

# Research question: does education (educ) raise income (income)?
# Illustrative DAG:
#   - ability and family background CONFOUND educ -> income
#   - job is a MEDIATOR  (educ -> job -> income):    do NOT adjust for it
#   - work is a COLLIDER (educ -> work <- income):   do NOT adjust for it
dag <- dagitty("dag {
  ability -> educ
  ability -> income
  family  -> educ
  family  -> income
  educ    -> job
  job     -> income
  educ    -> work
  income  -> work
}")

plot(dag)

# ---- 1. Every path between exposure and outcome, with open/blocked status ---
paths(dag, from = "educ", to = "income")
#    Back-door paths (start with an arrow INTO educ) must be blocked.
#    educ <- family  -> income   is a back-door path (confounder: family)
#    educ <- ability -> income   is a back-door path (confounder: ability)

# ---- 2. Minimal sufficient adjustment sets (back-door criterion) ------------
adjustmentSets(dag, exposure = "educ", outcome = "income")
#    Expect: { ability, family }  — the two confounders, and nothing else.

# ---- 3. Why the naive choices fail ------------------------------------------
#    - Adjusting for `job`  blocks the genuine educ -> job -> income channel
#      (over-adjustment: it removes part of the effect we want to estimate).
#    - Adjusting for `work` opens the collider path educ -> work <- income,
#      introducing selection bias where none existed.

# dagitty confirms both mistakes when you ask for the paths AFTER conditioning:
# adjustmentSets(dag, exposure = "educ", outcome = "income", effect = "total")
