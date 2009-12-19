require 'rubygems'
require 'dm-core'
require 'dm-aggregates'
require 'app/models/salary'

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

  has 1, :salary
end
