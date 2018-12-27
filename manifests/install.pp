# @summary Installs InfluxDB components.
#
# Installs InfluxDB components.
#
# @api private
class puppet_metrics_dashboard::install {
  package { 'influxdb':
    ensure  => present,
    require => Class['puppet_metrics_dashboard::repos'],
  }

  $_chronograf_ensure = $puppet_metrics_dashboard::enable_chronograf ? {
    true    => present,
    default => absent
  }

  $_kapacitor_ensure = $puppet_metrics_dashboard::enable_kapacitor ? {
    true    => present,
    default => absent
  }

  package { 'kapacitor':
    ensure  => $_kapacitor_ensure,
    require => Class['puppet_metrics_dashboard::repos'],
  }

  package { 'chronograf':
    ensure  => $_chronograf_ensure,
    require => Class['puppet_metrics_dashboard::repos'],
  }
}
