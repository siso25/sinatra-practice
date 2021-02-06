# frozen_string_literal: true

require 'pg'

module MemoPg
  DB_NAME = 'sinatra_db'
  private_constant :DB_NAME

  def fetch_all_memos
    memos = execute(query_fetch_all_memos)
    memos.map { |memo| memo }
  end

  def fetch_memo(id)
    memo = execute(query_fetch_memo, [id])
    memo.values[0].nil? ? {} : memo[0]
  end

  def insert_memo(title, content)
    params = [title, content]
    execute(query_insert_memo, params)
  end

  def update_memo(id, title, content)
    params = [id, title, content]
    execute(query_update_memo, params)
  end

  def delete_memo(id)
    execute(query_delete_memo, [id])
  end

  private

  def execute(sql, params=[])
    connection = PG.connect( dbname: DB_NAME )
    begin
      connection.exec( sql, params )
    ensure
      connection.finish
    end
  end

  def query_fetch_all_memos
    'SELECT id, title, content FROM memos ORDER BY id;'
  end

  def query_fetch_memo
    'SELECT id, title, content FROM memos WHERE id = $1;'
  end

  def query_insert_memo
    'INSERT INTO memos ( title, content, created_at, updated_at ) VALUES ( $1, $2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP );'
  end

  def query_update_memo
    'UPDATE memos SET title = $2, content = $3 WHERE id = $1;'
  end

  def query_delete_memo
    'DELETE FROM memos WHERE id = $1;'
  end
end
