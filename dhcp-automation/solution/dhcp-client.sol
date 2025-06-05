---
- name: Configure a DHCPv4 and DHCPv6 network interface
  hosts: clients
  become: true
  vars:
    network_connections:
      - name: dyn_net
        mac: "{{ mac_if2 }}"
        type: ethernet
        state: up
        ip:
          dhcp4: true
          auto6: true
        autoconnect: true

  roles:
    - redhat.rhel_system_roles.network

  tasks:
    # Verifying your work by testing the IPv4 and IPv6 configuration
    - name: Ensure system can connect to servera IPv4 address
      ansible.builtin.wait_for:
        host: 192.168.0.10
        port: 22
        timeout: 10

    - name: Ensure system can connect to servera IPv6 address
      ansible.builtin.wait_for:
        host: fde2:6494:1e09:2::a
        timeout: 10