default['tw-base']['ports']['allow'] = [ '22' ]

default['tw-base']['ports']['deny'] = [ '80' ]

default['tw-base']['packages']['install'] = ['acl', 'awscli', 'git', 'htop', 'tree', 'vim']

default['tw-base']['packages']['remove'] = ["rpcbind"]

default['tw-base']['groups'] = ['developer', 'sysadmin']
