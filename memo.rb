require 'json'

class Memo
  attr_accessor :id, :title, :content

  class << self
    def all
      memos = File.open("./memos.json") { |file| JSON.load(file) }["memos"]
      memos.map do |memo|
        Memo.new(id: memo["id"], title: memo["title"], content: memo["content"])
      end
    end

    def find(id)
      memos = self.all
      memos.find {|memo| memo.id == id.to_i}
    end

    def delete(id)
      memos = self.all
      memos.delete_if {|memo| memo.id == id.to_i}
      self.write_memos(memos)
    end

    def create(title: , content: )
      memos = self.all
      next_id = calc_next_id
      write_max_memo_id(next_id)

      memo = self.new(id: next_id, title: title, content: content)
      memos << memo
      self.write_memos(memos)
    end

    def write_memos(memos)
      memos_array = memos.map {|memo| {"id"=>memo.id, "title"=>memo.title, "content"=>memo.content}}
      memos_hash = { "memos" => memos_array }
      File.open("./memos.json", "w") { |file| JSON.dump(memos_hash, file) }
    end

    private
      def calc_next_id
        current_id = File.open("./max_memo_id.json") { |file| JSON.load(file) }["max_id"]
        current_id.next
      end

      def write_max_memo_id(next_id)
        max_id_hash = {"max_id" => next_id}
        File.open("./max_memo_id.json", "w") { |file| JSON.dump(max_id_hash, file) }
      end
  end

  def initialize(id: nil, title:, content:)
    @id = id
    @title = title
    @content = content
  end

  def update(title: , content: )
    memos = Memo.all
    memo = memos.find {|memo| memo.id == @id.to_i}
    memo.title = title
    memo.content = content

    Memo.write_memos(memos)
  end
end
