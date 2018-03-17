
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
