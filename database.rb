require 'active_record'
require 'rubygems'

#Making DB connection

ActiveRecord::Base.establish_connection(
 :adapter => "mysql2",
 :host => "localhost",
 :database =>"sakila",
 :username =>"root",
 :password => "classic")

class Actor < ActiveRecord::Base
  self.table_name = "actor"
end
