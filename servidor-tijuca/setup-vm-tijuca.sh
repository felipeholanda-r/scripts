#!/bin/bash
echo "INICIANDO CONFIGURAÇÕES INICIAIS..."

echo "ATUALIZANDO PACOTES..."
apt update && apt upgrade -y


echo "ATUALIZANNDO A TELA DE BOAS VINDAS..."
# Caminho para os arquivos
ARQUIVO_HEADER="/etc/update-motd.d/00-header"
ARQUIVO_HELP="/etc/update-motd.d/10-help-text"

# Texto a ser adicionado no 00-header
TEXTO_ADICIONADO='printf "\\n _____ ___   _____ _  _\\n|_   _|_ _| |_   _(_)(_)_   _  ___ __ _ \\n  | |  | |    | | | || | | | |/ __/ _\\` |\\n  | |  | |    | | | || | |_| | (_| (_| |\\n  |_| |___|   |_| |_|/ |\\__,_|\\___\\__,_|\\n                   |__/\\n\\n"'

# Verifica se os arquivos existem
if [[ ! -f "$ARQUIVO_HEADER" ]]; then
    echo "Arquivo $ARQUIVO_HEADER não encontrado!"
    exit 1
fi

if [[ ! -f "$ARQUIVO_HELP" ]]; then
    echo "Arquivo $ARQUIVO_HELP não encontrado!"
    exit 1
fi

# Linhas a serem comentadas no 10-help-text
PALAVRA_COMENTAR="printf"

# Comenta o texto no 10-help-text
sed -i "s/$PALAVRA_COMENTAR/# $PALAVRA_COMENTAR/g" $ARQUIVO_HELP
echo "Linhas comentadas com sucesso no arquivo $ARQUIVO_HELP"

# Adicionar o texto no 00-header, antes da linha de busca
LINHA_DE_BUSCA_HEADER='printf'

# Verifica se o texto já foi adicionado no 00-header
if grep -q "$TEXTO_ADICIONADO" "$ARQUIVO_HEADER"; then
    echo "O texto já foi adicionado no $ARQUIVO_HEADER."
else
    # Adiciona o texto antes da linha de busca no 00-header
    sed -i "/$LINHA_DE_BUSCA_HEADER/i $TEXTO_ADICIONADO" "$ARQUIVO_HEADER"
    echo "Texto adicionado ao $ARQUIVO_HEADER com sucesso."
fi

echo "INSTALANDO ZSH COMO NOVO SHELL..."
apt install -y zsh

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


sed -i "s/plugins=(/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g" .arquivo-teste



