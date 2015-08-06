include_recipe 'rbenv'

rbenv_source 'vagrant'

rbenv_install '2.2.1' do
  user 'vagrant'
end

rbenv_gem 'bundler' do
  user 'vagrant'
  ruby_version '2.2.1'
end
