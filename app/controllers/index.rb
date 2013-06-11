require 'securerandom'

get '/' do
  erb :index
end

post '/game' do
  @game = Game.create
  @game.users << User.find_or_create_by_name(params[:player1])
  @game.users << User.find_or_create_by_name(params[:player2])
  erb :game
end

post '/game/update' do
  content_type 'json'
  puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

  params[:elapsed]

  p params
  p params[:gameid]
  p params[:winner]

  winner = User.find_by_name(params[:winner])
  game = Game.find(params[:gameid])
  url = SecureRandom.hex(13)

  p game.id
  p winner.name


  game.update_attributes(winner_id: winner.id, time: params[:elapsed], url: url)

  {winner: winner.name, url: url, time: game.time }.to_json
end


get '/game/:url' do
  @game = Game.find_by_url(params[:url])
  @user = User.find(@game.winner_id)
  erb :stats
end