require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')

require('pry-byebug')

  customer1 = Customer.new({
    'name' => 'Jesus',
    'funds' => '60'
    })
    customer1.save()
  customer2 = Customer.new({
    'name' => 'Magda',
    'funds' => '80'
    })
    customer2.save()
  customer3 = Customer.new({
    'name' => 'Shaun',
    'funds' => '20'
    })
    customer3.save()



  film1 = Film.new({
    'title' => 'Jurassic World 2',
    'price' => '10.50'
    })
    film1.save()
  film2 = Film.new({
    'title' => 'I feel pretty',
    'price' => '10.50'
    })
    film2.save()
  film3 = Film.new({
    'title' => 'Avengers: Infinity War',
    'price' => '10.50'
    })
    film3.save()



  ticket1 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film1.id
    })
    ticket1.save()
  ticket2 = Ticket.new({
    'customer_id' => customer2.id,
    'film_id' => film2.id
    })
    ticket2.save()
  ticket3 = Ticket.new({
    'customer_id' => customer3.id,
    'film_id' => film2.id
    })
    ticket3.save()



binding.pry
nil
