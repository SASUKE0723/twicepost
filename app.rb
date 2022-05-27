require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'

enable :sessions

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end

def image_upload(img)
  logger.info "upload now"
  tempfile = img[:tempfile]
  
  upload = Cloudinary::Uploader.upload(tempfile.path)

  contents = Task.last

  contents.update_attribute(:img, upload['url'])
end

def image_upload_local(img)
  if img
    contents = Task.last
    id = contents.id
    logger.info img
    ext = File.extname(img[:filename])
    img_name = "#{id}-bbs#{ext}"
    p "="*20
    logger.info ext
    img_path = "/images/bbs/#{img_name}"
    contents.update_attribute(:img, img_path)

    save_path = File.join('public', 'images', 'bbs', img_name)

    File.open(save_path, 'wb') do |f|
     logger.info "Temp file: #{img[:tempfile]}"
     f.write img[:tempfile].read
     logger.info 'アップロード成功'
    end
  else
    logger.info 'アップロード失敗'
  end
end


get '/' do
    erb :index
end

get '/2' do
    erb :index2
end

get '/signup' do
    erb :sign_up
end

post '/signup' do
    user = User.create(
        name: params[:name],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
        )
    if user.persisted?
        session[:user] = user.id
    end
    redirect '/'
end

get '/signin' do
    erb :sign_in
end

post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

get '/twice_japan' do
    erb :TWICE_japan
end

get '/candypop' do
    erb :CandyPop
end

get '/chaeyoung' do
    erb :CHAEYOUNG
end

get '/dahyun' do
    erb :DAHYUN
end

get '/jeongyeon' do
    erb :JEONGYEON
end

get '/jihyo' do
    erb :JIHYO
end

get '/merryhappy' do
    erb :MerryHappy
end

get '/mina' do
    erb :MINA
end

get '/momo' do
    erb :MOMO
end

get '/nayeon' do
    erb :NAYEON
end

get '/onemoretime' do
    erb :OneMoreTime
end

get '/pagetwo' do
    erb :PageTwo
end

get '/page2' do
    erb :page2
end

get '/sana' do
    erb :SANA
end

get '/signal' do
    erb :SIGNAL
end

get '/thestorybegins' do
    erb :THESTORYBEGINS
end

get '/twicecoasterlane1' do
    erb :TWICEcoasterLANE1
end

get '/twicecoasterlane2' do
    erb :TWICEcoasterLANE2
end

get '/twicetagram' do
    erb :Twicetagram
end

get '/tzuyu' do
    erb :TZUYU
end

get '/whatislove' do
    erb :WhatisLove
end

get '/tasks/new' do
    erb :new
end

post '/tasks' do
    current_user.tasks.create(
        title: params[:title],
        comment: params[:comment],
        img: "",
    )
    
    if params[:file]
        image_upload(params[:file])
    end
    redirect '/post'
end

get '/post' do
    if current_user.nil?
        @tasks = Task.none
    else
        @tasks = Task.all.reverse_order
    end
    erb :post
end

before '/tasks' do
    if current_user.nil?
        redirect '/signin'
    end
end

get '/tasks/:id/star' do
    task = Task.find(params[:id])
    task.star = !task.star
    task.save
    redirect '/post'
end

get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
   erb :edit
end

post '/tasks/:id' do
    task = Task.find(params[:id])
    task.comment = params[:comment]
    task.save
    redirect '/post'
end

get '/suke' do
    if current_user.nil?
        @schedules = Schedule.none
    else
        @schedules = current_user.schedules
    end
    erb :suke
end

get '/schedules/new' do
    erb :newsuke
end

post '/schedules' do
    date = params[:due_date].split('-')
    if Date.valid_date?(date[0].to_i, date[1].to_i, date[2].to_i)
        current_user.schedules.create(
            title: params[:title],
            due_date: Date.parse(params[:due_date]),
            url: params[:url],
        )
        redirect '/suke'
    else
        redirect '/schedules/newsuke'
    end
end

before '/schedules' do
    if current_user.nil?
        redirect '/signin'
    end
end

get '/wakemeup' do
    erb :WakeMeUp
end

get '/anke' do
    erb :anke
end

post '/answers' do
    Answer.create(
        name: params[:name],
        age: params[:age],
        gender: params[:gender],
        grade: params[:grade],
        member: params[:member],
        music: params[:music],
        email: params[:email],
        password: params[:password],
        date: params[:date],
        content: params[:content]
    )
    redirect '/answers'
end

get '/answers' do
    @answers =Answer.all
    erb :answers
end

post '/schedules/:id/delete' do
    schedule = Schedule.find(params[:id])
    schedule.destroy
    redirect '/suke'
end

get '/summernight' do
    erb :DANCETHENIGHTAWAY
end

get '/bdz' do
    erb :BDZ
end

get '/twitter' do
    erb :twitter
end