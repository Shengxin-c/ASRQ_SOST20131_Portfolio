# Simpson’s paradox in recovery rates

How does the estimated association between treatment and recovery change after
adjusting for sex? The input is the 700-person teaching example from the
SOST20131/30031 Week 2 practical. The bundled CSV stores treatment, sex and
recovery as binary indicators.

From the repository root, run these independent base R scripts:

```sh
Rscript projects/w04/simpsons-paradox/R/01_reproducible_workflow.R
Rscript projects/w04/simpsons-paradox/R/02_simpsons_700_regression.R
```

The first script writes a recovery-rate plot and a summary CSV under this
project’s `outputs/`. The second prints crude, adjusted and interaction models.
The crude difference is about −4.6 percentage points. Adjusting for sex changes
the treatment coefficient to about +5.4 percentage points. The comparison
illustrates how group composition can change an association. A causal
interpretation depends on the assumed confounding structure.
