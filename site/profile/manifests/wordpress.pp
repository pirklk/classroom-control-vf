class profile::wordpress {

	# Mysql Server
	class { '::mysql::server':
	  root_password => 'password',
	  remove_default_accounts => true,
	}

	class { '::mysql::bindings' :
		php_enable => true
	}

	# WordPress Config
	package {'wget':
		ensure => present,
	}
	
	# Apache VHost Config
	class { 'apache': 
		default_vhost => false,
	}
	
	include apache::mod::php 
	apache::vhost { $::fqdn:
	  port    => '80',
	  docroot => '/var/www/wordpress',
	}

	
	# Setup Wordpress
	class { '::wordpress': 	
		wp_owner    => 'wordpress',
		wp_group    => 'wordpress',
		wp_proxy_host => 'http://proxy-us.intel.com',
		wp_proxy_port => '911',
		db_user        => 'wordpress',
		db_password    => 'strongpassword2',    		
		install_dir => '/var/www/wordpress',
		require => [
			Package['wget'],
			User['wordpress'],
			Group['wordpress'],
		]
	}

	#Local User for Wordpress
	user { 'wordpress': 
		ensure => present,
	}

	#Local Group for wordpress

	group { 'wordpress': 
		ensure => present,
	}
}

