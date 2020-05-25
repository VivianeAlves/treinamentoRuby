
p "order".methods
# p "order".start_with?("Orde".downcase)
# 
palavra = "order"
abrev = ""
for letra in 0..2
  abrev += palavra[letra]
  print palavra[letra]
end
puts ''
puts "abrev: #{abrev}"