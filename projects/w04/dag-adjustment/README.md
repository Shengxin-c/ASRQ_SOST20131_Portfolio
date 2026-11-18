# DAG adjustment for education and income

This hypothetical example examines how to estimate the total effect of
education on income. The script defines the graph directly. It treats ability
and family background as common causes, job as a mediator, and work as a
collider.

Install `dagitty` with `install.packages("dagitty")` in R. From the repository
root, run:

```sh
Rscript projects/w04/dag-adjustment/R/03_dag_adjustment.R
```

The script prints the paths and minimal adjustment sets and saves a diagram
under this project’s `outputs/` in a non-interactive session. Under the stated
graph, the expected minimal set is ability and family background.
