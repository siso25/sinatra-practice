# frozen_string_literal: true

require './lib/memo_pg'

class Memo
  extend MemoPg
  attr_accessor :id, :title, :content

  class << self
    def all
      memos = fetch_all_memos
      memos.map do |memo|
        new(id: memo['id'].to_i, title: memo['title'], content: memo['content'])
      end
    end

    def find(id)
      memo = fetch_memo(id.to_i)
      new(id: memo['id'].to_i, title: memo['title'], content: memo['content'])
    end

    def delete(id)
      delete_memo(id.to_i)
    end

    def create(title:, content:)
      insert_memo(title, content)
    end
  end

  def initialize(title:, content:, id: nil)
    @id = id
    @title = title
    @content = content
  end

  def update(title:, content:)
    Memo.update_memo(@id, title, content)
  end
end
