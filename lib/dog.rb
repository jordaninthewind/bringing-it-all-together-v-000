class Dog
attr_accessor :name, :breed
attr_reader :id

  def initialize(id=nil, name, breed)
    @id = id
    @name = name
    @breed = breed
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

end
