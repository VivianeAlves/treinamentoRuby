# puts Time.now.strftime("%d/%m/%Y").eql? "27/11/2019"

# puts Time.now.getlocal.strftime("%d/%m/%Y")
hora =  Time.now.getlocal.strftime("%H:%M:%S")
puts hora[0]
# Só funciona no Rails
# data_A = Date.today
# data_B = 3.days.from_now
# Date.today + 3.days
# Time.now + 4.days

# puts "hoje: #{data_A} \ndaqui a 3 dias: #{data_B}"
