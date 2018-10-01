class profile::debb_wm_tools {
  package { "linux-headers-${kernelrelease}":
    ensure => installed,
  }
  package { 'build-essential':
    ensure => installed,
  }
  package { 'open-vm-tools':
    ensure => installed,
  }
}
