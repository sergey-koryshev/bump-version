$script:versionFilePath = "version.json"

function Get-Version {
  [CmdletBinding()]
  [OutputType([string])]
  param ()

  begin {
    if (!(Test-Path $script:versionFilePath)) {
      throw "Version file doesn't exist."
    }
  }

  process {
    $currentVersion = (Get-Content -Raw $script:versionFilePath | ConvertFrom-Json).version

    if ($null -eq $currentVersion) {
      throw "Version node doesn't exist in version file."
    }

    Write-Output $currentVersion
  }
}

function Set-Version {
  [CmdletBinding()]
  param (
    [string]
    $OldVersion,

    [string]
    $NewVersion
  )

  begin {
    if (!(Test-Path $script:versionFilePath)) {
      throw "Version file doesn't exist."
    }
  }
  
  process {
    @{
      version = $NewVersion
    } | ConvertTo-Json | Out-File $script:versionFilePath
  }
}

Export-ModuleMember -Function @('Get-Version', 'Set-Version')