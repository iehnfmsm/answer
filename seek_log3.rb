
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

def update_ping_list(list, i)
  list.slice!(0)
  list << i
  return list
end

check_server = ""
check_time = ""
overload_time = ""
count = 0 #タイムアウト回数をカウントするための変数
num = 4 #「N回以上」設定用パラメータ
m = 5 # 「直近m回」指定用パラメータ
n = 150 # 「ping値の平均」指定用パラメータ
all_errors = []
overload_list = []
# ping値の平均を求めるための配列
reset_ping_list = []
m.times do 
  reset_ping_list << 0
end
ping_list = reset_ping_list.dup
# ping値の平均を求めるための配列


logs.each do |s|
  if check_server != s[1]
    if count >= num && check_time != ""
      all_errors << [check_server, check_time, "-"]
    end
    if overload_time != ""
      overload_list << [check_server, overload_time, "-"]
    end
    check_server = s[1]
    check_time = ""
    overload_time = ""
    count = 0
    ping_list = reset_ping_list.dup
  end
  if s[2] == '-' && check_time == ""
      check_time = s[0]
      count += 1
      ping_list = reset_ping_list.dup
  elsif s[2] != '-' && check_time != ""
    if count >= num
      all_errors << [check_server,check_time, s[0]]
    end
    check_time = ""
    count = 0
    ping_list = update_ping_list(ping_list,s[2].to_i)

  elsif s[2] == "-" && count > 0
    count += 1
  else
    ping_list = update_ping_list(ping_list, s[2].to_i)
  end
#過負荷状態の判別
  if ping_list.sum >= m * n && overload_time == ""
    overload_time = s[0]
  elsif ping_list.sum < m * n && overload_time != ""
    overload_list << [check_server, overload_time, s[0]]
    overload_time = ""
  end
end


puts "サーバーの故障時間"
all_errors.each do |t|
  if t[2] == "-"
    puts"#{t[0]}: #{change_to_date(t[1])}〜"
  else
    puts "#{t[0]}: #{change_to_date(t[1])}〜#{change_to_date(t[2])}"
  end
end

puts "サーバーの過負荷状態"
overload_list.each do |t|
  if t[2] == "-"
    puts"#{t[0]}: #{change_to_date(t[1])}〜"
  else
    puts "#{t[0]}: #{change_to_date(t[1])}〜#{change_to_date(t[2])}"
  end
end