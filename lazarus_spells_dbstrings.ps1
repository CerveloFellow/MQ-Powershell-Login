
# If this is the first time you run a powershell script on your computer you will likely get permission issues.  Read the following to troubleshoot them.
# https://www.faqforge.com/powershell/executing-powershell-script-first-time/
# Change the following line to the folders where your Project Lazarus Everquest folder is.
# A Single folder looks like this.
# $LazarusDestinations = @( "C:\Project Lazarus\" )
# Multiple folders are comma delimited and look like this.
$LazarusDestinations = @( "C:\Project Lazarus\", "C:\Project Lazarus - Main\" )

# Do not change anything below this line unless you know what you're doing!
$SpellsUrl = "http://192.99.254.193:3000/download/spells"
$DBStrUrl = "http://192.99.254.193:3000/download/dbstring"

function downloadAndExtract($url)
{
    $ZipFile = [System.IO.Path]::GetTempFileName() + ".zip"

    Invoke-WebRequest -Uri $url -OutFile $ZipFile 
 
    $ExtractShell = New-Object -ComObject Shell.Application 
    $Files = $ExtractShell.Namespace($ZipFile).Items() 


    for($i=0; $i -lt $LazarusDestinations.Length; $i++)
    {
        $ExtractShell.NameSpace($LazarusDestinations[$i]).CopyHere($Files,0x14) 
    }

    Remove-Item -Force -ErrorAction SilentlyContinue $ZipFile
}

downloadAndExtract $SpellsUrl
downloadAndExtract $DBStrUrl

