class role::deb_build_server {

  if ($facts['os']['family'] == 'Debian') {
    if ($facts['is_virtual']) {
      notify { "Virtualization detected": }
      if ($facts['boardproductname'] == 'VirtualBox') {
        notify { "VirtualBox detected": }
        include profile::debb_vb_tools
      }
      elsif ($facts['blockdevice_sda_vendor'] == 'VMware') {
        notify { "VMware detected": }
        include profile::debb_wm_tools
      }
      else {
        alert("Getting type of VM failed, vm tools skiped ")
      }
    }

    if ($facts['lsbdistcodename'] == 'jessie') {
    # Debian jessie spec
      notify { "${::lsbdistdescription} distribute": }
      include profile::deb8_bports
      class { 'profile::deb8_openjdk':
        java_version => '8',
        kit_type     => 'jdk',
      }
    }
    elsif ($facts['lsbdistcodename'] == 'stretch') {
    # Debian stretch spec
      notify { "${::lsbdistdescription} distribute": }
    }

    # Debian base packages
    include profile::deb_base

    # Debian configuration change
    include profile::debb_config

    # NTP Service for Debian
    include profile::debb_ntp

    # Python 3 + packages for Debian
    include profile::debb_py3

    # Crontab jobs manager
    # Adding fake insert
    class { 'profile::debb_cron':
      condition  => 'present',
      command    => 'echo "Crontab test execution" > /tmp/cron_exec.log',
      job_hour   => '*/1',
      job_minute => '30',
    }
  }
}
