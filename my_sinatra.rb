# frozen_string_literal: true
# encoding: utf-8

require 'sinatra/base'
require 'sinatra/namespace'

module MyAppModule
  class App < Sinatra::Base
    register Sinatra::Namespace

    # 1. Простые маршруты
    get '/' do
      'Hello My Sinatra - Easy and Wide world!'
    end

    get '/hello/:name' do
      "Sinatra приветствует тебя, #{params[:name]}!"
    end

    # 2. Перенаправление
    get '/redirect' do
      redirect to('/hello/World')
    end

    # 3. Блок с параметром
    get '/hello/:name' do |n|
      "Hello #{n}!"
    end

    # 4. Регулярка
    get %r{/meta/hello/([\w]+)} do |c|
      "Hello, #{c}!"
    end

    # 5. Splat — say/*/to/*
    get '/say/*/to/*' do
      params['splat'].join  # => "hello world"
    end

    # 6. Splat с точкой — download/*.*
    get '/download/*.*' do |path, ext|
      [path, ext].to_s
    end

    # 7. Необязательный формат
    get '/jobs.?:format?' do
      'Да, работает этот маршрут!'
    end

    # 8. API namespace — ТОЧНО КАК В МЕТОДИЧКЕ!
    namespace '/api/v1' do
      get '/*' do
        "I don't know what is the #{params[:splat].first}. It's what you typed."
      end
    end

    # 9. Ловушка для всего остального (должна быть ПОСЛЕДНЕЙ!)
    get '/*' do
      "I don't know what is the #{params[:splat].first}. It's what you typed."
    end

  end
end