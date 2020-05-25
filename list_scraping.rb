require 'mechanize'

url = "http://localhost:7000/segredos/list"
dados = Mechanize.new

pagina = dados.get(url)

assunto = []

#versão brutal Dev Pro
pagina.search('.listagem h4').each do |categoria|
  palavra = categoria.text.downcase
  abrev = ""
  for letra in 0..2
    abrev += palavra[letra]
  end
  puts categoria.text
  pagina.search('.listagem ul li').each do |conteudo|
    if (conteudo.text.start_with?(abrev))
      puts conteudo.text
    end
  end
end

#
# cont = 0
# #salva categorias em um lista
# pagina.search('.listagem h4').each do |p|
#   assunto[cont] = p.text
#   # puts p.text
#   cont = cont + 1
# end
#
# lista = []
# i = 0
#
# #salva conteudo em uma lista
# pagina.search('.listagem ul li').each do |x|
#   lista[i] = x.text
#   i = i + 1
# end
#
# # lista.each do |j|
# #   puts j
# # end
#
# texto = ""
#
# assunto.each do |word|
#   palavra = word.downcase
#   abrev = ""
#   for letra in 0..2
#     abrev += palavra[letra]
#   end
#   # puts word
#   texto += "#{word} \n"
#   lista.each do |x|
#     if (x.start_with?(abrev))
#       # puts x
#       texto += "#{x} \n"
#     end
#   end
# end
#
# puts texto
