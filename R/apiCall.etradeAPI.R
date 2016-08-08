#'get respost from etradeAPI call.  Currently is executed in the python enviromment.  
#'\code{apiCall(etradeAPI,url,path)}
#'@param etradeApi etradeAPI object that contain account information
#'@param url - base url for API call "https://etwssandbox.etrade.com" for sandbox
#'@param path - path to res object to retrieve "/accounts/sandbox/rest/accountlist.json"
#'@return value of auth code from from etrade.
#'@export
#'@examples
#'\dontrun{ auth(etradeAPI) }
#'@details Uses a combination of python and R to create an authenticated session in the python shell. \cr

apiCall.etradeAPI <- function(etradeAPI,url,path) {
  full_url <- httr::modify_url(url=url, path = path)
  
  #Build the command
  
  cmd<-paste0("raw = session.get('",full_url,"')")
  
  #Execute the command
  rPython::python.exec(cmd)
  
  
  
  
  # Header data avialable  
  #   {'transfer-encoding': 'chunked',
  #     'keep-alive': 'timeout=60, max=400',
  #     'server': 'Apache',
  #     'connection': 'Keep-Alive',
  #     'pragma': 'no-cache',
  #     'cache-control': 'no-cache,no-store',
  #     'date': 'Sat, 06 Aug 2016 19:37:24 GMT',
  #     'content-type': 'application/json',
  #     'apiservername': '20w44m3'}
  
  
  rPython::python.get("raw.headers['content-type']")
  rPython::python.get("raw.status_code")
  rPython::python.get("raw.text")
  rPython::python.get("raw.url")
  
  #we expect status 200
  if( rPython::python.get("raw.status_code") != 200 ) {
    stop("API did not return staus 200", call. = FALSE)
  }
  
  #and  and json content
  
  if (rPython::python.get("raw.headers['content-type']") != "application/json") {
    stop("API did not return json", call. = FALSE)
  }
  
  header <- list(status=rPython::python.get("raw.status_code"),content_type=rPython::python.get("raw.headers['content-type']"),
                 url = rPython::python.get("raw.url") )
  
  
  parsed <- jsonlite::fromJSON(rPython::python.get("raw.text"), simplifyVector = FALSE)
  
  structure(
    list(
      content = parsed,
      path = path,
      header = header
    ),
    class = "github_api"
  )
}

print.etrade_api <- function(x, ...) {
  cat("<GitHub ", x$path, ">\n", sep = "")
  str(x$content)
  invisible(x)
}


#url<-"https://etwssandbox.etrade.com"

#path<-"/accounts/sandbox/rest/accountlist.json"

#apiCall(api,url,path)

