# .files

You know, the basic files under `~/` that begin with a `.`
Used to keep my computers and mind in sync.

## Setup for Vim 8

Note I use VSCode now, so this is mostly for Servers.

Start with Vundle https://github.com/VundleVim/Vundle.vim

```bash
cd $HOME
git clone git@github.com:jb-1980/dot_files.git
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Set up vim folders:
`mkdir ~/.vim/files && mkdir ~/.vim/files/{backup,info,swap,undo}`

### Install ZSH

`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

Make zsh the default shell:
`chsh -s $(which zsh)`

Custom ZSH plugins

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Customization

From your `~/` home directory, symlink the dot_files:

```bash
mv .zshrc .zshrc_original
ln -s ~/dot_files/.zshrc
ln -s ~/dot_files/shadoath.zsh-theme ~/.oh-my-zsh/custom/themes/shadoath.zsh-theme
ln -s ~/dot_files/.vimrc
ln -s ~/dot_files/.gitconfig
ln -s ~/dot_files/.gitignore_global
ln -s ~/dot_files/.git-prompt.sh
ln -s ~/dot_files/.git-completion.bash
ln -s ~/dot_files/.pryrc
ln -s ~/dot_files/.agignore
```

Install all vim plugins:

```bash
vim +PluginInstall +qall
```

Load your profile settings:

```bash
source ~/.zshrc
```

Have git save user/pass

```bash
git config credential.helper store
```

## Notes

View the /includes folder for extended functionality.

```
* Functions ------- New terminals, Pull requests, YML/hosts s3 sync, tab-color, and IP binding.
* Aliases
  * Base ---------- Quick commands for all things.
  * Rails --------- ENV, custom ports, bake and more.
  * Capistrano ---- Deploying Rails apps with complicated enviroments.
  * Git ----------- Make git quick.
```

## Additional Files

### [Moonlander ZSA keyboard](https://configure.zsa.io/moonlander/layouts/EnmMA/latest/0) layout using [Colemak+](https://colemak.com/Learn)

![layout](https://github.com/shadoath/dot_files/blob/master/images/moonlander-layer-1.png?raw=true)

### OTF [Font kit](https://github.com/shadoath/dot_files/blob/master/include/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf) for [nerd fonts](https://github.com/ryanoasis/nerd-fonts)

### Synergy config for home Windows/OSX screen setup

Comment/PR and let's both get smarter.
