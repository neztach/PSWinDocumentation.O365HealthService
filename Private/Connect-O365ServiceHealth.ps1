function Connect-O365ServiceHealth {
    <#
    .SYNOPSIS
    Connects to the Office 365 Service Health API using the specified credentials.

    .DESCRIPTION
    This function establishes a connection to the Office 365 Service Health API using the provided credentials. It allows access to health information related to Office 365 services.

    .PARAMETER ApplicationID
    Specifies the Application ID used for authentication.

    .PARAMETER ApplicationKey
    Specifies the Application Key used for authentication.

    .PARAMETER ApplicationKeyEncrypted
    Specifies the encrypted Application Key used for authentication.

    .PARAMETER Credential
    Specifies the PSCredential object used for authentication.

    .PARAMETER TenantDomain
    Specifies the domain of the Office 365 tenant.

    .EXAMPLE
    Connect-O365ServiceHealth -ApplicationID "yourAppID" -ApplicationKey "yourAppKey" -TenantDomain "contoso.com"

    Connects to the Office 365 Service Health API using the provided credentials for the specified tenant domain.
    #>
    [cmdletBinding(DefaultParameterSetName = 'ClearText')]
    param(
        [parameter(Mandatory, ParameterSetName = 'Encrypted')]
        [parameter(Mandatory, ParameterSetName = 'ClearText')][string][alias('ClientID')] $ApplicationID,
        [parameter(Mandatory, ParameterSetName = 'ClearText')][string][alias('ClientSecret')] $ApplicationKey,
        [parameter(Mandatory, ParameterSetName = 'Encrypted')][string][alias('ClientSecretEncrypted')] $ApplicationKeyEncrypted,
        [parameter(Mandatory, ParameterSetName = 'Credential')][PSCredential] $Credential,

        [parameter(Mandatory, ParameterSetName = 'Encrypted')]
        [parameter(Mandatory, ParameterSetName = 'ClearText')]
        [parameter(Mandatory, ParameterSetName = 'Credential')]
        [string] $TenantDomain
    )

    $connectGraphSplat = @{
        ApplicationID           = $ApplicationID
        ApplicationKey          = $ApplicationKey
        ApplicationKeyEncrypted = $ApplicationKeyEncrypted
        Credential              = $Credential
        TenantDomain            = $TenantDomain
        Resource                = 'https://graph.microsoft.com/.default'
    }
    Remove-EmptyValue -Hashtable $connectGraphSplat
    Connect-Graphimo @connectGraphSplat
}