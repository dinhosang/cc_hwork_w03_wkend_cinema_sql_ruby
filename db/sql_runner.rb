require('pg')


class SqlRunner


  def run(sql, values = [])
    begin
      db = PG.connect(dbname: 'codeclan_cinema.sql', host: 'localhost')
      db.prepare("run", sql)
      result = db.exec_prepare(sql, values)
    ensure
      db.close()
    end
    return result
  end


end
