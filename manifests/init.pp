# == Class: crypto_policy
#
# crypto-policies - system-wide crypto policies overview.
#
# === Parameters
#
# [*policy*]
#   (Enum['default', 'legacy', 'future', 'fips']) The individual policy levels
#   are included in the crypto-policies(7) package. In the future, there will
#   be also a mechanism for easy creation and deployment of policies defined by
#   the system administrator or a third party vendor.
#   Defaults to 'default'
#

class crypto_policy (
  $policy = 'default',
) {

  if versioncmp($facts['os']['release']['major'],'8') >= 0 {
    $policy_level = $policy.upcase()
    exec {'update-crypto-policies':
      command => "update-crypto-policies --set ${policy_level}",
      unless  => "update-crypto-policies --show | grep -q ^${policy_level}$",
    }
  }
}
