property :name, String, required: true, name_property: true
property :properties, Hash, required: false
property :remove_children, [TrueClass, FalseClass], required: false, default: false # rubocop:disable Metrics/LineLength

default_action :create

# Required because 'name' is namespaced and we want to pass in the name
# of the zpool resource to the resources that underly it
def dataset
  name
end

# Confirm we have a valid name before continuing
if name =~ %r{ /.*(\/.+)+/ }
  Chef::Application.fatal!('Resource name must be a valid zpool/dataset format', 1) # rubocop:disable Metrics/LineLength
end

action :create do
  execute "create dataset: #{dataset}" do
    command "zfs create #{dataset}"
    only_if "zpool status -x #{dataset.split('/')[0]}"
  end

  properties.each_pair do |property, value|
    execute "set property: #{property}=#{value} on #{dataset}" do
      command "zfs set #{property}=#{value} #{dataset}"
      not_if "test $(zfs get #{property} #{dataset} | tail -n +2 | awk '{ print $3 }') = #{value}" # rubocop:disable Metrics/LineLength
    end
  end
end

action :destroy do
  execute "destroy dataset: #{dataset}" do
    command "zfs destroy #{dataset}"
    only_if "zfs list #{dataset}"
  end
end
