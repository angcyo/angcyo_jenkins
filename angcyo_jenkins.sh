work_path=$(pwd)
jdk_path=/usr/lib/jvm

init(){
 rm -df log
 if [ -f "./config.sh" ]
 then 
    source "./config.sh"
 else
    download_path="/angcyo/download"
    sdk_path="$download_path/AndroidSdk"
    sdk_tools="build-tools;27.0.3"
    sdk_p="platforms;android-27"
 fi
}

installCommand(){
  echo "check command: $1"
  type $1 >>log 0>>log 1>>log 2>>log
  if [ "$?" == "0" ]
  then 
    echo "ok."
  else 
    echo "install $1."
    yum -y install $1 >>log
  fi
}

createFolder(){
  if [ -d "$1" ]
  then 
    echo "$1 exist."  >>log
  else 
    mkdir "$1" >>log
  fi
}

temp_url=""
defaultValue(){
  if [ "$1" == "" ]
  then
    temp_url="$2"
  else 
    temp_url="$1"
  fi
}


tomcat_path=""
java_path=""
download(){
  url=$1
  echo "download $url."
  file_name=${url##*/}
  folder_name=${file_name%%$3*}

  #echo "$file_name"
  #echo "$folder_name"
  #return 0
  #echo "$target_path/$file_name"
  #exit
  if [ -f "$file_name" ]
  then 
    echo "File $file_name is Exist, Pass wget."
  else 
    if [ "$2" == "java" ]
    then
      wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $1 >>"../log"
    else
      wget $1 >>"../log"
    fi
  fi

  if [ "$2" == "tomcat" ]
  then
    tomcat_path=$folder_name
  fi

  if [ "$2" == "java" ]
  then
    java_path="/usr/lib/jvm/$folder_name"
    folder_name=$java_path
  fi

  if [ "$2" == "sdk" ]
  then
    folder_name=$sdk_path
  fi  

  #pwd
  #echo $(basename ${file_name})
  if [ -d "$folder_name" ]
  then
    #rm -df $folder_name
    #tar xf $folder_name
    echo "Folder $folder_name is Exist, Pass unzip."

    if [ "$2" == "sdk" ]
    then
      cd $folder_name
      a_path=$(pwd)
      cd ..
    fi
  else
    if [ "$2" == "jenkins" ]
    then
      #pwd 
      cp "$file_name" "./$tomcat_path/webapps/" >>log
    else
      echo "unzip $file_name to $folder_name" 
      if [ "$2" == "java" ]
      then 
        mkdir -p $jdk_path
        tar -zxvf $file_name -C $jdk_path
        #echo "export JAVA_HOME=$java_path" >>/etc/profile
        #echo 'export JRE_HOME=${JAVA_HOME}/jre' >>/etc/profile
        #echo 'export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib' >>/etc/profile
        #echo 'export PATH=${JAVA_HOME}/bin:$PATH' >>/etc/profile
        #source /etc/profile
      elif [ "$2" == "sdk" ] 
      then 
        unzip -do $folder_name $file_name >>log
        #echo "export ANDROID_HOME=$work_path/$target_path/$sdk_path" >>/etc/profile
        #echo 'export PATH=$ANDROID_HOME/tools:$PATH' >>/etc/profile
        #source /etc/profile
        cd $sdk_path/tools
        #pwd
        ./bin/sdkmanager $sdk_tools $sdk_p
        cd ..
        a_path=$(pwd)
        cd ..
      elif [ "$2" == "gradle" ]
      then 
        unzip -o $file_name >>log
      else
        tar -zxvf $file_name >>log
      fi
    fi
  fi
}

init
if [ "$1" != "" ] 
then 
 target_path="$1"
else 
 target_path="$download_path"
fi

#echo "$target_path"
createFolder "$target_path"

installCommand yum
installCommand wget
installCommand tar
installCommand unzip
installCommand git

cd $target_path
d_path=$(pwd)

defaultValue $tomcat_url "https://mirrors.cnnic.cn/apache/tomcat/tomcat-9/v9.0.10/bin/apache-tomcat-9.0.10.tar.gz_test"
tomcat_url_d=$temp_url
#echo "$tomcat_url_d"

defaultValue $jenkins_url "http://mirrors.jenkins.io/war-stable/2.121.2/jenkins.war"
jenkins_url_d=$temp_url
#echo "$jenkins_url_d"

defaultValue $java_url "http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz"
java_url_d=$temp_url
#echo $java_url_d

defaultValue $sdk_tool_url "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
sdk_tools_url_d=$temp_url
#echo $sdk_tools_url_d

defaultValue $gradle_url "https://downloads.gradle.org/distributions/gradle-4.4.1-all.zip"
gradle_url_d=$temp_url
#echo $gradle_url_d

download $tomcat_url_d tomcat .tar.gz
download $jenkins_url_d jenkins
download $java_url_d java -linux-x64.tar.gz
download $gradle_url_d gradle .zip
download $sdk_tools_url_d sdk .zip

echo "File Download in $d_path"
echo "Jdk in $jdk_path"
echo "Sdk in $a_path"

read -p "all command end..."
exit




