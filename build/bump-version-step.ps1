[CmdletBinding()]
param (
  [string]
  $GithubWorkspace,

  [string]
  $GithubRepository,

  [string]
  $PoshCustomModulePath,

  [string]
  $OverrideIncrementParts,

  [string]
  $ProjectType,

  [string]
  $PoshModuleName,

  [string]
  $SHA,

  [string]
  $VersionConfigurationPath,

  [string]
  $WorkspaceName
)

begin {
  $env:PSModulePath = $env:PSModulePath + "$([System.IO.Path]::PathSeparator)$(Join-Path $GithubWorkspace "sk-build-system" "scripts/ps")"
  Import-Module VersionHelper -Force -Verbose -ErrorAction Stop
}

process {
  $splitRepositoryName = $GithubRepository -split "/"

  if ($splitRepositoryName.Length -ne 2) {
    throw "Repository name cannot be parsed: $GithubRepository"
  }

  $params = @{
    ProjectType    = $ProjectType
    PowerShellModuleName = $PoshModuleName
    CustomPowershellModulePath = $null
    SHA = $SHA
    Owner = $splitRepositoryName[0]
    Repository = $splitRepositoryName[1]
    VersionConfigurationPath = (Join-Path $GithubWorkspace $VersionConfigurationPath)
    AuthToken = $env:GITHUB_TOKEN
    WorkspaceName = $WorkspaceName
    OverrideIncrementParts = @()
    Verbose = $true
  }

  if (-not ([string]::IsNullOrWhiteSpace($PoshCustomModulePath))) {
    $params['CustomPowershellModulePath'] = $(Join-Path $GithubWorkspace $PoshCustomModulePath)
  }

  if (-not ([string]::IsNullOrWhiteSpace($OverrideIncrementParts))) {
    $params['OverrideIncrementParts'] = $OverrideIncrementParts -split ","
  }

  $newVersion = Submit-NewVersionLabel @params
  "new-version=$newVersion" | Out-File -FilePath $env:GITHUB_ENV -Encoding utf8 -Append
}