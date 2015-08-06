action :install do
  user_root = (new_resource.name == 'root') ? '/root' : "/home/#{new_resource.name}"
  rbenv_root = "#{user_root}/.rbenv"

  git rbenv_root do
    repository 'git://github.com/sstephenson/rbenv.git'
    revision 'master'
    depth 1
    user new_resource.name
    group new_resource.name
    action :checkout
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
  plugins_root = ::File.join rbenv_root, 'plugins'

  directory plugins_root do
    user new_resource.name
    group new_resource.name
  end

  plugins.each do |user, repo|
    rbenv_plugin_root = ::File.join plugins_root, repo
    git rbenv_plugin_root do
      repository "git://github.com/#{user}/#{repo}.git"
      revision 'master'
      depth 1
      user new_resource.name
      group new_resource.name
      action :checkout
    end
  end

  bash "add rbenv to the top of bashrc for user #{new_resource.name}" do
    rbenv_line = 'export RBENV_ROOT="${HOME}/.rbenv"; if [ -d "${RBENV_ROOT}" ]; then   export PATH="${RBENV_ROOT}/bin:${PATH}";   eval "$(rbenv init -)"; fi; # RBENV SOURCE COOKBOOK'
    cwd user_root
    code <<-BASHCODE
    cp .bashrc .bashrc.rbenv.old
    echo '#{rbenv_line}' > .bashrc
    cat .bashrc.rbenv.old >> .bashrc
    BASHCODE
    user new_resource.name
    group new_resource.name
    not_if "grep 'RBENV SOURCE COOKBOOK' #{user_root}/.bashrc"
  end

  bash "rbenv check" do
    user new_resource.name
    group new_resource.name
    flags '-l'
    code "rbenv version"
    environment  ({'HOME' => user_root})
  end

end
