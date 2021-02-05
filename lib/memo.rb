require 'json'

class Memo
  attr_accessor :id, :title, :content

  MemoDataFilePath = "./data/memos.json"
  CurrentIdFilePath = "./data/current_id.json"

  class << self
    def all
      memos = load_json_file(MemoDataFilePath)["memos"]
      memos.map {|memo| self.new(id: memo["id"], title: memo["title"], content: memo["content"])}
    end

    def find(id)
      memos = all
      memos.find {|memo| memo.id == id.to_i}
    end

    def delete(id)
      memos = all
      memos.delete_if {|memo| memo.id == id.to_i}
      write_memos(memos)
    end

    def create(title: , content: )
      next_id = calc_next_id
      memos = all
      memo = self.new(id: next_id, title: title, content: content)
      memos << memo

      write_next_id(next_id)
      write_memos(memos)
    end

    def write_memos(memos)
      memos_array = memos.map {|memo| {"id"=>memo.id, "title"=>memo.title, "content"=>memo.content}}
      memos_hash = { "memos" => memos_array }
      write_json_file(MemoDataFilePath, memos_hash)
    end

    private
      def calc_next_id
        current_id = load_json_file(CurrentIdFilePath)["current_id"]
        current_id.next
      end

      def write_next_id(next_id)
        current_id_hash = {"current_id" => next_id}
        write_json_file(CurrentIdFilePath, current_id_hash)
      end

      def load_json_file(file_path)
        File.open(file_path) {|file| JSON.load(file)}
      end

      def write_json_file(file_path, hash)
        File.open(file_path, "w") { |file| JSON.dump(hash, file) }
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
