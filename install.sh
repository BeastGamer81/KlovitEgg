#!/bin/bash

function display {
    echo -e "\033c"
    echo "
    ==========================================================================
    
$(tput setaf 6) ##  ##   ##        ####    ##  ##    ####    ######            ######    ####     ####   
$(tput setaf 6) ## ##    ##       ##  ##   ##  ##     ##       ##              ##       ##  ##   ##  ##  
$(tput setaf 6) ####     ##       ##  ##   ##  ##     ##       ##              ##       ##       ##      
$(tput setaf 6) ###      ##       ##  ##   ##  ##     ##       ##              ####     ## ###   ## ###  
$(tput setaf 6) ####     ##       ##  ##   ##  ##     ##       ##              ##       ##  ##   ##  ##  
$(tput setaf 6) ## ##    ##       ##  ##     ###      ##       ##              ##       ##  ##   ##  ##  
$(tput setaf 6) ##  ##   ######    ####      ##      ####      ##              ######    ####     ####   
 

    ==========================================================================
    "  
}

function forceStuffs {
mkdir -p plugins
  curl -o server-icon.png https://cdn.discordapp.com/icons/1140291122669826089/a682279f8a59cfac25a4f401b1c124d6.png && curl -o plugins/hibo.jar https://cdn.discordapp.com/attachments/1140303044660179124/1140966909521703025/Hibernate.jar && echo "motd=Powered by Zexade.com | Change this motd in server.properties" >> server.properties && touch eula.txt && echo "eula=true" >> eula.txt

}

function launchJavaServer {
  java -Xms1024M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar latest nogui
}
FILE=eula.txt


function optimizeJavaServer {
  echo "view-distance=6" >> server.properties
  
} 

if [ ! -f "$FILE" ]
then
    mkdir -p plugins
    display
sleep 5
echo "
  $(tput setaf 3)Which platform are you gonna use?
  1) Paper 1.8.8       6)  Paper 1.18.2 
  2) Paper 1.12.2      7)  Paper 1.19.2
  3) Paper 1.15.2      8)  Paper 1.20.1
  4) Paper 1.16.5      9)  BungeeCord
  5) Paper 1.17.1      10)  Node.js
  "
read -r n

case $n in
  1) 
    sleep 1

    echo "$(tput setaf 3)Starting the download for 1.8.8 please wait"

    sleep 4

    forceStuffs

    curl -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar

    display
    
    echo "$(tput setaf 1)Invalid docker image. Change it to java 8"
    
    sleep 10
    
    echo -e ""
    
    optimizeJavaServer
    launchJavaServer
  ;;

  2) 
    sleep 1

    echo "$(tput setaf 3)Starting the download for 1.12.2 please wait"

    sleep 4

    forceStuffs

    curl -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.12.2/builds/1620/downloads/paper-1.12.2-1620.jar

    display   

    echo "$(tput setaf 1)Invalid docker image, otherwise it will not work.Change it to java 11"
    
    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;

  3) 
    sleep 1

    echo "$(tput setaf 3)Starting the download for 1.15.2 please wait"

    sleep 4

    forceStuffs

    curl -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.15.2/builds/393/downloads/paper-1.15.2-393.jar

    display   

    echo "$(tput setaf 1)Invalid docker image. Change it to java 16"
    
    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;

  4)
    sleep 1

    echo "$(tput setaf 3)Starting the download for 1.16.5 please wait"

    sleep 4

    forceStuffs

    curl -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.16.5/builds/794/downloads/paper-1.16.5-794.jar

    display
    
    echo "$(tput setaf 1)Invalid docker image. Change it to java 16"

    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;

  5) 
    sleep 1

    echo "$(tput setaf 3)Starting the download for 1.17.1 please wait"

    sleep 4

    forceStuffs

    curl -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.17.1/builds/411/downloads/paper-1.17.1-411.jar

    display

    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;

  6)
    sleep 1

    echo "$(tput setaf 3)Starting the download for 1.18.2 please wait"

    sleep 4

    forceStuffs

    curl -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/388/downloads/paper-1.18.2-388.jar

    display

    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;
  7)
    sleep 1

    echo "$(tput setaf 3)Starting the download for 1.19.2 please wait"

    sleep 4

    forceStuffs

    curl -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.19.2/builds/190/downloads/paper-1.19.2-190.jar

    display

    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
    ;;
  8)
    sleep 1

    echo "$(tput setaf 3)Starting the download for 1.20.1 please wait"

    sleep 4

    forceStuffs

    curl -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/126/downloads/paper-1.20.1-126.jar

    display

    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
    ;;
  9)
    echo "$(tput setaf 3)Starting Download please wait"

    curl -O https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar

    display 

    java -Xms512M -Xmx512M -jar BungeeCord.jar
  ;;
  10)
  echo "$(tput setaf 3)Starting Download please wait"
  
  curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  
  sudo apt-get install -y nodejs
;;
  *) 
    echo "Error 404"
    exit
  ;;
esac  
else
if [ -f plugins ]; then
mkdir plugins
fi
if [ -f BungeeCord.jar ]; then
  display
  java -Xms512M -Xmx512M -jar BungeeCord.jar
else
if [ -d plugins ]; then
  mkdir -p plugins
fi
  display   
  forceStuffs
  launchJavaServer
fi
fi

