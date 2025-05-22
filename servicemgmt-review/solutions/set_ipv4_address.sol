---
- name: Modify network connection
  hosts: servera.lab.example.com
  become: true

  tasks:
  - name: Create a network connection named lab_con
    command: nmcli con add con-name 'lab_conn' type ethernet ifname eth1

  - name: Modify network connection lab_conn
    command: nmcli con mod 'lab_conn' ipv4.addresses '192.168.0.1/24' ipv4.method manual