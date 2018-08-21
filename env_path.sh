java_path=/usr/lib/jvm/jdk1.8.0_181
sdk_path=/angcyo/sdk

echo "export JAVA_HOME=$java_path" >>/etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >>/etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >>/etc/profile
echo 'export PATH=${JAVA_HOME}/bin:$PATH' >>/etc/profile
echo "" >>/etc/profile

echo "export ANDROID_HOME=$sdk_path" >>/etc/profile
echo 'export PATH=$ANDROID_HOME/tools:$PATH' >>/etc/profile
echo "" >>/etc/profile

source /etc/profile

