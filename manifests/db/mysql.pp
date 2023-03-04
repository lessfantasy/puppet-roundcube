# crate a mysql db for roundcube
#
# @param dbname
#   the name of the database
# @param dbuser
#   db user
# @param dbpass
#   password for the user
# @param host
#   database host
#
class roundcube::db::mysql (
  $dbname = $roundcube::db::dbname,
  $dbuser = $roundcube::db::dbuser,
  $dbpass = $roundcube::db::dbpass,
  $host   = $roundcube::db::host,
) inherits roundcube::db {
  mysql::db { $dbname :
    user     => $dbuser,
    password => $dbpass,
    host     => $host,
    grant    => ['ALTER', 'CREATE', 'SELECT', 'INSERT', 'UPDATE', 'DELETE'],
  }
}
