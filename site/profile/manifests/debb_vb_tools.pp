class profile::debb_vb_tools {
  package { "linux-headers-${kernelrelease}":
    ensure => installed,
  }
  package { 'build-essential':
    ensure => installed,
  }
  package { 'dkms':
    ensure => installed,
  } 
}