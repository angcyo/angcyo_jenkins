# angcyo_jenkins
CentOS7 一键搭建/配置 Jenkins 环境

# 最终目的
创建虚拟机, 执行此脚本之后, 就能在浏览器中打开Jenkins网页. 

之后配置的任务, 不包含在内.

脚本包含的任务:
1. 下载`Tomcat` 并解压
2. 下载`Jenkins` 并复制到`Tomcat`的`webapps`目录
3. 下载`Java` 并解压和写入`/etc/profile`环境变量
4. 下载`android sdk tools` 并拉取相应的`sdk版本` 和 `build tools`
5. 下载`Gradle`, 并解压





# 写在最后
由于 `Windows` 和 `Linux` 字符编码不同, 这就导致在`Windows`下编写的脚本 无法在`Linux`上执行, 报语法错误. 有2个比较恶心的错误 就是 `'\r'` 字符和`文件非法结尾字符` . 尝试了 `dos2unix` 转换, 还是报错. 于是乎 代码全程在Linux环境中 使用 `vi` 编辑器手写. 痛苦啊;

如果大家有好多的解决方法, 欢迎联系告知. 万分感谢!
