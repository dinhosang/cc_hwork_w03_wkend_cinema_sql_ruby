require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')


Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({"name" => 'Jasmine', "funds" => 300})
customer1.save()
customer2 = Customer.new({'name' => 'James', 'funds' => 200})
customer2.save()

film1 = Film.new({'title' => 'Zoro the real movie', 'price' => 15, 'times' => ['09:00:00', '11:00:00', '12:00:00']})
film1.save()
film2 = Film.new({'title' => 'Pokemon the Movie', 'price' => 30, 'times' => ['11:00:00', '14:00:00']})
film2.save()
film3 = Film.new({'title' => 'Digimon', 'price' => 200, 'times' => ['18:00:00']})
film3.save()


customer1.funds = 233
customer2.name = 'Jam'


ticket1 = customer1.purchase_ticket(film3, '18:00:00')
ticket2 = customer1.purchase_ticket(film3, '18:00:00')

customer2.funds = 1000

ticket3 = customer2.purchase_ticket(film3, '18:00:00')
ticket4 = customer2.purchase_ticket(film2, '14:00:00')
ticket5 = customer2.purchase_ticket(film2, '14:00:00')
ticket6 = customer2.purchase_ticket(film2, '11:00:00')
ticket7 = customer2.purchase_ticket(film2, '11:00:00')
ticket8 = customer2.purchase_ticket(film1, '09:00:00')
ticket9 = customer2.purchase_ticket(film1, '12:00:00')

blah = film2.busiest_time
binding.pry

film2.price = 30
film1.title = 'Zorro'

ticket3.update({'customer_id' => customer1.id})
ticket10 = customer2.purchase_ticket(film1, '11:00:00')
result_update10a = ticket10.update({'film' => film2})
result_update10a = ticket10.update({'film' => film3, 'time' => '18:00:00'})
result_update10b = ticket10.update({'film' => film3})
result_update10c = ticket10.update({'film' => film3, 'time' => '11:00:00'})
result_update10d = ticket10.update({'time' => '19:00:00'})

binding.pry
result_update10a = ticket10.update({'film' => film3, 'time' => '18:00:00'})
binding.pry

result_change = customer2.change_ticket(ticket10, {'film' => film1, 'time' => '12:00:00', 'customer_id' => customer1.id})
result_change2 = customer2.change_ticket(ticket10, {'film' => film3, 'time' => '15:00:00', 'customer_id' => customer1.id})

binding.pry

customer1.update()
customer2.update()
film2.update()
film1.update()


binding.pry


customer2.delete()
film1.delete()
ticket3.delete()


binding.pry
nil
