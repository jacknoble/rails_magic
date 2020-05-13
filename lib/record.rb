# frozen_string_literal: true

require 'sqlite3'

class Record
  def self.table_name
    name.downcase + 's'
  end

  def self.all
    rows = db.execute("select * from #{table_name}")

    rows.map { |r| new(r) }
  end

  def self.find(id)
    new(load_row_from_id(id))
  end

  def self.db
    @db ||= SQLite3::Database.new 'rails_magic.db'
  end

  def self.column_names
    # table_info returns a row for each column
    # The second column is the name, third is the type, fourth not null
    # fifth the default value
    db.execute("PRAGMA table_info(#{table_name})").map { |row| row[1] }
  end

  def initialize(row)
    set_attributes(row)
  end

  attr_accessor :attributes

  def save
    if @attributes["id"]
      row = update_to_db
    else
      row = insert_to_db
    end
  end


  def respond_to_missing(method_name)
    self.class.column_names.include? method_name.to_s
  end

  def method_missing(method_name)
    if self.class.column_names.include? method_name.to_s
      @attributes[method_name.to_s]
    else
      super
    end
  end

  private

  def self.load_row_from_id(id)
    db.execute("select * from #{table_name} where id = ?", id).first
  end

  def set_attributes(row)
    case row
    when Array
      @attributes = self.class.column_names.zip(row).to_h
    when Hash
      @attributes = row
    else
      raise "Argument to Record#new must be array of values or attribute hash"
    end
  end

  def table_name
    self.class.table_name
  end

  def db
    self.class.db
  end

  def insert_to_db
    fields = @attributes.keys.join(",")
    placeholders = (Array("?") * @attributes.count).join(",")

    db.execute("insert into #{table_name} (#{fields}) VALUES (#{placeholders})", @attributes.values)

    # Update attributes with the new id
    last_id = db.execute("SELECT last_insert_rowid()")[0][0]
    row = self.class.load_row_from_id(last_id)
    set_attributes(row)
  end

  def update_to_db
    fields_to_set = @attributes.keys.reject { |f| f == "id" }
    set_sql = fields_to_set.map do |f|
      "#{f} = ?"
    end.join(",")

    args = fields_to_set << attributes["id"]
    self.class.db.execute("update #{table_name} set #{set_sql} where id = ?", *args)
  end
end
