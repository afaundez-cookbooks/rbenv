action :install do

  user_root = (new_resource.user == 'root') ? '/root' : "/home/#{new_resource.user}"
  rbenv_root = "#{user_root}/.rbenv"

  execute "git clone git://github.com/sstephenson/rbenv.git #{rbenv_root}" do
    not_if "ls #{rbenv_root}"
    user new_resource.user
    group new_resource.user
  end

  plugins =[
    ['sstephenson', 'rbenv-vars'],
    ['sstephenson', 'ruby-build'],
    ['sstephenson', 'rbenv-default-gems'],
    ['sstephenson', 'rbenv-gem-rehash'],
    ['fesplugas', 'rbenv-installer'],
    ['fesplugas', 'rbenv-bootstrap'],
    ['rkh', 'rbenv-update'],
    ['rkh', 'rbenv-whatis'],
    ['rkh', 'rbenv-use'],
  ]

  plugins.each do |user, repo|
    rbenv_plugin_root = "#{rbenv_root}/plugins/#{repo}"
    execute "git clone git://github.com/#{user}/#{repo}.git #{rbenv_plugin_root}" do
      not_if "ls #{rbenv_plugin_root}"
      user new_resource.user
    group new_resource.user
    end
  end

  bash "Add rbenv to the top of bashrc for user #{new_resource.user}" do
    rbenv_line = 'export RBENV_ROOT="${HOME}/.rbenv"; if [ -d "${RBENV_ROOT}" ]; then   export PATH="${RBENV_ROOT}/bin:${PATH}";   eval "$(rbenv init -)"; fi; # RBENV SOURCE COOKBOOK'
    not_if "grep 'RBENV SOURCE COOKBOOK' #{user_root}/.bashrc"
    cwd user_root
    code <<-BASHCODE
    cp .bashrc .bashrc.rbenv.old
    echo '#{rbenv_line}' > .bashrc
    cat .bashrc.rbenv.old >> .bashrc
    BASHCODE
    user new_resource.user
    group new_resource.user
  end

  bash "rbenv check" do
    user new_resource.user
    group new_resource.user
    flags '-l'
    code "rbenv version"
    environment  ({'HOME' => user_root})
  end

end