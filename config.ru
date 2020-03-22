require './app/api'
require 'sequel'

#Connect to database if exists
if ENV['DATABASE_URL']
  DB = Sequel.connect(ENV['DATABASE_URL'])
else
  db_url = 'postgres://localhost/reserved_seating'
  DB = Sequel.connect(db_url, user: ENV['DATABASE_USER'], password: ENV['DATABASE_PASSWORD'])
end

Sequel.extension :migration

#Run migrations if exists a database connection
Sequel::Migrator.run(DB, './db/migrations') if DB

# Auto-Load models and transactions
Dir[File.join(File.dirname(__FILE__), 'app/models', '**', '*.rb')].sort.each {|file| require file }
Dir[File.join(File.dirname(__FILE__), 'app/transactions', '**', '*.rb')].sort.each {|file| require file }

App::API.compile!
run App::API