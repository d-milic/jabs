mysql_service 'jabs' do
  version '5.7'
  initial_root_password 'SQLloznika-456'# node['mysql_root_password']
  action [:create, :start]
end

mysql_client 'jabs' do
  action :create
end