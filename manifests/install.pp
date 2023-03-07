# @summary install roundcube packages
# 
# @param packages
#   the packages to install
# @param package_ensure
#   what to ensure for packages
#
class roundcube::install (
  Array  $packages       = ['roundcube'],
  String $package_ensure = 'installed',
) {
  ensure_packages($packages, {
      ensure => $package_ensure,
      tag    => 'roundcube-packages',
  })
}
