/*
pushmesspref: Stata module to save preferences for pushmess
*/

capture program drop pushmesspref 
program define pushmesspref
    syntax, Token(string) Userid(string) App(string) Password(string) Device(string)
	
   ** If pushmessconfig.ado does not exist yet, create pushmessconfig.ado
    cap findfile pushmessconfig.ado
    if _rc == 601 {
	tempname pushmesspref_ado
	file open pushmesspref_ado using `"`c(sysdir_plus)'p/pushmessconfig.ado"', write
	file close pushmesspref_ado
	di as result "Created file `c(sysdir_plus)'p/pushmessconfig.ado to save your preferences."
    }
    quietly findfile pushmessconfig.ado
    local pushmessconfig "`r(fn)'"
    quietly file open  pushmesspref_ado using "`pushmessconfig'", write append
    quietly file write pushmesspref_ado "local _token    `token'"    	_n
    quietly file write pushmesspref_ado "local _password `password'"  	_n
    quietly file write pushmesspref_ado "local _userid    `userid'"  	_n
    quietly file write pushmesspref_ado "local _app       `app'"  	_n
    quietly file write pushmesspref_ado "local _device    `device'"  	_n
    quietly file close pushmesspref_ado 
    if _rc == 0 {
        display as result "Your preferences have been saved in pushmessconfig.ado."
    }
end
