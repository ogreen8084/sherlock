require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

helpers do

  def in_paragraphs(text)
    text.split("\n\n").map do |line|
      "<p>#{line}</p>"
    end.join
  end

end

before do
  @contents = File.readlines("data/toc.txt")
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"

  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  chapter_name = @contents[number - 1]
  @title = "Chapter #{number}: #{chapter_name}"

  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end

not_found do
  redirect "/"
end
