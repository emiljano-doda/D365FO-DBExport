try
{
    Write-Host "--> D365FO - Create a database backup (.BACPAC) File From SQL Database `n"

    $SQLPackagePath   = "C:\Program Files (x86)\Microsoft SQL Server\130\DAC\bin\SqlPackage.exe"
    $sqlPackageFolder = $PSScriptRoot + "\SQLPackage"

    if(![System.IO.Directory]::Exists($SQLPackagePath))
    {
        if(![System.IO.Directory]::Exists($sqlPackageFolder))
        {
            Write-Host "Warning : Couldn't find SQLPackage in the default Directory `n" -ForegroundColor Yellow
            $sqlPackageZip = $PSScriptRoot + "\SQLPackage.zip"

            Write-Host "--> Downloading SQLPackage...`n" -ForegroundColor Yellow
            Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2249738" -OutFile $sqlPackageZip

            Write-Host "--> Extracting SQLPackage...`n" -ForegroundColor Yellow
            Expand-Archive -Path "SQLPackage.zip" -DestinationPath $sqlPackageFolder
        }
        
        $SQLPackagePath = $sqlPackageFolder + "\SqlPackage.exe"
        Write-Host "SQLPackage.exe Location Found : $SQLPackagePath" -ForegroundColor Yellow
    }    

    $currentDateTime = Get-date -Format "yyyyMMddhhmmss"
    $backupEnvironmentName = "AxDB_"
    $backupFileName = $backupEnvironmentName + $currentDateTime + ".bacpac"

    Write-Host "--> Starting Backup" -ForegroundColor Yellow
    Write-Host "--> Target Path :'$backupFileName'" -ForegroundColor Yellow
    Write-Host "--> Launching SqlPackage`n" -ForegroundColor Yellow
    Write-Host "--> DO NOT PANIC IF IT LOOKS STUCK JUST PRESS ANY KEY (EX. Arrow Keys) `n"

    $backupCmd = cmd.exe /c "$SQLPackagePath /a:export /ssn:localhost /sdn:AxDB /tf:$backupFileName /p:CommandTimeout=1200 /p:VerifyFullTextDocumentTypesSupported=false /SourceEncryptConnection:false"
    write $backupCmd
    Invoke-Expression -Command:$backupCmd

    pause     
}
catch
{
    Write-Host "--> An error occurred !" -ForegroundColor Red
    Write-Host "--> Check the ERROR above !" -ForegroundColor Red

    pause
}