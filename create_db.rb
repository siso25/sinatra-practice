require 'pg'

create_sql =<<~SQL
  CREATE TABLE posts (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT,
    created_at TIMESTAMP,
    udpated_at TIMESTAMP
  )
SQL

connection = PG.connect( dbname: 'sinatra_db' )
connection.exec( create_sql.gsub(/\n/, '') )
