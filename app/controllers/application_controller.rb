class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
 # before_filter :pre
 # 
 #  def pre
 #    @verbs_hash=  conj_verb()
 #  end
 #  
 #  def conj_verb
 #  # Rails.cache.clear() 
 #    if  Rails.cache.read("hash_verb") then
 #      return true
 #    else
 #    hash_verb=Hash.new
 #    hash_trans=Hash.new
 #    Word.all.each do |w|
 #      v=Verb.find(:first,:conditions=>["conj=?",w.word])
 #      hash_verb[w.word]=v.verb
 #      r=Root.find(:first,:conditions=>["verb=?",v.verb])
 #      hash_trans[v.verb]=r.trans
 #    end
 #    Rails.cache.write("hash_verb",hash_verb)
 #    Rails.cache.write("hash_trans",hash_trans)
 #    end
 #  end
end
