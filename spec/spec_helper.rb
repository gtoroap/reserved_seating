# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'sequel'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  #enable database
  db_url = 'postgres://localhost/reserved_seating_test'
  DB = Sequel.connect(db_url, user: ENV['DATABASE_USER'], password: ENV['DATABASE_PASSWORD'])

  Sequel.extension :migration
  Sequel::Migrator.run(DB, './db/migrations') if DB

  config.around(:each) do |example|
    DB.transaction(:rollback=>:always, :auto_savepoint=>true){example.run}
  end

  Dir[File.join(File.dirname(__FILE__), '..', 'app', 'models', '**', '*.rb')].sort.each {|file| require file }
  Dir[File.join(File.dirname(__FILE__), '..', 'app', 'transactions', '**', '*.rb')].sort.each {|file| require file }
end
