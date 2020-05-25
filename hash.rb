# a = nil
# # => 0
# a.nil? ? puts("É zero!") : puts("Não é zero")
#
# ar = [[1, 6, 7],
#       [34, 78, 43],
#       [2, 1, 3]]
#
# ab = {:nome => "tom", :tipo => "gato", :amigo => "Jerry"}

#puts ar.length

# for linha in 0..2
#   for coluna in 0..2
#     print "#{ar[linha][coluna]} "
#   end
#   puts
# end

#
# puts "É inteiro"if 3.class == Integer
#
# array = ["José", "Jesus", "Maria"]
#
# for x in 0..array.length - 2 do
#   puts array[x]
# end
#
#
# ar=[1,7,34]
#
#
#
# puts ar.include? (0)

#
#  puts ar.empty?

# puts "É tres"if 3 == 3
# for x,y in ab do
#   puts "#{x} é uma chave do elemento #{y} do hash ab"
# end
#

# hash = {1=>18, 2=>3}

# hash.each do |x, y|
#   puts "key: #{x} value: #{y}"
# end
# hash.keys.each do |x|
#   puts x
# end

# for x,y in ab do
#   puts "#{x}: #{y}"
# end
# 
# puts "viviane".capitalize
# 
puts "viviane".start_with?("v")

puts Time.now.strftime('%z').to_i