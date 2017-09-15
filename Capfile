# Load DSL and set up stages
require 'capistrano/setup'

require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/passenger'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

# If you are using rvm add these lines:
set :rvm_type, :user
set :rvm_ruby_version, '2.3.3'
