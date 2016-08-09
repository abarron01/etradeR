#'Authenticates and create valid session.  
#'\code{auth("path to json")}
#'@param etradeApi etradeAPI object that contain account information
#'@param debug Print out debug information, default = FALSE
#'@return value of auth code from from etrade.
#'@export
#'@examples
#'\dontrun{ etradeAuth("path to json") }
#'@details Uses a combination of python and R to create an authenticated session in the python shell. \cr


#Generic for auth function

auth <- function(etradeAPI,debug){ UseMethod("auth",etradeAPI)}

