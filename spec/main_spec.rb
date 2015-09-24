require 'spec_helper'

describe "Newrelic plugin agent setup" do
  describe package('python-pip') do
    it { should be installed }
  end

  describe package('python-dev') do
    it { should be_installed }
  end

  describe file('/etc/newrelic/newrelic-plugin-agent.cfg') do
    it { should exist }
    it { should contain('nginx') }
  end

  describe file('/etc/init/newrelic-plugin-agent.conf') do
    it { should exist }
    it { should contain('newrelic-plugin-agent -c /etc/newrelic/newrelic-plugin-agent.cfg') }
  end

  describe service('newrelic-plugin-agent') do
    it { should be_enabled }
    it { should be_running }
  end
end
