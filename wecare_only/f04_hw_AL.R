# Deviation from HW
# Started: Alexey Larionov, 09Apr2017
# Last updated: Alexey Larionov, 12Apr2017

# Function to calculate HW-equilibrium 
# Accepts numbers of AA and RR homozygotes
# and number of AR heterozygotes
p_hw <- function(AA, AR, RR){

  cases_count <- sum(AA, AR, RR)
  AN <- 2*cases_count
  AC <- 2*AA + AR
  AF <- AC/AN
  
  AA_exp <- cases_count*AF^2
  AR_exp <- cases_count*2*AF*(1-AF)
  RR_exp <- cases_count*(1-AF)^2
  
  m <- c(AA_exp, AR_exp, RR_exp, AA, AR, RR)
  m <- matrix(m, ncol=2)
  #colnames(m) <- c("exp","obs")
  #rownames(m) <- c("aa","ar","rr")
  #m
  
  return(fisher.test(m)$p.value)

}

# --- Testing --- #

# Not to run 
if(FALSE){

# Common variant
AA <- 10
AR <- 23
RR <- 110
p_hw(AA, AR, RR) # ~0.02

# Rare variant
AA <- 0
AR <- 1
RR <- 100
p_hw(AA, AR, RR) # 1

# Stupid input: no alt alleles
AA <- 0
AR <- 0
RR <- 100
p_hw(AA, AR, RR) # 1

# Stupid input: no data at all
AA <- 0
AR <- 0
RR <- 0
p_hw(AA, AR, RR)
#Error in fisher.test(m) : 
#  all entries of 'x' must be nonnegative and finite 

}