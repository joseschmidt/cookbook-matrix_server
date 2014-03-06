# encoding: utf-8

# cookbook:: ohai
if defined?(ChefSpec)
  def reload_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:ohai, :reload, resource_name)
  end # def

end # if
