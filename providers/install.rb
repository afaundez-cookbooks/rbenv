action :install do

  user_root = (new_resource.user == 'root') ? '/root' : "/home/#{new_resource.user}"

  bash "rbenv install #{new_resource.name}" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "rbenv install #{new_resource.name} && rbenv rehash"
    environment  ({'HOME' => user_root})
    not_if "ls #{user_root}/.rbenv/versions | grep #{new_resource.name}"
  end

  bash "rbenv versions #{new_resource.name} check" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "rbenv versions | grep #{new_resource.name}"
    environment  ({'HOME' => user_root})
  end

end
