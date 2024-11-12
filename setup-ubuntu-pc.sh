echo "Iniciandos processo..."
echo "Instalando pacotes..."
sudo apt install -y curl nmap git

git config --global user.email "felipe.holanda@conetech.com.br"
git config --global user.name "Felipe Holanda"

echo "Instalando ZSH + Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Alterando tema e instalando plugins do Oh My Zsh..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Comando que faz o clone do arquivo com as novas informações do .zshrc

