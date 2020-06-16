# == Class: crypto_policy
#
# crypto-policies - system-wide crypto policies overview.
#
# === Parameters
#
# [*policy_level*]
#   (Enum['default', 'legacy', 'future', 'fips']) The individual policy levels
#   are included in the crypto-policies(7) package. In the future, there will
#   be also a mechanism for easy creation and deployment of policies defined by
#   the system administrator or a third party vendor.
#   Defaults to 'default'
#

class crypto_policy (
  $policy = 'default',
) {
}
