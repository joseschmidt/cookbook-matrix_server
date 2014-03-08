# encoding: utf-8

# cookbook:: sudo
if defined?(ChefSpec)
  def install_sudoer(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:sudo, :install, resource_name)
  end # def

end # if
