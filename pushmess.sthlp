{smcl}
{* 23dec2021}
{title: Title}

{p 4 8}{cmd:pushmess} - Stata module for sending push notifications using PushNotifier App

{p 8 17 2}
{cmd:pushmess}
[{opt using} {it:filename}]
[{cmd:,} {it:options}]

{synoptset 22 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Required options}

{synopt:{opt t:oken(string)}}Provide your Pushnotifier API Token.

{synopt:{opt u:serid(string)}}Provide your username.

{synopt:{opt p:assword(string)}}Provide your password.

{synopt:{opt a:pp(string)}}Provide your Pushnotifier application name, e.g., com.myapp.app.

{synopt:{opt d:evice(string)}}Provide your device ID.

{syntab:Optional arguments}

{synopt:{opt m:essage(string)}}Specify a message you would like included in your push notification. Default is: "pushmess: Stata job done"

{synopt:{opt i:mage(string)}}Specify a file path for an attachment you would like included with your notification. Files supported are jpeg and png.

{synopt:{opt s:top}}Specify this option if you want your dofile to be interrupted.

{synopt:{opt save:pref}}Saves your default settings so you do not need to specify your token, username, device ID, app name, and password every time you run the command.
			{bf: Caution}: your credentials, including API token and password, will be saved in pushmessconfig.ado.

{title: Description}
{p 4 8}{cmd:pushmess} sends push notifications to your device using the PushNotifier App. 
	You can specify a dofile in {it:filename}, then a message is sent once the dofile ends or is interrupted by an error.

{title: Prerequisites}
{p 4 8}{cmd:pushmess} requires Python with the packages {browse "https://github.com/tomg404/pushnotifier-python":pushnotifier} and "requests".
You can install the packages from STATA using pip: {stata !pip install pushnotifier} and {stata !pip install requests}

{p 4 8}{cmd:pushmess} also requires the free push notification service {browse "https://pushnotifier.de/":Pushnotifier}, which can be set up as follows:

{p 4 8}{bf:1.} Create a free {browse "https://pushnotifier.de/":Pushnotifier} account.

{p 4 8}{bf:2.} Create an API token under {browse "https://pushnotifier.de/account/api":API settings}.

{p 4 8}{bf:3.} Create an API application under {browse "https://pushnotifier.de/account/api":API settings} by clicking "create application". The name you give to this app will be fed to the "app" option of the pushmess command.

{p 4 8}{bf:4.} Install the Pushnotifier {browse "https://pushnotifier.de/apps":client} on your device (Android, iOS) and register your device in the Webbrowser under {browse "https://pushnotifier.de/account/api":Devices}.
The device ID will be fed to the "device" option of the pushmess command.

{title:Author}

{p 4}Jean-Victor Alipour{p_end}
{p 4}LMU Munich & ifo Institute{p_end}
{p 4}{browse "https://sites.google.com/view/jv-alipour/"}{p_end}