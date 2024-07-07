# systemctl

- [systemctl](https://man7.org/linux/man-pages/man1/systemctl.1.html)

## Examples

```bash
# Tested on Ubuntu 22.04.4 LTS
cat /etc/os-release  | grep "PRETTY_NAME"
PRETTY_NAME="Ubuntu 22.04.4 LTS"
```

Check if `docker` service is running

```bash
systemctl status docker
```

Displays the current status of IP forwarding for IPv4.

```bash
sysctl net.ipv4.ip_forward
# Enables IP forwarding for IPv4. This change is temporary and will be lost after a reboot.
sudo sysctl -w net.ipv4.ip_forward=1
```

Displays the current value of the lowest unprivileged port number that can be used by non-root users.

```bash
sudo sysctl net.ipv4.ip_unprivileged_port_start
# Sets the lowest unprivileged port number to 443, allowing non-root users to bind to ports 443 and above. This requires superuser privileges and the change is temporary, lost after a reboot.
sudo sysctl -w net.ipv4.ip_unprivileged_port_start=443
```
