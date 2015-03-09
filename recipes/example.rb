include_recipe 'rbenv'

rbenv_source 'install rbenv for user vagrant' do
  user 'vagrant'
end

rbenv_install 'rbenv install ruby 2.2.1 for user vagrant' do
  user 'vagrant'
  ruby_version '2.2.1'
end

rbenv_gem 'install bundler to ruby 2.2.1 installed with rbenv for user vagrant' do
  user 'vagrant'
  ruby_version '2.2.1'
  gem_name 'bundler'
end
