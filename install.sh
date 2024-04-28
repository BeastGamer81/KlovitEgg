#!/bin/bash

display() {
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
$(tput setaf 6) COPYRIGHT 2023 - 2024 Klovit & https://github.com/beastgamer81

    ==========================================================================
    "
}

forceStuffs() {
mkdir -p plugins
curl -s -o plugins/hibernate.jar https://raw.githubusercontent.com/beastgamer81/klovitegg/main/HibernateX-2.0.3.jar

echo "eula=true" > eula.txt
}

# Install functions
installsdkman() {
if [ ! "$(command -v sdk version)" ]; then
curl -s "https://get.sdkman.io" | bash
source ".sdkman/bin/sdkman-init.sh"
fi
}



installPhp() {
REQUIRED_PHP_VERSION=$(curl -sSL https://update.pmmp.io/api?channel="$1" | jq -r '.php_version')

PMMP_VERSION="$2"

curl --location --progress-bar https://github.com/pmmp/PHP-Binaries/releases/download/php-"$REQUIRED_PHP_VERSION"-latest/PHP-Linux-x86_64-"$PMMP_VERSION".tar.gz | tar -xzv

EXTENSION_DIR=$(find "bin" -name '*debug-zts*')
  grep -q '^extension_dir' bin/php7/bin/php.ini && sed -i'bak' "s{^extension_dir=.*{extension_dir=\"$EXTENSION_DIR\"{" bin/php7/bin/php.ini || echo "extension_dir=\"$EXTENSION_DIR\"" >>bin/php7/bin/php.ini
}

# Useful functions
getJavaVersion() {
    java_version_output=$(java -version 2>&1)

    if [[ $java_version_output == *"1.8"* ]]; then
        echo "8"
    elif [[ $java_version_output == *"11"* ]]; then
        echo "11"
    elif [[ $java_version_output == *"16"* ]]; then
        echo "16"
    elif [[ $java_version_output == *"17"* ]]; then
        echo "17"
    elif [[ $java_version_output == *"18"* ]]; then
        echo "18"
    else
        echo "error"
    fi
}
# Validation functions

    JAVA_VERSION=$(getJavaVersion)
    
    installsdkman
    VER_EXISTS=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r --arg VERSION $MINECRAFT_VERSION '.versions[] | contains($VERSION)' | grep -m1 true)
	LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r '.versions' | jq -r '.[-1]')

	if [ "${VER_EXISTS}" != "true" ]; then
		MINECRAFT_VERSION=${LATEST_VERSION}
	fi
    MINECRAFT_VERSION_CODE=$(echo "$MINECRAFT_VERSION" | cut -d. -f1-2 | tr -d '.')
if [ "$MINECRAFT_VERSION_CODE" -ge "120" ]; then
    sdk install java 21.0.2-tem
elif [ "$MINECRAFT_VERSION_CODE" -ge "117" ]; then
    sdk install java 17.0.0-tem
elif [ "$MINECRAFT_VERSION_CODE" -ge "112" ]; then
    sdk install java 11.0.22-tem
elif [ "$MINECRAFT_VERSION_CODE" -eq "18" ]; then
    sdk install java 8.0.392-tem
fi


# Launch functions
launchJavaServer() {
  
  # Remove 200 mb to prevent server freeze
  number=200
  memory=$((SERVER_MEMORY - number))
  java -Xms128M -Xmx${memory}M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -DPaper.IgnoreJavaVersion=true -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui
}

launchPMMPServer() {
  if [ ! "$(command -v ./bin/php7/bin/php)" ]; then
    echo "Php not found, installing Php..."
    sleep 5
    PMMP_VERSION="${PMMP_VERSION^^}"
  
    if [[ "${PMMP_VERSION}" == "PM4" ]]; then
      API_CHANNEL="4"
    elif [[ "${PMMP_VERSION}" == "PM5" ]]; then
      API_CHANNEL="stable"
    else
      printf "Unsupported version: %s" "${PMMP_VERSION}"
      exit 1
    fi
    installPhp "$API_CHANNEL" "$PMMP_VERSION"
    sleep 5
  fi
./bin/php7/bin/php ./PocketMine-MP.phar --no-wizard --disable-ansi
}

launchNodeServer() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    nvm install $NODE_VERSION
    nvm use $NODE_VERSION
    
    if [ -n "$NODE_DEFAULT_ACTION" ]; then
      action="$NODE_DEFAULT_ACTION"
    else
      echo "
      $(tput setaf 3)What to run?
      1) Run main file      2) Install packages from package.json
        "
      read -r action
    fi
    case $action in
      1)
        node "${NODE_MAIN_FILE}"
      ;;
      2)
        npm install
      ;;
      *) 
        echo "Error 404"
        exit
      ;;
    esac
}

optimizeJavaServer() {
  echo "view-distance=6" >> server.properties
  
}

if [ ! -e "server.jar" ] && [ ! -e "nodejs" ] && [ ! -e "PocketMine-MP.phar" ]; then
    display
sleep 5
echo "
  $(tput setaf 3)Which platform are you gonna use?
  1) Paper             2) Purpur
  3) BungeeCord        4) PocketmineMP
  5) Node.js
  "
read -r n

case $n in
  1) 
    sleep 1

    echo "$(tput setaf 3)Starting the download for PaperMC ${MINECRAFT_VERSION} please wait"

    sleep 4

    forceStuffs
    

    VER_EXISTS=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r --arg VERSION $MINECRAFT_VERSION '.versions[] | contains($VERSION)' | grep -m1 true)
	LATEST_VERSION=$(curl -s https://api.papermc.io/v2/projects/paper | jq -r '.versions' | jq -r '.[-1]')

	if [ "${VER_EXISTS}" == "true" ]; then
		echo -e "Version is valid. Using version ${MINECRAFT_VERSION}"
	else
		echo -e "Specified version not found. Defaulting to the latest paper version"
		MINECRAFT_VERSION=${LATEST_VERSION}
	fi
	
	BUILD_NUMBER=$(curl -s https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION} | jq -r '.builds' | jq -r '.[-1]')
	JAR_NAME=paper-${MINECRAFT_VERSION}-${BUILD_NUMBER}.jar
	DOWNLOAD_URL=https://api.papermc.io/v2/projects/paper/versions/${MINECRAFT_VERSION}/builds/${BUILD_NUMBER}/downloads/${JAR_NAME}
	shasum "${DOWNLOAD_URL}" > debugshasum.txt 2>&1
	curl -o server.jar "${DOWNLOAD_URL}"

    display
    
    echo -e ""
    
    optimizeJavaServer
    launchJavaServer
    forceStuffs
  ;;
  2)
    sleep 1

    echo "$(tput setaf 3)Starting the download for PurpurMC ${MINECRAFT_VERSION} please wait"

    sleep 4

    forceStuffs
    
    
    VER_EXISTS=$(curl -s https://api.purpurmc.org/v2/purpur | jq -r --arg VERSION $MINECRAFT_VERSION '.versions[] | contains($VERSION)' | grep true)
	LATEST_VERSION=$(curl -s https://api.purpurmc.org/v2/purpur | jq -r '.versions' | jq -r '.[-1]')

	if [ "${VER_EXISTS}" == "true" ]; then
		echo -e "Version is valid. Using version ${MINECRAFT_VERSION}"
	else
		echo -e "Specified version not found. Defaulting to the latest purpur version"
		MINECRAFT_VERSION=${LATEST_VERSION}
	fi
	
	BUILD_NUMBER=$(curl -s https://api.purpurmc.org/v2/purpur/${MINECRAFT_VERSION} | jq -r '.builds.latest')
	JAR_NAME=purpur-${MINECRAFT_VERSION}-${BUILD_NUMBER}.jar
	DOWNLOAD_URL=https://api.purpurmc.org/v2/purpur/${MINECRAFT_VERSION}/${BUILD_NUMBER}/download
	
	curl -o server.jar "${DOWNLOAD_URL}"

    display
    
    echo -e ""
    
    optimizeJavaServer
    launchJavaServer
    forceStuffs
  ;;
  3)
    sleep 1
    
    echo "$(tput setaf 3)Starting the download for Bungeecord latest please wait"
    
    sleep 4

    curl -o server.jar https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar
    
    touch proxy

    display
    
    sleep 10

    echo -e ""

    launchJavaServer proxy
  ;;
  4)
  sleep 1
  
  echo "$(tput setaf 3)Starting the download for PocketMine-MP ${PMMP_VERSION} please wait"
  
  sleep 4
  
  PMMP_VERSION="${PMMP_VERSION^^}"
  
  if [[ "${PMMP_VERSION}" == "PM4" ]]; then
    API_CHANNEL="4"
  elif [[ "${PMMP_VERSION}" == "PM5" ]]; then
     API_CHANNEL="stable"
  else
    printf "Unsupported version: %s" "${PMMP_VERSION}"
    exit 1
  fi
  
  if [ ! "$(command -v ./bin/php7/bin/php)" ]; then
    installPhp "$API_CHANNEL" "$PMMP_VERSION"
    sleep 5
  fi
  
  
  DOWNLOAD_LINK=$(curl -sSL https://update.pmmp.io/api?channel="$API_CHANNEL" | jq -r '.download_url')

  curl --location --progress-bar "${DOWNLOAD_LINK}" --output PocketMine-MP.phar
  
  display
    
  echo -e ""
  
  launchPMMPServer
  ;;
  5)
  echo "$(tput setaf 3)Starting Download please wait"
  touch nodejs
  
  display
  
  sleep 10

  echo -e ""
  
  launchNodeServer
  ;;
  *) 
    echo "Error 404"
    exit
  ;;
esac  
else
if [ -e "server.jar" ]; then
    display   
    forceStuffs
    if [ -e "proxy" ]; then
    launchJavaServer proxy
    else
    launchJavaServer
    fi
elif [ -e "PocketMine-MP.phar" ]; then
    display
    launchPMMPServer
elif [ -e "nodejs" ]; then
    display
    launchNodeServer
fi
fi
