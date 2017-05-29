class art::service inherits art {

  #
  validate_bool($art::manage_docker_service)
  validate_bool($art::manage_service)
  validate_bool($art::service_enable)

  validate_re($art::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${art::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $art::manage_docker_service)
  {
    if($art::manage_service)
    {
      service { $art::params::service_name:
        ensure => $art::service_ensure,
        enable => $art::service_enable,
      }
    }
  }
}
