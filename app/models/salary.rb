require 'rubygems'
require 'dm-core'
require 'dm-aggregates'
require 'dm-types'
require 'app/models/employee'

DataMapper.setup(:default, :adapter => 'mysql',
                  :username => 'root',
                  :password => 'even-fish',
                  :database => 'payroll')
class Salary
  include DataMapper::Resource

  property :id,             Serial
  property :pay_rate,       Float
  property :commission,     Float
  property :compensation,  Enum['monthly','hourly']
  property :type,           Discriminator

  belongs_to :employee
end
