# # encoding: utf-8

# Inspec test for recipe tw-base::users

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe user('root') do
  it { should exist }
end

describe user('john') do
  it { should exist }
end
