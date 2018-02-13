require('pg')

class Bounty

  attr_reader(:id)
  attr_accessor(:name, :danger_level, :last_known_location, :cashed_in)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @danger_level = options['danger_level']
    @last_known_location = options['last_known_location']
    @cashed_in = options['cashed_in']
  end

  def save()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})

    sql = "
    INSERT INTO bounties
    (
      name,
      danger_level,
      last_known_location,
      cashed_in
    )
    VALUES
    ($1, $2, $3, $4);
    "
    values = [@name, @danger_level, @last_known_location, @cashed_in]
    db.prepare("save", sql)
    db.exec_prepared("save", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})

    sql = "
    UPDATE bounties
    SET
    (
      name,
      danger_level,
      last_known_location,
      cashed_in
    ) =
    ( $1, $2, $3, $4)
    WHERE id = $5;
    "
    values = [@name, @danger_level, @last_known_location, @cashed_in, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})

    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close
  end

  def Bounty.find_by_id(id)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})

    sql = "SELECT * FROM bounties WHERE id = $1;"
    values = [id]
    db.prepare("find_by_id", sql)
    bounties = db.exec_prepared("find_by_id", values)
    db.close
    return bounties.map { |bounty| Bounty.new(bounty) }.first()
  end

  def Bounty.all()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})

    sql = "SELECT * FROM bounties;"
    values = []
    db.prepare("all", sql)
    bounties_hash = db.exec_prepared("all", values)
    db.close
    return bounties_hash.map { |bounty| Bounty.new(bounty) }

  end

  def Bounty.delete_all()
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})

    sql = "DELETE FROM bounties;"
    values = []
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all", values)
    db.close
  end
end
