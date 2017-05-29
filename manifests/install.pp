class art::install inherits art {

  if($art::manage_package)
  {
    package { $art::params::package_name:
      ensure => $art::package_ensure,
    }
  }

}
