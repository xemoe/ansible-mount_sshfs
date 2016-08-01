require 'spec_helper'

describe "System spec" do
    describe "Required packages should be installed" do
        describe package('sshfs') do
            it { should be_installed }
        end
    end
end

mounted_directory = '/mnt/sshfs/mainbox/logs'
syslog_file = "#{mounted_directory}/syslog"
supervisor_program = 'supervisor_sshfs_mainbox'

describe "Tasks spec" do
    describe "Given directory should be mounted directory" do
        describe file("#{mounted_directory}") do
              it { should be_mounted }
        end
    end
    describe "Syslog file from mounted directory should be exist" do
        describe file("#{syslog_file}") do
              it { should be_file }
        end
    end
    describe service('supervisor') do
          it { should be_running }
    end
    describe service("#{supervisor_program}") do
          it { should be_running.under('supervisor') }
    end
end
