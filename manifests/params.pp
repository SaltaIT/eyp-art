class art::params {

  $package_name='art'

  $gpg_art_url='https://www.atomicorp.com/RPM-GPG-KEY.art.txt'
  $gpg_atomicorp_url='https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt'

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^7.*$/:
        {
          $atomic_repo='http://updates.atomicorp.com/channels/atomic/redhat/7/x86_64/RPMS/atomic-release-${art::version}.el7.art.noarch.rpm'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    # 'Debian':
    # {
    #   case $::operatingsystem
    #   {
    #     'Ubuntu':
    #     {
    #       case $::operatingsystemrelease
    #       {
    #         /^14.*$/:
    #         {
    #         }
    #         /^16.*$/:
    #         {
    #         }
    #         default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
    #       }
    #     }
    #     'Debian': { fail('Unsupported')  }
    #     default: { fail('Unsupported Debian flavour!')  }
    #   }
    # }
    default: { fail('Unsupported OS!')  }
  }
}
