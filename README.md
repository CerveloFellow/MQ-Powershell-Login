# MQ-Powershell-Login
Powershell scripts to autologin your Everquest team with MacroQuest

If you're not familiar with powershell, you might be best of running the scripts initially with "Windows Powershell ISE" so you can see the errors you are getting.  Otherwise you can usually just right click your .ps1 file and Run With PowerShell.

See this FAQ for some common first time run errors:
https://www.faqforge.com/powershell/executing-powershell-script-first-time/

An online editor for the JSON file can be found here if you're not comfortable editing JSON.
https://jsoneditoronline.org/

The script and accompanying JSON file let you define some basic parameters for, Everquest, MacroQuest, EBCSServe, Accounts and Characters.  Set this file up one time and then save a powershell script for each team or individual you want to quickly login with.  The powershell script will attempt to see what processes are running and only start new processes if none are running.  This includes EverQuest game client for your driver and bots(*** See note below for how it determines which bot is running***), MacroQuest and EQBCServer.  

One of the benefits of this script is that it will modify your MQ2AutoLogin.ini file if you have different characters on the same account automatically.

EQ client window names can be set in the zoned.cfg(file location varies depending on your configuration) file as following:
/setwintitle ${Me.Name}
Your file may contain more than the above depending on what it's doing, but look for a line that sets your window title.

If the client window name is set, the powershell script will look for windows with that name to determine if your game client is running for this character.

For each team that has a .ps1 file you'll want to check the configurations at the top.

# PowerShell file notes
--Path to your JSON containing your config
$AutoLogin = Get-Content -Raw -Path "C:\Users\user1\Desktop\EverQuest\AccountConfiguration.json" | ConvertFrom-Json
--A driver character must be set or you'll get errors
$Driver = "DriverCharacter"
--Bots can be 0 to many in this array.  A full team will look like this
$Bots = @("BotCharacter1", "BotCharacter2", "BotCharacter3", "BotCharacter4", "BotCharacter5")
--No bots would look like this
$Bots = @()

# JSON file notes
The sample JSON file should be fairly self explanatory, but here's a couple of quick comments.

  --The path to your EQ Game exe for the driver of your team
  "DriverClientFilePath" : "C:\\Project Lazarus - Main\\eqgame.exe",
  --The directory you want to run the driver out of
  "DriverClientWorkingDirectory" : "C:\\Project Lazarus - Main",
  --The path to your EQ Game exe for your bots
  "BotClientFilePath" : "C:\\Project Lazarus\\eqgame.exe",
  --The directory you want to run the bots out of
  "BotClientWorkingDirectory" : "C:\\Project Lazarus",
  --The path to your Macroquest exe file
  "MacroQuestFilePath" : "C:\\E3_RoF2\\MacroQuest2.exe",
  --The directory you want to run MacroQuest out of
  "MacroQuestWorkingDirectory" : "C:\\E3_RoF2",
  --The process name that your version of MacroQuest runs as.  When in doubt, run MacroQuest and check task manager for the task name.
  "MacroQuestProcessName" : "MacroQuest2",
  --The process name that eqgame.exe uses, this shouldn't change but when in doubt, check task manager.
  "EverQuestProcessName" : "eqgame",
  --The path to your EQBCServer.exe file
  "EQBCServerFilePath" : "C:\\E3_RoF2\\EQBCServer.exe",
  --The folder to run EQBCServer out of
  "EQBCServerWorkingDirectory" : "C:\\E3_RoF2",
  --The process name for EQBCServer
  "EQBCServerProcessName" : "EQBCServer",
  --The path to your MQ2AutoLogin.ini file 
  "AutoLoginFile" : "C:\\E3_RoF2\\config\\MQ2AutoLogin.ini",

The rest of the JSON file is to define logins and characters.  Multiple characters can exist on a single login.  The powershell script will try to modify your MQ2AutoLogin.ini file and swap characters so they can be auto logged in if you have different characters on a single account

"Accounts" : [ 
	{
    "Account" : "Account1",
    "Characters" : [ "Character1", "Character2" ]
    },
    {
    "Account" : "Account2",
    "Characters" : [ "Character1", "Character2" ]
    },
    {
    "Account" : "Account3",
    "Characters" : [ "Character1", "Character2" ]
    },
    {
    "Account" : "Account4",
    "Characters" : [ "Character1", "Character2" ]
    },
    {
    "Account" : "Account5",
    "Characters" : [ "Character1", "Character2" ]
    },
	{
    "Account" : "Account6",
    "Characters" : [ "Character1", "Character2" ]
    },
    {
    "Account" : "Account7",
    "Characters" : [ "Character1" ]
    }
  ]
  


