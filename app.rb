# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require './lib/memo'
require 'erb'

helpers do
  include ERB::Util
  def h(text)
    html_escape(text)
  end
end

get '/' do
  redirect to('/memos')
end

get '/memos' do
  @memos = Memo.all
  erb :index
end

post '/memos' do
  Memo.create(title: params[:title], content: params[:content])
  redirect to('/memos')
end

get '/memos/new' do
  erb :new
end

get '/memos/:memo_id' do
  @memo = Memo.find(params[:memo_id])
  erb :show
end

patch '/memos/:memo_id' do
  memo = Memo.find(params[:memo_id])
  memo.update(title: params[:title], content: params[:content])
  redirect to('/memos')
end

delete '/memos/:memo_id' do
  Memo.delete(params[:memo_id])
  redirect to('/memos')
end

get '/memos/:memo_id/edit' do
  @memo = Memo.find(params[:memo_id])
  erb :edit
end

not_found do
  erb :not_found
end
