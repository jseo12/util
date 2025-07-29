# set-oh-my-posh-dracula-theme-username.ps1

param (
    [Parameter(Mandatory=$true)]
    [string]$NewUsername  # The new username to set in the template
)

$themePath = "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\dracula.omp.json"

if (-Not (Test-Path $themePath)) {
    Write-Error "❌ Theme file does not exist: $themePath"
    exit 1
}

# Load JSON from the Dracula theme
$json = Get-Content $themePath -Raw | ConvertFrom-Json

# Traverse all blocks and segments
foreach ($block in $json.blocks) {
    foreach ($segment in $block.segments) {
        if ($segment.type -eq "session" -and $segment.template) {
            # Replace the template with the new username (remove any previous value)
            $segment.template = "$NewUsername "
            Write-Host "✅ session.template updated to '$NewUsername '"
        }
    }
}

# Save the updated JSON back to the file
$json | ConvertTo-Json -Depth 10 | Set-Content -Path $themePath -Encoding UTF8
Write-Host "🎉 Update complete: $themePath"
