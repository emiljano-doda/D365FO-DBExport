# D365FO-DBExport
* Export Dynamics 365 Finance And Operations SQL Database into a .bacpac file

# Overview
* Automated PowerShell script which uses Microsoft SQL Package to Export D365FO AxDB SQL Database into a .bacpac file

# How it works ?
* Verifies if SqlPackage already exists in the default path (C:\Program Files (x86)\Microsoft SQL Server\130\DAC\bin\SqlPackage.exe)
* If not, downloads and extracts SqlPackage from Microsoft Mirror on the path where the Powershell script is being executed ([Microsoft Official SQL Package Mirror]([https://www.google.com](https://go.microsoft.com/fwlink/?linkid=2249738)))
* Afterwards runs the script to start the backup
* DO NOT PANIC IF IT LOOKS STUCK JUST PRESS ANY KEY (EX. Arrow Keys)
* Please note that the time required it actually depends by the Database size itself and not by this script

# Usage
- Run the following command in Powershell
```
iwr -useb https://raw.githubusercontent.com/emiljano-doda/D365FO-DBExport/master/SqlPackageExport.ps1 | iex
```

# To Do
* Check if the script has been used before and if the SQLPackage.zip already exists
