# Bump Version action

Increments version of specified project and submit it to repository with the following commit:

```
[automated] Bumped My App version to 1.0.1 [skip ci]
```

and tag (in case of `skip-tag` parameter is not specified):

```
v1.0.1
```

**Input Parameters:**

| Parameter Name | Description |
| - | - |
| **app-name** | Project name (used for commit name) |
| **project-type** | Project type: `Node`, `Posh`, `Custom` |
| **version-configuration-path** | Full path to version configuration |
| **posh-module-name** | Name of powershell module, needs to be specified in case of project type `Posh` |
| **posh-custom-module-path** | Path to powershell module with custom logic to get/set version, needs to be specified in case of project type `Custom` |
| **skip-tag** | Indicates if wether the workflow will create tag or not |
| **workspace-name** | Name of npm-workspace where version need to be incremented. Can be specified in case of project type `Node` |
| **override-increment-parts** | Comma separated version parts to increment. If specified, it forces the workflow to increment specified version parts instead of determined based on PR's label |

**Notes**

If you specify project type as `Custom` then you need to specify path to custom `PS` module which must have the following functions implemented:

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
```