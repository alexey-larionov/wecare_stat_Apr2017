# Function for handling errorsa and warnings
# Motivated by demo(error.catching)
# Started: Alexey Larionov, 09Mar2017
# Last updated: Alexey Larionov, 25Mar2017

# Description:
# Tries to execute an expression. 
# Returns a list with 4 elements:
# - value (if expression succeeded without error; NA if error)
# - info (succeeded, warning, error), 
# - error message (if generated, NA of no error) 
# - warning message (if generated, NA if no warning) 

# Notes:
# 1) The function does NOT expect simulteneous error+warning. 
#    This may need to be dealt with later - see (*)
# 2) Sometime errors are not generated when expected, 
#    this cannot be handled with tryCatch, e.g:
#    tryCatchAL(1/0)

# (*)
# See about double-error, which generates error(s) + warning:
# http://stackoverflow.com/questions/20596902/r-avoiding-restarting-interrupted-promise-evaluation-warning

# Tests: 
# tryCatchAL(1/2)
# tryCatchAL(1/"A")
# tryCatchAL(chisq.test(matrix(c(1,2,3,4,5,6), nrow=2)))

tryCatchAL <- function(expr)
{
  
  # Initial settings
  V <- NA
  I <- "succeeded"
  W <- NA
  E <- NA
  
  # Warning handler
  w.handler <- function(w){
    
    # Record information about warning
    # <<- is for assignment outside the function scope (i.e. in the external environment)
    # http://stackoverflow.com/questions/2628621/how-do-you-use-scoping-assignment-in-r
    I <<- "warning"
    W <<- w
    
    # Execute expression again, suppressing warnings
    invokeRestart("muffleWarning")
    
  }
  
  # Error handler
  e.handler <- function(e){
    
    # Record information about error
    I <<- "error"
    E <<- e
    
    # Do not return error message as a value
    return(NA)
    
  }
  
  # Try to execute the expression
  V <- withCallingHandlers(tryCatch(expr, error=e.handler), warning=w.handler)
  
  # Return value
  list(value = V,
       info = I,
       warning = W,
       error = E)
}
