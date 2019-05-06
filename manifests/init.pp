class art (
            $manage_package = true,
            $package_ensure = 'installed',
            $srcdir         = '/usr/local/src',
            $gpgkeydir      = '/etc/pki/rpm-gpg',
            $version        = '1.0-21',
          ) inherits art::params{

  class { '::art::install': }
  -> class { '::art::config': }
  -> Class['::art']

}
