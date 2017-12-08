require_relative('../db/sql_runner')


class Customer

  attr_reader :id

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


end
