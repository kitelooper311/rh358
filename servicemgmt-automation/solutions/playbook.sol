---
- name: Configure 2nd network interface
  hosts: servers
  become: true
  vars:
    target_mac: "52:54:00:01:00:6e"

  tasks:
    - name: Confirm NetworkManager is running
      ansible.builtin.service:
        name: NetworkManager
        state: started
        enabled: true

    - name: Find the_interface for target_mac
      ansible.builtin.set_fact:
        the_interface: "{{ item }}"
      when:
        - ansible_facts[item]['macaddress'] is defined
        - ansible_facts[item]['macaddress'] == target_mac
      loop: "{{ ansible_facts['interfaces'] }}"

    - name: Display the_interface
      ansible.builtin.debug:
        var: the_interface
