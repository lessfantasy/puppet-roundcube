#
class roundcube::params{

  $packages     = ['roundcube']
  $config_file  = '/etc/roundcube/config.inc.php'
  $include_db_config = '/etc/roundcube/debian-db-roundcube.php'
  $config_owner = 'root'
  $config_group = 'www-data'
  $config_mode  = '0640'
  $docroot      = '/var/lib/roundcube'

  $plugin_config_dir = '/etc/roundcube/plugins'

}
