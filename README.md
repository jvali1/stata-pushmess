
# pushmess.ado

`pushmess` is a Stata module for sending push notifications using the PushNotifier App and Python package pushnotifier. It can be used to flag groups where observations are not constant and to fill up missings when non-missing values are not conflicting within by-groups.

## Prerequisites

`pushmess` requires Python with the packages [pushnotifier](https://github.com/tomg404/pushnotifier-python) and "requests".

You can install the packages from STATA using pip:

```stata
!pip install pushnotifier
!pip install requests
```

`pushmess` also requires the free push notification service [Pushnotifier](https://pushnotifier.de/), which can be set up as follows:

1. Create a free [Pushnotifier](https://pushnotifier.de/) account.

2. Create an API token under [API settings](https://pushnotifier.de/account/api).

3. Create an API application under [API settings](https://pushnotifier.de/account/api) by clicking "create application". The name you give to this app will be fed to the "app" option of the pushmess command.

4. Install the Pushnotifier [client](https://pushnotifier.de/apps) on your device (Android, iOS) and register your device in the Webbrowser under [Devices](https://pushnotifier.de/account/api). The device ID will be fed to the "device" option of the pushmess command.

```

## Example
To push a message to your device, you will need to provide your API token, user ID, password, app name, and device id, e.g.:
```stata
pushmess, token("ABDCE") userid("myid") password("password123") device("393K") app("com.myapp.app") message("Stata job done") savepref
```
Use option `savepref` to save your credentials in pushmessconfig.ado, so that you don't need to speficy them every time you run the command (use with caution!).
Use option `stop` to interrupt dofile (optional).
Use option `message("some message")` to customize push notification (optional).


## Installation
To install from Github, type:

```stata
net install pushmess, from("https://raw.githubusercontent.com/jvali1/stata-pushmess/master/") replace
```

For questions and suggestions, please contact:  
Jean-Victor Alipour  
LMU Munich & ifo Institute  
alipour@ifo.de 
