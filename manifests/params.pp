# Pulp Master Params
# Private class
class pulp::params {
  $version = 'installed'

  $db_name = 'pulp_database'
  $db_seeds = 'localhost:27017'
  $db_username = undef
  $db_password = undef
  $db_replica_set = undef
  $db_ssl = false
  $db_ssl_keyfile = undef
  $db_ssl_certfile = undef
  $db_verify_ssl = true
  $db_ca_path = '/etc/pki/tls/certs/ca-bundle.crt'

  $server_name = downcase($::fqdn)
  $key_url = '/pulp/gpg'
  $ks_url = '/pulp/ks'
  $default_login = 'admin'
  $default_password = cache_data('pulp_password', random_password(32))
  $debugging_mode = false
  $log_level = 'INFO'

  $rsa_key = '/etc/pki/pulp/rsa.key'
  $rsa_pub = '/etc/pki/pulp/rsa_pub.key'

  $consumers_ca_cert = '/etc/pki/pulp/ca.crt'
  $consumers_ca_key = '/etc/pki/pulp/ca.key'
  $ssl_ca_cert = '/etc/pki/pulp/ssl_ca.crt'
  $user_cert_expiration = 7
  $consumer_cert_expiration = 3650
  $serial_number_path = '/var/lib/pulp/sn.dat'

  $consumer_history_lifetime = 180
  $oauth_enabled = true
  $oauth_key = 'pulp'
  $oauth_secret = 'secret'

  $messaging_url = "tcp://${::fqdn}:5672"
  $messaging_transport = 'qpid'
  $messaging_auth_enabled = true
  $messaging_ca_cert = undef
  $messaging_client_cert = undef
  $messaging_topic_exchange = 'amq.topic'
  $broker_url = "qpid://${::fqdn}:5672"
  $broker_use_ssl = false

  $email_host = 'localhost'
  $email_port = 25
  $email_from = "no-reply@${::domain}"
  $email_enabled = false

  $consumers_crl = undef

  $repo_auth = false
  $enable_http = false
  $ssl_verify_client = 'require'
  $db_manage = false
  $broker_manage = false
  $reset_data = false
  $reset_cache = false

  $proxy_url = undef
  $proxy_port = undef
  $proxy_username = undef
  $proxy_password = undef

  $num_workers = min($::processorcount, 8)

  $enable_rpm = true
  $enable_docker = false
  $enable_puppet = false
  $enable_parent_node = false
  $enable_child_node = false

  $node_parent_host = $::fqdn
  $node_certificate = '/etc/pki/pulp/nodes/node.crt'
  $node_verify_ssl = true
  $node_server_ca_cert = '/etc/pki/pulp/ca.crt'
  $node_oauth_effective_user = 'admin'
  $node_oauth_key = 'pulp'
  $node_oauth_secret = 'secret'

  $osreleasemajor = regsubst($::operatingsystemrelease, '^(\d+)\..*$', '\1')

  case $::osfamily {
    'RedHat' : {
      case $osreleasemajor {
        '6'     : { $pulp_workers_template = 'upstart_pulp_workers' }
        default : { $pulp_workers_template = 'systemd_pulp_workers' }
      }
    }
    default  : {
      fail("${::hostname}: This module does not support osfamily ${::operatingsystem}")
    }
  }

}
