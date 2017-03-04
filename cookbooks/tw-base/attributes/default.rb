# firewall

## Add more ports to the list to open
default['tw-base']['ports']['allow'] = [ '22' ]
default['tw-base']['ports']['deny'] = [ '80' ]

# install
## acl : for backup/recovery files/folder permissions
## awscli : for interacting with amazon aws services
## git: cloning project's repository
## htop: visualize system status
## tree: visualize folder structure in a tree format
## vim: file editor

default['tw-base']['packages']['install'] = ['acl', 'awscli', 'git', 'htop', 'tree', 'vim']

# remove
## rpcbind: ensures rpcbind is not installed (security)
default['tw-base']['packages']['remove'] = ["rpcbind"]

default['tw-base']['groups'] = ['developer', 'sysadmin']
