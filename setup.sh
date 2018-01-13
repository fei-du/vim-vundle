# Setup
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
    # install fzf finder
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    #install vifm
    git clone --depth=1 git@github.com:vifm/vifm.git
    cd vifm/
    sudo apt-get install sshfs curlftpfs fuse fuse-zip fusefat fuseiso
    ls scripts/
    ./scripts/fix-timestamps
    ./configure
    make
    sudo make install
    # skip vifmrc, currently not working on ubuntu box
    mv vifmrc vifmrc_backup

    #bash-it
    bashit enable plugin dirs
    bashit enable plugin fzf
    bashit enable plugin git
    bashit enable plugin history
    bashit enable plugin tmux
    bashit enable plugin extract
    bashit enable plugin projects
    bashit enable alias tmux
    bashit enable alias git
    bashit enable alias general
    bashit enable alias clipboard
    bashit enable alias apt

    apt-get install bashdb

# Starting yocto
    mkdir ~/bin
    curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    git clone git@github.com:fei-du/yocto-repo.git
    chmod a+x ~/bin/repo
    export PATH=~/bin:$PATH

    mkdir fsl-release-bsp
    cd fsl-release-bsp
    repo init -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git -b imx-4.1-krogoth
    repo sync

    du L4.1.15_2.0.0-ga_mfg-tools.tar.gz  -sh
    tar -xvzf L4.1.15_2.0.0-ga_mfg-tools.tar.gz 
    git clone git://git.freescale.com/imx/uboot-imx.git -b imx_v2016.03_4.1.15_2.0.0_ga
    git clone git://git.freescale.com/imx/uboot-imx.git -b imx_v2016.03_4.1.15_2.0.0_ga --depth=1


# SetUp build directory for device and board
    DISTRO=fsl-imx-x11 MACHINE=imx6ull14x14evk source fsl-setup-release.sh -b build-x11
    bitbake core-image-base
    # build the whole image
    bitbake fsl-image-gui
    # flashing images
    # write uboot image
    # to find out sdcard location
    sudo fdisk -l
    # writing u-boot image to sdcard
    sudo dd if=6ul-u-boot.imx of=/dev/mmcblk0 bs=512 seek=2
    sync

# setup U-boot build
    #install cross compiler
    sudo apt-get install gcc-arm-linux-gnueabihf
    #install dtc, not avaiable on ubuntu-14
    sudo apt-get install device-tree-compiler

    export ARCH=arm
    export CROSS_COMPILE=arm-linux-gnueabihf-

    make mx6ul_14x14_ddr3_arm2_defconfig
    make

    sudo dd if=u-boot.imx of=/dev/mmcblk0 bs=512 seek=2
    sync
