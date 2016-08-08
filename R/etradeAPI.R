#'Creates a object of class etradeAPI that contains account information  
#'\code{etradeAPI("path to json")}
#'@param etradeAccountInfo file with account information in json format.
#'@return Object of class etradeAPI
#'@export
#'@examples
#'\dontrun{ etradeAuth("path to json") }
#'@details Creates a object of class etradeAPI that contains account information. \cr
#'          Requires a json file that contins the urls and account information for etrade
#'         
#'\code{
#'            [{
#'              "consumer_key": "xxxxxxxxx",         \cr
#'              "consumer_secret": "xxxxxxxxx",      \cr
#'              "request_token_url": "xxxxxxxxx",    \cr
#'              "authorize_token_url": "xxxxxxxxx",  \cr
#'              "access_token_url": "xxxxxxxxx",     \cr
#'              "username": "xxx",                   \cr
#'              "userpass": "xxx"                    \cr
#'            }]                                     \cr
#' }
etradeAPI<- function(etradeAccountInfo )
{  
  structure(
    list(account=jsonlite::fromJSON(etradeAccountInfo),
         
         tokens = list(access_token = NULL, access_token_secret=NULL)  
    )
    
  ,class="etradeAPI"
  )
  
  
  
}

