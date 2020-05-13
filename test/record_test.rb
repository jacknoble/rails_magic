require "test/unit"
require_relative "../lib/record.rb"

class Thing < Record
end

class RecordTest < Test::Unit::TestCase

  def db
    @db ||= SQLite3::Database.new 'rails_magic.db'
  end

  def setup
    db.execute("drop table if exists things")
    db.execute(<<-sql)
      create table things (
        id integer primary key autoincrement,
        email varchar(30) not null unique,
        name varchar(30) not null unique
      );
    sql
  end

  def cleanup
    db.execute("drop table if exists things")
  end

  def test_save_new_record
    assert_nil Thing.all.first
    thing = Thing.new({ "name" => "Barney", "email" => "barney@doximity.com" })
    thing.save
    assert_not_nil Thing.all.first.attributes["id"]
  end

  def test_save_old_record
    thing = Thing.new({ "name" => "Barney", "email" => "barney@doximity.com" })
    thing.save
    assert thing.save
  end
end
