# System - Monitoring




| Stats                                                         | Visualization                                 |
|---------------------------------------------------------------|-----------------------------------------------|
| [Number of hosts](#Number-of-hosts)                           | ![](.images/number-of-hosts.png)              |
| [CPU Usage Guage](#CPU-Usage-Gauge)                           | ![](.images/cpu-usage-guage.png)              |
| [Memory Usage Gauge](#Memory-Usage-Gauge)                     | ![](.images/memory-usage-guage.png)           |
| [Disk used](#Disk-used)                                       | ![](.images/disk-used.png)                    |
| [Inbound Traffic](#Inbound-Traffic)                           | ![](.images/inbound-traffic.png)              |
| [Outbound Traffic](#Outbound-Traffic)                         | ![](.images/outbound-traffic.png)             |
| [Top Hosts By CPU Realtime](#Top-Hosts-By-CPU-Realtime)       | ![](.images/top-hosts-by-cpu-realtime.png)    |
| [Top Hosts By Memory Realtime](#Top-Hosts-By-Memory-Realtime) | ![](.images/top-hosts-by-memory-realtime.png) |
| [Host histogram by CPU usage](#Hosts-histogram-by-CPU-usage)  | ![](.images/host-histogram-by-cpu-usage.png)  |










<br>

### Number-of-hosts

Metrics

```bash
<br>

## UniqueCount ##
a = UniqueCount(host.name)
```

<br>

### CPU-Usage-Gauge

- system.cpu.user.pct: 
  - The percentage of CPU time spent in user space. On multi-core systems, you can have percentages that are greater than 100%. For example, if 3 cores are at 60% use, then the system.cpu.user.pct will be 180%. 
  - type: scaled_float
  - format: percent
  
- system.cpu.system.pct
  - The percentage of CPU time spent in kernel space.
  - type: scaled_float
  - format: percent

- system.cpu.cores
  - The number of CPU cores present on the host. The non-normalized percentages will have a maximum value of 100% * cores. The normalized percentages already take this value into account and have a maximum value of 100%.
  - type: long

**Aggregations**

- Timefield : @timestamp
- Inverval : auto
- Data timerange mode : last value

```bash
<br>

## Average ##
user = Avg(system.cpu.user.pct)

<br>

## Average ##
system = Avg(system.cpu.system.pct)

<br>

## Average ##
n = Avg(system.cpu.cores)

<br>

## Bucket Script ##
params.n > 0 ? (params.user+params.system)/params.n : null

GroupBy-Everything
```


| COLOR  | EXPRESSION                 | VALUE |
|--------|----------------------------|-------|
| GREEN  | : >= greater than or equal | 0     |
| ORANGE | : >= greater than or equal | 0.7   |
| RED    | : >= greater than or equal | 0.85  |

<br>

### Memory-Usage-Gauge

- system.memory.actual.used.pct
    - The percentage of actual used memory. 
    - type: scaled_float
    - format: percent
    

**Aggregation**

- Timefield : @timestamp
- Inverval : auto
- Data timerange mode : last value

```bash
<br>

## Average ##
a = Avg(system.memory.actual.used.pct)

GroupBy-Everything
```

| COLOR  | EXPRESSION                 | VALUE |
|--------|----------------------------|-------|
| GREEN  | : >= greater than or equal | 0     |
| ORANGE | : >= greater than or equal | 0.7   |
| RED    | : >= greater than or equal | 0.85  |


<br>

### Disk-used

- system.fsstat.total_size.used
  - Total used space.
  - type: long
  - format: bytes
  
- system.fsstat.total_size.total
  - Total space (used plus free).
  - type: long
  - format: bytes
 
**Aggregation**

- Dataformatter : Percent
- Data timerange mode : last value

```bash
<br>

## TopHit ##
a = TopHit(system.fsstat.total_size.used)         # Size=1, Aggregate with Avg, Order By : @timastamp, Desc

<br>

## TopHit ##
b = TopHit(system.fsstat.total_size.total)        # Size=1, Aggregate with Avg, Order By : @timastamp, Desc

Expression = a/b

GroupBy-Everything
```



| COLOR  | EXPRESSION                 | VALUE |
|--------|----------------------------|-------|
| GREEN  | : >= greater than or equal | 0     |
| ORANGE | : >= greater than or equal | 0.7   |
| RED    | : >= greater than or equal | 0.85  |


<br>

### Inbound-Traffic

*network*  network contains network IO metrics for a single network interface.

- system.network.in.bytes
    - The number of bytes received.

- system.network.name
  - The network interface name.
  - type: keyword
  - example: eth0
  
**Aggregation**
  
- Timefield : @timestamp
- Inverval : auto
- Data timerange mode : last value
  
```bash
<br>

## Max ##
a = Max(system.network.in.bytes)

<br>

## Derivative ##
b = Derivative(a)/1s

<br>

## PositiveOnly ##
c = PositiveOnly(b)

<br>

## Series Agg ##
Function : Sum             # c1 + c2 + c3 ....

GroupBy-Terms : system.network.name
Top : 10
OrderBy : Doc Count (default)
Decending
```



  
<br>

#### Total Transferred

**Aggregation**
  
- Dataformatter : Bytes
- Template : {{value}}         
- Data timerange mode : last value

```bash
<br>

## Max ##
a = Max(system.network.in.bytes)

<br>

## Derivative ##
b = Derivative(a)/1s

<br>

## PositiveOnly ##
c = PositiveOnly(b)

<br>

## Series Agg ##
Function : Overall Sum             # c1 + c2 + c3 ....

GroupBy-Terms : system.network.name
Top : 10
OrderBy : Doc Count (default)
Decending
```

<br>

### Outbound-Traffic


- system.network.out.bytes
    - The number of bytes sent.
    - type: long
    - format: bytes

**Aggregation**
  
- Timefield : @timestamp
- Inverval : auto
- Data timerange mode : last value
  
```bash
<br>

## Max ##
a = Max(system.network.out.bytes)

<br>

## Derivative ##
b = Derivative(a)/1s

<br>

## PositiveOnly ##
c = PositiveOnly(b)

<br>

## Series Agg ##
Function : Sum             # c1 + c2 + c3 ....

GroupBy-Terms : system.network.name
Top : 10
OrderBy : Doc Count (default)
Decending
```

<br>

#### Total Transferred

- system.network.name
  - The network interface name.
  - type: keyword
  - example: eth0

**Aggregation**
  
- Dataformatter : Bytes
- Template : {{value}}         
- Data timerange mode : last value

```bash
<br>

## Max ##
a = Max(system.network.out.bytes)

<br>

## Derivative ##
b = Derivative(a)/1s

<br>

## PositiveOnly ##
c = PositiveOnly(b)

<br>

## Series Agg ##
Function : Overall Sum             # c1 + c2 + c3 ....

GroupBy-Terms : system.network.name
Top : 10
OrderBy : Doc Count (default)
Decending
```

<br>

### Top-Hosts-By-CPU-Realtime

- system.cpu.user.pct
  - The percentage of CPU time spent in user space. On multi-core systems, you can have percentages that are greater than 100%. For example, if 3 cores are at 60% use, then the system.cpu.user.pct will be 180%.
  - type: scaled_float
  - format: percent

**Aggregation**

- Timefield : @timestamp
- Inverval : auto
- Data timerange mode : last value

```bash
<br>

## Average ##
a = Avg(system.cpu.user.pct)

GroupBy-Terms : host.name
Top : 10
Order by : a
Desc
```

| COLOR  | EXPRESSION                 | VALUE |
|--------|----------------------------|-------|
| GREEN  | : >= greater than or equal | 0     |
| ORANGE | : >= greater than or equal | 0.6   |
| RED    | : >= greater than or equal | 0.85  |



<br>

### Top-Hosts-By-Memory-Realtime

- system.memory.actual.used.pct
    - The percentage of actual used memory. 
    - type: scaled_float
    - format: percent

**Aggregation**

- Timefield : @timestamp
- Inverval : auto
- Data timerange mode : last value

```bash
<br>

## Average ##
a = Avg(system.memory.actual.used.pct)

GroupBy-Terms : host.name
Top : 10
Order by : a
Desc
```

| COLOR  | EXPRESSION                 | VALUE |
|--------|----------------------------|-------|
| GREEN  | : >= greater than or equal | 0     |
| ORANGE | : >= greater than or equal | 0.6   |
| RED    | : >= greater than or equal | 0.85  |


<br>

### Hosts-histogram-by-CPU-usage

- system.cpu.user.pct
  - The percentage of CPU time spent in user space. On multi-core systems, you can have percentages that are greater than 100%. For example, if 3 cores are at 60% use, then the system.cpu.user.pct will be 180%.
  - type: scaled_float
  - format: percent
  
**Metrics**
```bash
Value Average(system.cpu.user.pct)
```

**Buckets**
```bash
<br>

## X-axis ##
@timestamp per 30 seconds

<br>

## Y-axis ##
host.name: Descending
```
