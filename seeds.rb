require "sqlite3"

# Open a database
db = SQLite3::Database.new "rails_magic.db"

# Create users table

db.execute("drop table if exists users")
db.execute <<-sql
  create table users (
    id integer primary key autoincrement,
    email varchar(30) not null unique,
    name varchar(30) not null unique
  );
sql

# Create posts table
db.execute("drop table if exists posts")
db.execute <<-SQL
  create table posts (
    id integer PRIMARY KEY autoincrement,
    title varchar(30) NOT NULL UNIQUE,
    body TEXT NOT NULL UNIQUE,
    user_id int
  );
SQL

# Create a user
db.execute "insert into users ( name, email ) VALUES (?, ?)", "Harry", "hpotter@doximity.com"

# Create a post
db.execute "insert into posts ( title, body ) VALUES (?, ?)", "You're a Wizard Now", "hpotter@doximity.com"
