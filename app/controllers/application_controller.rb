class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :pre
 # 


 def grab_ip_info(search,returned_results,page,lang)
   browser= request.env['HTTP_USER_AGENT']
   ip = request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
   Track.new(:ip=>ip,:search=>search, :browser=>browser,:num=>returned_results,:lang=>lang).save!
 end

   def pre     
     @trans_hash=  verb_trans()
     @hash_conj_trans= conj_trans()
   end
 #  

 def conj_trans
   if  Rails.cache.read("hash_conj_trans") then
     return true
   else
     hash_conj_trans=Hash.new()
     Translation.find(:all).each do |t|
       hash_conj_trans["#{t.verb}#{t.mood}#{t.tense}"]=t.trans
     end
     Rails.cache.fetch("hash_conj_trans", :expires_in=>3.days){hash_conj_trans} 

   end
 end

   def verb_trans
     if  Rails.cache.read("hash_trans") then
       return true
     else
       hash_trans=Hash.new()
       Root.find(:all).each do |r|
         hash_trans[r.verb]=r.trans
       end
       Rails.cache.fetch("hash_trans", :expires_in => 3.days){hash_trans} 
     end
   end
   private

       def authenticate
         deny_access unless signed_in?
       end
       def deny_access
         redirect_to signin_path, :notice => "Please sign in to access this page."
       end
end
