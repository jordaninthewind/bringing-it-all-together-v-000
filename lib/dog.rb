class Dog
attr_accessor :name, :breed
attr_reader :id

  def initialize(hash, id=nil)
    @name = hash[:name]
    @breed = hash[:breed]
    @id = id
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

end
