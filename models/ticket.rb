require_relative('../db/sql_runner')
require_relative('./customer.rb')
require_relative('./film.rb')

attr_accessor(:customer_id, :film_id)
attr_reader(:id)

class Ticket

  def initialize(options)
    @id = options['id']to_i() if options['id']
    @customer_id = options['customer_id'].to_i()
    @film_id = options['film_id'].to_i()
  end

end
