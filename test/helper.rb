require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'acts_as_nested_by'

class Foo < ActiveRecord::Base; end

class Bar < ActiveRecord::Base; end

class Test::Unit::TestCase
  def self.db_setup    
    @dbfile = File.join(File.dirname(__FILE__),"test.sqlite3")
    ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database  => @dbfile)
    ActiveRecord::Migration.create_table :foos
    ActiveRecord::Migration.create_table :bars do |t| t.references :foo end
  end
  
  def self.db_teardown
    File.delete(@dbfile)
  end
end
