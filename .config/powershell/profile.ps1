Write-Warning -Message "I am user shared $($PSVersionTable.PSVersion.ToString())"

# if ($PSVersionTable.psversion.Major -ge 6)
# { Import-Module oh-my-posh -MinimumVersion 3.0 ; Set-PoshPrompt -Theme $home/.config/my-oh-my-posh.json }
Import-Module posh-git
Import-Module Terminal-Icons