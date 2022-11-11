puts "サブネットの数"
sub_net_num = gets.to_i
puts "サブネット毎のサーバー数"
servers_each_net = gets.to_i
sub_net_list = []
servers = []
date = Time.now

def date_data(date)
  return "#{sprintf("%04d",date.year)}#{sprintf("%02d",date.month)}#{sprintf("%02d",date.day)}#{sprintf("%02d",date.hour)}#{sprintf("%02d",date.min)}#{sprintf("%02d",date.sec)}"
end

sub_net_num.times do
  pre_fix = rand(8..31)
  net = []
  sub_net = []
  pre_fix.times do
    sub_net << rand(0..1)
  end
  net = sub_net.dup
  (32 - pre_fix).times do
    net << 0
  end
  sub_net_list << (net.join("").scan(/.{1,#{8}}/) << pre_fix)

  servers_each_net.times do
    net = sub_net.dup
    (32 - pre_fix).times do
      net << rand(0..1)
    end
    servers << (net.join("").scan(/.{1,#{8}}/) << pre_fix)
  end
end

logs = []
500.times do
  servers.each do |i|
    ping = rand(500)
    if ping >= 300
      ping = "-"
    end
    logs << "#{date_data(date)},#{i[0].to_i(2)}.#{i[1].to_i(2)}.#{i[2].to_i(2)}.#{i[3].to_i(2)}/#{i[4]},#{ping}"
  end
  date += 10
end

File.open("sample4.txt", mode = "w"){|f|
  logs.each do |log|
    f.write("#{log}\n")
  end
}