# == Class: crypto_policy
#
# crypto-policies - system-wide crypto policies overview.
#
# === Parameters
#
# [*level*]
#   (Enum['default', 'legacy', 'future', 'fips']) The individual policy levels
#   are included in the crypto-policies(7) package. In the future, there will
#   be also a mechanism for easy creation and deployment of policies defined by
#   the system administrator or a third party vendor.
#   Defaults to 'default'
#

class crypto_policy (
  $level = 'default',
) {
  if ($facts['os']['family'] == 'RedHat' and
  versioncmp($facts['os']['release']['major'],'8') >= 0) {
    $policy_level = $level.upcase()

    package { ['crypto-policies','crypto-policies-scripts']:
      ensure => present,
    } -> file { '/etc/crypto-policies/policies/modules/TLS1.pmod':
      content => 'protocol@TLS = +TLS1.1 +TLS1.0 +DTLS1.0',
      owner   => root,
      group   => root,
      mode    => '0444';
    } ~> exec { 'update-crypto-policies':
      command => "update-crypto-policies --set ${policy_level}",
      unless  => "update-crypto-policies --show | grep -q ^${policy_level}$",
    }
  } else {
    fail("${facts['os']['family']} ${facts['os']['release']['major']} is not supported.")
  }
}
