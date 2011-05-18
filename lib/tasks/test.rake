task :create_subs => [:environment] do
  basedir = Rails.root.to_s + "/lib/tasks"
  file = File.new(basedir + "/combined.txt","r")
  c=0
  file.each {|line|
    (num,start,stop,spa,eng,url)=line.split(/\t/)
    spa.gsub(/(^\s+|\s+$)/,'')
    eng.gsub(/(^\s+|\s+$)/,'')

    wcount=line.split(/\s+/)
#    wcount.each do |w|
#     puts "#{w}\n"
#    end
    ccount= line.size.to_s
    cap = Cap.new(:num=>num,:start=>start,:stop=>stop,:spa=>spa,:eng=>eng,:url=>url,:lang=>"spa",:wcount=>wcount.size,:ccount=>ccount)
    #puts wcount.size.to_s + " " + ccount + " " + txt
    cap.save
    c+=1
    puts c.to_s + " " + cap.spa
  }  
end

task :turn_off_alarm do
  
  basedir = Rails.root.to_s + "/lib/tasks/transcriptions/spa"
  contains = Dir.new(basedir).entries

  contains.each do |i|
   next if i =~ /^\./
    file = File.new(basedir + "/" + i,"r")
    file.each {|line|
    puts   line
    }
  end
end

task :ready_for_the_day => [:turn_off_alarm] do
  puts "Ready for the day!"
end



