require 'rubygems'
require 'dm-core'
require 'dm-aggregates'

DataMapper.setup(:default, :adapter => 'mysql',
                  :username => 'root',
                  :password => 'even-fish',
                  :database => 'payroll')
class Employee
  include DataMapper::Resource

  property :id,       Serial
  property :emp_id,   Integer
  property :name,     String
  property :address,  Text
end
Employee.auto_migrate!
