# @summary
#  Manage the hitch service
#
# @api private
class hitch::service (
  String $service_name,
) {

  service { $service_name:
    ensure => running,
    enable => true,
  }

  # configure hitch.service
  $hitch_dropin = @(LIMITS)
  [Service]
  LimitNOFILE=65536
  | LIMITS

  systemd::resources::override { 'limits.conf':
    unit    => $service_name,
    ensure    => present,
    notify  => Service[$service_name],
    overrides => {
      'LimitNOFILE' => 65536
    }
  }
}
