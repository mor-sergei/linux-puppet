# Debian 8 time sync system
# Implementation logic:
#  - Shutdown NTP
#  - Set Enable Timesyncd
#  - Set NTP Enable - off 
#  - Upload ntp.conf -. /etc/timesyncd.conf
#  - Set subscription on /etc/timesyncd.conf change
#  - Start Timesyncd Service

class debb_timesyncd {
  $tsync_cfg = 'puppet:///modules/profile/timesyncd.conf'

  service { 'ntp':
    ensure => stopped,
    enable => false,
  }
  file { '/etc/systemd/timesyncd.conf':
    ensure => file,
    source => $tsync_cfg,
    notify => Sevice['systemd-timesyncd'],
  }
  service { 'systemd-timesyncd':
    ensure => running,
    enable => false,
    subscribe => File['/etc/systemd/timesyncd.conf'],
    require => [File['/etc/systemd/timesyncd.conf'], Service['ntp']],
  }
}
