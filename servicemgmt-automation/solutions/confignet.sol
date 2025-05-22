---
- name: Configure 2nd network interface
  hosts: servers
  become: true
  vars:
    target_mac: "52:54:00:01:00:6e"
    network_connections:
      - name: static_net
        type: ethernet
        mac: "{{ target_mac }}"
        state: up
        ip:
          dhcp4: false
          address:
            - 192.168.0.1/24

  roles:
    - redhat.rhel_system_roles.network
