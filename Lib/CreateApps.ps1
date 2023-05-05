

Function CreateApps{

    $apps = Import-Csv -Path "Lib\apps.csv"
    foreach ($app in $apps) {

        $new_app= New-MgApplication -DisplayName $app.DisplayName 
        $new_sp= New-MgServicePrincipal -AppId $new_app.Appid
        Write-Host [+] Created application with displayname $app.DisplayName and Service Principal $new_sp.Id

    }
}

