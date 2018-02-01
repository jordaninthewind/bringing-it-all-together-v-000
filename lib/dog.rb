class Dog
attr_accessor :name, :breed
attr_reader :id

  def initialize(hash, id = nil)
    @name = hash[:name]
    @breed = hash[:breed]
    @id = hash[:id]
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name VARCHAR(25),
        breed VARCHAR(25)
      )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE dogs;")
  end

  def save
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs").flatten[0]
    return self
  end

  def update
    sql = <<-SQL
      UPDATE dogs SET name = ?, breed = ? WHERE id = ?;
    SQL

    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

  def self.create(dog_hash)
    dog = self.new(dog_hash)
    dog.save
    dog
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    result = DB[:conn].execute(sql, id)[0]
    dog_hash = {id: result[0], name: result[1], breed: result[2]}
    self.new(dog_hash)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM dogs WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    dog_hash = {id: result[0], name: result[1], breed: result[2]}
    self.new(dog_hash)
  end

  def self.find_or_create_by(name, breed)
    dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed).flatten
    binding.pry
    if !dog.empty?
      dog_hash = {id: dog[0], name: dog[1], breed: dog[2]}
      dog = Dog.new(dog_data[0], song_data[1], song_data[2])
    else
      song = self.create(name: name, album: album)
    end
    song
  end

  def self.new_from_db

  end
end
