# Bump Version Action

Increments the version of a specified project and commits the changes to the repository with the following commit message:

```
[automated] Bumped My App version to 1.0.1 [skip ci]
```

And creates a tag (unless the `skip-tag` parameter is specified):

```
v1.0.1
```

## Input Parameters

| Parameter Name | Description |
| - | - |
| **app-name** | Project name (used for commit message) |
| **project-type** | Project type: `Node`, `Posh`, `Custom` |
| **version-configuration-path** | Full path to version configuration file |
| **posh-module-name** | Name of PowerShell module, required when project type is `Posh` |
| **posh-custom-module-path** | Path to PowerShell module with custom logic for getting/setting version, required when project type is `Custom` |
| **skip-tag** | Indicates whether the workflow should create a tag or not |
| **workspace-name** | Name of npm workspace where version needs to be incremented. Can be specified when project type is `Node` |
| **override-increment-parts** | Comma-separated version parts to increment. If specified, forces the workflow to increment these parts instead of determining based on PR labels |
| **root-path** | Root path of target project |
| **default-increment-part** | Name of increment part to be incremented by default if there is no linked PR |
| **suffix** | Name of suffix to set |
| **remove-suffix** | Indicates whether the current suffix should be removed |

## Notes

If you specify project type as `Custom`, you must provide a path to a custom PowerShell module that implements the following functions:

```posh
function Get-Version {
  [CmdletBinding()]
  [OutputType([string])]
  param ()

  process {
    ...
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
  
  process {
    ...
  }
}

Export-ModuleMember -Function @('Get-Version', 'Set-Version')
```