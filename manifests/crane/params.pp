# Default params for Crane
class pulp::crane::params {
  $fqdn = $::fqdn
  $port = 5000
  $key = undef
  $cert = undef
  $ca_cert = undef
}
