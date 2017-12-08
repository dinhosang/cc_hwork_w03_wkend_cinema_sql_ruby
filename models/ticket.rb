require_relative('../db/sql_runner')


class Ticket

  attr_reader :id, :film_time
  attr_accessor :customer_id, :film_id

  def initialize(options_hash)
    @id = options_hash['id'].to_i if options_hash['id']
    @customer_id = options_hash['customer_id'].to_i
    @film_id = options_hash['film_id'].to_i
    @film_time = options_hash['film_time'].to_s if options_hash['film_time']
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
    if @film_time != nil
      sql = "
      SELECT screenings.id FROM screenings
      WHERE screenings.film_id = $1 AND screenings.film_time = $2;
      "
      values = [@film_id, @film_time]
      screening_id_hash = SqlRunner.run(sql,values)[0]
      screening_id = screening_id_hash['id'].to_i
      sql = "
      UPDATE tickets SET screening_id = $1
      WHERE id = $2;
      "
      values = [screening_id, @id]
      SqlRunner.run(sql, values)
    end
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


  def Ticket.mapper(t_hashes)
    tickets = t_hashes.map do |t_hash|
      Ticket.new(t_hash)
    end
    return tickets
  end


  def Ticket.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end


end
