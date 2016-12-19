# XPCServiceDemo
MAC端开发XPC的Demo，进程间的通讯
##**使用步骤**

- 1.首先创建一个MAC的项目- 
- 2.然后在项目中添加一个XPC Service
- 3.设置XPC Service的BundleID
- 4.将XPCClient和XPCService文件下的内容拖入到项目中
- 5.在需要使用的地方做以下操作
	- 1.引入头文件
	- 2.使用manager的service发送消息
- 6.项目中的ClientManager和ServiceDelegate分别为app端和service端的单例,负责发送和接收消息

