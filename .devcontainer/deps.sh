#!/usr/bin/zsh

set -e

sudo apt-get update && sudo apt-get install -y pkg-config libssl-dev gcc-x86-64-linux-gnu

# Install NVM and NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts --latest-npm

# Install prettier
npm install -g prettier

# Install semantic-release
npm install -g semantic-release @semantic-release/changelog @semantic-release/exec @semantic-release/git @semantic-release/github

# Install favorite prompt theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install task
TASK_VERSION=v3.39.2
curl -s https://taskfile.dev/install.sh | sudo sh -s -- -b /usr/local/bin $TASK_VERSION

# Install ctlptl
CTLPTL_VERSION="0.8.34"
curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v$CTLPTL_VERSION/ctlptl.$CTLPTL_VERSION.linux.x86_64.tar.gz | sudo tar -xzv -C /usr/local/bin ctlptl

# Install k3d
K3D_VERSION="v5.7.4"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=$K3D_VERSION bash

# Install kubectl
KUBECTL_VERSION="v1.31.0"
curl -L https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl -o ~/kubectl
chmod +x ~/kubectl
sudo mv ~/kubectl /usr/local/bin/kubectl

# Install mdbook
cargo install mdbook
