require_relative('../db/sql_runner')


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options_hash)
    @id = options_hash['id'].to_i if options_hash['id']
    @customer_id = options_hash['customer_id'].to_i
    @film_id = options_hash['film_id'].to_i
  end


  def save()
    sql = "
    INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2)
    RETURNING id;
    "
    values = [@customer_id, @film_id]
    id_hash = SqlRunner.run(sql, values).first
    @id = id_hash['id'].to_i
  end


  def update()
    sql = "
    UPDATE tickets
    SET (customer_id, film_id) = ($1, $2)
    WHERE id = $3;
    "
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM tickets WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end


  def Ticket.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end


end
