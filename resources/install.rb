actions :install
default_action :install

attribute :user, :kind_of => String, :required => true, :name_attribute => true
attribute :ruby_version, :kind_of => String, :required => true
