name             'mandrel'
maintainer       'Will Drew'
maintainer_email 'willdrew@gmail.com'
license          'MIT'
description      'Provides a Chef LWRP for the python-mandrel pip'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

recipe "mandrel::_install", "This recipe is used to install the mandrel (python pip)"
recipe "mandrel::default", "This (driver) recipe is used to call the _install recipe"
recipe "mandrel::default_test", "This recipe is strictly intended for testing the mandrel's default resource"
recipe "mandrel::pylog_test", "This recipe is strictly intended for testing the mandrel's pylog resource"

depends          'python'
