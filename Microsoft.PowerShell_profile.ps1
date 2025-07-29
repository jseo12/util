#region Oh My Posh ------------------------------------------------------------

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\dracula.omp.json" --eval | Invoke-Expression

#endregion Oh My Posh ---------------------------------------------------------

#region Helpers ---------------------------------------------------------------

function Test-Command {
    param([Parameter(Mandatory)][string]$Name)
    return [bool](Get-Command -Name $Name -ErrorAction SilentlyContinue)
}

function Set-AliasIfAvailable {
    param(
        [Parameter(Mandatory)][string]$Name,
        [Parameter(Mandatory)][string]$Target
    )
    #Write-Host "Checking command '$Target' for alias '$Name'..."
    if (Test-Command $Target) {
        #Write-Host "Command '$Target' found. Setting alias '$Name' to '$Target'."
        if (Test-Path "Alias:$Name") {
            #Write-Host "Alias '$Name' exists. Removing existing alias."
            Remove-Item "Alias:$Name" -Force
        }
        #Set-Alias $Name $Target -Force

    }
    else {
        #Write-Host "Command '$Target' not found. Alias '$Name' not set."
    }
}


# eza가 없으면 기본 Get-ChildItem으로 폴백
function Invoke-Ls {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Args
    )
    if (Test-Command 'eza') {
        eza @Args
    } else {
        Get-ChildItem @Args
    }
}

#endregion Helpers ------------------------------------------------------------

#region Aliases & Shortcuts ---------------------------------------------------

# 표준 유틸 대체 - 제대로 실행안되서 주석 처리
#Set-AliasIfAvailable -Name cat   -Target bat
#Set-AliasIfAvailable -Name find  -Target fd
#Set-AliasIfAvailable -Name http  -Target xh
#Set-AliasIfAvailable -Name https -Target xhs
#Set-AliasIfAvailable -Name ps    -Target procs
#Set-AliasIfAvailable -Name du    -Target dust
#Set-AliasIfAvailable -Name dig   -Target dog
#Set-AliasIfAvailable -Name top   -Target btm
# 필요 시
# Set-Alias rm Remove-Item
# Set-Alias cp Copy-Item
# Set-Alias mv Move-Item
# Set-Alias cls Clear-Host

if (Test-Path Alias:ls) {
    Remove-Item Alias:ls -Force
}
Set-Alias ls eza -force
if (Test-Path Alias:cat) {
    Remove-Item Alias:cat -Force
}
Set-Alias cat bat
#Set-Alias cls Clear-Host
if (Test-Path Alias:find) {
    Remove-Item Alias:find -Force
}
Set-Alias find fd

if (Test-Path Alias:http) {
    Remove-Item Alias:http -Force
}
Set-Alias http xh
if (Test-Path Alias:https) {
    Remove-Item Alias:https -Force
}
Set-Alias https xhs

if (Test-Path Alias:ps) {
    Remove-Item Alias:ps -Force
}
Set-Alias ps procs

if (Test-Path Alias:du) {
    Remove-Item Alias:du -Force
}
Set-Alias du dust
if (Test-Path Alias:dig) {
    Remove-Item Alias:dig -Force
}
Set-Alias dig dog

if (Test-Path Alias:top) {
    Remove-Item Alias:top -Force
}
Set-Alias top btm


# 편의 함수 (eza 프리셋)
#function ls { Invoke-Ls -Args @('--group-directories-first', '--icons=auto') }
function ll { Invoke-Ls -Args @('-l', '--group-directories-first', '--icons=auto') }
function la { Invoke-Ls -Args @('-a', '--group-directories-first', '--icons=auto') }
function lt { Invoke-Ls -Args @('--tree', '-a', '-L', '2', '--group-directories-first', '--icons=auto') }

#endregion Aliases & Shortcuts ------------------------------------------------
