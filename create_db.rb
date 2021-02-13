# frozen_string_literal: true

require 'pg'

create_sql = <<~SQL.delete("\n")
  CREATE TABLE memos (
    id SERIAL NOT NULL,
    title TEXT NOT NULL,
    content TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    PRIMARY KEY (id)
  )
SQL

connection = PG.connect(dbname: 'sinatra_db')
begin
  connection.exec(create_sql)
ensure
  connection.finish
end
