# Hysteria 简易教程

1. 修改 hysteria.json 和 docker-compose.yml 中的密码和端口
2. 这里 cert 用的是 bing.com 的，也可以自己生成
3. docker-compose up -d 启动服务

## 进阶：开启多端口跳跃

多端口跳跃不在 docker 中进行，而是得在本地防火墙上做 nat 转发。

### iptables 配置方式：

```
# IPv4
iptables -t nat -A PREROUTING -i eth0 -p udp --dport 20000:50000 -j DNAT --to-destination :5666
# IPv6
ip6tables -t nat -A PREROUTING -i eth0 -p udp --dport 20000:50000 -j DNAT --to-destination :5666
```

### firewalld 配置方式：

可以使用 FirewallD 防火墙命令配置UDP端口的NAT转发。以下是具体步骤：  
  
在 NAT 转发之前，您需要确保系统上已启用网络地址转换（NAT）。您可以通过运行以下命令来检查：  
sudo firewall-cmd --query-masquerade  
如果该命令返回“no”，则必须启用 MASQUERADE：  
  
sudo firewall-cmd --add-masquerade --permanent  
sudo firewall-cmd --reload  
这将启用 NAT 转发，并在防火墙重新加载期间永久保存更改。  
  
然后，您需要向防火墙添加一个跨区域的端口转发规则。例如，如果您希望将 TCP 端口 80 转发到本地端口 8080（或另一个服务器），可以运行以下命令：  
sudo firewall-cmd --add-forward-port=port=20000-30000:proto=udp:toport=48778 --zone=public --permanent  
sudo firewall-cmd --reload  
此命令将将所有传入的UDP端口80请求转发到本地端口8080。您可以根据需要更改端口号。  
  
您可以在防火墙重新加载时永久保存该规则。最后，在测试规则之前，请确保防火墙未启用 drop 规则或与您的特定应用程序有关的其他规则。  
  
注意：这些命令需要在具有管理员特权的 shell 中运行。  


## clash.yaml 配置

注意，正常版本的 clash 目前不支持 hysteria，需要使用特殊版本的：

- 安卓： https://github.com/MetaCubeX/ClashMetaForAndroid
- Windows： https://github.com/2dust/clashN
- Mac： https://github.com/MetaCubeX/Clash.Meta
- iOS：小火箭

配置协议使用 hysteria：

```yml
  - name: hhh
    type: hysteria
    server: xx.xx.xx.xx # 你的 ip
    port: 20000 # 你默认 docker 端口或者多端口中任何一个都行
    ports: 20000-30000 # 多端口跳跃
    auth_str: ed38c1 # json 中填的密码
    alpn:
      - h3
    protocol: udp
    up: 200
    down: 200
    sni: www.bing.com
    skip-cert-verify: true
```

## FAQ

如果没效果，可以检查一下服务器的 UDP 是否连通，或者防火墙是否正常。

UDP 的连通性，可以用 iperf 进行检查：

- server
-
  ```sh
  iperf -u -s -p 12345
  ```
- client
-
  ```sh
  iperf -u -c xxx.com -t 1 -b 10M -p 12345
  ```

