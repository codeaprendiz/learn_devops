#!/bin/bash -xe


# Make it easy to run iperf3.
echo "iperf3 -c <EXT_IP> -p 80 -i 1 -t 30 -P 8 -V" > /tmp/run_iperf_to_ext.sh
chmod 755 /tmp/run_iperf_to_ext.sh
echo "iperf3 -c <INT_IP> -p 80 -i 1 -t 30 -P 8 -V" > /tmp/run_iperf_to_int.sh
chmod 755 /tmp/run_iperf_to_int.sh

# Setup iperf3.
apt-get update
apt-get install -y iperf3

cat > /etc/systemd/system/iperf3.service <<EOF
[Unit]
Description=iPerf 3 Server
[Service]
Restart=always
TimeoutStartSec=0
RestartSec=3
WorkingDirectory=/tmp
ExecStart=/usr/bin/iperf3 -s -p 80
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable iperf3
systemctl start iperf3
