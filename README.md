# IaC-Heat-A

This is a Heat template to launch a flexible provisioned infrastructure. The servers are initialized based on [this Puppet control repo](https://gitlab.com/erikhje/control-repo-a).

Clone and launch in OpenStack with e.g.
```bash
# edit iac_top_env.yaml and enter name of your keypair
git clone https://gitlab.com/erikhje/iac-heat-a.git
cd iac-heat-a
openstack stack create my_iac -t iac_top.yaml -e iac_top_env.yaml
```

## Other repositories

Website repository: https://bitbucket.org/SteinarVrenne/website-repo/src

Control repository: https://bitbucket.org/Jimbob21148/control-repo/src

## Benchmarking

### Network speed

We have tested the link speed between the nodes in our network to inform our design decisions. We used "iperf3" to measure and the results from one worker machine to the master was the following:

```
ubuntu@srv2:~$ iperf3 -c 192.168.180.140
Connecting to host 192.168.180.140, port 5201
[  4] local 192.168.180.131 port 38280 connected to 192.168.180.140 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec   781 MBytes  6.55 Gbits/sec    0   3.02 MBytes       
[  4]   1.00-2.00   sec   736 MBytes  6.18 Gbits/sec    0   3.02 MBytes       
[  4]   2.00-3.00   sec   758 MBytes  6.36 Gbits/sec    0   3.02 MBytes       
[  4]   3.00-4.00   sec   736 MBytes  6.17 Gbits/sec    0   3.02 MBytes       
[  4]   4.00-5.00   sec   735 MBytes  6.17 Gbits/sec    0   3.02 MBytes       
[  4]   5.00-6.00   sec   741 MBytes  6.22 Gbits/sec    0   3.02 MBytes       
[  4]   6.00-7.00   sec   705 MBytes  5.91 Gbits/sec    0   3.02 MBytes       
[  4]   7.00-8.00   sec   721 MBytes  6.05 Gbits/sec    0   3.02 MBytes       
[  4]   8.00-9.00   sec   727 MBytes  6.10 Gbits/sec    0   3.02 MBytes       
[  4]   9.00-10.00  sec   719 MBytes  6.03 Gbits/sec    0   3.02 MBytes       
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-10.00  sec  7.19 GBytes  6.17 Gbits/sec    0             sender
[  4]   0.00-10.00  sec  7.19 GBytes  6.17 Gbits/sec                  receiver

iperf Done.
```
