logs = []
File.foreach("sample.txt"){|line|
  logs << line.chomp.split(",")
}
logs.sort!{|a,b| [a[1],a[0]] <=> [b[1],b[0]]}

File.open("sorted_sample.txt", mode = "w"){|f|
  logs.each do |t|
    f.write("#{t[1]}\t#{t[0]}\t#{t[2]}\n")
  end
}