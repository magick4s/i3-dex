# I3 Dex - Instalação da configuração

> 1. ATENÇÃO: Siga todos os passos aqui postados. Qualquer eventual problema será sua responsabilidade.
> 2. A proposta aqui é, trazer um método de instalação simples e fácil de ser executado.
> 3. Qualquer usuário conseguirá instalar o I3 Dex apartir deste repositório.
  
* Requisitos: Arch Linux e conexão cabeada:

## ⚙ 1° Passo: Logue como root:
```...```  

## ⚙ 2° Passo: Deixe o teclado em pt_BR:
```loadkeys br-abnt2```  

## ⚙ 3° Passo: Adicione seu usuário ao grupo sudoers:
```nano /etc/sudoers```
* Procure por root *```ALL=(ALL) ALL```*, e abaixo insira *```<SEU USUÁRIO> ALL=(ALL) ALL```*

## ⚙ 4° Passo: Saia do root e logue com o seu usuário:
```exit```

## ⚙ 5° Passo: Novamente, deixe o teclado em pt_BR:
```sudo loadkeys br-abnt2```

## ⚙ 6° Passo: Execute o script de instalação e depois reinicie o sistema:
```bash <(curl -s https://raw.githubusercontent.com/jirrezdex/i3-dex/master/config/instalador.sh)```  
```reboot```

##### Sistema de login: Digite seu usuário e senha, após ter feito isto, dê "startx"

## ⚙ Passos adicionais:
### Teclado pt-br
```localectl set-x11-keymap br abnt2```  

### WiFi
```nmcli d wifi list```  
```nmcli device wifi connect NOME-DA-REDE password SENHA-DA-REDE```
