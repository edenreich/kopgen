#!/usr/bin/zsh

set -e

architecture=$(uname -m)

architecture_pretty="arm64"
if [ "$architecture" = "x86_64" ]; then
  architecture_pretty="amd64"
fi

cd $HOME

sudo apt-get update && sudo apt-get install -y pkg-config libssl-dev gcc-x86-64-linux-gnu

# Install NVM and NodeJS
echo "==> Installing NVM and NodeJS"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts --latest-npm

# Install prettier
echo "==> Installing prettier"
npm install -g prettier

# Install semantic-release
echo "==> Installing semantic-release"
npm install -g semantic-release @semantic-release/changelog @semantic-release/exec @semantic-release/git @semantic-release/github

# Install favorite prompt theme
echo "==> Installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install task
echo "==> Installing task"
TASK_VERSION=v3.39.2
curl -s https://taskfile.dev/install.sh | sudo sh -s -- -b /usr/local/bin $TASK_VERSION

# Install ctlptl
echo "==> Installing ctlptl"
CTLPTL_VERSION="0.8.34"
curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v$CTLPTL_VERSION/ctlptl.$CTLPTL_VERSION.linux.$architecture_pretty.tar.gz | sudo tar -xzv -C /usr/local/bin ctlptl

# Install k3d
echo "==> Installing k3d"
K3D_VERSION="v5.7.4"
curl -sSL https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=$K3D_VERSION bash

# Install kubectl
echo "==> Installing kubectl"
KUBECTL_VERSION="v1.31.0"
curl -sSL https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/$architecture_pretty/kubectl -o kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

# Install mdbook
echo "==> Installing mdbook"
MDBOOK_VERSION="v0.4.40"
curl -sSL https://github.com/rust-lang/mdBook/releases/download/$MDBOOK_VERSION/mdbook-$MDBOOK_VERSION-$architecture-unknown-linux-musl.tar.gz -o mdbook.tar.gz
tar -xzf mdbook.tar.gz
chmod +x mdbook
sudo mv mdbook /usr/local/bin/mdbook

# Install mdbook-mermaid
echo "==> Installing mdbook-mermaid"
MDBOOK_MERMAID_VERSION="v0.14.0"
curl -sSL https://github.com/badboy/mdbook-mermaid/releases/download/$MDBOOK_MERMAID_VERSION/mdbook-mermaid-$MDBOOK_MERMAID_VERSION-x86_64-unknown-linux-musl.tar.gz -o mdbook-mermaid.tar.gz
tar -xzf mdbook-mermaid.tar.gz
chmod +x mdbook-mermaid
sudo mv mdbook-mermaid /usr/local/bin/mdbook-mermaid
