---
network_connections:
  - name: lab_conn
    type: ethernet
    mac: "52:54:00:01:00:6f"
    state: up
    ip:
      dhcp4: false
      address:
        - 192.168.0.11/24