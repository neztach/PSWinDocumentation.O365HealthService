function Get-Office365ServiceHealthServices {
    <#
    .SYNOPSIS
    Retrieves health information related to Office 365 services.

    .DESCRIPTION
    This function retrieves health information related to Office 365 services based on the specified parameters.

    .PARAMETER Authorization
    Specifies the authorization information required to access the Office 365 service health data.

    .PARAMETER TenantDomain
    Specifies the domain of the Office 365 tenant.

    .EXAMPLE
    Get-Office365ServiceHealthServices -Authorization $Authorization -TenantDomain "contoso.com"

    Retrieves the health overview of Office 365 services for the specified tenant domain.

    #>
    [CmdLetbinding()]
    param(
        [System.Collections.IDictionary] $Authorization,
        [string] $TenantDomain
    )
    try {
        $Services = Invoke-Graphimo -Uri "https://graph.microsoft.com/v1.0/admin/serviceAnnouncement/healthOverviews" -Method GET -Headers $Authorization -FullUri
    } catch {
        $ErrorMessage = $_.Exception.Message -replace "`n", " " -replace "`r", " "
        Write-Warning -Message "Get-Office365ServiceHealthServices - Error: $ErrorMessage"
        return
    }
    $Output = @{ }
    $Output.Simple = foreach ($Service in $Services) {
        [PSCustomObject][ordered] @{
            ID      = $Service.ID
            Service = $Service.service
        }
    }
    return $Output
}
