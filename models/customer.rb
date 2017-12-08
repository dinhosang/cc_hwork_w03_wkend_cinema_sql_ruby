require_relative('../db/sql_runner')
require_relative('film')
require_relative('ticket')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options_hash)
    @id = options_hash['id'].to_i if options_hash['id']
    @name = options_hash['name']
    @funds = options_hash['funds'].to_i
  end


  def save()
    sql = "
    INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id;
    "
    values = [@name, @funds]
    id_hash = SqlRunner.run(sql, values).first
    @id = id_hash['id'].to_i
  end


  def update()
    sql = "
    UPDATE customers
    SET (name, funds) = ($1, $2)
    WHERE id = $3;
    "
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM customers WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end


  def films()
    sql = "
    SELECT DISTINCT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    INNER JOIN customers
    ON tickets.customer_id = customers.id
    WHERE customers.id = $1;
    "
    film_hashes = SqlRunner.run(sql, [@id])
    return Film.mapper(film_hashes)
  end


  def purchase_ticket(film, time)
    cost = film.price
    if cost <= funds
      if film.availability?
        ticket = Ticket.new({
          'customer_id' => @id,
          'film_id' => film.id,
          'film_time' => time
          })
        ticket.save()
        @funds -= cost
        update()
        return ticket
      else
        return "Sorry, it's booked up"
      end
    end
    return "Sorry, not enough funds"
  end


  def ticket_count()
    sql = "
    SELECT COUNT(*) FROM tickets
    WHERE tickets.customer_id = $1;
    "
    count_hash = SqlRunner.run(sql, [@id])[0]
    return count_hash['count'].to_i
  end


  def Customer.mapper(c_hashes)
    customers = c_hashes.map do |c_hash|
      Customer.new(c_hash)
    end
    return customers
  end


  def Customer.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end


end
