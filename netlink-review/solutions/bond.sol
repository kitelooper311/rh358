---
- name: Configure link aggregation
  hosts: serverb.lab.example.com
  become: true
  vars:
    network_connections:
      - name: lab
        state: up
        type: bond
        interface_name: lab
        bond:
          mode: active-backup
        ip:
          address:
            - 10.1.1.10/24

      - name: lab-port1
        state: up
        type: ethernet
        interface_name: eth1
        port_type: bond
        controller: lab

      - name: lab-port2
        state: up
        type: ethernet
        interface_name: eth2
        port_type: bond
        controller: lab

  roles:
    - redhat.rhel_system_roles.network
