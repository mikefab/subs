require 'iconv' 
task :create_subs => [:environment] do

  basedir = Rails.root.to_s + "/lib/tasks"
  file = File.new(basedir + "/files/#{ENV["file"]}.txt","r")
  c=0
  ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')

  file.each {|line|
    
    line = ic.iconv(line + ' ')[0..-2]
    line.gsub(/\n/,'')
    line.gsub(/\r/,'')
    
    (url,num,start,stop,spa,eng,trash,source,source2,trash)=line.split(/\t/)
    spa.gsub(/(^\s+|\s+$)/,'')
    eng.gsub(/(^\s+|\s+$)/,'')
    wcount=line.split(/\s+/)
#    wcount.each do |w|
#     puts "#{w}\n"
#    end
    ccount= line.size.to_s
    cap = Cap.new(:num=>num,:start=>start,:stop=>stop,:spa=>spa,:eng=>eng,:url=>url,:lang=>"spa",:source=>source,:source2=>source2,:wcount=>wcount.size,:ccount=>ccount)
    #puts wcount.size.to_s + " " + ccount + " " + txt
    cap.save
    c+=1
    puts c.to_s + " " + cap.spa
  }  
end

task :create_roots => [:environment] do
  
    basedir = Rails.root.to_s + "/lib/tasks"
    file = File.new(basedir + "/roots.txt","r")
    c=0
    c2=0
#    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')

    file.each {|line|

 #     line = ic.iconv(line + ' ')[0..-2]
#      line=line.gsub(/\n/,'')
#      line=line.gsub(/\r/,'')
#  line=line.gsub(/(^\s+|\s+$)/)
      (verb,english)=line.split(/\t/)
    
  english=english.gsub(/\s+$/,"") 
      root = Root.new(:verb=>verb,:trans=>english)

      root.save
      c+=1
      c2=c2+1
     puts c.to_s + " " + root.verb
    }  
end



task :create_verbs => [:environment] do
  
    basedir = Rails.root.to_s + "/lib/tasks"
    file = File.new(basedir + "/verbs.txt","r")
    c=0
    c2=0
#    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')

    file.each {|line|

 #     line = ic.iconv(line + ' ')[0..-2]
      line.gsub(/\n/,'')
      line.gsub(/\r/,'')
      (verb,conj,mood,tense_type,tense,pro,pre)=line.split(/\t/)

      verb = Verb.new(:verb=>verb,:conj=>conj,:mood=> mood,:tense_type=>tense_type,:tense=>tense,:pro=>pro,:pre=>pre)

      verb.save
      c+=1
      c2=c2+1
     puts c.to_s + " " + verb.conj if c2==200
     c2=0 if c2==201
    }  
end
task :destroy_verbs => [:environment] do
  v=Verb.find(:all)
  v.map do |f|  f.destroy  end
  
end
task :test_verbs => [:environment] do
  basedir = Rails.root.to_s + "/lib/tasks"
  file = File.new(basedir + "/verbs.txt","r")
  c=0
  #    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
  file.each {|line|
    line.gsub(/\n/,'')
    line.gsub(/\r/,'')
    (verb,conj,mood,tense_type,tense,pro,pre)=line.split(/\t/)
    v=Verb.find(:all,:conditions=>["verb = ? and conj = ? and tense_type= ? and mood = ? and tense = ? and pro = ?", "#{verb}", "#{conj}","#{tense_type}","#{mood}","#{tense}","#{pro}"])
    
if v.size==0 then
  verb = Verb.new(:verb=>verb,:conj=>conj,:mood=> mood,:tense_type=>tense_type,:tense=>tense,:pro=>pro,:pre=>pre)
  verb.save
  puts "added #{conj}.."
end
 #    if !v then
 #     verb = Verb.new(:verb=>verb,:conj=>conj,:tense_type=>tense_type,:tense=>tense,:pro=>pro,:pre=>pre)
  #    verb.save
   #   exit
  #  end
    
  }

end





