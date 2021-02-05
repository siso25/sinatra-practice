require 'pg'

create_sql =<<~SQL
  CREATE TABLE posts (
    id SERIAL NOT NULL,
    title TEXT NOT NULL,
    content TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    PRIMARY KEY (id)
  )
SQL

connection = PG.connect( dbname: 'sinatra_db' )
connection.exec( create_sql.gsub(/\n/, '') )
