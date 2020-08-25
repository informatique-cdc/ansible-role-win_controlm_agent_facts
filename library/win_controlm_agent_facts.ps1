#!powershell

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options             = @{ }
    supports_check_mode = $true
}

# All entries to REG_SZ type
$configuration = @{
    agent_to_server_port               = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'ATCMNDATA'  ; ParameterType = 'int32' }
    server_to_agent_port               = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'AGCMNDATA'  ; ParameterType = 'int32' }
    primary_controlm_server_host       = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'CTMSHOST' ; ParameterType = 'string' }
    authorized_controlm_server_hosts   = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'CTMPERMHOSTS' ; ParameterType = 'string' }
    diagnostic_level                   = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'DBGLVL'; Default = '0' ; ParameterType = 'int32' }
    communication_trace                = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'COMM_TRACE'; Default = '0' ; ParameterType = 'boolean' }
    days_to_retain_log_files           = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'LOGKEEPDAYS'; Default = '1'; ParameterType = 'int32' }
    daily_log_file_enabled             = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'AG_LOG_ON'; Default = 'Y' ; ParameterType = 'boolean' }
    tracker_event_port                 = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'TRACKER_EVENT_PORT'; ParameterType = 'int32' }
    logical_agent_name                 = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'LOGICAL_AGENT_NAME' ; Default = "$env:COMPUTERNAME" ; ParameterType = 'string' }
    java_new_ar                        = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'JAVA_AR' ; Default = 'N' ; ParameterType = 'boolean' }
    persistent_connection              = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'PERSISTENT_CONNECTION'; Default = 'N' ; ParameterType = 'boolean' }
    allow_agent_to_ini_connection      = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'ALLOW_COMM_INIT'; Default = 'Y'; ParameterType = 'boolean' }
    foreign_language_support           = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'I18N'; Default = 'LATIN-1' ; ParameterType = 'string' }
    ssl                                = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'COMMOPT'; Default = 'SSL=N' ; ParameterType = 'boolean' }
    server_agent_protocol_version      = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'PROTOCOL_VERSION'; Default = '12'; ParameterType = 'int32' }
    autoedit_inline                    = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'USE_JOB_VARIABLES'; Default = 'Y' ; ParameterType = 'boolean' }
    listen_to_network_interface        = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'LISTEN_INTERFACE'; Default = '*ANY'; ParameterType = 'string' }
    ctms_address_mode                  = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'CTMS_ADDR_MODE'; Default = '' ; ParameterType = 'string' }
    timeout_for_agent_utilities        = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'UTTIMEOUT'; Default = '600' ; ParameterType = 'int32' }
    tcpip_timeout                      = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'TCP_IP_TIMEOUT'; Default = '60'; ParameterType = 'int32' }
    tracker_polling_interval           = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'EVENT_TIMEOUT' ; Default = '60' ; ParameterType = 'int32' }
    limit_log_file_size                = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'LIMIT_LOG_FILE_SIZE'; Default = '10' ; ParameterType = 'int32' }
    limit_log_version                  = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'LIMIT_LOG_VERSIONS'; Default = '10'; ParameterType = 'int32' }
    measure_usage_day                  = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'MEASURE_USAGE_DAYS'; Default = '7'; ParameterType = 'int32' }
    logon_as_user                      = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'LOGON_AS_USER'; Default = 'N' ; ParameterType = 'boolean' }
    logon_domain                       = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'DOMAIN'; Default = '' ; ParameterType = 'string' }
    job_children_inside_job_object     = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'JOB_WAIT'; Default = 'Y' ; ParameterType = 'boolean' }
    add_job_statistics_to_sysout       = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'JOB_STATISTIC'; Default = 'Y' ; ParameterType = 'boolean' }
    job_output_name                    = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'OUTPUT_NAME'; Default = 'MEMNAME' ; ParameterType = 'string' }
    wrap_parameters_with_double_quotes = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'WRAP_PARAM_QUOTES'; Default = '4' ; ParameterType = 'int32' }
    run_user_logon_script              = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'RUN_USER_LOGON_SCRIPT'; Default = 'N' ; ParameterType = 'boolean' }
    cjk_encoding                       = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'APPLICATION_LOCALE'; Default = ''; ParameterType = 'string' }
    default_printer                    = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'DFTPRT'; Default = '' ; ParameterType = 'string' }
    echo_job_commands_into_sysout      = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'ECHO_OUTPUT'; Default = 'Y' ; ParameterType = 'boolean' }
    smtp_server_relay_name             = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'SMTP_SERVER_NAME'; Default = '' ; ParameterType = 'string' }
    smtp_port                          = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'SMTP_PORT_NUMBER'; Default = '25' ; ParameterType = 'int32' }
    smtp_sender_mail                   = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'SMTP_SENDER_EMAIL'; Default = 'control@m' ; ParameterType = 'string' }
    smtp_sender_friendly_name          = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'SMTP_SENDER_FRIENDLY_NAME'; Default = ''; ParameterType = 'string' }
    smtp_reply_to_mail                 = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'SMTP_REPLY_TO_EMAIL'; Default = ''; ParameterType = 'string' }
    default_agent_name                 = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent' ; Name = 'DEFAULT_AGENT'; ParameterType = 'string' }
    cm_type                            = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\WIN' ; Name = 'APPLICATION_VERSION'; ParameterType = 'string' }
    cm_name                            = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'CM_APPL_TYPE'; Default = '' ; ParameterType = 'string' }
    agent_version                      = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'CODE_VERSION'; Default = '' ; ParameterType = 'string' }
    fd_number                          = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'FD_NUMBER'; ParameterType = 'string' }
    fix_number                         = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'FIX_NUMBER'; ParameterType = 'string' }
    agent_directory                    = @{ Path = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent\CONFIG' ; Name = 'AGENT_DIR'; ParameterType = 'string' }
}

function ConvertTo-Boolean {
    <#
    .SYNOPSIS
    This function Convert common values to Powershell boolean values $true and $false.
    .PARAMETER value
    Specifies the string to convert.
    #>
    param
    (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [string]
        $value
    )
    switch ($value) {
        "y" { return $true; }
        "yes" { return $true; }
        "true" { return $true; }
        "t" { return $true; }
        1 { return $true; }
        "n" { return $false; }
        "no" { return $false; }
        "false" { return $false; }
        "f" { return $false; }
        0 { return $false; }
    }
}

Function ConvertFrom-ControlMParameter {

    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Name,
        [string]
        $Value
    )
    if ($null -eq $Value) {
        return $null
    }
    $ConvertedValue = $null

    if (-not $configuration[$Name]) {
        $ConvertedValue = [string]$Value
    }
    elseif ($Name -eq 'ssl') {
        $ConvertedValue = ($Value -contains 'SSL=Y')
    }
    elseif ($Name -eq 'communication_trace') {
        $ConvertedValue = ConvertTo-Boolean -Value $Value;
    }
    else {
        $ParameterType = $configuration[$Name].ParameterType
        $ConvertedValue = switch ($ParameterType) {
            "Int32" {
                [int]$int = $null
                [int32]::TryParse($Value, [ref]$int) | Out-Null; $int; break
            }
            "Boolean" {
                ConvertTo-Boolean -Value $Value; break
            }
            default {
                [string]$Value
            }
        }
    }
    return $ConvertedValue
}

Function Get-ControlMParameter {

    [OutputType('System.String')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]
        $Name
    )

    if ( -not $configuration.ContainsKey($Name) ) {
        $module.FailJson("The configuration hashtable does not contain the `"$Name`" setting")
    }

    $Value = $null
    $RegistryInfo = $configuration[$Name]
    Get-ItemProperty -Path $RegistryInfo.Path -Name $RegistryInfo.Name -ErrorAction SilentlyContinue -ErrorVariable RegistryError -OutVariable RegistryEntry | Out-Null
    if (-not $RegistryError) {
        $Value = $($RegistryEntry.$($RegistryInfo.Name))
    }
    elseif ($RegistryInfo.Default) {
        $Value = $RegistryInfo.Default
    }
    return $Value
}

function Get-HostAddresses {
    <#
    .SYNOPSIS
    Returns the Internet Protocol (IP) addresses for the specified host.
    .PARAMETER HostNameOrAddress
    The host name or IP address to resolve.
    .OUTPUTS
    An array of type IPAddress that holds the IP addresses for the host that is specified by the hostNameOrAddress parameter.
    #>
    [OutputType([System.Net.IPAddress[]])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]
        $HostNameOrAddress
    )
    $IPAddresses = [System.Net.Dns]::GetHostAddresses($HostNameOrAddress)
    return $IPAddresses
}

Function Get-VersionPart {
    <#
    .SYNOPSIS
    Retrieves the sermver part in a string
    #>
    [OutputType([hashtable])]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]
        $string
    )

    $semver = [regex]@'
(?inx)
(?<Major>0|\d+)\.
(?<Minor>[0-9]\d*)
(?<PatchWithSeparator>\.(?<Patch>[0-9]\d*))?
(?<PreReleaseTagWithSeparator>-(?<PreReleaseTag>([a-z-][\da-z-]+|[\da-z-]+[a-z-][\da-z-]*|0|[1-9]\d*)(\.([a-z-][\da-z-]+|[\da-z-]+[a-z-][\da-z-]*|0|[1-9]\d*))*))?
(?<BuildMetadataWithSeparator>\+(?<BuildMetadata>[\da-z-]+(\.[\da-z-]+)*))?
(?<BuildWithSeparator>\.(?<Build>\d+))?
'@
    if ($string -match $semver) {
        return @{
            full     = $matches[0]
            major    = [int]$matches['Major']
            minor    = [int]$matches['Minor']
            build    = [int]$matches['Patch']
            revision = [int]$matches['Build']
        }
    }
    else {
        return $null
    }
}

Function Get-DiagnosticReport {
    <#
    .SYNOPSIS
    Retrieves the communication diagnostic results
    #>
    $report = @{ }
    $config = $module.result.ansible_facts.ansible_controlm_agent.config

    $service = Get-Service -Name ctmag
    $report.agent_state = $service.Status.ToString()
    $report.agent_start_mode = $service.StartType.ToString()

    $service = Get-WmiObject -Class Win32_Service -Filter "Name='ctmag'"
    $report.user_name = $service.StartName
    $report.agent_status = $service.Status

    if ($config.ContainsKey('persistent_connection')) {
        $report.server_agent_connection_mode = switch ($config['persistent_connection']) {
            $true { 'persistant' }
            $false { 'transient' }
        }
    }
    if ($config.ContainsKey('ssl')) {
        $report.server_agent_communication_protocol = switch ($config['ssl']) {
            $true { 'SSL' }
            $false { 'TCP' }
        }
    }

    if ($module.CheckMode) {
        $report.system_ping_to_server_platform = $true
        $report.agent_ping_to_controlm_server = $true
        $report.dns_translation_of_server = '1.1.1.1'
    }
    elseif ($config['primary_controlm_server_host']) {

        $serverHostName = $config['primary_controlm_server_host']
        $port = $config['agent_to_server_port']

        $ping = Test-NetConnection -ComputerName $serverHostName
        $report.system_ping_to_server_platform = $ping.PingSucceeded

        $agping = Test-NetConnection -ComputerName $serverHostName -Port $port
        $report.agent_ping_to_controlm_server = $agping.TcpTestSucceeded

        $ips = Get-HostAddresses -HostNameOrAddress $serverHostName
        $translation = @()
        foreach ($ip in $ips) { $translation = $translation + $ip.IPAddressToString }
        $report.dns_translation_of_server = $translation -join ','
    }

    $module.result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report = $report
}

Function Get-Configuration {
    <#
    .SYNOPSIS
    Retrieves all settings of the configuration.
    #>
    $config = @{ }

    $configuration.Keys | ForEach-Object {
        $ControlMValue = Get-ControlMParameter -Name $_
        $Value = ConvertFrom-ControlMParameter -Name $_ -Value $ControlMValue
        $config[$_] = $Value
    }

    if ($config.ContainsKey('fix_number') -and $config.ContainsKey('fix_number') -ne "0") {
        $version = Get-VersionPart -String $config.fix_number
        $config.agent_version = $version
    }
    else {
        $version = Get-VersionPart -String $config.agent_version
        $config.agent_version = $version
    }

    $module.result.ansible_facts.ansible_controlm_agent.config = $config
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

# Create a new result object
$module.Result.changed = $false

$service = Get-Service -Name ctmag -ErrorAction SilentlyContinue -ErrorVariable ProcessError
If ($ProcessError) {
    $module.ExitJson()
}

$module.Result.ansible_facts = @{
    ansible_controlm_agent = @{
        config                          = @{ }
        communication_diagnostic_report = @{ }
    }
}

Get-Configuration
Get-DiagnosticReport

# Return result
$module.ExitJson()
