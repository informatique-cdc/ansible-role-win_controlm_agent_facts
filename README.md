
# win_controlm_agent_facts - Create a facts collection for Control-M Agent on a Windows host

## Synopsis

* This Ansible module shows information from Control-M Agent configuration, such as configuration or a communication diagnostic report.

## Examples

```yaml
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

```

## Return Values

Common return values are documented [here](https://docs.ansible.com/ansible/latest/reference_appendices/common_return_values.html#common-return-values), the following are the fields unique to this module:

| Key    | Returned   | Description |
| ------ |------------| ------------|
| __ansible_facts__<br><font color="purple">complex</font> | always |  Detailed information about the Control-M Agent installation |

## Authors

* Stéphane Bilqué (@sbilque) Informatique CDC

## License

This project is licensed under the Apache 2.0 License.

See [LICENSE](LICENSE) to see the full text.
