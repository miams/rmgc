# This script must be run in Powershell as Administrative user.
# Run these three commands prior to running script to enable script execution, download this file, and run this file.

#    Set-ExecutionPolicy Unrestricted
#    powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/miams/rmgc/refs/heads/main/installers/rmgc-full-install-Win11.ps1" -OutFile "rmgc-full-install-Win11.ps1"
#    rmgc-full-install-Win11.ps1

# Process Parameters
param (
    [string]$OptionalString,
    [int]$OptionalNumber,
    [switch]$OptionalFlag
)

# Script logic using the parameters
if ($OptionalString) {
    Write-Host "Optional String: $OptionalString"
}

if ($OptionalNumber) {
    Write-Host "Optional Number: $OptionalNumber"
}

if ($OptionalFlag) {
    Write-Host "Optional Flag is present."
}


# Permit Powershell to software.
Set-ExecutionPolicy AllSigned

# Install Choco
Write-Host "Installing Chocolatey Package Manager."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Write-Host "Chocolatey install complete." -ForegroundColor Green

# Install Nushell
Write-Host "Installing Nushell."
choco install nushell -y
Write-Host "Nushell install complete." -ForegroundColor Green

# Install RMGC
Write-Host "Downloading RMGC installer."
powershell -Command Invoke-WebRequest -Uri "https://raw.githubusercontent.com/miams/rmgc/refs/heads/main/installers/rmgc-install-Win11.nu" -OutFile "rmgc-install-Win11.nu"
Write-Host `n

nu rmgc-install-Win11.nu

Write-Host `n
$answer = Read-Host "Okay to clean up by deleting install scripts (y/n) "
if ($answer -eq "y" -or $answer -eq "Y") {
    # Code to execute if yes
    rm .\rmgc-full-install-Win11.ps1
    rm .\rmgc-install-Win11.nu
    Write-Host "Deletion of installers completed."
    Write-Host "All tasks completed, Exiting..."
} elseif ($answer -eq "n" -or $answer -eq "N") {
    # Code to execute if no
    Write-Host "All tasks completed, Exiting..."
} else {
    Write-Host "Invalid input. Please enter 'y' or 'n'."
}

Write-Host `n
Write-Host "RMGC is successfully installed." -ForegroundColor Green



# There are three ways to enter Nushell: 
#   1.  From within Powershell, type: nu <enter>
#   2.  From Terminal, Open the dropdown menu by clicking on the 'down carat' You will see Nushell as an option

Write-Host "Additionally, the next time you open the Terminal program, click on the 'down carat' for the drop-down menu.  You will see Nushell is a new option available. If you choose, you can go into Settings from the drop-down menu, and make Nushell your default shell in Terminal." 
Write-Host `n
Write-Host "Type 'nu' at the prommpt. Then begin having fun with RMGC by typing: rmgc [tab key]" 


# $answer = Read-Host "Would you like (y/n) "

# Create shortcut and save to programs section of menu bar
$SourceExe = "$env:USERPROFILE\AppData\Local\Programs\nu\bin\nu.exe"
$ArgumentsToSourceExe = ""
$DestinationPath = "$env:AppData\Microsoft\Windows\Start Menu\Programs\rmgc.lnk"
# param ( [string]$SourceExe, [string]$ArgumentsToSourceExe, [string]$DestinationPath )
$WshShell = New-Object -COMObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($DestinationPath)
$Shortcut.TargetPath = $SourceExe
$Shortcut.Arguments = $ArgumentsToSourceExe
$Shortcut.Save()


# https://files.rootsmagic.com/RM10/RootsMagic10Setup.exe
# https://files.rootsmagic.com/RM10/RootsMagic10SetupX64.exe

# https://files.rootsmagic.com/RM9/RootsMagic9Setup.exe
# https://files.rootsmagic.com/RM9/RootsMagic9SetupX64.exe

# https://files.rootsmagic.com/RM8/RootsMagic8Setup.exe

# https://files.rootsmagic.com/RM10/RootsMagic10.dmg
# https://files.rootsmagic.com/RM9/RootsMagic9.dmg
# https://files.rootsmagic.com/RM8/RootsMagic8.dmg


# This is erroring.  TODO: find way to reset permissions to normal
# Set-ExecutionPolicy Restricted

