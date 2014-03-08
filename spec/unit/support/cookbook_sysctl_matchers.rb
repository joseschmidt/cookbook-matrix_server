# encoding: utf-8

# cookbook:: sysctl
if defined?(ChefSpec)
  def apply_sysctl_param(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:sysctl_param, :apply, resource_name)
  end # def

  def remove_sysctl_param(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:sysctl_param, :remove, resource_name)
  end # def

end # if
