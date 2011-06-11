require 'iconv' 

#Not sure if I still need this
task :qualify_verbs => [:environment] do
  count=0
      a_conj = Array.new()
      hash= Hash.new()
      conjugations = Verb.find(:all,:conditions=>["mood != ? and pre='' and conj !='missing'", "Subjuntivo"])
      conjugations.each do |j|
         count=count+1
          c=Cap.find(:all,:conditions=>["spa like ?", "%#{j.conj}%"])

          hash["#{j.verb}"] =1 unless hash["#{j.verb}"]
          j.pre=c.size if c;
          j.save if c;
          print "#{count} #{j.verb} #{j.conj}\n" if count==200
          count=0 if count==200
      end  
end



task :merge_url_source => [:environment] do
  caps=Cap.find(:all, :conditions=>["source !='dotsub'"]);
  caps.each do |c|
    c.url = "trash"
    c.save!
  end  

  caps=Cap.find(:all, :conditions=>["source ='dotsub'"]);
  caps.each do |c|
    c.source2 = c.trash
    c.save!
  end  



end



#this creates an index of words and compound words that match conjugations in verbs table
task :create_words => [:environment] do
  h=Hash.new()
  seen=Hash.new()
  i=0
#  Verb.find(:all).each do |v|

 ActiveRecord::Migration.execute("select conj from verbs").each do |j|
   temp=j[0]
    h[temp]=1
    print "#{temp}\n"
  end
h.each do |x|
  print "hash .. #{h[x]}\n"
end
  print "done with conj hash, getting gaps #{h.size}\n"
  Cap.find(:all,:conditions=>["hide != '1' and spa!=eng"]).each do |c|
    c.spa=c.spa.gsub(/(\(|\)|"|'|\?|\!|\.|,|\n|\r|^\s+|\s+$)/,"").downcase
    a=Array.new
    a = c.spa.split(/\s+/) 
    a.length.times do |i| 
      print "#{a[i]}\n"
      if h[a[i]] then

        unless seen[a[i]]  then
          w = Word.new(:word=>a[i])
          if w.word and w.word.match(/[a-zA-Z]/) then
            w.save 
          end
          print "making hash of #{a[i]}\n"
          seen[a[i]]=1
        else
        end
      end
      if i>0 and h["#{a[i-1]} #{a[i]}"] then
        unless seen["#{a[i-1]} #{a[i]}"]then
          w2=Word.new(:word=>"#{a[(i-1)]} #{a[i]}") 
          w2.save
          print "#{c.id}vvv #{w2.word}\n"
          seen["#{a[i-1]} #{a[i]}"]=1
        else
        end
      end
    end
  end
end


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
    wcount=spa.split(/\s+/)
#    wcount.each do |w|
#     puts "#{w}\n"
#    end
    ccount= spa.size.to_s
    cap = Cap.new(:num=>num,:start=>start,:stop=>stop,:spa=>spa,:eng=>eng,:url=>url,:lang=>"spa",:source=>source,:source2=>source2,:wcount=>wcount.size,:ccount=>ccount)
    #puts wcount.size.to_s + " " + ccount + " " + txt
    cap.save
    c+=1
    puts c.to_s + " " + cap.spa
  }  
end



task :import_caps => [:environment] do
  basedir = Rails.root.to_s + "/lib/tasks"
   counter = 1
   counter2=1
   file = File.new(basedir +'/caps.txt', "r")
   while (line = file.gets)
    line= line.gsub(/\n/,"")
     (url,num,start,stop,spa,eng,source,source2,trash)=line.split(/\t/)
      wcount=spa.split(/\s+/).size.to_s
      ccount= spa.size.to_s
#      puts "#{start} #{stop} #{eng} #{wcount} #{ccount} #{spa} -p- #{source} -x- #{source2}"
      cap = Cap.new(:num=>num,:start=>start,:stop=>stop,:spa=>spa,:eng=>eng,:url=>url,:wcount=>wcount,:ccount=>ccount,:lang=>"spa",:source=>source,:source2=>source2,:wcount=>wcount.size,:ccount=>ccount)
      cap.save
      print "#{counter2}\n" if counter==200;
      counter=0 if counter==200
      counter = counter + 1
      counter2=counter2+1
   end
  file.close
end



task :export_caps => [:environment] do
  basedir = Rails.root.to_s + "/lib/tasks"
  c=Cap.find(:all, :conditions=>["hide is null and eng !='' and spa!=eng "])
  count=0
  count2=0
  c.each do |c|
    count=count+1
    count2=count2+1
    string = "#{c.url}\t#{c.num}\t#{c.start}\t#{c.stop}\t#{c.spa}\t#{c.eng}\t#{c.source}\t#{c.source2}\n"
    File.open(basedir +'/caps.txt', 'a') do |f2|  
      f2.puts string  
    end
    print "#{count2.to_s}\n" if count==200
    count=0 if count==200
  end
end

task :export_verbs => [:environment] do
  basedir = Rails.root.to_s + "/lib/tasks"
  string=String.new()
  string=""
  File.open(basedir +'/verbs.txt', 'w') do |f2|  
    f2.puts string  
  end

  v=Verb.find(:all)
  count=0
  count2=0
  v.each do |v|
    count=count+1
    count2=count2+1
    
    string = "#{v.verb}\t#{v.conj}\t#{v.mood}\t#{v.tense_type}\t#{v.tense}\t#{v.pro}\t#{v.pre}\n"
    File.open(basedir +'/verbs.txt', 'a') do |f2|  
      f2.puts string  
    end
    print "#{count2.to_s}\n" if count==200
    count=0 if count==200
  end
end

task :import_words => [:environment] do
  basedir = Rails.root.to_s + "/lib/tasks"
   counter = 1
   counter2=1
   file = File.new(basedir +'/words.txt', "r")
   while (line = file.gets)
    line= line.gsub(/\n/,"")
    line= line.gsub(/\r/,"")
    word = Word.new(:word=>line)
    word.save!
    print "#{counter2} #{word}\n" if counter==200;
    counter=0 if counter==200
    counter = counter + 1
    counter2=counter2+1
  end
  file.close
end



task :export_words=> [:environment] do
  basedir = Rails.root.to_s + "/lib/tasks"
  string=String.new()
  string=""
  File.open(basedir +'/words.txt', 'w') do |f2|  
    f2.puts string  
  end

  word=Word.find(:all)
  count=0
  count2=0
  word.each do |w|
    count=count+1
    count2=count2+1
    
    string = "#{w.word}\n"
    File.open(basedir +'/words.txt', 'a') do |f2|  
      f2.puts string  
    end
    print "#{count2.to_s}\n" if count==200
    count=0 if count==200
  end
end



task :import_verbs => [:environment] do
  basedir = Rails.root.to_s + "/lib/tasks"
  counter = 1
  counter2=1
  counter3=1
  flag =0
  v=Verb.find(:last,:order=>'id');
  first=1 if !v
  file = File.new(basedir +'/verbs.txt', "r")
  while (line = file.gets)
    line=line.gsub(/\n/,'')
    line = line.gsub(/\r/,'')
    (verb,conj,mood,tense_type,tense,pro,pre)=line.split(/\t/)

if first==1 then
  flag = 1
else
  ActiveRecord::Migration.execute("insert into Verbs (verb,conj,mood,tense_type,tense,pro,pre) values('#{verb}','#{conj}','#{mood}','#{tense_type}','#{tense}','#{pro}','#{pre}');") if flag==1
#print "have #{verb} " if flag=0

  if conj then
    flag=1 if conj.match(/#{v.conj}/) and pro.match(/#{v.pro}/) and mood.match(/#{mood}/) and verb.match(/#{v.verb}/) and tense_type.match(/#{v.tense_type}/)
  end
end
#    verb = Verb.new(:verb=>verb,:conj=>conj,:mood=> mood,:tense_type=>tense_type,:tense=>tense,:pro=>pro,:pre=>pre)
#    verb.save!
    counter3=counter3+1
      print " #{counter2} #{counter3} #{conj}\n" if counter==400;
    counter=0 if counter==400
    counter = counter + 1
    counter2=counter2+1
   end
  file.close
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
     puts c.to_s + " " + root.verb if c2==200
     c2=0 if c2==201
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
      line=line.gsub(/\n/,'')
      line = line.gsub(/\r/,'')
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
#  v=Verb.find(:all)
#  v.map do |f|  f.destroy  end
ActiveRecord::Migration.execute("truncate verbs;")

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





