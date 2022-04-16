
# Environment Vars
NAME="xotoguest"
EMAIL="xotoguest@gmail.com"
USER_NAME="vagrant"
USER_HOME="/home/vagrant"
DOTFILE_REPO="https://github.com/xotoenv/dotfiles.git"
BREW_REPO="https://github.com/linuxbrew/brew"

# VAGRANT CONFIG
PROVIDER="virtualbox"
GUI="true"
MEMORY="6154"
CPUS="4"

# VERISONS
NVM_VERSION="0.33.2"
YARN_VERSION="1.8.0"
POSTGRES_VERSION="12"
JAVA_VERSION="11"
RUBBY_VERSION="2.1.1"
NERDS_FONT_VERSION="2.1.0"
FZF_VERSION="0.21.1"
GITSTATUS_VERSION="1.0.0"

# REPO
REPO_PATH="./packages/xotomachine-script/setup/"
USER_HOME="/home/"+USER_NAME
ZSH_CUSTOM="/home/"+USER_NAME+"/.oh-my-zsh/custom"

Vagrant.configure("2") do |config|
 
  config.vm.box = "ubuntu/bionic64"
  config.ssh.insert_key = true
  config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.provision "shell", path: REPO_PATH + "apts.sh", privileged: false, env: {"NAME" => NAME, "EMAIL"=> EMAIL, "NVM_VERSION" => NVM_VERSION, "YARN_VERSION" => YARN_VERSION ,"USER_HOME" => USER_HOME, "USER_NAME" => USER_NAME  }

  ####################
  ##  LANGUAGE DEPS ##
  ####################

  config.vm.provision "shell", path: REPO_PATH + "language.sh", env: {"JAVA_VERSION" => JAVA_VERSION,"RUBBY_VERSION" => RUBBY_VERSION, "USER_HOME" => USER_HOME }

  ###################
  ## DATABASE DEPS ##
  ###################

  config.vm.provision "shell", path: REPO_PATH + "database.sh", env: {"POSTGRES_VERSION" => POSTGRES_VERSION }

  #################
  ##   ZSH DEPS  ##
  #################

  config.vm.provision "shell", path: REPO_PATH + "zsh.sh", env: {"ZSH_CUSTOM" => ZSH_CUSTOM , "GITSTATUS_VERSION" => GITSTATUS_VERSION  }

  ##################
  ## Config files ##
  ##################

  config.vm.provision "config files", type: "shell", inline:<<-SHELL
  sudo chsh -s $(which zsh) vagrant
  mkdir ${USER_HOME}/.config
  touch ${USER_HOME}/.zshrc
  
  echo "source $HOME/.config/.zshrc" >> ${USER_HOME}/.zshrc
  git clone --recurse-submodules -j8 ${DOTFILE_REPO} ~/.config ${USER_HOME}/.config > /dev/null
  
  chown ${USER_NAME}:$USER_GROUP ${USER_HOME}/.config
  
  SHELL

  #######################
  ##  PACKAGE MANAGER  ##
  #######################
  
  config.vm.provision "Install brew", type: "shell", inline:<<-SHELL
  sudo git clone ${BREW_REPO} /usr/local/Homebrew
  
  SHELL
  
  config.vm.provision "shell", path: REPO_PATH + "package.sh"

  #############
  ##  UNIX   ##
  #############

  config.vm.provision "shell", path: REPO_PATH + "ccat.sh"

  ##################
  ## FINAL CLEAN  ##
  ##################
  
  config.vm.provision "shell", path: REPO_PATH + "clean.sh"

  ##################
  ## FINAL CLEAN  ##
  ##################

  # MAKE CONFIG FOLDER
  config.vm.provision "config files", type: "shell", inline:<<-SHELL
  
  reboot
  
  SHELL
  
  config.vm.provider PROVIDER do |vb|
    vb.name = USER_NAME
	
    vb.gui = GUI
    vb.memory = MEMORY
    vb.cpus = CPUS
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
  end

end
