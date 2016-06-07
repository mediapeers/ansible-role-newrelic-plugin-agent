require 'spec_helper'

describe "Newrelic plugin agent setup" do
  plugin_configs = ANSIBLE_VARS.fetch('newrelic_plugins', 'FAIL')
  nr_licence_key = ANSIBLE_VARS.fetch('nr_licence_key', 'FAIL')
  nginx_status_page = ANSIBLE_VARS.fetch('nginx_status_page', 'FAIL')

  describe package('python-pip') do
    it { should be_installed }
  end

  describe package('python-dev') do
    it { should be_installed }
  end

  describe package('newrelic-plugin-agent') do
    it { should be_installed.by('pip') }
  end

  if INSIDE_ROLE
    describe file(ANSIBLE_VARS.fetch('newrelic_config_dir', 'FAIL')) do
      it { should be_directory }
    end

    describe file(ANSIBLE_VARS.fetch('newrelic_plugin_agent_log_dir', 'FAIL')) do
      it { should be_directory }
    end
  end

  if nr_licence_key != 'FAIL'
    describe file('/etc/newrelic/newrelic-plugin-agent.cfg') do
      it { should be_file }
      plugin_configs.each do |elem|
        config_string = elem.to_yaml.delete("-\"").gsub("\n", "\n  ").strip
        its(:content) { should include(config_string.gsub("{{nginx_status_page}}", nginx_status_page)) }
      end
      its(:content) { should include("license_key: #{nr_licence_key}") }
    end

    describe file('/etc/init.d/newrelic-plugin-agent') do
      it { should exist }
      its(:content) { should include('/etc/newrelic/newrelic-plugin-agent.cfg') }
    end

    describe service('newrelic-plugin-agent') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
