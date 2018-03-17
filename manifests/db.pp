# Parameters:
# $dbpass
#   password to connect to the database.
# $dbtype
#   database type to use currently only mysql is
#   supported. 
#   defaults to 'mysql'
# $dbname
#   name of the database
#   defaults to: 'roundcube'
# $dbuser
#   username to connect to the database.
#   defaults to: 'roundcube'
# $basepath
#   basepath for database, defaults to ''
# $dbport
#   port to connect to db defaults to '3306' (mysql)
# $host
#   host that is allowed to connect
#   defaults to 'localhost'
# $dbconfig_inc
#   where to write the db config.
#   defaults to '/etc/roundcube/debian-db.php'
#   if you do not want to write, set it to ''
#
class roundcube::db (
  String $dbpass       = 'CHANGEME',
  String $dbtype       = 'mysql',
  String $dbname       = 'roundcube',
  String $dbuser       = 'roundcube',
  String $host         = 'localhost',
  String $basepath     = '',
  String $dbport       = '3306',
  String $dbconfig_inc = '/etc/roundcube/debian-db.php',
){

  case $dbtype {
    'mysql': { include ::roundcube::db::mysql }
    default: { fail("Database '${dbtype}' is not supported") }
  }

  if $dbconfig_inc != '' {
    file { $dbconfig_inc:
      owner   => 'root',
      group   => 'www-data',
      mode    => '0640',
      content => epp('roundcube/dbconfig.inc.epp', {
        dbpass   => $dbpass,
        dbtype   => $dbtype,
        dbname   => $dbname,
        dbuser   => $dbuser,
        host     => $host,
        basepath => $basepath,
        dbport   => $dbport,
      }),
    }
  }
}
