# ==============================================================================
# 01_reproducible_workflow.R
# Good Data Practice — a minimal reproducible workflow
# ------------------------------------------------------------------------------
# SOST20131 / SOST30031 · Week 4 · Answering Social Research Questions with
# Statistical Models · University of Manchester
#
# This is the "first R script" of my course portfolio. It demonstrates the four
# conditions of reproducibility introduced in Week 4:
#   1. Same data + same code  =>  same result, for anyone, on any machine.
#   2. Data are READ-ONLY.     Never edit the raw file in place.
#   3. Relative paths,         anchored to the project root (the .Rproj file).
#   4. Outputs are separate    from inputs, and regenerated on demand.
#
# HOW TO RUN
#   Open "ASRQ_SOST20131_Portfolio.Rproj" in RStudio. That sets the working
#   directory to the project root, so the relative paths below resolve for
#   anyone who clones this repository. No setwd() is required.
# ==============================================================================


# ---- 0. Load the data (read-only, relative path) ----------------------------
data_file <- file.path("projects", "w04", "simpsons-paradox", "data", "simpson_700.csv")

# Fail loudly if the input is missing — silent failures break reproducibility.
stopifnot("Input data not found. Run this script from the project root." =
            file.exists(data_file))

df <- read.csv(data_file)

# ---- 1. Inspect (step 1 of the modelling cycle: data inspection) ------------
str(df)      # structure: 700 observations, 4 variables
summary(df)  # five-number summaries and counts

# ---- 2. Describe the key question -------------------------------------------
# Question: does the new drug raise the recovery rate?
cat("Sample size:", nrow(df), "\n")
cat("Recovered:", sum(df$recovered), "of", nrow(df), "\n")

# Crude (marginal) recovery rate by treatment group:
crude <- prop.table(table(df$drug, df$recovered), margin = 1)
print(round(crude, 3))

# ---- 3. Summarise by sex and treatment -------------------------------------
group_counts <- with(df, table(
  sex = factor(male, levels = c(0, 1), labels = c("female", "male")),
  treatment = factor(drug, levels = c(0, 1), labels = c("no_drug", "drug")),
  recovered = factor(recovered, levels = c(0, 1))
))
group_n <- margin.table(group_counts, c(1, 2))
group_recovered <- group_counts[, , "1"]
group_rates <- group_recovered / group_n

# ---- 4. Visualise -----------------------------------------------------------
output_dir <- file.path("projects", "w04", "simpsons-paradox", "outputs")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
png(file.path(output_dir, "recovery_by_drug_and_sex.png"), width = 800, height = 420)
par(mfrow = c(1, 2), mar = c(4, 4, 3, 1))

rates <- tapply(df$recovered, df$drug, mean)
centers <- barplot(rates, names.arg = c("No drug", "Drug"), ylim = c(0, 1.08),
                   main = "Crude recovery rate by drug",
                   col = c("grey70", "steelblue"), ylab = "Proportion recovered")
text(x = centers, y = rates + 0.04, labels = sprintf("%.1f%%", 100 * rates))

barplot(group_rates, beside = TRUE, legend.text = c("Female", "Male"),
        ylim = c(0, 1), main = "Recovery rate by drug and sex",
        col = c("indianred", "steelblue"),
        names.arg = c("No drug", "Drug"), ylab = "Proportion recovered")
dev.off()

# ---- 5. Save the same group summaries used in the plot -----------------------
out <- data.frame(
  group = as.vector(t(outer(rownames(group_n), colnames(group_n), paste, sep = "_"))),
  n = as.vector(t(group_n)),
  recovered = as.vector(t(group_recovered)),
  rate = round(as.vector(t(group_rates)), 4)
)
write.csv(out, file.path(output_dir, "summary_table.csv"), row.names = FALSE)
cat("Done. Figure and summary written to outputs/.\n")
