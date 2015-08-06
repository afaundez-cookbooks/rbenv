actions :install, :update
default_action :install

attribute :user, :kind_of => String, :required => true
attribute :ruby_version, :kind_of => String, :required => true
attribute :name, :kind_of => String, :name_attribute => true
attribute :gem_version, :kind_of => String, :default => ''
attribute :rubygems_version, :kind_of => String
attribute :source, :kind_of => String
