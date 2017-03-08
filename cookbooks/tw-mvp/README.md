# tw-mvp

Installs/configure the MVP using the cookbook `tw-mvp`.

## Vagrant

If you want to test using Vagrant:

.kitchen.yml using Vagrant and Chef-Zero:

      ---
      driver:
        name: vagrant
        network:
          - ["private_network", {ip: "192.168.33.33"}]
          - ["forwarded_port", {guest: 8000, host: 8080}]
          - ["forwarded_port", {guest: 8001, host: 8081}]
          - ["forwarded_port", {guest: 8002, host: 8082}]

      provisioner:
        name: chef_zero
        always_update_cookbooks: false
        roles_path: ../../roles
        data_bags_path: ../../data_bags
        encrypted_data_bag_secret_key_path: "../../secret_key"

      verifier:
        name: inspec

      platforms:
        - name: ubuntu-16.04

      suites:
        - name: default
          run_list:
            - role[base]
            - role[mvp]
          verifier:
            inspec_tests:
              - test/smoke/default
          attributes:
            authorization:
              sudo:
                users: ['kitchen', 'vagrant']
                passwordless: true
                include_sudoers_d: true
