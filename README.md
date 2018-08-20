# angcyo_jenkins
CentOS7 一键搭建/配置 Jenkins 环境

# 使用方法
```
# 下载脚本
wget https://raw.githubusercontent.com/angcyo/angcyo_jenkins/master/angcyo_jenkins.sh
# 下载脚本配置文件
wget https://raw.githubusercontent.com/angcyo/angcyo_jenkins/master/config.sh
# 赋予执行权限
chmod 777 angcyo_jenkins.sh
# 执行脚本
./angcyo_jenkins.sh
```

# 最终目的
创建虚拟机, 执行此脚本之后, 就能在浏览器中打开Jenkins网页. 

之后配置的任务, 不包含在内.

**脚本包含的任务:**
1. 下载`Tomcat` 并解压
2. 下载`Jenkins` 并复制到`Tomcat`的`webapps`目录
3. 下载`Java` 并解压和写入`/etc/profile`环境变量
4. 下载`android sdk tools` 并写入`/etc/profile`环境变量和拉取相应的`sdk版本` 和 `build tools`
5. 下载`Gradle`, 并解压

## 你可能还需要手动配置一下任务
### 1.Tomcat端口和用户
*端口修改*

进入`Tomcat`根目录, 进入`conf`文件夹, 打开`server.xml`文件, 找到
```
<Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
```
`8080`就是端口 可以修改. 重启`Tomcat`之后生效. 同时新的端口需要在系统防火墙规则内.

*用户修改*

进入`Tomcat`根目录, 进入`conf`文件夹, 打开`tomcat-users.xml`文件, 在文件末尾`</tomcat-users>`标签之前,加入
```
#角色,用来区别权限 tomcat有规定的几种.
<role rolename="manager-gui"/>
#使用上面的角度 创建用户
<user username="name" password="123456" roles="manager-gui"/>
```
保存 重启`Tomcat`生效.

*启动Tomcat*
进入`Tomcat`根目录
```
./bin/startup.sh
```


### 2.Jenkins安装
上述步骤之后 启动`Tomcat``Jenkins`会自动安装 安装完成后 打开`Jenkins`首页`http://localhost:8080/Jenkins`, 进行初始化即可.必备的2个插件`git`和'Gradle'

### 3.Android 任务的创建
[传送门](https://blog.csdn.net/angcyo/article/details/50503571)

# 写在最后
由于 `Windows` 和 `Linux` 字符编码不同, 这就导致在`Windows`下编写的脚本 无法在`Linux`上执行, 报语法错误. 有2个比较恶心的错误 就是 `'\r'` 字符和`文件非法结尾字符` . 尝试了 `dos2unix` 转换, 还是报错. 于是乎 代码全程在Linux环境中 使用 `vi` 编辑器手写. 痛苦啊;

如果大家有好多的解决方法, 欢迎联系告知. 万分感谢!
