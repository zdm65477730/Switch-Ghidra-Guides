#!/bin/bash
cd $HOME/ && \
wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.7%2B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.7_7.tar.gz && \
mkdir ojdk17 && \
tar xvzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.7_7.tar.gz -C ojdk17 && \
rm OpenJDK17U-jdk_x64_linux_hotspot_17.0.7_7.tar.gz && \
export JAVA_HOME=$HOME/ojdk17/jdk-17.0.7+7 && \
export PATH="$HOME/ojdk17/jdk-17.0.7+7 /bin:$PATH" && \
echo "export PATH="$HOME/ojdk17/jdk-17.0.7+7 /bin:$PATH"" >> $HOME/.profile && \
wget $(curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest | grep "browser_download_url" | cut -d '"' -f 4) -O ghidra.zip && \
unzip ghidra.zip -d ghidra && \
rm ghidra.zip && \
GHIDRA=$(ls $HOME/ghidra) && \
echo "alias ghidra=$HOME/ghidra/$GHIDRA/ghidraRun" >> $HOME/.bash_aliases && \
export GHIDRA_INSTALL_DIR=$HOME/ghidra/$GHIDRA && \
git clone https://github.com/Adubbz/Ghidra-Switch-Loader && \
cd Ghidra-Switch-Loader && \
chmod +x gradlew && \
./gradlew && \
cd dist && \
unzip *.zip -d "$HOME/ghidra/$GHIDRA/Ghidra/Extensions" && \
cd ../.. && \
rm -rf Ghidra-Switch-Loader && \
source $HOME/.profile && \
source $HOME/.bash_aliases && \
ghidra
