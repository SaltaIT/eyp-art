class art (
            $manage_package = true,
            $package_ensure = 'installed',
            $srcdir         = '/usr/local/src',
            $gpgkeydir      = '/etc/pki/rpm-gpg',
            $version        = '1.0-21',
          ) inherits art::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::art::install': }
  -> class { '::art::config': }
  -> Class['::art']

}
