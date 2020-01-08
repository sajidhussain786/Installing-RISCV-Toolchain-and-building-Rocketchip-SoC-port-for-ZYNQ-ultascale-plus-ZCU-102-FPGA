#echo "<---**********************************************************************************************---> "
#"<---This script will build/install the RISCV processor in the current directory. ----> "
# "<---Execute this script in privilidge mode(sudo) because it will install many prerequsit software tools required to build RISCV beside cloning the relevant repsoitories. --> "
# "<---If it is not executing at host machine make it executable by running the following command in terminal. --> "
# "<--- sudo chmod 777 RISCV_install.sh ---> " # to make is executable, or use  chmod 744 for current user only
# "<---This script has been tested on ubuntu 18.04 but i beleive it works fine with other ubuntu and Fedora versions --> "
# "<---IF your OS is Fedora please uncomment the requiered packeges installation command for Fedora and comment the Ubuntu's one below. follow the comments to get the right one. --> "
#echo "<---**********************************************************************************************---> "

echo "*" 
echo "*"  
echo "*" 
echo "<-------------------------------------------------------->"
echo "-  welcome to Rocketchip ZCU102 installing              -" 
echo "-  Written By: Sajid Hussain, UNSW sydney, AUstralia    -" 
echo "<-------------------------------------------------------->"

echo "*" 
echo "*"  
echo "*"  
echo "<--If you do not want to install it please press CLT+C immediately--->"
echo "On_Hold for 20 seconds"
sleep 20
echo "*"
echo "*"
echo " Ok Fine. Going to start installation"
echo "*"
echo "<-------------------checking updates --------------------->"
echo "<---***************************************************---> "
echo "*"
echo "*"
 
sudo apt-get update; #sudo apt-get upgrade 
sudo apt-get install git
echo "<----------------cloning RC-FPGA-ZYNC resposiroty-------------------> "
#git clone https://github.com/ucb-bar/fpga-zynq.git
#cd fpga-zynq 
git clone https://github.com/li3tuo4/rc-fpga-zcu.git
cd rc-fpga-zcu 
cd zcu102 
make init-submodules
cd ..
sleep 5
#make init-submodules
echo "*"
echo "*"
echo "<---*****************************************************************---> "
echo "<-----------------Generating the Rocket-Chip----------------------------> "
echo "<---*****************************************************************---> "
echo "*"
echo "*"

    git clone https://github.com/ucb-bar/rocket-chip.git
    cd rocket-chip                       # Enter into rocket chip directory
    git submodule update --init

    #Installing rocket-chip tools
    echo "*"
    echo "*"
    echo "<---*************************************************************************************---> "
    echo "<---some pre-req tools are required for RISCV buidling & running: i.e. RISCV ToolChanin------>"
    echo "<---**************************************************************************************---> "
    echo "*"
    echo "*"
                echo "*"
                echo "*"
                 echo "<---*********************************************************************---> "
                echo "<---Installing some pre-requsit tools for required to build RISCV ToolChanin--->"
                echo "<---**********************************************************************---> "
                echo "*"
                echo "*"
                
                # Packages needed for ubuntu are following. plz comment/uncomment a line based on your OS.
                sudo apt-get install autoconf automake autotools-dev curl device-tree-compiler libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat1-dev pkg-config python python-dev
            
 	# Now they have added some more tools on gethub; second version they have added some new tools so better to keep both 
                sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev libusb-1.0-0-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev device-tree-compiler pkg-config libexpat-dev
                
               # This is not mentioned but required to install otherwise it will give error like "error while loading shared libraries: libtcl8.5.so: cannot open shared object file:" 
                    sudo apt-get install tcl8.5-dev tk8.5-dev  
                #if  some pacakges failed to install due to some dependencies please install those pre-requsit packeges first. 

                #if  some pacakges failed to install due to some dependencies please install those pre-requsit packeges first. 

                #Fedora packages needed are following. plz comment/uncomment a line based on your OS. 
                #sudo dnf install autoconf automake @development-tools curl dtc libmpc-devel mpfr-devel gmp-devel libusb-devel gawk gcc-c++ bison flex texinfo gperf libtool patchutils bc zlib-devel python python-dev
                #if  some pacakges failed to install due to some dependencies please install those pre-requsit packeges first.
                
                echo "*"
                echo "*"
                 echo "<---*************************************************************---> "
                echo "<------------------- Chisel3 Installation----------------------------> " 
                echo "<---**************************************************************---> "
                echo "*"
                echo "*"
                sudo apt-get install default-jdk # 1 install JAVA
                # 2 Install sbt, which isn't available by default in the system package manager:
                echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
                sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
                sudo apt-get update
                sudo apt-get install sbt
                echo "*"
                echo "*"
                 echo "<---***************************************************************---> "
                echo "<-------------------- Verilator Installation---------------------------> " 
                echo "<---****************************************************************---> "
                echo "*"
                echo "*"
                # Install Verilator. We currently recommend Verilator version 3.922. Follow these instructions to compile it from source.
                sudo apt-get install git make autoconf g++ flex bison # i. Install prerequisites (if not installed already):
                git clone http://git.veripool.org/git/verilator # ii. Clone the Verilator repository 
                cd verilator 
                git pull                     # ii In the Verilator repository directory, check out a known good version:
                git checkout verilator_3_922 
                # iv. In the Verilator repository directory, build and install:
                unset VERILATOR_ROOT # For bash, unsetenv for csh
                autoconf # Create ./configure script
                ./configure
                make
                sudo make install
                cd ..              ## come out of verilator directory
                echo "*"
                echo "*"
                 echo "<---*********************************************************************---> "
                 echo "<-----pre-requisit tools required for building Riscv tolls are installed here ----->" 
                 echo "<---************************************************************************---> "
            echo "*"
            echo "*"     
            echo "<---*********************************************************---> "
            echo "<------------- Now Building the Riscv-Toolchaing -------------> " 
            echo "<---- This will may take longer time(30 mint- 3hr depending the speed of your computer & internet)----> " 
            echo "<---*********************************************************---> "
            git clone https://github.com/riscv/riscv-tools.git
	    cd riscv-tools                            #Enter into riscv-directory
            git submodule update --init --recursive   # get latest one for git

            
            echo '#<---------- RISCV toolchain envirment varialbe ------------>'>>~/.bashrc
 	    echo "export RISCV=$(pwd)">>~/.bashrc     # add them permanently to .bashrc
            echo 'export PATH=$RISCV/bin:$PATH'>>~/.bashrc
	    #make them visibl in current shell
            echo " sourcing ~/.bashrc "
            #source ~/.bashrc          # this might not work if you are running it in SUDO mode, therefore   
            export RISCV=$(pwd)
	    export PATH=$RISCV/bin:$PATH          
            
                 #-------------- If you do not have the RISCV-GNU/RSICV-GCC cross compiler install it usign belo command otherwise riscv-toolchain will not be able to build successfully ----
        # following step will take most of your time, if cross-compiler already installed please comment this step
          if [ ! `which riscv64-unknown-elf-gcc` ]
	then
    	echo "RSICV-gcc-crosss compiler not found going to download and build it first"
	
          
          echo '****************installing RISCV-GNU cross compiler  ***************'             
                git clone https://github.com/riscv/riscv-gnu-toolchain
        	cd riscv-gnu-toolchain
    		 git submodule update --init --recursive
               echo '-------------installing RSICV-GNU(NewLib)-----------------'
                export PATH=/opt/riscv/bin:$PATH
	   	echo 'export PATH=/opt/riscv/bin:$PATH'>>~/.bashrc   # add it into bashrc permanently 
               ./configure --prefix=/opt/riscv
    		sudo make
             echo '---------------installing RSICV-GNU(Linux)------------'
		./configure --prefix=/opt/riscv
    		sudo make linux
               cd ..
            #--------------------
        else
    	echo "******RSICV cross compiler already installed******"
	fi 
            echo "<---- RISCV variable will be pointed now to the following riscv-tools installation directory---> "
            echo $RISCV
             echo '---------------Building RISCV main tolls (PK, spike etc)------------'
            ./build.sh                                # build it
            #./build-rv32ima.sh  # incase (if you are using RV32).
            cd ..                                     # leave the directory, going back to rocket-chip directory
            echo "*"
            echo "*"
            echo "<---*********************************************************---> "
            echo "<----------------------CONGRATS---------------------------------> " 
            echo "<-------Riscv-toolchaing installation done here ---------------->" 
            echo "<---*********************************************************---> "
    echo "*"
    echo "*"
    echo "<---***********************************************************************---> "
    echo "<----------------NOW, First, going to build the C simulator------------------>" 
    echo "<---***********************************************************************---> "
    cd emulator
    make
    printenv >RISCV_Environment_variables #save environment variables in file for future use if not properly exported by export command. 
    # For me, export command was not adding variable permanently so i have to set RISCV and add it to PATH every time i restart the system. export RISCV=$(pwd)  export PATH=$PATH:$RISCV/bin
    echo "*"
    echo "*"
    echo "<---**********************************************************************---> "
    echo "<-------IF you want to install VCS simulator uncomment the following lines in script after installing VCS from synopsis-------->" 
    echo "<---**********************************************************************---> "
    #cd vsim
    #make
    echo "*"
    echo "*"
    echo "<---************************************************************---> "
    echo "<------------------Now Running Assembly tests ---------------------->"
    echo "<---*************************************************************---> " 
    make  run-asm-tests
    
    echo "*"
    echo "*"
    echo "<---**********************************************************************---> "
    echo "<---------------------Now Running Benchmarks tests tests --------------------->"
    echo "<---**********************************************************************---> "
    make  run-bmark-tests
    cd ..                       #going up to rocket-chip directory
    #To build a C simulator that is capable of VCD waveform generation:
    #cd emulator
    #make debug
    #And to run the assembly tests on the C simulator and generate waveforms (Assuming you have N cores on your host system):
    #make -jN run-asm-tests-debug
    #make -jN run-bmark-tests-debug
    #To generate FPGA- or VLSI-synthesizable Verilog (output will be in vsim/generated-src):
    # cd vsim
    # make verilog
    
    
    echo "<---**********************************************************************---> "
    echo "<---------------------Now Generating Hardware for FPGA    --------------------->"
    echo "<---**********************************************************************---> "
    
    cd ..      # leave the directory, going back to main directoyr (rc-fpga-zcu)
    
    cd zcu102 
    # make init-submodules
    make rocket                 # generate verilog code for the SoC 
    make bitstream              # implement and build Bitstream for FPGA
    
    cp zcu102_rocketchip_ZynqConfig/zcu102_rocketchip_ZynqConfig.runs/impl_1/
rocketchip_wrapper.sysdef soft_config/rocketchip_wrapper.hdf
cp zcu102_rocketchip_ZynqConfig/zcu102_rocketchip_ZynqConfig.runs/impl_1/
rocketchip_wrapper.bit soft_config/rocketchip_wrapper.bit
    
    cd ..                    # leave the directtory, go to main directory 
    cd ..                    # leave the main directory 
   # if you ran the cript with sudo command you need to make directory non-root
   # replace it with your username " username:username"
    sudo chown sajid-ubuntu:sajid-ubuntu -R rc-fpga-zcu 
    echo "*"
    echo "*"
    echo "<---***************************************************---> "
    echo "<--------------------Congratulations----------------------->"
    echo "<----------------------All DONE --------------------------->"
    echo "<---------------------------------------------------------->"
    echo "<---***************************************************---> "

