class Movie < ActiveRecord::Base
  
  def self.return_movies()
     if  Rails.cache.read("movies") then
       Rails.cache.read("movies")
     else
       Rails.cache.fetch("movies", :expires_in=>3.days){Movie.find(:all)} 
     end
   end
end
