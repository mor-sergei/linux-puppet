class profile::deb_base {
  package { 'gcc':
    ensure => installed,
  }
  package { 'make':
    ensure => installed,
  }
  package { 'cmake':
    ensure => installed,
  }
  package { 'zip':
    ensure => installed,
  }
}