# coding: utf-8
class Verb < ActiveRecord::Base

def self.all_cached

#  Rails.cache.fetch('Verb.all') { all }
end

  def self.num_verbs()
    v = Verb.find(:all)
    return v.size
  end

  def self.return_tenses(mood)

    Rails.cache.clear();
    if Rails.cache.read("#{mood}") 
      return Rails.cache.read("#{mood}").split(/:/) if Rails.cache.read("#{mood}") 
    else
#      tenses = ["futuro perfecto", "futuro simple", "gerundio", "imperfecto", "infinitivo", "participio", "pluscuamperfecto", "presente", "pretérito perfecto","pretérito anterior","condicional simple","condicional perfecto"]
      tenses = ["presente", "imperfecto", "preterito perfecto", "preterito anterior", "pluscuamperfecto", "futuro simple", "futuro perfecto", "infinitivo","gerundio","preterito","condicional simple","condicional perfecto","participio"]
      a=Array.new()
      tenses.each do |t|
        v= Verb.find(:first, :conditions=>["mood = ? and tense = ?", "#{mood}","#{t}"])
        a<<t if v
      end
      
      a_string=a.join(":")
      Rails.cache.write("#{mood}","#{a_string}")
      return a
    end
  end

  def self.return_mood_verbs(mood,tense)
    if Rails.cache.read("#{mood}#{tense}") 
      return Rails.cache.read("#{mood}#{tense}").split(/:/) 
    else
    a_verbs=Array.new()
    a_strings=Array.new()
    hash_words=Hash.new()
    conjugations=ActiveRecord::Migration.execute("select conj from verbs where mood = '#{mood}' and tense = '#{tense}';")


    if connection().to_s.match(/mysql/i) then
      conjugations.each do |j|
        a_strings<<j[0]
      end
    else
      #mu'fuck'n po'gres
      conj_count=ActiveRecord::Migration.execute("select count(*) from verbs where mood = '#{mood}' and tense = '#{tense}';")
      conj_count[0]["count"].to_i.times{|i| a_strings<< conjugations[i]['conj'] }
    end

     words=ActiveRecord::Migration.execute("select word from words;")

     if connection().to_s.match(/mysql/i) then
       words.each do |w|
         hash_words[w[0]]=1
       end
     else
       word_count=ActiveRecord::Migration.execute("select count(*) from words;")
       word_count[0]["count"].to_i.times{|i| hash_words[words[i]['word']]=1 }

     end
    #Many conjugations repeat, so make list unique
    a_strings=a_strings.uniq
    #Now find out if each conjugation is found in a caption
    a_strings.each do |s|
      a_verbs << s if hash_words[s]
    end
    a_string=a_verbs.join(":")
    Rails.cache.write("#{mood}#{tense}","#{a_string}")
    return a_verbs.uniq.sort!
  end
end


  def self.return_verbs(caps)
    verbs=""
    text=""
    a_caps=[]
    hash_ids=Hash.new()
    hash_id=Hash.new()
    english=Hash.new()
    
    caps.each do |cap|
      print "aaaa #{cap.id} #{cap.spa}\n"
      cap.spa=cap.spa.gsub(/\s+/," ")
      text = cap.spa.split(/\s+/)
      #loop through each word
      #push each word into a_caps
      #push each word and predecessor into a_caps
      text.length.times do |i|
      text[i] = text[i].gsub(/(\?|\!|\.|,)/,"")
  
      text[i-1] = text[i-1].gsub(/(\?|\!|\.|,)/,"")if i>0
        text[i].downcase!
        a_caps.push(text[i])
        a_caps.push("#{text[i-1]} #{text[i]}") if i>0
        
        #Create hash with words as keys and the value a string of all its positions in captions (id-i)
        if hash_ids["#{text[i]}"] then
          hash_ids["#{text[i]}"] = hash_ids["#{text[i]}"] + "#{cap.id}-#{i}|"
        else
             hash_ids["#{text[i]}"] ="#{cap.id}-#{i}|"
        end

         if hash_ids["#{text[i-1]} #{text[i]}"]  then
          hash_ids["#{text[i-1]} #{text[i]}"] = hash_ids["#{text[i-1]} #{text[i]}"] +  "#{cap.id}-#{i}|"
         else
           hash_ids["#{text[i-1]} #{text[i]}"] = "#{cap.id}-#{i}|"
         end
      end
    end
    a_caps.uniq!
    a_caps.each do |word|
#      print "zzzz #{word}\n"
      #remove punctuation from word or compound before checking if it's a verb
      word = word.gsub(/(\?|\!|\.|,)/,"")
      temp = Verb.find(:first,:conditions=>['conj = ?',"#{word}"])
      #loop through ids for each word, initialize hash set id as key and verb as value
      if hash_ids[word] and temp then
 #       print "11111 #{word} #{temp.verb}\n"
        #get english translation for verb
        trans=Root.find(:first,:conditions=>['verb=?',temp.verb])
          english["#{temp.verb}"]=trans.trans

        hash_ids[word] =  hash_ids[word].sub(/|$/,"")
        array_of_ids = hash_ids[word].split("|")
        array_of_ids.each do |id|

        hash_id["#{id}"] = temp
        puts "#{hash_id[id].verb} #{id}"
      end
    end
    verbs = verbs + " | " + word + " - " + temp.verb if temp
    end
  [verbs,hash_id,english]
  end



end
