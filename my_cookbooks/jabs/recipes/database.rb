# Connection parameters
jabs_connection_info = {
	:host     => '127.0.0.1',
  :username => 'root',
	:password => 'SQLloznika-456'
}

# Create a development database
mysql_database 'jabs_development' do
  connection jabs_connection_info
  action :create
end

# Create a test database
mysql_database 'jabs_test' do
  connection jabs_connection_info
  action :create
end

# Create mysql user jabs
mysql_database_user 'jabs' do
  connection jabs_connection_info
  password   'loznika'
  action     :create
end

# Grant all privileges on jabs_development to jabs
mysql_database_user 'jabs' do
  connection 	jabs_connection_info
  password   	'loznika'
  database_name 'jabs_development'
  host 			'localhost'
  # privileges 	[:all]
  action     	:grant
end

# Grant all privileges on jabs_test to jabs
mysql_database_user 'jabs' do
  connection 	jabs_connection_info
  password   	'loznika'
  database_name 'jabs_test'
  host 			'localhost'
  # privileges 	[:all]
  action     	:grant
end

# Create root user on host machine
mysql_database_user 'root' do
  connection jabs_connection_info
  password   'SQLloznika-456'
  host		 '10.0.0.2'
  action     :create
end

# grant all privileges on all databases/tables for the root@host
mysql_database_user 'root' do
	connection 	jabs_connection_info
	password 	'SQLloznika-456'
	host		'10.0.0.2'
	action		:grant
end
