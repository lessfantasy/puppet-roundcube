#
# internal class that installs an apache vhost
# Parameters are inherited from roundcube::vhost
# 
# @param servername
# @param serveraliases
# @param docroot
# @param apache_vhost
# @param ssl
# @param ssl_cert
# @param ssl_key
# @param ssl_chain
# @param redirect_to_ssl
#
class roundcube::vhost::apache (
  String  $servername      = $roundcube::vhost::servername,
  Array   $serveraliases   = $roundcube::vhost::serveraliases,
  String  $docroot         = $roundcube::vhost::docroot,
  Hash    $apache_vhost    = {},
  Boolean $ssl             = $roundcube::vhost::ssl,
  String  $ssl_cert        = $roundcube::vhost::ssl_cert,
  String  $ssl_key         = $roundcube::vhost::ssl_key,
  String  $ssl_chain       = $roundcube::vhost::ssl_chain,
  Boolean $redirect_to_ssl = $roundcube::vhost::redirect_to_ssl,
) inherits roundcube::vhost {

  include ::apache
  include ::apache::mod::php

  $vhost = {
    $servername => {
      'serveraliases' => $serveraliases,
      'docroot'       => $docroot,
      'ssl'           => $ssl,
      'ssl_cert'      => $ssl_cert,
      'ssl_key'       => $ssl_key,
      'ssl_chain'     => $ssl_chain,
      'port'          => '443',
    },
  }

  create_resources('apache::vhost', $vhost, $apache_vhost)

  if $ssl and $redirect_to_ssl {
    $redir_vhost = {
      "${servername}_nossl" => {
        'servername'      => $servername,
        'serveraliases'   => $serveraliases,
        'docroot'         => $docroot,
        'port'            => 80,
        'redirect_status' => 'permanent',
        'redirect_dest'   => "https://${servername}/",
      },
    }

    create_resources('apache::vhost', $redir_vhost)
  }
}
