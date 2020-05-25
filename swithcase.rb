def procura_sede_copa_do_mundo(ano)
  case ano
  when 1895..2005
    "Não lembro... :)"
  when 2006
    "Alemanha"
  when 2010
    "África do Sul"
  when 2014
    "Brasil"
  else
    "Ano desconhecido"
  end
end

loop do
  puts "Digite um ano"
  ano = gets.chomp
  if ano.to_i == 0
    break
  else
    puts procura_sede_copa_do_mundo(ano.to_i)
  end
end

