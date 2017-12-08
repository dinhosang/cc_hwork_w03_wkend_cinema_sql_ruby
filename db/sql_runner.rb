require('pg')


class SqlRunner


  def self.run(sql, values = [])
    begin
      db = PG.connect(dbname: 'codeclan_cinema', host: 'localhost')
      db.prepare("run", sql)
      result = db.exec_prepared("run", values)
    ensure
      db.close()
    end
    return result
  end


end
