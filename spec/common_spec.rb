require 'spec_helper'

describe 'network::common' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should provide network resource (action: nothing)' do
    # work around chefspec's inability to verify action :nothing
    # would prefer to use the following:
    #   expect(chef_run).to nothing_service('network')
    expect(chef_run).to_not disable_service('network')
    expect(chef_run).to_not enable_service('network')
    expect(chef_run).to_not reload_service('network')
    expect(chef_run).to_not restart_service('network')
    expect(chef_run).to_not start_service('network')
    expect(chef_run).to_not stop_service('network')
  end # it

end # describe
