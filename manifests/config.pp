#
# Paramters:
#   $config_file:
#     configuration file to use
#   $configs: 
#     Hash of configuration variables to set.
#     Defaults to {}
#   $owner:
#     owner of the config file
#     Defaults to $roundcube::params::config_owner
#   $group
#     group of the config file
#     Defaults to $roundcube::params::config_group
#   $mode
#     mode of the config file
#     Defaults to $roundcube::params::config_mode
#   $append_include
#     if set to a file a line
#     include_once($config_file) is appended this is used
#     if you do not want to pverwrite the system config file
#     Defaults to '' (nothing done)
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
    content => epp('roundcube/config.epp',{
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
