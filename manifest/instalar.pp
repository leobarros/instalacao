# Arquivo para instalação de programas e configurações.
#16-08-14
#Autor: Leonardo Barros
  
include apt

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

package { $pacotes:
 ensure => "installed",
}

#Forçar a instalação
exec { "apt-get -f install ":
 path => "usr/sbin:/usr/bin:/sbin:/bin",
 }

exec { "/usr/bin/apt-get -f install": }
