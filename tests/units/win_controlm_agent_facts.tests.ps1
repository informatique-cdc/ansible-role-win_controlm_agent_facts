# Set $ErrorActionPreference to what's set during Ansible execution
$ErrorActionPreference = "Stop"

#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

.$(Join-Path -Path $Here -ChildPath 'test_utils.ps1')

# Update Pester if needed
Update-Pester

#Get Function Name
$moduleName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Resolve Path to Module path
$ansibleModulePath = "$Here\..\..\library\$moduleName.ps1"

Invoke-TestSetup

Function Invoke-AnsibleModule {
    [CmdletBinding()]
    Param(
        [hashtable]$params
    )

    begin {
        $global:complex_args = @{
            "_ansible_check_mode" = $false
            "_ansible_diff"       = $true
        } + $params
    }
    Process {
        . $ansibleModulePath
        return $module.result
    }
}

$RegistryPath = 'HKLM:\SOFTWARE\BMC Software\Control-M/Agent'

try {
    Describe 'win_controlm_agent_facts' -Tag 'Get' {

        Context 'Control/M Agent is installed' {

            BeforeAll {

                Mock -CommandName Get-Service -ParameterFilter { $Name -eq 'ctmag' } -MockWith {
                    return @{
                        Name      = 'ctmag'
                        Status    = 'Running'
                        StartType = 'Automatic'
                    }
                }

                Mock -CommandName Test-NetConnection -MockWith {
                    return @{
                        TcpTestSucceeded = $true
                        PingSucceeded    = $true
                    }
                }

                Mock -CommandName Get-WmiObject -MockWith {
                    return @{
                        startname = 'LocalSystem'
                        status    = 'OK'
                    }
                }

                Mock -CommandName Get-ItemProperty -ParameterFilter { $Path.StartsWith($RegistryPath) } -MockWith {
                    return @{
                        ATCMNDATA             = '9000'
                        AGCMNDATA             = '9001'
                        TRACKER_EVENT_PORT    = '9002'
                        CTMSHOST              = 'server1'
                        CTMPERMHOSTS          = 'server1|server2|server3.cloud'
                        OUTPUT_NAME           = 'MEMNAME'
                        COMM_TRACE            = '1'
                        JOB_WAIT              = 'Y'
                        COMMOPT               = 'SSL=N;DUMMY=N'
                        JOB_STATISTIC         = 'Y'
                        PERSISTENT_CONNECTION = 'N'
                        DEFAULT_AGENT         = 'Default'
                        CODE_VERSION          = '9.0.19.100'
                        FD_NUMBER             = 'DRKAI.9.0.19.100'
                        FIX_NUMBER            = '0'
                    }
                }
                Mock -CommandName Get-HostAddresses -MockWith { return @( @{ IPAddressToString = '192.168.1.1' }) }
            }

            It 'Should return the configuration only' {

                $params = @{ }

                $result = Invoke-AnsibleModule -params $params
                $result.changed | Should -Be $false
                $result.ansible_facts.ansible_controlm_agent.config.job_output_name | Should -Be 'MEMNAME'
                $result.ansible_facts.ansible_controlm_agent.config.agent_to_server_port | Should -Be 9000
                $result.ansible_facts.ansible_controlm_agent.config.server_to_agent_port | Should -Be 9001
                $result.ansible_facts.ansible_controlm_agent.config.tracker_event_port | Should -Be 9002
                $result.ansible_facts.ansible_controlm_agent.config.primary_controlm_server_host | Should -Be 'server1'
                $result.ansible_facts.ansible_controlm_agent.config.authorized_controlm_server_hosts | Should -Be 'server1|server2|server3.cloud'
                $result.ansible_facts.ansible_controlm_agent.config.job_children_inside_job_object | Should -Be $true
                $result.ansible_facts.ansible_controlm_agent.config.agent_version.full | Should -Be '9.0.19.100'
                $result.ansible_facts.ansible_controlm_agent.config.agent_version.major | Should -Be 9
                $result.ansible_facts.ansible_controlm_agent.config.agent_version.minor | Should -Be 0
                $result.ansible_facts.ansible_controlm_agent.config.agent_version.build | Should -Be 19
                $result.ansible_facts.ansible_controlm_agent.config.agent_version.revision | Should -Be 100
                $result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report.agent_ping_to_controlm_server | Should -Be $true
                $result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report.system_ping_to_server_platform | Should -Be $true
                $result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report.dns_translation_of_server | Should -Be '192.168.1.1'
                $result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report.user_name | Should -Be 'LocalSystem'
                $result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report.agent_status | Should -Be 'OK'
                $result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report.agent_state | Should -Be 'Running'
                $result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report.agent_start_mode | Should -Be 'Automatic'
                $result.ansible_facts.ansible_controlm_agent.communication_diagnostic_report.server_agent_connection_mode | Should -Be 'transient'
            }
        }
    }
}
finally {
    Invoke-TestCleanup
}
