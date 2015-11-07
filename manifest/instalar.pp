# Arquivo para instalação de programas e configurações.
#16-08-14
#Autor: Leonardo Barros
  
include apt

#removendo driver ATI
#sudo apt-get remove fglrx
#exec {"remover_driver_ati":
#  command   => "sudo apt-get remove fglrx",
#  path      => "/usr/bin/",
#}

#Colocar o certificado do google chrome
exec {"certificado google":
  command   => "wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -",
  path      => "/usr/bin/",
  before    => Notify["certificado_google"],
  require   => Exec["apt-get update"],
}

notify {"certificado_google":
  message => "O certificado foi inserido com sucesso!",
}

#Adicionando os repositórios

#repositorio WebUpd8 para o 14.04 - chave: 4C9D234C
#apt::source { "WebUpd8": 
#  comment     => 'Repositorio do site WebUpd8',
#  location    => 'http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu', 
#  release     => 'trusty',
#  repos       => 'main',
#  key         => '4C9D234C',
#  include_deb => true,
#}

#repositorio de drivers ati radeon/nvidia
#Para ati radeon instalar com fglrx

#apt::source {"ubuntu-x-swat":
# comment     => 'Repositorio de drivers ATI',
# location    => 'http://ppa.launchpad.net/ubuntu-x-swat/x-updates/ubuntu',
# release     => 'trusty',
# repos       => 'main',
# key         => 'AF1CDFA9',
# include_src => true,
# include_deb => true,
#require     => Exec["remover_driver_ati"],
#}

#Instalar as funções do teclado Fn do Notebook Samsung
#apt::source {"Module_Samsung":
# comment     => 'Repositorio do Voria para as funções do teclado Fn',
# location    => 'http://ppa.launchpad.net/voria/ppa/ubuntu',
# release     => 'trusty',
# repos       => 'main',
# key         => '1E5F36F0',
# include_src => true,
# include_deb => true,
#}

#Comandos para atualizar as configurações do driver da ATI
#exec {"Configurando Driver ATI":
#  command   => "amdconfig --initial",
#  path      => "/usr/bin/",
#  require   => Package['pacotes'],
#}

#Colocando o repositorio do Google Chrome no sources.list.d
exec {"instalar google chrome" :
 command => "sh -c 'echo \"deb http://dl.google.com/linux/chrome/deb/ stable main\" > /etc/apt/sources.list.d/google-chrome.list'",
 path    => "/bin/" 
}

#Atualizar lista de repositório
exec { "apt-get update":
 path => "usr/sbin:/usr/bin:/sbin:/bin",
 }

exec { "/usr/bin/apt-get update": }

#lista de pacotes
$pacotes = ["whois", "traceroute", "ipython", "ipython3", "idle-python3.4", "strace", "zim", "git",
            "lynx", "terminator", "ubuntu-restricted-extras",
            "vim", "cdbs", "fakeroot", "build-essential",
            "dh-make", "debconf", "execstack", "dh-modaliases",
            "debhelper", "dkms", "libqtgui4", "libstdc++6", "libelfg0", "unzip",
            "google-chrome-stable", "lib32gcc1", "aptitude", 
            "virtualbox", "virtualbox-guest-additions-iso", "indicator-cpufreq",
            "unity-tweak-tool", "gnome-clocks", "mysql-workbench"]

            #"fglrx", "fglrx-amdcccle"

package { $pacotes:
  ensure => "installed", 
}

#Forçar a instalação
exec { "apt-get -f install ":
 path => "usr/sbin:/usr/bin:/sbin:/bin",
 }

exec { "/usr/bin/apt-get -f install": }
