################################################################################
##  File:  Install-Python.ps1
##  Team:  CI-X
##  Desc:  Configure python on path with 3.6.* version from the tools cache
##         Must run after tools cache is setup
################################################################################

Import-Module -Name ImageHelpers -Force

$python36path = $Env:AGENT_TOOLSDIRECTORY + '/Python/3.6*/x64'
$pythonDir = Get-Item -Path $python36path

if($pythonDir -is [array])
{
    Write-Host "More than one python 3.6.* installations found"
    Write-Host $pythonDir
    exit 1
}

$currentPath = Get-MachinePath

if ($currentPath | Select-String -SimpleMatch $pythonDir.FullName)
{
    Write-Host $pythonDir.FullName ' is already in PATH'
    exit 0
}

Add-MachinePathItem -PathItem $pythonDir.FullName
Add-MachinePathItem -PathItem "$($pythonDir.FullName)\Scripts"
