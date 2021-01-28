#
# @summary the main roundcube class
#
# @param ensure_database
#   if true a database is created
#   Defaults to false
# @param ensure_vhost
#   if true a virtualhost is created
#   Defaults to false
#
class roundcube(
  Boolean $ensure_database = false,
  Boolean $ensure_vhost    = false,
) inherits roundcube::params {

  Package<|tag == 'roundcube-packages'|> -> Class['roundcube::config']
  Class['roundcube::install'] -> Class['roundcube::config']

  if $ensure_database {
    Package<|tag == 'roundcube-packages'|> -> Class['roundcube::db']
    include ::roundcube::db
  }

  if $ensure_vhost {
  Class['roundcube::config'] -> Class['roundcube::vhost']
    include ::roundcube::vhost
  }

  include ::roundcube::install
  include ::roundcube::config
}
