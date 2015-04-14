#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2011, Bryan W. Berry
#
# license Apache v2.0
#

# Install unzip 

package "unzip" do
   action :install
end


jboss_home = node['jboss']['deploy_dir']
jboss_user = node['jboss']['jboss_user']


tarball_name = node['jboss']['deploy_url'].
split('/')[-1].
sub!('.zip', '')
path_arr = jboss_home.split('/')
path_arr.delete_at(-1)
jboss_parent = path_arr.join('/')


# get files
bash "put_files" do
 code <<-EOH
 cd /tmp
 wget #{node['jboss']['deploy_url']}
 unzip #{tarball_name}.zip -d #{jboss_home}
 chown -R jboss:jboss #{jboss_home}
 rm -f #{tarball_name}.zip
EOH

end

