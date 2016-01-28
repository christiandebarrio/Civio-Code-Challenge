require 'mechanize'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'

get '/' do

  agent = Mechanize.new

  page = agent.get('http://es.soccerway.com/national/spain/primera-division/20152016/regular-season/r31781/players/?ICID=PL_3N_04')

  table = page.search("table.playerstats tr")

  @players = table.drop(1).map do |player|
    id = player.attr("data-people_id")
    name = player.search(".player").text
    url = player.search(".player a").attr("href").value
    photo_url = "http://cache.images.core.optasports.com/soccer/players/150x150/" + id + ".png"
    goals = player.search(".goals").text
    team_id = player.attr("data-team_id")
    team = player.search(".team").text
    photo_team_url = "http://cache.images.core.optasports.com/soccer/teams/150x150/" + team_id + ".png" 

    { name: name, url: url, photo_url: photo_url, goals: goals, team_id: team_id, team: team, photo_team_url: photo_team_url }
  end

  erb :goleadores
end


