---
- name: Deploy a DHCPv4 and DHCPv6 server
  hosts: dhcp_servers
  become: true
  vars:
    network_connections:
      - name: static_net
        type: ethernet
        mac: "{{ mac_if2 }}"
        state: up
        ip:
          address:
            - "192.168.0.10/24"
            - "fde2:6494:1e09:2::a/64"
        autoconnect: true

  roles:
    - redhat.rhel_system_roles.network

  tasks:
    - name: Ensure dhcp-server package is installed
      ansible.builtin.dnf:
        name: dhcp-server
        state: present

    - name: Ensure DHCPv4 configuration file is deployed
      ansible.builtin.copy:
        src: files/dhcpd.conf
        dest: /etc/dhcp/dhcpd.conf
      notify: Reload dhcpd

    - name: Ensure DHCPv6 configuration file is deployed
      ansible.builtin.copy:
        src: files/dhcpd6.conf
        dest: /etc/dhcp/dhcpd6.conf
      notify: Reload dhcpd6

    - name: Ensure dhcpd and dhcpd6 services are started and enabled
      ansible.builtin.service:
        name: "{{ item }}"
        state: started
        enabled: true
      loop:
        - dhcpd
        - dhcpd6

    - name: Ensure dhcp and dhcpv6 firewall services are enabled
      ansible.posix.firewalld:
        service: "{{ item }}"
        state: enabled
        immediate: true
        permanent: true
      loop:
        - dhcp
        - dhcpv6

  handlers:
    - name: Reload dhcpd
      ansible.builtin.service:
        name: dhcpd
        state: restarted

    - name: Reload dhcpd6
      ansible.builtin.service:
        name: dhcpd6
        state: restarted