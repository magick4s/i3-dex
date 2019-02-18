# I3 Dex - Instalação do sistema base

> 1. ATENÇÃO: Siga todos os passos aqui postados. Qualquer eventual problema será sua responsabilidade.
> 2. A proposta aqui é, trazer um método de instalação simples e fácil de ser executado.
> 3. Qualquer usuário conseguirá instalar o I3 Dex apartir deste repositório.
  
* Requisitos: Pendrive bootável com o Arch Linux e conexão cabeada:

## ⚙ 1° Passo: Baixe o Etcher e o Arch Linux:
O  Etcher vai ser usado para criar o pendrive bootável - [SITE](https://www.balena.io/etcher/).
![Etcher](https://www.balena.io/static/steps-8006dca57323756b1b84fb9408742409.gif)

O Arch Linux é a distribuição que será usada - [SITE](https://www.archlinux.org/)

## ⚙ 2° Passo: Deixe o teclado em pt_BR:
```loadkeys br-abnt2```

## ⚙ 3° Passo: Ative a conexão com a internet:
```systemctl enable dhcpcd.service```  
```systemctl start dhcpcd```

## ⚙ 4° Passo: Particione o disco:
```cfdisk```
* Eu crio sempre duas partições: 
* Para *```/dev/sda1```* uso quase todo meu espaço e separo 4GB.
* Para *```/dev/sda2```* uso 4GB.

```/dev/sda1 – 508GB```  
```/dev/sda2 – 4GB```

* A partição *```/dev/sda1```* deve ser *```primária e bootável```*
* A partição *```/dev/sda2```* deve ser *```primária e do tipo Linux Swap / Solaris```*
* Depois de ter feito isso, dê *```write```* e *```quit```*

## Obs: Para usar máquina virtual (Virtual box):
* Para máquina virtual, crie um hd de 30GB e crie 3 partições:
* Para *```/dev/sda1```* bios boot eu separo 2M.
* Para *```/dev/sda2```* uso 36GB para File system.
* Para *```/dev/sda3```* uso 4GB para Swap.

```/dev/sda1 – 2M```  
```/dev/sda2 – 36GB```
```/dev/sda3 – 4GB```

* A partição *```/dev/sda1```* deve ser *```bios boot ou boot de inicialização```*
* A partição *```/dev/sda2```* deve ser *```file system```*
* A partição *```/dev/sda2```* deve ser *```Linux Swap```*
* Depois de ter feito isso, dê *```write```* e *```quit```*


## ⚙ 5° Passo: Formate as partições criadas:
```mkfs.ext4 /dev/sda1```  
```mount -t ext4 /dev/sda1 /mnt```  
```mkswap /dev/sda2```  
```swapon /dev/sda2```  

## ⚙ 6° Passo: Definina um servidor de download:
```nano /etc/pacman.d/mirrorlist```  
* Procure por *```Brazil```*, recorte o espelho com o comando *```Ctrl+K```* e cole no inicio do arquivo com o comando *```Ctrl+U```*  
* O espelho se parece com isso: *```Server = http://mirror.ufscar.br/archlinux/$repo/os/$arch```*

## ⚙ 7° Passo: Instale o sistema base:
```pacstrap /mnt base base-devel```  

## ⚙ 8° Passo: Gere o fstab:
```genfstab /mnt >> /mnt/etc/fstab```  

## ⚙ 9° Passo: Logue no chroot:
```arch-chroot /mnt```  

## ⚙ 10° Passo: Defina o idioma:
```nano /etc/locale.gen```  
* Procure por *```pt_BR```*, você vai achar a seguinte linha  
*```#pt_BR.UTF-8 UTF-8```*, remova o sustenido *```#```* da frente 
dela e insira espaço:

```locale-gen```  
```echo LANG=pt_BR.UTF-8 > /etc/locale.conf```  
```export LANG=pt_BR.UTF-8```  

## ⚙ 11° Passo: Defina o horário:
```rm /etc/localtime```  
```ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime```  

## ⚙ 12° Passo: Defina a senha do root:
```passwd```  

## ⚙ 13° Passo: Crie um usuário e defina sua senha:
```useradd -m -g users -G wheel -s /bin/bash <SEU USUÁRIO>```  
```passwd <SEU USUÁRIO>```  

## ⚙ 14° Passo: Baixe e instale o grub:
```pacman -S grub```  
```grub-install /dev/sda```  

## ⚙ 15° Passo: Configure o mkinitcpio:
```mkinitcpio -p linux```  

## ⚙ 16° Passo: Configure o grub:
```grub-mkconfig -o /boot/grub/grub.cfg```  

## ⚙ 17° Passo: Saia do chroot:
```exit```  

## ⚙ 18° Passo: Desmonte todas as partições e reinicie o sistema:
```umount -a```  
```reboot```   
