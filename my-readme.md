Need to install for treesitter https://stackoverflow.com/questions/75587679/neovim-treesitter-returning-no-c-complier-error?noredirect=1

> Settings are for neovim 0.11.3

# Dependency

```shell
sudo apt update && sudo apt install -y build-essential

# Node
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
sudo apt-get install -y nodejs

# Telescope dependency
ver=14.1.0
curl -LO "https://github.com/BurntSushi/ripgrep/releases/download/${ver}/ripgrep_${ver}-1_amd64.deb"
sudo dpkg -i "ripgrep_${ver}-1_amd64.deb"
```


# Mac install

```shell
brew install ripgrep
# pyenv
brew install pyenv
brew install openssl readline sqlit3 xz zlib tcl-tk
pyenv install 3.11.4
# Poetry
brew install poetry
# https://github.com/isen-ng/homebrew-dotnet-sdk-versions
brew tap isen-ng/dotnet-sdk-versions
brew install --cask dotnet-sdk8-0-400 
dotnet --list-sdks
```

# After neovim update

```shell
# After upgrade
## Update lazy settings
Lazy sync
## Update treesitter
TSUpadateSync
```

```shell
:checkhealth
```

# Windows setup

Disable ctrl+c/v bindings in windows terminal
- https://github.com/microsoft/terminal/issues/5641#issuecomment-621186852 and then https://learn.microsoft.com/en-us/windows/terminal/install#settings-json-filf
- then sync system clipboard with windows https://superuser.com/questions/1291425/windows-subsystem-linux-make-vim-use-the-clipboard

