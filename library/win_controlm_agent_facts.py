#!/usr/bin/python
# -*- coding: utf-8 -*-

# This is a windows documentation stub.  Actual code lives in the .ps1
# file of the same name.

# Copyright 2020 Informatique CDC. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

from __future__ import absolute_import, division, print_function
__metaclass__ = type


ANSIBLE_METADATA = {'metadata_version': '1.1',
                    'status': ['preview'],
                    'supported_by': 'community'}

DOCUMENTATION = r'''
---
module: win_controlm_agent_facts
short_description: Create a facts collection for Control-M Agent on a Windows host
author:
    - Stéphane Bilqué (@sbilque) Informatique CDC
description:
    - This Ansible module shows information from Control-M Agent, such as configuration or a communication diagnostic report.
seealso:
- module: win_controlm_agent_config
'''

EXAMPLES = r'''
---
- name: test the win_controlm_agent_facts module
  hosts: all
  gather_facts: false

  roles:
    - win_controlm_agent_facts

  tasks:
    - name: Gather facts from Control-M Agent
      win_controlm_agent_facts:

    - name: Displays the Configuration
      debug:
        var: ansible_controlm_agent.config

    - name: Displays the Configuration
      debug:
        var: ansible_controlm_agent.communication_diagnostic_report
'''

RETURN = r'''
ansible_facts:
    description: Detailed information about the Control-M Agent installation.
    returned: always
    type: complex
    contains:
        ansible_controlm_agent:
            description: Detailed information about the Control-M Agent installation.
            returned: always
            type: complex
            contains:
                communication_diagnostic_report:
                    description: Detailed information about Agent issues.
                    returned: success
                    type: dict
                    contains:
                        agent_state:
                            description: Current state of the Windows agent.
                            returned: success
                            type: str
                            sample: as C(Running) or C(Stopped) or C(Paused)
                        agent_start_mode:
                            description: Startup type of the Windows agent service.
                            returned: success
                            type: str
                            sample: as C(Automatic) or C(Manual)
                        user_name:
                            description: Account name under which the Windows agent service runs.
                            returned: success
                            type: str
                            sample: 'LocalSystem'
                        agent_status:
                            description: Current status of the Windows service.
                            returned: success
                            type: str
                            sample: as C(OK) or C(Degraded) or C(Error) or C(Pred Fail)
                        server_agent_connection_mode:
                            description: Indicates whether the agent is connected to the server in persistent connection mode.
                            returned: success
                            type: str
                            sample: as C(persistent) or C(transient)
                        server_agent_communication_protocol:
                            description: Protocol type of the Server-Agent communication.
                            returned: success
                            type: str
                            sample: as C(TCP) or C(SSL)
                        system_ping_to_server_platform:
                            description: Ping connectivity to the primary server.
                            returned: success
                            type: bool
                        agent_ping_to_controlm_server:
                            description: Indicates that CONTROL-M/Server is active on the Server platform that is connected to the Agent platform.
                            returned: success
                            type: bool
                        dns_translation_of_server:
                            description: IP address of the primary server host.
                            returned: success
                            type: bool
                            sample: '192.168.1.1'
                config:
                    description: Detailed information about stored the configuration.
                    returned: success
                    type: dict
                    contains:
                        agent_to_server_port:
                            description: Port number in the Control-M Agent computer where data is received from the Control-M Server computer.
                            returned: success
                            type: int
                            sample: 7006
                        allow_comm_init:
                            description: Indicates whether the agent can open a connection to the server when working in persistent connection mode.
                            returned: success
                            type: bool
                        authorized_controlm_server_hosts:
                            description: List of backup servers which can replace the primary server if it fails.
                            returned: success
                            type: str
                        autoedit_inline:
                            description: Indicates whether all variables will be set as environment variables in the script.
                            returned: success
                            type: bool
                        cjk_encoding:
                            description: CJK encoding used by Control-M Agent to run jobs.
                            returned: success
                            type: str
                            sample: UTF-8
                        communication_trace:
                            description: Indicates whether communication packets that Control-M Agent sends to and receives from Control-M Server are written to a file.
                            returned: success
                            type: bool
                        ctms_address_mode:
                            description: Indicates if the IP address is used instead of the host name.
                            returned: success
                            type: str
                        daily_log_file_enabled:
                            description: Indicates if the ctmag_\<year>\<month>\<day>.log file is generated.
                            returned: success
                            type: bool
                        days_to_retain_log_files:
                            description: Number of days to retain agent proclog files.
                            returned: success
                            type: int
                            sample: 1
                        default_printer:
                            description: Default printer for job OUTPUT files.
                            returned: success
                            type: str
                        diagnostic_level:
                            description: Debug level.
                            returned: success
                            type: int
                            sample: 0
                        echo_job_commands_into_sysout:
                            description: Indicates whether to print commands in the OUTPUT of a job.
                            returned: success
                            type: bool
                        foreign_language_support:
                            description: Indicates whether the system is configured for CJK languages or Latin1 languages.
                            returned: success
                            type: str
                            sample: LATIN-1
                        job_children_inside_job_object:
                            description: Indicates whether procedures invoked by a job can be run outside the Job Object.
                            returned: success
                            type: bool
                        limit_log_file_size:
                            description: Maximum size (MB) of diagnostic log files for a process or a thread.
                            returned: success
                            type: int
                            sample: 10
                        limit_log_version:
                            description: Number of generations of diagnostic log information to keep for a process or a thread.
                            returned: success
                            type: int
                            sample: 10
                        listen_to_network_interface:
                            description: Network interface the agent is listening on.
                            returned: success
                            type: str
                            sample: \*ANY
                        logical_agent_name:
                            description: Logical name of the agent.
                            returned: success
                            type: str
                        logon_as_user:
                            description: Indicates whether the user account is used for the services to log on to.
                            returned: success
                            type: bool
                        logon_domain:
                            description: Logon domain of the user account.
                            returned: success
                            type: str
                        measure_usage_day:
                            description: Number of days to retain the files in the dailylog directory.
                            returned: success
                            type: int
                            sample: 7
                        persistent_connection:
                            description: Indicates whether NS process creates a persistent connection with the agent and manages the session with this agent.
                            returned: success
                            type: bool
                        primary_controlm_server_host:
                            description: Hostname of the computer where the current Control-M Server submits jobs to the Control-M Agent.
                            returned: success
                            type: str
                        server_agent_protocol_version:
                            description: Server-Agent communication protocol version.
                            returned: success
                            type: int
                            sample: 12
                        run_user_logon_script:
                            description: Indicates wether a user-defined logon script should be run by the Control-M Agent before running the standard user logon script.
                            returned: success
                            type: bool
                        server_to_agent_port:
                            description: Port number that receives data from the Control-M Agent computer.
                            returned: success
                            type: int
                            sample: 7005
                        smtp_port:
                            description: Port number on which the SMTP server communicates.
                            returned: success
                            type: int
                            sample: 25
                        smtp_reply_to_mail:
                            description: E-mail address to which to send replies.
                            returned: success
                            type: str
                        smtp_sender_friendly_name:
                            description: Name or alias that appears on the e-mail sent.
                            returned: success
                            type: str
                        smtp_sender_mail:
                            description: E-mail address of the sender.
                            returned: success
                            type: str
                            sample: control@m
                        smtp_server_relay_name:
                            description: Name of the SMTP server.
                            returned: success
                            type: str
                        ssl:
                            description: Indicates whether SSL is used to encrypt the communication between Control-M Server and the Control-M Agent.
                            returned: success
                            type: bool
                        job_output_name:
                            description: Prefix for the OUTPUT file name.
                            returned: success
                            type: str
                            sample: JOBNAME
                        tcpip_timeout:
                            description: Communication job-tracking timeout in seconds.
                            returned: success
                            type: int
                            sample: 60
                        timeout_for_agent_utilities:
                            description: Maximum time (in seconds) the agent waits after sending a request to Control-M Server.
                            returned: success
                            type: int
                            sample: 600
                        tracker_event_port:
                            description: Number of the port for sending messages to the Tracker process when jobs end.
                            returned: success
                            type: int
                            sample: 7035
                        tracker_polling_interval:
                            description: Tracker event timeout in seconds.
                            returned: success
                            type: int
                            sample: 60
                        wrap_parameters_with_double_quotes:
                            description: Indicates how parameter values (%%PARMn....%%PARMx) are managed by Control-M Agent for Microsoft Windows.
                            returned: success
                            type: int
                            sample: 4
                        default_agent_name:
                            description: Agent name.
                            returned: success
                            type: str
                            sample: Default
                        cm_name:
                            description: Version of the Control/M application.
                            returned: success
                            type: str
                            sample: WIN
                        cm_type:
                            description: Type of the Control/M plateforme.
                            returned: success
                            type: str
                            sample: WIN2K
                        agent_version:
                            description: Dictionary/map that contains information about the current running version of the agent.
                            returned: success
                            type: dict
                            contains:
                                full:
                                    description: The full string of the version.
                                    type: str
                                    sample: 9.0.20.100
                                major:
                                    description: The major component of the version number.
                                    type: int
                                    sample: 9
                                minor:
                                    description: The minor component of the version number.
                                    type: int
                                    sample: 0
                                build:
                                    description: The build component of the version number.
                                    type: int
                                    sample: 20
                                revision:
                                    description: The revision component of the version number. A higher revision number might be used in a build that fixes a security hole in a previously released agent.
                                    type: int
                                    sample: 100
                        fd_number:
                            description: Unique identifier of the agent.
                            returned: success
                            type: str
                            sample: DRKAI.9.0.20.000
                        fix_number:
                            description: Unique identifier of the fix pack.
                            returned: success
                            type: str
                            sample: DRKAI.9.0.20.000
                        agent_directory:
                            description: Installation folder of the agent.
                            returned: success
                            type: str
                            sample: C:\Program Files\Control-M Agent\Default
'''
