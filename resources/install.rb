actions :install
default_action :install

attribute :user, :kind_of => String, :required => true
attribute :name, :kind_of => String, :required => true, :name_attribute => true
