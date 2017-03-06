# # encoding: utf-8

# Inspec test for recipe tw-mvp::packages

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/usr/bin/java') do
  it { should exist}
end

describe command('/usr/bin/java -version') do
  its('exit_status'){ should eq 0 }
  skip "Ensure that java is installed"
end

describe command('/usr/bin/javac -version') do
  its('exit_status'){ should eq 0 }
  skip "Ensure that javac is installed"
end

describe file('/bin/lein') do
  it { should exist}
end

%w(.git common-utils front-end quotes).each do |dir|
  describe directory("/srv/mvp/#{dir}") do
    it { should exist }
    it { should be_owned_by 'mvp' }
    it { should be_grouped_into 'mvp' }
  end
end

describe user('mvp') do
  it { should exist }
  its('group'){ should eq 'mvp' }
  its('shell'){ should eq '/bin/false'}
end

directory '/usr/lib/jvm' do
  it { should exist }
  it { should be_owned_by 'root' }
  it { should be_grouped_into  }
end

directory '/opt/mvp' do
  it { should exist }
  it { should be_owned_by 'mvp' }
  it { should be_grouped_into 'mvp' }
end
