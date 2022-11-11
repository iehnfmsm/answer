#　設問２を拡張



def change_to_date(date)
  s = "#{date.slice(0,4)}/#{date.slice(4,2)}/#{date.slice(6,2)} #{date.slice(8,2)}:#{date.slice(10,2)}:#{date.slice(12,2)}"
  return s
end
def change_to_sub_net(server)
  a = server.split("/")
  b = a[0].split(".")
  c = sprintf("%08d",b[0].to_i.to_s(2)) + sprintf("%08d",b[1].to_i.to_s(2)) + sprintf("%08d",b[2].to_i.to_s(2)) + sprintf("%08d",b[3].to_i.to_s(2))
  i = 0
  address = []
  c.split("").each do |d|
    if i < a[1].to_i
      address << d
      i += 1
    end
  end
  (32 - a[1].to_i).times do
    address << 0
  end
  sub_net = (address.join("").scan(/.{1,#{8}}/) << a[1])
  return "#{sub_net[0].to_i(2)}.#{sub_net[1].to_i(2)}.#{sub_net[2].to_i(2)}.#{sub_net[3].to_i(2)}/#{sub_net[4]}"
end


logs = []

##「sample4.txt」がログファイルとする
File.foreach("sample4.txt"){|line|
  logs << line.chomp.split(",")
}
logs.sort!{|a,b| [a[1],a[0]] <=> [b[1],b[0]]}

check_server = ""
check_time = ""
count = 0 #タイムアウト回数をカウントするための変数
num = 4 #「N回以上」設定用パラメータ
all_errors = []
logs.each do |s|
  if check_server != s[1] && check_time != ""
    if count >= num
      #all_errors << [check_server, check_time, "-"]
    end
    check_server = s[1]
    check_time = ""
    count = 0
  elsif check_server != s[1]
    check_server = s[1]
  end
  if s[2] == '-' && check_time == ""
      check_time = s[0]
      count += 1
  elsif s[2] != '-' && check_time != ""
    if count >= num
      #all_errors << [check_server,check_time, s[0]]
    end
    check_time = ""
    count = 0
  elsif s[2] == "-" && count > 0
    count += 1
    if s[2] == "-" && count >= num
      all_errors << [check_server,s[0]]
    end
  end
end

puts "サーバーの故障時間"
all_errors.sort!{|a,b| [change_to_sub_net(a[0]), a[1]] <=> [ change_to_sub_net(b[0]), b[1]]}
all_errors.each do |l|
  p l
end

=begin
all_errors.each do |t|
  if t[2] == "-"
    puts"#{t[0]}: #{change_to_date(t[1])}〜"
  else
    puts "#{t[0]}: #{change_to_date(t[1])}〜#{change_to_date(t[2])}"
  end
end
=end