# install packages
class roundcube::install (
  Array  $packages            = $roundcube::params::packages,
  String $package_ensure      = 'installed',
) inherits roundcube::params {

  $package_default = {
    ensure => $package_ensure,
    tag    => 'roundcube-packages',
  }
  ensure_packages($packages, $package_default)
}
