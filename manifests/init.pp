#
# Paramters:
#   $ensure_database
#     if true a database is created
#     Defaults to false
#   $ensure_vhost
#     if true a virtualhost is created
#     Defaults to false
#
class roundcube(
  Boolean $ensure_database = false,
  Boolean $ensure_vhost    = false,
) inherits roundcube::params {

  Package<|tag == 'roundcube-packages'|> -> Class['roundcube::config']

  if $ensure_database {
    include ::roundcube::db
  }

  if $ensure_vhost {
    include ::roundcube::vhost
  }

  include ::roundcube::install
  include ::roundcube::config

  Class['roundcube::install'] -> Class['roundcube::config']
}
