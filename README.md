**Moved to https://github.com/mediafellows/ansible-role-newrelic-plugin-agent**

[![Build Status](https://travis-ci.com/mediapeers/ansible-role-newrelic-plugin-agent.svg?branch=master)](https://travis-ci.com/mediapeers/ansible-role-newrelic-plugin-agent)

# Ansible role for newrelic-plugin-agent
This ansible role will install and configure the [Newrelic plugin agent](https://github.com/MeetMe/newrelic-plugin-agent). Based on the parameters it will setup the plugin agent to monitor
different software packages.

## Requirements
Role was tested on Ubuntu 14.04 but might as well work on other Debian based systems that have an apt pacakage for python-dev and python-pip.

## Role Variables
Following variables should be provided:
- `nr_licence_key` - Your licence key for your [Newrelic](http://newrelic.com/) account.
- `newrelic_plugins` - list of packages to create a config for in the `newrelic-plugin-agent.cfg` file*. Provice necessary YAML params for each entry!

*Can theoretically be any of [those package](https://github.com/MeetMe/newrelic-plugin-agent/blob/master/README.rst#newrelic-plugin-agent).

## Dependencies
Doesn't depend on any other ansible roles

## Example Playbook
Copy this role into the `roles/mediapeers.newrelic-plugin-agent` dir in your Ansible project. Preferably add it as a submodule.
You can also install it with `ansible-galaxy install mediapeers.newrelic-plugin-agent`.

Then use it like so:
```yaml
- name: Some Playbook
  hosts: servers
  vars:
    nr_licence_key: abc123
    newrelic_plugins:
      - nginx:
          host: localhost
          port: 8080
          path: /status_page/
      - elasticsearch:
          host: localhost
          port: 9200
          name: my_cluster
  roles:
    - mediapeers.newrelic-plugin-agent
```

## License
BSD. Feel free to reuse. No guarantees attached.

## Author Information
Stefan Horning <horning@mediapeers.com>
