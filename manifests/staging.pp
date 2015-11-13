# backwards compatibility with staging:
class puppetarchive::staging (
  $path  = $puppetarchive::params::path,
  $owner = $puppetarchive::params::owner,
  $group = $puppetarchive::params::group,
  $mode  = $puppetarchive::params::mode,
) inherits puppetarchive::params {
  include '::puppetarchive'

  if !defined(File[$path]) {
    file { $path:
      ensure => directory,
      owner  => $owner,
      group  => $group,
      mode   => $mode,
    }
  }
}

