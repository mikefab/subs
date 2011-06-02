class Verb < ActiveRecord::Base

  def self.num_verbs()
    v = Verb.find(:all)
    return v.size
  end

  def self.return_verbs(caps)
    verbs=""
    text=""
    a_caps=[]
    hash_ids=Hash.new()
    hash_id=Hash.new()
    
    caps.each do |cap|
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
      #remove punctuation from word or compound before checking if it's a verb
      word = word.gsub(/(\?|\!|\.|,)/,"")
      temp = Verb.find(:first,:conditions=>['conj = ?',"#{word}"])
      #loop through ids for each word, initialize hash set id as key and verb as value
      if hash_ids[word] and temp then

        hash_ids[word] =  hash_ids[word].sub(/|$/,"")
        array_of_ids = hash_ids[word].split("|")
        array_of_ids.each do |id|

        hash_id["#{id}"] = temp
        puts "#{hash_id[id].verb} #{id}"
      end
    end
    verbs = verbs + " | " + word + " - " + temp.verb if temp
    end
  [verbs,hash_id]
  end



end
