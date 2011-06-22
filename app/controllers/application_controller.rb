class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :pre
 # 
   def pre
     @trans_hash=  verb_trans()
   end
 #  
   def verb_trans
     if  Rails.cache.read("hash_trans") then
       return true
     else
       hash_trans=Hash.new()
       Root.find(:all).each do |r|
         hash_trans[r.verb]=r.trans
       end
       Rails.cache.write("hash_trans",hash_trans) 
     end
   end
end
