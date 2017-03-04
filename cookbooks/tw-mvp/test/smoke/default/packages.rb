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
