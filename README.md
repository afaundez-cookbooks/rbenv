# Rbenv

This cookbook gives you and easy way to install rbenv for a single user

## Supported Platforms

Tested on ubuntu Trusty platforms.

## Attributes

## Usage

```ruby
include_recipe 'rbenv'

rbenv_source 'vagrant'

rbenv_install '2.2.1' do
  user 'vagrant'
end

rbenv_gem 'bundler' do
  user 'vagrant'
  ruby_version '2.2.1'
end
```

## License and Authors

Author:: Álvaro Faúndez (alvaro@faundez.net)
