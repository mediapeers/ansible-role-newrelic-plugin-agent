require 'spec_helper'

describe "Newrelic plugin agent setup" do
  plugin_configs = ANSIBLE_VARS.fetch('newrelic_plugins', 'FAIL')

  describe package('python-pip') do
    it { should be_installed }
  end

  describe package('python-dev') do
    it { should be_installed }
  end

  describe file('/etc/newrelic/newrelic-plugin-agent.cfg') do
    it { should exist }
    plugin_configs.each do |elem|
      config_string = elem.to_yaml.delete("-\"").gsub("\n", "\n  ").strip
      its(:content) { should include(config_string) }
    end
  end

  describe file('/etc/init/newrelic-plugin-agent.conf') do
    it { should exist }
    its(:content) { should include('newrelic-plugin-agent -c /etc/newrelic/newrelic-plugin-agent.cfg') }
  end

  describe service('newrelic-plugin-agent') do
    it { should be_enabled }
    it { should be_running }
  end
end
