# Install Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Install requirements (all)
scoop install bat broot dog duf dust eza fd ffmpeg less procs pwsh ripgrep xh yt-dlp

# Install Oh My Posh
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

# Update $PROFILE for powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jseo12/util/main/Microsoft.PowerShell_profile.ps1" -OutFile $PROFILE -UseBasicParsing

# Update $PROFILE for pwsh
$pwshProfile = & pwsh -NoLogo -NoProfile -Command '$PROFILE'
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jseo12/util/main/Microsoft.PowerShell_profile.ps1" -OutFile $pwshProfile -UseBasicParsing

# Update Dracula Theme UserName String to dinx
$script = "$env:TEMP\set-omp.ps1"; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jseo12/util/main/set-oh-my-posh-dracula-theme-username.ps1" -OutFile $script; pwsh $script dinx; Remove-Item $script
