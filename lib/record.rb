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
    @attributes = self.class.column_names.zip(row).to_h
  end
end
