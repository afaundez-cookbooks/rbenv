# Change Log

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
