require 'mechanize'
require "classifier-reborn"
require "pg"

conn = PG.connect(
    dbname: "qconcursos",
    port: 5432,
    user: "postgres",
    password: 123
)

url = "https://www.qconcursos.com/questoes-de-concursos/provas/iades-2019-crf-to-analista-de-ti"
dados = Mechanize.new
pagina = dados.get(url)

data = File.read("classifier.dat")
classifier = Marshal.load(data)

info_prova = pagina.search(".q-page-heading .q-info .q-title").text.delete!(" ")
banca = info_prova.split('-')[0].delete_prefix!("Prova")
ano = info_prova.split('-')[1]

puts "Inserindo no Banco os dados da url: \n#{registro['url']}"

pagina.search(".q-discipline-item .q-heading").each do |materia|
  # substitui a string questões por espaço
  # depois.strip retira os espaços do inicio e fim da string
  if materia.text.index(/questão/i)
    nome_materia = materia.text.sub(/questão/i, "").strip
  else
    nome_materia = materia.text.sub(/questões/i, "").strip
  end

  numeracao = nome_materia.split(' ')[0]
  # corta a string no último espaço encontrado extraindo assim o número de questões
  n_questoes = nome_materia.split(' ')[nome_materia.count(" ")]
  #nome da materia sem espaços e sem números ou seja sem prefixo e sem sufixo

  nome_materia.delete_prefix!(numeracao)
  nome_materia.delete_suffix!(n_questoes)
  # puts "#{nome_materia}: #{n_questoes}"

  registro_id = conn.exec "insert into materia (banca, nome_materia,ano,tipo)
  values ('#{banca}','#{nome_materia}',#{ano},'#{classifier.classify(nome_materia)}') returning id"
  id = registro_id[0]
  chave_estrangeira = id["id"]
  puts "as materias foram inseridas com sucesso!"

  pagina.search('.q-discipline-item ul li').each do |assunto|
    if (assunto.text.strip.start_with?(numeracao))
      if assunto.text.index(/questão/i)
        nome_assunto = assunto.text.sub(/questão/i, "").strip!
      else
        nome_assunto = assunto.text.sub(/questões/i, "").strip!
      end

      numeracao_assunto = nome_assunto.split(' ')[0]
      n_questoes_assunto = nome_assunto.split(' ')[nome_assunto.count(" ") - 1]
      aux = nome_assunto.sub(numeracao_assunto, "")
      nome_assunto = aux.sub(/#{n_questoes_assunto}/, "").strip!

      conn.exec "insert into assunto (nome_assunto,qtd_questoes,materia_id)
values ('#{nome_assunto}',#{n_questoes_assunto.to_i},#{chave_estrangeira.to_i})"
      puts "os assuntos foram inseridas com sucesso!"
    end
  end
end
conn.exec "update qconcursos_urls set status ='ok' where id ='#{registro['id']}'"
puts "Dados inseridos com sucesso!"