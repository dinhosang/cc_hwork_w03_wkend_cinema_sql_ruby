require('pry-byebug')
require_relative('models/customer')


customer1 = Customer.new({"name" => 'Jasmine', "funds" => 300})

binding.pry

customer1.save()


binding.pry
nil
