require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')


customer1 = Customer.new({"name" => 'Jasmine', "funds" => 300})
customer1.save()

film1 = Film.new({'title' => 'Zorro', 'price' => 15})
film1.save()


binding.pry
nil
