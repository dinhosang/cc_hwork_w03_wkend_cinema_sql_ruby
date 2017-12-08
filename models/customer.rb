require_relative('../db/sql_runner')


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


  def Customer.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end


end
