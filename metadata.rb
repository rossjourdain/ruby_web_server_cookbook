name             'ruby_web_server'
maintainer       'Ross Jourdain'
maintainer_email ''
license          'Apache 2.0'
description      'Installs/Configures ruby_web_server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'ubuntu'

depends 'user'
depends 'locale'
depends 'postgresql'
depends 'rbenv'
depends 'passenger_apache2'
depends 'nodejs'
depends 'imagemagick'
