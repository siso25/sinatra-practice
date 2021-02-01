require 'sinatra'
require 'sinatra/reloader'

get "/memos" do
  erb :index
end

post "/memos" do
end

get "/memos/new" do
  erb :new
end

get "/memos/:memo_id" do
  erb :show
end

patch "/memos/:memo_id" do
end

delete "/memos/:memo_id" do
end

get "/memos/:memo_id/edit" do
  erb :edit
end
