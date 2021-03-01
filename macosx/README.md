# `dot/macosx`

Mac OSX dot files and setup.

**DO NOT COMMIT SENSITIVE FILES!**

## Recommendations

Install the following, then restart your shell so changes take effect.

```
# Install Homebrew and Cask
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/cask
brew tap homebrew/cask-versions
brew install brew-cask-completion

# Install Bash, Git, Vim
brew install bash bash-completion@2 git vim
sudo echo /usr/local/bin/bash >> /etc/shells
chsh -s /usr/local/bin/bash

# Install Docker, Golang, Java, Python
brew cask install docker java
brew install docker-completion go python pip-completion
```
