# Reflection: why reproducibility matters in social research

Reproducibility means that another researcher, supplied with the same data and code, can arrive at the same result. In social research, this matters for a reason particular to the discipline: our analyses are shaped by many small, consequential decisions. How we code a variable, which model we select, and how we deal with missing data — each choice has the potential to alter our findings. Where these decisions remain undisclosed, readers cannot distinguish whether a finding stems from the data itself or from the researcher’s choices.

The discipline has borne the cost of this lack of transparency. High-profile cases where published results could not be replicated have eroded trust in the social sciences. Transparency — sharing data, code, and the rationale behind each decision — offers the solution. It transforms a claim from something we are expected to take on trust into something we can independently verify.

Version control facilitates this directly. Git records the versions I commit, so I can see when an analytical decision changed and revisit the code behind a result.

In my Simpson’s paradox example, the crude recovery rate was about 4.6 percentage points lower in the treatment group. After adjusting for sex, the treatment coefficient was about 5.4 percentage points higher. Keeping the input data, group definitions and code together lets a reader trace that reversal.

For me, reproducibility also has practical merit. Developing an e-portfolio compels me to write code that others are able to run, which in turn makes my own work far easier to revisit and repurpose. Reproducibility is not an optional add-on to rigorous analysis; it is what makes analysis credible.
