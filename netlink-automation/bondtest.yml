---
- name: Test network bond
  hosts: servera.lab.example.com
  become: true

  tasks:
    - name: Confirm bond interface functions
      ansible.builtin.command: ping -I bond0 -c1 -w2 192.168.0.254
