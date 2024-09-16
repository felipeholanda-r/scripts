#!/bin/bash
echo "Iniciando as mudanças no servidor..."
# Função para trocar as linhas no arquivo fornecido
swap_motd_lines() {
  local arquivo=$1

  # Verifica se o arquivo existe
  if [ ! -f "$arquivo" ]; then
    echo "Erro: Arquivo '$arquivo' não encontrado!"
    return 1
  fi
  
  echo "Alterando o arquivo '$arquivo'..."

  # Define as linhas a serem procuradas
  local linha_motd="session    optional     pam_motd.so  motd=/run/motd.dynamic"
  local linha_noupdate="session    optional     pam_motd.so noupdate"

  # Encontra o número das linhas onde cada uma aparece
  local linha_motd_num=$(grep -n "$linha_motd" "$arquivo" | cut -d: -f1)
  local linha_noupdate_num=$(grep -n "$linha_noupdate" "$arquivo" | cut -d: -f1)

  # Verifica se ambas as linhas foram encontradas
  if [ -n "$linha_motd_num" ] && [ -n "$linha_noupdate_num" ]; then
    # Garante que a linha "noupdate" esteja acima de "motd"
    if [ "$linha_noupdate_num" -gt "$linha_motd_num" ]; then
      # Usa 'sed' para trocar as duas linhas de lugar mantendo a posição
      sed -i "${linha_motd_num}s|.*|$linha_noupdate|" "$arquivo"
      sed -i "${linha_noupdate_num}s|.*|$linha_motd|" "$arquivo"
      echo "Linhas trocadas com sucesso no arquivo $arquivo."
    else
      echo "As linhas já estão na ordem correta no arquivo $arquivo. Nenhuma alteração foi feita."
    fi
  else
    echo "As linhas não foram encontradas no arquivo $arquivo ou uma delas está faltando."
  fi
}

# Defina os nomes dos arquivos diretamente no script
sshd="/etc/pam.d/sshd"
login="/etc/pam.d/login"
motd="/etc/motd"

# Chama a função para o primeiro arquivo
swap_motd_lines "$sshd"

# Chama a função para o segundo arquivo
swap_motd_lines "$login"

echo "Alterando o arquivo /etc/motd..."

echo "
  ____                   _____         _     
 / ___|___  _ __   ___  |_   _|__  ___| |__  
| |   / _ \| '_ \ / _ \   | |/ _ \/ __| '_ \ 
| |__| (_) | | | |  __/   | |  __/ (__| | | |
 \____\___/|_| |_|\___|   |_|\___|\___|_| |_|


Bem-vindo!

Este servidor é hospedado pela Cone Tech. Se você tiver 
alguma dúvida ou precisar de ajuda, não hesite em nos
contatar em https://suporte.conetech.com.br

" > $motd
