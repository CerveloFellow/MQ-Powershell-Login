# Path to your JSON containing your config
$AutoLogin = Get-Content -Raw -Path "C:\Users\user1\Desktop\EverQuest\AccountConfiguration.json" | ConvertFrom-Json
$Driver = "Character1"
$Bots = @("Character2", "Character3", "Character4", "Character5", "Character6")

function findAccount($character)
{
    for($i=0; $i -lt $AutoLogin.Accounts.Length; $i++)
    {
        if($AutoLogin.Accounts[$i].Characters -contains $character)
        {
            return $AutoLogin.Accounts[$i]
        }
    }
}

function startProcess($processName, $processToRun, $workingDirectory)
{
    $Running = Get-Process $processName -ErrorAction SilentlyContinue

    if($Running -eq $null) # evaluating if the program is running
    {
        Start-Process -FilePath $processToRun -WorkingDirectory $workingDirectory
    }
}

function startGameClient($processName, $characterName, $loginName, $clienteExe, $workingDirectory)
{
    $Client=Get-Process $processName -ErrorAction SilentlyContinue | Where-Object { $_.mainWindowTitle -like "$characterName*" } 
    if($Client -eq $null)
    {
        Start-Process -FilePath $clienteExe -WorkingDirectory $workingDirectory -ArgumentList "patchme","-h","/login:$loginName"
    }
}

$driverAccount = findAccount $Driver

$ini = Get-IniContent $AutoLogin.AutoLoginFile
$ini[$driverAccount.Account]["Character"] = $Driver
$ini | Out-IniFile -FilePath $AutoLogin.AutoLoginFile -Force -Pretty -Encoding ASCII

for($i=0; $i -lt $Bots.Length; $i++)
{
    $botAccount = findAccount $Bots[$i]
    #replaceAutoLoginCharacter $AutoLogin.AutoLoginFile $botAccount.Account $Bots[$i]
    
    $ini[$botAccount.Account]["Character"] = $Bots[$i]
    $ini | Out-IniFile -FilePath $AutoLogin.AutoLoginFile -Force -Pretty -Encoding ASCII
    
}

# Check if MacroQuest is running and start it if not
startProcess $AutoLogin.MacroQuestProcessName $AutoLogin.MacroQuestFilePath $AutoLogin.MacroQuestWorkingDirectory

# Check if EQBCServer is running and start it if not
startProcess $AutoLogin.EQBCServerProcessName $AutoLogin.EQBCServerFilePath $AutoLogin.EQBCServerWorkingDirectory

Start-Sleep -Seconds 10
# I like to start the bots first so the group of windows show up on the left of the driver w
for($i=0; $i -lt $Bots.Length; $i++)
{
    $botAccount = findAccount $Bots[$i]
    startGameClient $AutoLogin.EverQuestProcessName $Bots[$i] $botAccount.Account $AutoLogin.BotClientFilePath $AutoLogin.BotClientWorkingDirectory
}

Start-Sleep -Seconds 5
# Check for driver and start them if they aren't running
startGameClient $AutoLogin.EverQuestProcessName $Driver $driverAccount.Account $AutoLogin.DriverClientFilePath $AutoLogin.DriverClientWorkingDirectory





