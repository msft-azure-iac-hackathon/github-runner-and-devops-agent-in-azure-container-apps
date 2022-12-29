Param (
    [Parameter(Mandatory = $false)]
    [string]$owner = $env:GH_OWNER,
    [Parameter(Mandatory = $false)]
    [string]$repo = $env:GH_REPOSITORY,
    [Parameter(Mandatory = $false)]
    [string]$pat = $env:GH_TOKEN
)

Set-Location actions-runner;
$RUNNER_NAME = $repo + "-" + (New-Guid).Guid.Split("-")[0]

$REG_TOKEN_GEN = Invoke-WebRequest `
                -Method Post `
                -Uri "https://api.github.com/repos/$owner/$repo/actions/runners/registration-token" `
                -Headers @{ 
                    Accept = 'application/vnd.github.v3+json' 
                    Authorization = "token $pat" 
                }
$REG_TOKEN = $REG_TOKEN_GEN.Content | ConvertFrom-Json | Select-Object -ExpandProperty token
dir


try {
    Write-Host "Registering [$RUNNER_NAME] on [$owner/$repo]..."
    ./config.cmd --unattended --url "https://github.com/$owner/$repo" --token $REG_TOKEN --name $RUNNER_NAME --labels pwsh,azps,azcli
    $pat=$null
    $env:GH_TOKEN=$null
    ./run.cmd
}
catch {
    Write-Error $_.Exception.Message
}
finally {
    # This won't work until this is fixed https://github.com/moby/moby/issues/25982# and manual cleanup is required
    ./config.cmd remove --token $REG_TOKEN
}