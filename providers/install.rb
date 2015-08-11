action :install do

  user_root = (new_resource.user == 'root') ? '/root' : "/home/#{new_resource.user}"

  patch = case node[:platform]
  when 'centos'
    if Gem::Version.new('1.9.1') <= Gem::Version.new(new_resource.name) && Gem::Version.new(new_resource.name) <= Gem::Version.new('2.0.0-p247')
      'curl -fsSL "https://github.com/ruby/ruby/commit/0d58bb55985e787364b0235e5e69278d0f0ad4b0.patch" | filterdiff -x a/ChangeLog | '
    elsif Gem::Version.new(new_resource.name) < Gem::Version.new('1.9.1')
      'curl -fsSL "https://github.com/ruby/ruby/commit/0d58bb55985e787364b0235e5e69278d0f0ad4b0.patch" | filterdiff -x a/ChangeLog -x a/test/openssl/test_pkey_ec.rb | '
    end
  end

  bash "rbenv install #{new_resource.name}" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "#{patch unless patch.nil?} rbenv install #{'--patch' unless patch.nil?} #{new_resource.name} && rbenv rehash"
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
