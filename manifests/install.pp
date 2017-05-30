class art::install inherits art {

  Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
	}

  exec { "art mkdir p ${gpgkeydir}":
    command => "mkdir -p ${gpgkeydir}",
    creates => $gpgkeydir,
  }

  exec { 'art which wget':
    command => 'which wget',
    unless  => 'which wget',
  }

  # $gpg_art_url
  exec { 'wget art gpg':
    command => "wget ${$art::params::gpg_art_url} -O ${gpgkeydir}/RPM-GPG-KEY.art.txt",
    creates => "${gpgkeydir}/RPM-GPG-KEY.art.txt",
    require => Exec[ [ 'art which wget', "art mkdir p ${gpgkeydir}" ] ],
  }

  # $gpg_atomicorp_url
  exec { 'wget atomicorp gpg':
    command => "wget ${$art::params::gpg_atomicorp_url} -O ${gpgkeydir}/RPM-GPG-KEY.atomicorp.txt",
    creates => "${gpgkeydir}/RPM-GPG-KEY.atomicorp.txt",
    require => Exec[ [ 'art which wget', "art mkdir p ${gpgkeydir}" ] ],
  }


  # [atomic]
  # name = CentOS / Red Hat Enterprise Linux $releasever - atomic
  # mirrorlist = http://updates.atomicorp.com/channels/mirrorlist/atomic/centos-$releasever-$basearch
  # enabled = 1
  # protect = 0
  # gpgkey = file:///etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt
  # 	file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atomicorp.txt
  # gpgcheck = 1
  yumrepo { 'atomic':
    ensure     => 'present',
    mirrorlist => 'http://updates.atomicorp.com/channels/mirrorlist/atomic/centos-$releasever-$basearch',
    enabled    => true,
    protect    => false,
    gpgkey     => [ 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.art.txt', 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atomicorp.txt' ],
    gpgcheck   => true,
    require => Exec[ [ 'wget art gpg', 'wget atomicorp gpg' ] ],
  }


}
