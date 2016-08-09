#'@export


auth.etradeAPI <-function(etradeAPI,debug=FALSE){
  
  #function need error checking
  
  #Start up Selenuim
  
  RSelenium::checkForServer()
  RSelenium::startServer()
  
  #read account info
 # etrade_info<-jsonlite::fromJSON(etradeInfo)
  
  
  #load info in python
  
  rPython::python.assign("username",etradeAPI$account$username)
  rPython::python.assign("userpass",etradeAPI$account$userpass)
  rPython::python.assign("consumer_key",etradeAPI$account$consumer_key)
  rPython::python.assign("consumer_secret",etradeAPI$account$consumer_secret)
  rPython::python.assign("request_token_url",etradeAPI$account$request_token_url)
  rPython::python.assign("authorize_token_url",etradeAPI$account$authorize_token_url)
  rPython::python.assign("access_token_url",etradeAPI$account$access_token_url)
  
  remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost" 
                                   , port = 4444
                                   , browserName = "chrome"
  )
  
  remDr$open()
  
  
  remDr$navigate("https://us.etrade.com/e/t/user/logout")
  remDr$navigate("https://us.etrade.com/e/t/user/login")
  if(debug) remDr$screenshot(display = TRUE)
  
  
  Sys.sleep(3)
  userbox <- remDr$findElement(using = 'name', "USER")
  Sys.sleep(3)
  userbox$sendKeysToElement(list(etradeAPI$account$username))
  Sys.sleep(3)
  if(debug) remDr$screenshot(display = TRUE)
  
  passbox <- remDr$findElement(using = 'id', "txtPassword")
  Sys.sleep(3)
  passbox$clickElement()
  if(debug) remDr$screenshot(display = TRUE)
  Sys.sleep(3)
  
  
  passbox2 <- remDr$findElement(using = 'name', "PASSWORD")
  Sys.sleep(3)
  passbox2$clickElement()
  if(debug) remDr$screenshot(display = TRUE)
  passbox2$sendKeysToElement(list(etradeAPI$account$userpass))
  Sys.sleep(3)
  if(debug) remDr$screenshot(display = TRUE)
  
  
  logbutton <- remDr$findElement(using = 'class name', "log-on-btn")
  Sys.sleep(3)
  logbutton$clickElement()
  Sys.sleep(3)
  
  
  if(debug) remDr$screenshot(display = TRUE)
  
  if(debug) system.file("python", "auth_s1.py", package = "etradeR")
  
  
  t<-rPython::python.load(system.file("python", "auth_s1.py", package = "etradeR"), get.exception = TRUE )
  
  
  rederect_response<-rPython::python.get("authorize_url")
  rederect_response
  
  Sys.sleep(1)
  
  remDr$navigate(rederect_response)
  if(debug) remDr$screenshot(display = TRUE)
  Sys.sleep(1)
  
  acceptbut<-remDr$findElement(using ='name', 'submit')
  Sys.sleep(1)
  
  acceptbut$clickElement()
  Sys.sleep(1)
  
  authCodeBox = remDr$findElement(using ='tag', 'input')
  if(debug) remDr$screenshot(display = TRUE)
  authCode <- authCodeBox$getElementAttribute("value")[[1]]
  
  remDr$close()
  
 
  
  rPython::python.assign("oauth_verifier",authCode)
  
  
  
  t<-rPython::python.load(system.file("python", "auth_s2.py", package = "etradeR"), get.exception = TRUE )
  
  
  
  return(authCode)
  
  
  
  
}




#etradeAuth("/home/craig/etrade_info.json" , debug = FALSE)
