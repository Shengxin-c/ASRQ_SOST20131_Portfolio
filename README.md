# ASRQ SOST20131 / SOST30031 — E-Portfolio

**Answering Social Research Questions with Statistical Models** · University of Manchester · 2026/27

This repository is my course e-portfolio: a living record of how I learn to answer
social research questions with statistical models, and a showcase of reproducible
data analysis in R.

## About me

I'm **Shengxin Chen**, a BA Economics and Data Analytics student at the
University of Manchester. My background spans econometrics, statistics, and data
analysis (R, Python, Excel, Power BI). I use this course to make my analysis
transparent, reproducible, and reviewable — and this repository to make that work
visible.

## Purpose

- **Learn in public** — record notes, code, and reflections week by week.
- **Practise reproducibility** — every result should be re-creatable from the
  data and scripts in this repo, by anyone, on any machine.
- **Build a portfolio** — demonstrate the modelling workflow the course
  assesses: inspect → specify → fit → criticise.

## Repository structure

```
ASRQ_SOST20131_Portfolio/
├── README.md                         # this file
├── reflection.md                     # Week 4 reflection on reproducibility
├── data/
│   └── simpson_700.csv               # read-only input (Week 2 practical)
├── R/
│   ├── 01_reproducible_workflow.R    # first script: a minimal workflow
│   ├── 02_simpsons_700_regression.R  # Simpson's paradox in regression
│   └── 03_dag_adjustment.R           # DAGs & adjustment sets with dagitty
└── outputs/                          # figures & tables (regenerated, gitignored)
```

## Reproducibility

- **Data are read-only** and live in `data/`; scripts never edit them in place.
- **Relative paths** are anchored to the project root — open the `.Rproj` file.
- **Outputs are regenerated** by running the scripts; they are not stored in git.

## Course

SOST20131/30031 — *Answering Social Research Questions with Statistical Models*
covers causal diagrams (DAGs), linear and logistic regression, and reproducible
analysis. Key deadlines:

- Formative (DAG application): Mon 2 Nov 2026, 14:00
- Part 1 (40%): Mon 30 Nov 2026, 14:00
- Part 2 (60%): Sun 11 Jan 2027, 14:00
