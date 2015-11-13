# download from go
define puppetarchive::go (
  $server,
  $port,
  $url_path,
  $md5_url_path,
  $username,
  $password,
  $path         = $name,
  $owner        = undef,
  $group        = undef,
  $mode         = undef,
  $archive_path = undef,
  $ensure       = present,
  $extract      = undef,
  $extract_path = undef,
  $creates      = undef,
  $cleanup      = undef,
) {

  include puppetarchive::params

  if $archive_path {
    $file_path = "${archive_path}/${name}"
  } else {
    $file_path = $path
  }

  validate_absolute_path($file_path)

  $go_url = "http://${server}:${port}"
  $file_url = "${go_url}/${url_path}"
  $md5_url = "${go_url}/${md5_url_path}"

  puppetarchive { $file_path:
    ensure        => $ensure,
    path          => $file_path,
    extract       => $extract,
    extract_path  => $extract_path,
    source        => $file_url,
    checksum      => go_md5($username, $password, $name, $md5_url),
    checksum_type => 'md5',
    creates       => $creates,
    cleanup       => $cleanup,
    username      => $username,
    password      => $password,
  }

  $file_owner = pick($owner, $puppetarchive::params::owner)
  $file_group = pick($group, $puppetarchive::params::group)
  $file_mode  = pick($mode, $puppetarchive::params::mode)

  file { $file_path:
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
    require => Archive[$file_path],
  }
}
