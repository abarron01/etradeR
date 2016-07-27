library(RSelenium)
library(rPython)
library(jsonlite)
RSelenium::checkForServer()
RSelenium::startServer()

etrade_info<-jsonlite::fromJSON("/home/craig/etrade_info.json")


#load info in python
rPython::python.assign("username",etrade_info$username)
rPython::python.assign("userpass",etrade_info$userpass)
rPython::python.assign("consumer_key",etrade_info$consumer_key)
rPython::python.assign("consumer_secret",etrade_info$consumer_secret)
rPython::python.assign("request_token_url",etrade_info$request_token_url)
rPython::python.assign("authorize_token_url",etrade_info$authorize_token_url)
rPython::python.assign("access_token_url",etrade_info$access_token_url)

remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4444
                      , browserName = "chrome"
)

remDr$open()


remDr$navigate("https://us.etrade.com/e/t/user/logout")
remDr$navigate("https://us.etrade.com/e/t/user/login")
remDr$screenshot(display = TRUE)


Sys.sleep(3)
userbox <- remDr$findElement(using = 'name', "USER")
Sys.sleep(3)
userbox$sendKeysToElement(list(etrade_info$username))
Sys.sleep(3)
remDr$screenshot(display = TRUE)

passbox <- remDr$findElement(using = 'id', "txtPassword")
Sys.sleep(3)
passbox$clickElement()
remDr$screenshot(display = TRUE)
Sys.sleep(3)


passbox2 <- remDr$findElement(using = 'name', "PASSWORD")
Sys.sleep(3)
passbox2$clickElement()
remDr$screenshot(display = TRUE)
passbox2$sendKeysToElement(list(etrade_info$userpass))
Sys.sleep(3)
remDr$screenshot(display = TRUE)


logbutton <- remDr$findElement(using = 'class name', "log-on-btn")
Sys.sleep(3)
logbutton$clickElement()
Sys.sleep(3)


remDr$screenshot(display = TRUE)



t<-rPython::python.load("auth_s1.py", get.exception = TRUE )


rederect_response<-rPython::python.get("authorize_url")
rederect_response

Sys.sleep(1)

remDr$navigate(rederect_response)
remDr$screenshot(display = TRUE)
Sys.sleep(1)

acceptbut<-remDr$findElement(using ='name', 'submit')
Sys.sleep(1)

acceptbut$clickElement()
Sys.sleep(1)

authCodeBox = remDr$findElement(using ='tag', 'input')
remDr$screenshot(display = TRUE)
authCode <- authCodeBox$getElementAttribute("value")[[1]]

remDr$close()

authCode

rPython::python.assign("oauth_verifier",authCode)

t<-rPython::python.load("inst/python/auth_s2.py", get.exception = TRUE )

page.txt<-rPython::python.get("accounts_raw.text")
jsonlite::fromJSON(page.txt)
