  sudo apt update
  sudo apt-get install gnome-tweak-tool
  apt list --installed
  sudo apt-get install git
  gnome-tweak-tool 
  ssh-keygen -t rsa -b 4096 -C fei.du@nxp.com
  sudo apt-get install xclip
  xclip -sel clip < ~/.ssh/id_rsa.pub 
  sudo apt-get remove vim
  sudo apt-get install vim-gnome

  git config --global user.name "Fei Du"
  git config --global user.email fei.du@nxp.com
  git config --global core.editor vim
  git add .vimrc 
  git commit -m 'init'
  git remote add origin git@github.com:fei-du/vim-vundle.git
  git push -u origin master
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
  ~/.bash_it/install.sh 

  sudo apt-get install tmux
  ln -s  profile/vim-vundle/.vimrc .vimrc


  starting yocto

  du L4.1.15_2.0.0-ga_mfg-tools.tar.gz  -sh
  tar -xvzf L4.1.15_2.0.0-ga_mfg-tools.tar.gz 
  git clone git://git.freescale.com/imx/uboot-imx.git -b imx_v2016.03_4.1.15_2.0.0_ga
  git clone git://git.freescale.com/imx/uboot-imx.git -b imx_v2016.03_4.1.15_2.0.0_ga --depth=1
  bitbake -h
