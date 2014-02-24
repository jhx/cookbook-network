# encoding: utf-8
if defined?(ChefSpec)
  # cookbook:: simple_iptables
  # rubocop:disable AccessorMethodName
  def set_iptables_chain(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:simple_iptables_policy, :set, resource_name)
  end # def
  # rubocop:enable AccessorMethodName

  # cookbook:: simple_iptables
  def append_iptables_rule(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:simple_iptables_rule, :append, resource_name)
  end # def

end # if
