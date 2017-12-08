require_relative('../db/sql_runner')


class Ticket

  attr_reader :id

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


end
