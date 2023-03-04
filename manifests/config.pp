# @summary roundcube configuration
#
# @param config_file
#   configuration file to use
# @param configs
#   Hash of configuration variables to set.
#   Defaults to {}
# @param owner
#   owner of the config file
#   Defaults to $roundcube::params::config_owner
# @param group
#   group of the config file
#   Defaults to $roundcube::params::config_group
# @param mode
#   mode of the config file
#   Defaults to $roundcube::params::config_mode
# @param include_db_config
# @param plugins
#   plugings with configuration to generate
#   (uses create_resources for roundcube::plugin
#    define, simplifies hiera usage !)
# @param plugin_config_dir
#   the default config directory to use for plugins
#   only used if roundcube::config::plugins parameter
#   is used
#
class roundcube::config (
  String $config_file       = $roundcube::params::config_file,
  Hash   $configs           = {},
  String $owner             = $roundcube::params::config_owner,
  String $group             = $roundcube::params::config_group,
  String $mode              = $roundcube::params::config_mode,
  String $include_db_config = $roundcube::params::include_db_config,
  Hash   $plugins           = {},
  String $plugin_config_dir = $roundcube::params::plugin_config_dir,
) inherits roundcube::params {
  file { $config_file:
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => epp('roundcube/config.epp', {
        configs           => $configs,
        include_db_config => $include_db_config,
        plugins           => $plugins.keys,
    }),
  }

  $plugin_default = {
    plugin_config_dir => $plugin_config_dir,
  }

  ensure_resources('roundcube::plugin', $plugins, $plugin_default)
}
