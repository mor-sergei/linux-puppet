node default {}

node 'node1' {
  $osl_name = "${::date} Node 1 ${::osfamily} - ${::fqdn} online ${::uptime}"
  file { '/tmp/online.sig':
    ensure  => file,
    content => $osl_name,
  }
  class { 'role::deb_build_server': require => File['/tmp/online.sig'] }
}
node 'node2' {
  $osl_name = "${::date} Node 2 ${::osfamily} - ${::fqdn} online ${::uptime}"
  file { '/tmp/online.sig':
    ensure  => file,
    content => $osl_name,
  }
  class { 'role::deb_build_server': require => File['/tmp/online.sig'] }
}