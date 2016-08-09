#'get respost from etradeAPI call.  Currently is executed in the python enviromment.  
#'\code{apiCall(etradeAPI,url,path)}
#'@param etradeApi etradeAPI object that contain account information
#'@param url - base url for API call "https://etwssandbox.etrade.com" for sandbox
#'@param path - path to res object to retrieve "/accounts/sandbox/rest/accountlist.json"
#'@param query - list containind query key - value pairs
#'@return value of auth code from from etrade.
#'@export
#'@examples
#'\dontrun{ auth(etradeAPI) }
#'@details Uses a combination of python and R to create an authenticated session in the python shell. \cr
#'
#
# Generic for apiCall
apiCall <- function(etradeAPI,url,path,query){ UseMethod("apiCall",etradeAPI)}