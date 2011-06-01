class Verb < ActiveRecord::Base

  def self.return_number_of_verbs()
    v = Verb.find(:all)
    return v.size
  end

  def self.return_verbs(caps)
    verbs=""
    text=""
    a_caps=[]
    caps.each do |cap|
      cap.spa=cap.spa.gsub(/\s+/," ")
      text = cap.spa.split(/\s+/)
      text.length.times do |i|
        text[i].downcase!
        a_caps.push(text[i])
        a_caps.push("#{text[i-1]} #{text[i]}") if i>0
      end
    end


    a_caps.uniq!
    a_caps.each do |word|
      word = word.gsub(/(\?|\!|\.|,)/,"")
      temp = Verb.find(:first,:conditions=>['conj = ?',"#{word}"])
      verbs = verbs + " | " + word + " " + temp.verb if temp
    end
  verbs
  end
end
