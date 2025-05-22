---
- name: Configure bond network device
  hosts: servera.lab.example.com
  become: true
  vars:
    network_connections:
      # Create a bond
      - name: bond0
        state: up
        type: bond
        interface_name: bond0
        bond:
          mode: active-backup
        ip:
          address:
            - 192.168.0.100/24

      # add a port interface to the bond
      - name: bond0-port1
        state: up
        type: ethernet
        interface_name: eth1
        port_type: bond
        controller: bond0

      # add a port interface to the bond
      - name: bond0-port2
        state: up
        type: ethernet
        interface_name: eth2
        port_type: bond
        controller: bond0

  roles:
    - redhat.rhel_system_roles.network