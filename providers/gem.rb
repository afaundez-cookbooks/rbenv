action :install do

  user_root = (new_resource.user == 'root') ? '/root' : "/home/#{new_resource.user}"
  gem_version = (new_resource.gem_version.empty?) ? '' : "-v=#{new_resource.gem_version}"
  source_url = (new_resource.source.nil? or new_resource.source.empty?) ? '' : "--source #{new_resource.source}"

  bash "rbenv ruby #{new_resource.ruby_version} gem install #{new_resource.name} #{gem_version}" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "rbenv shell #{new_resource.ruby_version} && rbenv exec gem install #{gem_version} #{new_resource.name} #{source_url} && rbenv rehash"
    environment  ({'HOME' => user_root})
    # TODO: grep by ruby version
    not_if "ls -R #{user_root}/.rbenv | grep #{new_resource.ruby_version} | grep '/gems/#{new_resource.name}-#{new_resource.gem_version}'"
  end

  grep_version = (new_resource.gem_version.empty?) ? '' : "| grep #{new_resource.gem_version}"
  bash "rbenv ruby #{new_resource.ruby_version} gem #{new_resource.name} #{new_resource.name} #{grep_version} check" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "rbenv shell #{new_resource.ruby_version} && rbenv exec gem list #{new_resource.name} | grep #{new_resource.name} #{grep_version}"
    environment  ({'HOME' => user_root})
  end

end

action :upgrade do

  user_root = (new_resource.user == 'root') ? '/root' : "/home/#{new_resource.user}"

  bash "rbenv ruby #{new_resource.ruby_version} gem upgrade #{new_resource.rubygems_version}" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "rbenv shell #{new_resource.ruby_version} && rbenv exec gem update --system '#{new_resource.rubygems_version}' && rbenv rehash"
    environment  ({'HOME' => user_root})
    not_if "ls -R #{user_root}/.rbenv/versions/#{new_resource.ruby_version} | grep /gems/rubygems-update-#{new_resource.rubygems_version}/"
  end

  bash "rbenv ruby #{new_resource.ruby_version} gem upgrade #{new_resource.rubygems_version} check" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "rbenv shell #{new_resource.ruby_version} && rbenv exec gem --version | grep #{new_resource.rubygems_version}"
    environment  ({'HOME' => user_root})
  end

end
