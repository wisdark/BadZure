
Function AssignAppPermissions{
    
    $roles = ('Exchange Administrator', 'Security Operator', 'Network Administrator', 'Intune Administrator', 'Attack Simulation Administrator', 'Application Developer')
    $apps = Import-Csv -Path "Lib\apps.csv"
    $used_apps =@()
    foreach ($role in  $roles)
    {
        do
        {
            $random_app_dn = (Get-Random $apps).DisplayName
        }
        until ($used_apps -notcontains $random_app_dn)

        $roleDefinitionId = (Get-MgRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq '$role'").Id
        $appObjectId = (Get-MgServicePrincipal -Filter "DisplayName eq '$random_app_dn'").Id
        New-MgRoleManagementDirectoryRoleAssignment -PrincipalId $appObjectId -RoleDefinitionId $roleDefinitionId -DirectoryScopeId "/" | Out-Null
        Write-Host [+] Assigmed $role to application with displayName $random_app_dn
        $used_apps += $random_app_dn 
    }
    
}
