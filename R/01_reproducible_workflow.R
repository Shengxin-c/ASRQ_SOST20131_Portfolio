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
data_file <- file.path("data", "simpson_700.csv")

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

# ---- 3. Visualise -----------------------------------------------------------
# Outputs go to outputs/, never back into data/ (inputs stay read-only).
dir.create("outputs", showWarnings = FALSE)

png("outputs/recovery_by_drug_and_sex.png", width = 800, height = 420)
par(mfrow = c(1, 2), mar = c(4, 4, 3, 1))

# Left: crude comparison — the drug appears to HURT (78% vs 83%).
rates <- tapply(df$recovered, df$drug, mean)
barplot(rates, names.arg = c("No drug", "Drug"), ylim = c(0, 1),
        main = "Crude recovery rate by drug",
        col = c("grey70", "steelblue"), ylab = "Proportion recovered")
text(x = 1:2, y = rates + 0.04, labels = sprintf("%.1f%%", 100 * rates))

# Right: stratify by sex — within each sex the drug HELPS (Simpson's paradox).
female <- c(no_drug = 55 / 80, drug = 192 / 263)
male   <- c(no_drug = 234 / 270, drug = 81 / 87)
m <- rbind(Female = female, Male = male)
barplot(m, beside = TRUE, legend.text = rownames(m), ylim = c(0, 1),
        main = "Recovery rate by drug and sex",
        col = c("indianred", "steelblue"),
        names.arg = c("No drug", "Drug"), ylab = "Proportion recovered")

dev.off()

# ---- 4. Save a tidy summary -------------------------------------------------
out <- data.frame(
  group = c("female_no_drug", "female_drug", "male_no_drug", "male_drug"),
  n     = c(80, 263, 270, 87),
  recovered = c(55, 192, 234, 81)
)
out$rate <- round(out$recovered / out$n, 4)
write.csv(out, "outputs/summary_table.csv", row.names = FALSE)

cat("Done. Figure and summary written to outputs/.\n")
