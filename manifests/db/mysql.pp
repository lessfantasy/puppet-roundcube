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
# @param collate
#   set collate
# @param charset
#   set charset
#
class roundcube::db::mysql (
  String              $dbname  = $roundcube::db::dbname,
  String              $dbuser  = $roundcube::db::dbuser,
  String              $dbpass  = $roundcube::db::dbpass,
  String              $host    = $roundcube::db::host,
  Optional[String[1]] $collate = undef,
  Optional[String[1]] $charset = undef,
) inherits roundcube::db {
  mysql::db { $dbname :
    user     => $dbuser,
    password => $dbpass,
    host     => $host,
    grant    => ['ALTER', 'CREATE', 'SELECT', 'INSERT', 'UPDATE', 'DELETE'],
    collate  => $collate,
    charset  => $charset,
  }
}
