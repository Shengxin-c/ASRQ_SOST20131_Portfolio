# ==============================================================================
# 02_simpsons_700_regression.R
# Simpson's paradox, quantified with linear regression
# ------------------------------------------------------------------------------
# The 700-patient table from the Week 2 practical (Nick Shryane). The SAME data
# support opposite conclusions depending on whether we control for sex:
#   - crude:      the drug looks harmful  (78% vs 83% recovered)
#   - stratified: the drug helps within   each sex (male 93% vs 87%, female 73% vs 69%)
#
# Below I reproduce that reversal in regression form. Sex is a CONFOUNDER here
# (it affects both who gets the drug and the chance of recovery), so the correct
# model controls for it — Model B. Watch the drug coefficient change sign.
#
# Expected coefficients (pre-verified):
#   Model A: intercept = 0.8257,  drug = -0.0457
#   Model B: intercept = 0.6788,  drug = +0.0538,  male = +0.1904
#   Model D: intercept = 0.6875,  interaction   = +0.0218
# ==============================================================================

df <- read.csv(file.path("data", "simpson_700.csv"))

# Recode to labelled factors. The reference levels are "no" (drug) and
# "female" (male), so every drug/male coefficient is relative to that baseline.
df$drug <- factor(df$drug, levels = c(0, 1), labels = c("no", "yes"))
df$male <- factor(df$male, levels = c(0, 1), labels = c("female", "male"))

# ---- Model A: crude (ignore sex) --------------------------------------------
mA <- lm(recovered ~ drug, data = df)
summary(mA)
#    (Intercept) = 0.8257   (recovery rate among the untreated)
#    drugyes     = -0.0457  (the drug looks harmful)

# ---- Model B: control for sex (the confounder) ------------------------------
mB <- lm(recovered ~ drug + male, data = df)
summary(mB)
#    (Intercept) = 0.6788   (female, untreated)
#    drugyes     = +0.0538  (sign FLIPS once sex is controlled)
#    malemale    = +0.1904  (men recover more often, on average)

# ---- Model D: saturated (add the drug:male interaction) ---------------------
mD <- lm(recovered ~ drug * male, data = df)
summary(mD)
#    (Intercept)           = 0.6875 = 55/80  (female, untreated)
#    drugyes:malemale      = +0.0218 (interaction, far from significant)

# ---- Does the interaction add anything? -------------------------------------
anova(mB, mD)
#    F ~ 0.10, p ~ 0.75  ->  the simpler additive model (B) is preferred.

# ---- Takeaway ----------------------------------------------------------------
# The crude -0.0457 becomes +0.0538 after adjustment. This is Simpson's paradox
# in coefficient form: the sign of a treatment effect can reverse when a
# confounder (sex) is omitted. Deciding to control for sex is a CAUSAL judgment,
# not a statistical one.
