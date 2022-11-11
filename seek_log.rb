
logs = []
##「sample.txt」がログファイルとする
File.foreach("sample.txt"){|line|
  logs << line.chomp.split(",")
}
logs.sort!{|a,b| [a[1],a[0]] <=> [b[1],b[0]]}

def change_to_date(date)
  s = "#{date.slice(0,4)}/#{date.slice(4,2)}/#{date.slice(6,2)} #{date.slice(8,2)}:#{date.slice(10,2)}:#{date.slice(12,2)}"
  return s
end

check_server = ""
check_time = ""
all_errors = []
logs.each do |s|
  if check_server != s[1] && check_time != ""
    all_errors << [check_server, check_time, "-"]
    check_server = s[1]
    check_time = ""
  elsif check_server != s[1]
    check_server = s[1]
  end
  if s[2] == '-' && check_time == ""
      check_time = s[0]
  elsif s[2] != '-' && check_time != ""
    all_errors << [check_server,check_time, s[0]]
    check_time = ""
  end
end

all_errors.each do |t|
  if t[2] == "-"
    puts"#{t[0]}: #{change_to_date(t[1])}〜"
  else
    puts "#{t[0]}: #{change_to_date(t[1])}〜#{change_to_date(t[2])}"
  end
end