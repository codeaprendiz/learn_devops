# tcpdump

## Learning TCP Dump

### To capture and display network packets transmitted from the source IP address `192.168.1.130` to the destination IP address `142.250.181.78` on any network interface, without resolving hostnames.

```bash
# Terminal 1
$ nslookup google.com
Server:         192.168.1.1
Address:        192.168.1.1#53

Non-authoritative answer:
Name:   google.com
Address: 142.250.181.78

$ sudo tcpdump -i any -n 'src 192.168.1.130 and dst 142.250.181.78'    
tcpdump: data link type PKTAP
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type PKTAP (Apple DLT_PKTAP), snapshot length 524288 bytes

# Terminal 2
$ curl google.com                           
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

# Terminal 1
$ sudo tcpdump -i any -n 'src 192.168.1.130 and dst 142.250.181.78'    
tcpdump: data link type PKTAP
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on any, link-type PKTAP (Apple DLT_PKTAP), snapshot length 524288 bytes

15:11:32.657768 IP 192.168.1.130.60025 > 142.250.181.78.80: Flags [S], seq 469828970, win 65535, options [mss 1460,nop,wscale 6,nop,nop,TS val 82779814 ecr 0,sackOK,eol], length 0
15:11:32.670766 IP 192.168.1.130.60025 > 142.250.181.78.80: Flags [.], ack 4133612689, win 2056, options [nop,nop,TS val 82779827 ecr 2499919998], length 0
15:11:32.670803 IP 192.168.1.130.60025 > 142.250.181.78.80: Flags [P.], seq 0:73, ack 1, win 2056, options [nop,nop,TS val 82779827 ecr 2499919998], length 73: HTTP: GET / HTTP/1.1
15:11:32.882832 IP 192.168.1.130.60025 > 142.250.181.78.80: Flags [.], ack 774, win 2044, options [nop,nop,TS val 82780039 ecr 2499920212], length 0
15:11:32.883292 IP 192.168.1.130.60025 > 142.250.181.78.80: Flags [F.], seq 73, ack 774, win 2048, options [nop,nop,TS val 82780039 ecr 2499920212], length 0
15:11:32.896260 IP 192.168.1.130.60025 > 142.250.181.78.80: Flags [.], ack 775, win 2048, options [nop,nop,TS val 82780053 ecr 2499920225], length 0

```

**Description**

The table below outlines the output from a `tcpdump` command capturing packets sent from the local machine (IP address `192.168.1.130`) to a Google server (IP address `142.250.181.78`). This data illustrates the TCP/IP communication during an HTTP request to the server.

**Output Table**

| Time                                             | Source IP:Port                                                   | Destination IP:Port                                                 | TCP Flags                                                                      | Sequence & Acknowledgment Numbers                                                           | Window Size                                                | TCP Options                                                                                                                                                              | Payload Size                                 | Description                                                                   |
|--------------------------------------------------|------------------------------------------------------------------|---------------------------------------------------------------------|--------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------------|
| 15:11:32.657768 <br><br> Time of packet capture. | 192.168.1.130:60025 <br><br> Source IP and port (local machine). | 142.250.181.78:80 <br><br> Destination IP and port (Google server). | [S] <br><br> SYN flag set, initiating a TCP connection.                        | seq 469828970 <br><br> Initial sequence number for the connection.                          | win 65535 <br><br> Window size (flow control information). | mss 1460, wscale 6, TS, sackOK <br><br> TCP options including Maximum Segment Size (MSS), window scaling (wscale), Timestamp (TS), and Selective Acknowledgement (SACK). | 0 <br><br> No payload data.                  | Initiating a TCP connection with a SYN packet.                                |
| 15:11:32.670766 <br><br> Time of packet capture. | 192.168.1.130:60025 <br><br> Source IP and port (local machine). | 142.250.181.78:80 <br><br> Destination IP and port (Google server). | [.] <br><br> ACK flag set, acknowledging receipt of data.                      | ack 4133612689 <br><br> Acknowledgment number for the received packet.                      | win 2056 <br><br> Window size (flow control information).  | nop, nop, TS <br><br> TCP options including no-operations (nop) and Timestamp (TS).                                                                                      | 0 <br><br> No payload data.                  | Acknowledging receipt of the server's SYN-ACK packet.                         |
| 15:11:32.670803 <br><br> Time of packet capture. | 192.168.1.130:60025 <br><br> Source IP and port (local machine). | 142.250.181.78:80 <br><br> Destination IP and port (Google server). | [P.] <br><br> PSH and ACK flags set, indicating pushed data.                   | seq 0:73, ack 1 <br><br> Sequence number for the data being sent and acknowledgment number. | win 2056 <br><br> Window size (flow control information).  | nop, nop, TS <br><br> TCP options including no-operations (nop) and Timestamp (TS).                                                                                      | 73 <br><br> Length of the HTTP request data. | Sending an HTTP GET request.                                                  |
| 15:11:32.882832 <br><br> Time of packet capture. | 192.168.1.130:60025 <br><br> Source IP and port (local machine). | 142.250.181.78:80 <br><br> Destination IP and port (Google server). | [.] <br><br> ACK flag set, acknowledging receipt of data.                      | ack 774 <br><br> Acknowledgment number for the received packet.                             | win 2044 <br><br> Window size (flow control information).  | nop, nop, TS <br><br> TCP options including no-operations (nop) and Timestamp (TS).                                                                                      | 0 <br><br> No payload data.                  | Acknowledging receipt of the HTTP response from the server.                   |
| 15:11:32.883292 <br><br> Time of packet capture. | 192.168.1.130:60025 <br><br> Source IP and port (local machine). | 142.250.181.78:80 <br><br> Destination IP and port (Google server). | [F.] <br><br> FIN and ACK flags set, indicating the closing of the connection. | seq 73, ack 774 <br><br> Sequence number for the data being sent and acknowledgment number. | win 2048 <br><br> Window size (flow control information).  | nop, nop, TS <br><br> TCP options including no-operations (nop) and Timestamp (TS).                                                                                      | 0 <br><br> No payload data.                  | Initiating closure of the TCP connection.                                     |
| 15:11:32.896260 <br><br> Time of packet capture. | 192.168.1.130:60025 <br><br> Source IP and port (local machine). | 142.250.181.78:80 <br><br> Destination IP and port (Google server). | [.] <br><br> ACK flag set, acknowledging receipt of data.                      | ack 775 <br><br> Acknowledgment number for the received packet.                             | win 2048 <br><br> Window size (flow control information).  | nop, nop, TS <br><br> TCP options including no-operations (nop) and Timestamp (TS).                                                                                      | 0 <br><br> No payload data.                  | Acknowledging the server's FIN packet, completing the connection termination. |

**Explanation of Fields**

- **Time**: The timestamp when the packet was captured.
- **Source IP:Port**: The IP address and port number of the packet's source.
- **Destination IP:Port**: The IP address and port number of the packet's destination.
- **TCP Flags**: Indicate the type of TCP packet (SYN, ACK, FIN, PSH, etc.).
- **Sequence & Acknowledgment Numbers**: Used for tracking data transmission in TCP.
- **Window Size**: The size of the receiver's available buffer (flow control).
- **TCP Options**: Various options set in the TCP header (MSS, SACK, Timestamps, Window Scale).
- **Payload Size**: Size of the data in the packet.
- **Description**: Brief explanation of what each packet represents in the communication.
