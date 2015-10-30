# Change Log

## 1.1.6 - 2015-10-30
### Fixed
- gem install was failing when user had more than one version of ruby, fix not_if check

## 1.1.5 - 2015-08-06
### Fixed
- 1.8.7 install patch

## 1.1.4 - 2015-08-06
### Added
- recommended packages
### removed
- remove unnecessary log line

## 1.1.3 - 2015-08-06
### Fixed
- debug line messing up last centos patch

## 1.1.2 - 2015-08-06
### Fixed
- miss bump version

## 1.1.1 - 2015-08-06
### Fixed
- centos compatibility path for ruby build and <=2.0.0p247 versions

## 1.1.0 - 2015-08-06
### Added
- Centos compatibility

## 1.0.0 - 2015-08-05
### Changed
- Using resource name as relevant parameter
## Refactor
These changes are not backward compatible
- more checks after install or upgrading rbenv, ruby and gems
- using rbenv shell instead rbenv local
- more expressive bash names, avoiding collisions
- rename gem update to gem upgrade
- using git resource instead raw git clone

## [0.1.0] - 2015-03-09
### Added
Initial release of rbenv. Now you can
- install rbenv command for a single user
- install a ruby version using rbenv
- install a gem for a ruby version using rbenv
