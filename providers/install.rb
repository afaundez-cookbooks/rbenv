action :install do

  user_root = (new_resource.user == 'root') ? '/root' : "/home/#{new_resource.user}"

  bash "install ruby #{new_resource.ruby_version} with rbenv for user #{new_resource.user}" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "rbenv install #{new_resource.ruby_version} && rbenv rehash"
    environment  ({'HOME' => user_root})
    not_if "ls #{user_root}/.rbenv/versions | grep #{new_resource.ruby_version}"
  end

end
