# test.R
# AL, 03Apr2017

# Prepare data
dat.df <- read.table("data.txt", quote="", sep="\t", header=TRUE, row.names = 1)
str(dat.df) # all columns are numeric
Y <- dat.df[,1]
E <- as.matrix(dat.df[,2:4])
G <- dat.df[,5:14]

# Prepare matrix for output
result.mx <- matrix(ncol=4, nrow=0) 
colnames(result.mx) <- c("variant_id", "p_glm_wald", "p_glm_anova_lrt", "p_glm_lrt")

# Run tests
for(var in 1:ncol(G)){
  
  # Get vector of genotypes  
  X <- G[,var]
  
  # --- Calculate the regression models --- #
  
  regE <- glm(Y ~ E, family=binomial) # Null model
  regXE <- glm(Y ~ X + E, family=binomial) # Complete model
  
  # --- Calculate p-estimates --- #
  
  # Wald (?) test
  p_glm_wald <- summary(regXE)$coef["X", "Pr(>|z|)"]
  
  # Anova-LRT
  anova_lrt <- anova(regXE, test="LRT")
  p_glm_anova_lrt <- anova_lrt["X", "Pr(>Chi)"]
  
  # LRT
  chi_stat_lrt = 2*(logLik(regXE) - logLik(regE))
  p_glm_lrt = 1-pchisq(chi_stat_lrt, df=1) # Why df=1? (it was taken from one of your examples)
  
  # p_glm_lrt
  # 'log Lik.' 0.1234567 (df=5)
  # Why df is different from what was asked
  
  # --- Record results --- #
  
  result.mx <- rbind(result.mx, c(var, p_glm_wald, p_glm_anova_lrt, p_glm_lrt))

}

result.mx
# variant 7: p_lrt=1 and p_wald=0 
#            How could it be?