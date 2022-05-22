# shell_cash_container

## 简介

自用的shell_cash_container仓库；

##  使用方式

1. dockerfile方式

   ```shell
   git clone 
   # 请修改脚本‘http://example.com’为你自己的http代理后再运行。。
   # 使用docker
   sh dockerRun.sh
   # 使用podman
   sh podmanRun.sh
   # 根据提示输入参数
   ```

2.   保存容器为 系统systemd

   ```shell
   podman generate systemd --restart-policy=always -t 1 --name -f shell_clash
   sed -i "/ExecStart/a\ExecStartPost=podman\ exec\ -it\ shell_clash\ /bin/bash\ -c\ 'systemctl start clash'" container-shell_clash.service
   mv container-shell_clash.service /usr/lib/systemd/system/
   systemctl daemon-reload
   systemctl enable container-shell_clash.service
   systemctl start container-shell_clash.service
   ```

   

## 注意事项

- 运行此 dockerfile 时请注意自行修改替换其中代理部分；（以免一直网络报错。。）
- 进入容器中后最好也配置http代理 ：
  ==all_proxy=http://example.com && export http_proxy=$all_proxy && export https_proxy=$all_proxy== 
