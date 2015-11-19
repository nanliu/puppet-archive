# archive parameters
class archive::params {
  case $::osfamily {
    default: {
      $path  = '/opt/staging'
      $owner = '0'
      $group = '0'
      $mode  = '0640'
    }
    'Windows': {
      $path               = $::staging_windir
      $owner              = 'S-1-5-32-544' # Adminstrators
      $group              = 'S-1-5-18'     # SYSTEM
      $mode               = '0640'
      $seven_zip_name     = '7zip'
      $seven_zip_provider = 'chocolatey'
    }
  }

# from https://tickets.puppetlabs.com/browse/MODULES-2279
  if $aio_agent_version {
      # the master version is irrelevant here, all AIO agents will use this
      $gem_provider = 'puppet_gem'
  }
  elsif str2bool($is_pe) and $::osfamily != 'Windows' {
      $gem_provider = 'pe_gem'
  }
  else {
      $gem_provider = 'gem'
  }

}
