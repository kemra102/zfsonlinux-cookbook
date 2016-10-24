property :name, String, required: true, name_property: true
property :vdevs, Array, required: false, default: []

default_action :create

# Required because 'name' is namespaced and we want to pass in the name
# of the zpool resource to the resources that underly it
def real_name
  name
end

action :create do
  if vdevs.empty?
    Chef::Application.fatal!('When creating a zpool you must supply the vdevs
      that are a part of that pool!', 1)
  end

  execute "create #{real_name}" do
    command "zpool create #{real_name} #{vdevs.join}"
    not_if "zpool status -x #{real_name}"
  end
end

action :destroy do
  execute "destroy #{real_name}" do
    command "zpool destroy #{real_name}"
    only_if "zpool status -x #{real_name}"
  end
end
