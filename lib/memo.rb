# frozen_string_literal: true

require 'pg'

class Memo
  attr_accessor :id, :title, :content

  class << self
    def all
      connection = PG.connect( dbname: 'sinatra_db' )
      result_rows = connection.exec('SELECT * FROM posts ORDER BY id;')
      memos = []
      result_rows.each do |row|
        memos << new(id: row['id'].to_i, title: row['title'], content: row['content'])
      end
      memos
    end

    def find(id)
      memos = all
      memos.find { |memo| memo.id == id.to_i }
    end

    def delete(id)
      connection = PG.connect( dbname: 'sinatra_db' )
      connection.exec( 'DELETE FROM posts WHERE id = $1;', [id.to_i] )
    end

    def create(title:, content:)
      connection = PG.connect( dbname: 'sinatra_db' )
      connection.exec(
        'INSERT INTO posts ( title, content, created_at, updated_at ) VALUES ( $1, $2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP );',
        [title, content]
      )
    end
  end

  def initialize(title:, content:, id: nil)
    @id = id
    @title = title
    @content = content
  end

  def update(title:, content:)
    connection = PG.connect( dbname: 'sinatra_db' )
    connection.exec(
      'UPDATE posts SET title = $1, content = $2, updated_at = CURRENT_TIMESTAMP WHERE id = $3;',
      [title, content, @id]
    )
  end
end
