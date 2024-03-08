/*
pushmess Stata module for sending push notifications

*/

capture program drop pushmess
program define pushmess
 
    syntax [using/], [Message(string)] [Token(string) Userid(string) App(string) Password(string) Device(string)] [Image(string)] [SAVEpref] [stop]

    * Load default preferences if token/userid not given
    if "`token'" == "" {
        _pushmessprefgrab
        local token    	"`r(token)'"
        local userid   	"`r(userid)'"
        local device 	"`r(device)'"
	local app	"`r(app)'"
        local password 	"`r(password)'"
    }
	
    * Save preferences if SAVEPREF specified
    if "`savepref'" !=""{
	_pushmesspref, t(`token') u(`userid') a(`app') p(`password') d(`device')
    }	

    * Default message if message not given
    if "`message'" == "" {
	local message "pushmess: Stata job done"
    }
	
    * Run the do file if "using" specified, otherwise just push message
    if "`using'" != "" {
        capture noisily do "`using'"
        if _rc == 0 {
            _pushmess, t(`token') u(`userid') m(`message') a(`app') p(`password') d(`device') i(`image')
        }
        else {
           _pushmess, t(`token') u(`userid') a(`app') p(`password') d(`device') i(`image') m("There's an error in `using'.") 
        }
    }
    else {
        _pushmess, t(`token') u(`userid') m(`message') a(`app') p(`password') d(`device') i(`image')
    }
	
    * Abort DOfile if option "stop" specified
    if 	"`stop'"!="" {
    	di as error "Do file ran until specified stopping point" _newline
	error 1
    }

end


* pushnotifier package using Python
capture program drop _pushmess
program define _pushmess
    syntax, Message(string) Token(string) Userid(string) App(string) Password(string) Device(string) [Image(string)]
	
	* Check whether stata can access Python
	qui python search
	
	* Access Python and send message (sometimes it works even if 
	python: from pushnotifier import PushNotifier as pn
	python: pn = pn.PushNotifier("`userid'", "`password'", "`app'", "`token'")
	python: pn.send_text("`message'", silent=False, devices=["`device'"])

    	display as text "Notification pushed at `c(current_time)' via Pushnotifier"

	* If Attachment specified, send image
	if "`image'" != ""	{
		cap noisily python: pn.send_image("`image'", silent=False, devices=["`device'"])
		if _rc != 0 {
			display as text "Warning: Image `image' not found or not compatible"
		}
		else {
			display as text "Image pushed at `c(current_time)' via Pushnotifier"
		}
	}
	
end


* Pull StataPush preferences
capture program drop _pushmessprefgrab
program define _pushmessprefgrab, rclass
    quietly findfile pushmessconfig.ado
    quietly include "`r(fn)'"
    return local token    "`_token'"
    return local userid   "`_userid'"
    return local app      "`_app'"
    return local password  "`_password'"
    return local device  "`_device'"
end

* Save Preferences in pushmessconfig.ado
capture program drop _pushmesspref 
program define _pushmesspref
    syntax, Token(string) Userid(string) App(string) Password(string) Device(string)
	
   * If pushmessconfig.ado does not exist yet, create pushmessconfig.ado
    cap findfile pushmessconfig.ado
    if _rc == 601 {
	tempname pushmess_ado
	file open pushmess_ado using `"`c(sysdir_plus)'p/pushmessconfig.ado"', write
	file close pushmess_ado
	di as result "Created file `c(sysdir_plus)'p/pushmessconfig.ado to save your preferences."
    }
	
    quietly findfile pushmessconfig.ado
    local pushmessconfig "`r(fn)'"
    quietly file open  pushmess_ado using "`pushmessconfig'", write append
    quietly file write pushmess_ado "local _token    `token'"    	_n
    quietly file write pushmess_ado "local _password `password'" 	_n
    quietly file write pushmess_ado "local  _userid    `userid'"  	_n
    quietly file write pushmess_ado "local _app       `app'"  		_n
    quietly file write pushmess_ado "local _device    `device'"  	_n
    quietly file close pushmess_ado
    if _rc == 0 {
        display as result "Your preferences have been saved in pushmessconfig.ado."
    }
end







