puts "(サーバーの数) (pingの数)　で入力してください"
input = gets.split(" ").map(&:to_i)

puts "ファイル名を入力してください"
name = gets.chomp + ".txt"
random = Random.new(10)
date = Time.now
servers = []
input[0].times do
  server = "#{rand(256)}.#{rand(256)}.#{rand(256)}.#{rand(256)}/#{rand(8..31)}"
  servers << server
end

def date_data(date)
  return "#{sprintf("%04d",date.year)}#{sprintf("%02d",date.month)}#{sprintf("%02d",date.day)}#{sprintf("%02d",date.hour)}#{sprintf("%02d",date.min)}#{sprintf("%02d",date.sec)}"
end

p servers

File.open(name, mode = "w"){|f|
  input[1].times do
    servers.each do |server|
      ping = rand(500)
      if ping < 300
        f.write("#{date_data(date)},#{server},#{ping}\n")
      else
        f.write("#{date_data(date)},#{server},-\n")
      end
    end
    date += 10
  end
}
