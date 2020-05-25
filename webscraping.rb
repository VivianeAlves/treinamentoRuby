require 'mechanize'

url = "http://localhost:7000"
dados = Mechanize.new

pagina = dados.get(url)
# n_colunas_extracao = (pagina.search('thead tr th').length) - 1
coluna = []

#retona as colunas da tabela
cont = 0
pagina.search('thead tr th').each do |p|
  coluna[cont] = p.text
  cont = cont + 1
end

# for x in 0..coluna.length
#   print coluna[x]
# end

#exporta para arquivo de texto
# out_file = File.new('dados_msg.txt', 'w')
# out_file.puts 'Exportando dados das mensagens:'

#retorna as linhas da tabela
pagina.search('tbody tr').each do |p|
  # Extrai as colunas dos produtos, organiza e escreve no arquivo
  f = p.search('td')
  line = "#{coluna[0]}: #{f[0].text}, "
  line += "#{coluna[1]}: #{f[1].text}, "
  line += "#{coluna[2]}: #{f[2].text}, "
  puts line
  # out_file.puts line
end

# out_file.close
