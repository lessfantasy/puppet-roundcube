# @summary configures plugins
#
# @param plugin_config_dir
#   directory
# @param configs
#   the configurations
# @param plugin_name
#   name of the plugin
# @param owner
#   owner of the config file
# @param group
#  group of the config file
# @param mode
#  mode of the config file
# 
define roundcube::plugin (
  String $plugin_config_dir,
  Hash   $configs     = {},
  String $plugin_name = $title,
  String $owner       = 'root',
  String $group       = 'root',
  String $mode        = '0644',
) {
  if $configs != {} {
    file { "${plugin_config_dir}/${plugin_name}/config.inc.php":
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => epp('roundcube/config_plugin.epp', {
          configs           => $configs,
      }),
      require => Class['roundcube::install'],
    }
  }
}
