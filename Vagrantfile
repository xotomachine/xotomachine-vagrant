Vagrant.configure("2") do |config|
 
  config.vm.box = "ubuntu/bionic64"
  config.ssh.insert_key = true
  config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.provision "shell", path: ${REPO_PATH} + "apts/editor.sh", privileged: false
  config.vm.provision "shell", path: ${REPO_PATH} + "apts/git.sh" , privileged: false, env: {"NAME" => ${NAME}, "EMAIL"=> ${EMAIL} }
  config.vm.provision "shell", path: ${REPO_PATH} + "apts/node.sh"  , privileged: false, env: {"NVM_VERSION" => ${NVM_VERSION}, "YARN_VERSION" => ${YARN_VERSION} ,"USER_HOME" => "/home/"+${USER_NAME} }
  config.vm.provision "shell", path: ${REPO_PATH} + "apts/docker.sh"
  config.vm.provision "shell", path: ${REPO_PATH} + "apts/ssh.sh" , env: {"EMAIL" => ${EMAIL}, "USER_NAME" => ${USER_NAME} ,"USER_HOME" => "/home/"+{USER_NAME} }

  ####################
  ##  LANGUAGE DEPS ##
  ####################

  config.vm.provision "shell", path: ${REPO_PATH} + "language/python.sh"
  config.vm.provision "shell", path: ${REPO_PATH} + "language/java.sh", env: {"JAVA_VERSION" => ${JAVA_VERSION} }
  config.vm.provision "shell", path: ${REPO_PATH} + "language/ruby.sh", env: {"RUBBY_VERSION" => ${RUBBY_VERSION}, "USER_HOME" => "/home/"+${USER_NAME} }
  config.vm.provision "shell", path: ${REPO_PATH} + "language/go.sh"

  ###################
  ## DATABASE DEPS ##
  ###################

  config.vm.provision "shell", path: ${REPO_PATH} + "database/postgres.sh", env: {"POSTGRES_VERSION" => ${POSTGRES_VERSION} }
  config.vm.provision "shell", path: ${REPO_PATH} + "database/mongo.sh"

  #################
  ##   ZSH DEPS  ##
  #################

  config.vm.provision "shell", path: ${REPO_PATH} + "zsh/zsh.sh", env: {"ZSH_CUSTOM" => ${USER_HOME}+"/.oh-my-zsh/custom" }
  config.vm.provision "shell", path: ${REPO_PATH} + "zsh/gitstat.sh", env: { "GITSTATUS_VERSION" => ${GITSTATUS_VERSION} }
  config.vm.provision "shell", path: ${REPO_PATH} + "zsh/clean.sh"

  ##################
  ## Config files ##
  ##################

  config.vm.provision "config files", type: "shell", inline:<<-SHELL
  sudo chsh -s $(which zsh) vagrant
  mkdir ${USER_HOME}/.config
  touch ${USER_HOME}/.zshrc
  echo "source $HOME/.config/.zshrc" >> ${USER_HOME}/.zshrc
  git clone --recurse-submodules -j8 ${DOTFILE_REPO} ~/.config ${USER_HOME}/.config > /dev/null
  chown $${USER_NAME}:$USER_GROUP ${USER_HOME}/.config
  SHELL

  #######################
  ##  PACKAGE MANAGER  ##
  #######################
  config.vm.provision "Install brew", type: "shell", inline:<<-SHELL
  sudo git clone ${BREW_REPO} /usr/local/Homebrew
  SHELL
  
  config.vm.provision "shell", path: ${REPO_PATH} + "package/brew.sh"
  config.vm.provision "shell", path: ${REPO_PATH} + "package/maven.sh"
  config.vm.provision "shell", path: ${REPO_PATH} + "package/clean.sh"

  #############
  ##  UNIX   ##
  #############

  config.vm.provision "shell", path: ${REPO_PATH} + "unix/ccat.sh"

  ##################
  ## FINAL CLEAN  ##
  ##################
  
  config.vm.provision "shell", path: ${REPO_PATH} + "clean/services.sh"
  config.vm.provision "shell", path: ${REPO_PATH} + "clean/clean.sh"

  # MAKE CONFIG FOLDER
  config.vm.provision "config files", type: "shell", inline:<<-SHELL
  reboot
  SHELL
  config.vm.provider ${PROVIDER} do |vb|
    vb.name = ${USER_NAME}
    vb.gui = ${GUI}
    vb.memory = ${MEMORY}
    vb.cpus = ${CPUS}
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
  end

end
