include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'
include_recipe 'rbenv::rbenv_vars'

rbenv_ruby '2.3.1' do
	global true
end

rbenv_gem 'bundler' do
	ruby_version '2.3.1'
end

rbenv_gem 'rails' do
	ruby_version '2.3.1'
end

rbenv_gem 'rails_best_practices' do
	ruby_version '2.3.1'
end