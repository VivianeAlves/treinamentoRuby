require 'mechanize'
require "classifier-reborn"
require "pg"

conn = PG.connect(
    dbname: "qconcursos",
    port: 5432,
    user: "postgres",
    password: 123
)

dados = Mechanize.new
data = File.read("classifier.dat")
classifier = Marshal.load(data)

rs = conn.exec "select * from qconcursos_urls where status='pendente' order by id asc"

rs.each do |registro|
  begin
    url = registro['url'].split("&")[0]
    pagina = dados.get(url)
    info_prova = pagina.search(".q-page-heading .q-info .q-title").text.delete!(" ")
    banca = info_prova.split('-')[0].delete_prefix!("Prova")
    ano = info_prova.split('-')[1]

    puts "Inserindo no Banco os dados da url: \n#{registro['url']}"

    pagina.search(".q-discipline-item .q-heading").each do |materia|
      tmp_materia = materia.text
      if tmp_materia.index(/questão/i)
        nome_materia = tmp_materia.sub(/questão/i, "").strip
      else
        nome_materia = tmp_materia.sub(/questões/i, "").strip
      end

      numeracao = nome_materia.split(' ')[0]
      n_questoes = nome_materia.split(' ')[nome_materia.count(" ")]
      aux = nome_materia.sub(numeracao, "")
      nome_materia = aux.sub(/#{n_questoes}/, "").strip!
      nome_materia.delete_prefix!(numeracao)
      nome_materia.delete_suffix!(n_questoes)

      registro_id = conn.exec "insert into materias (banca, nome_materia,ano,tipo)
      values ('#{banca}','#{nome_materia}',#{ano},'#{classifier.classify(nome_materia)}') returning id"
      id = registro_id[0]
      chave_estrangeira = id["id"]
      puts "a materia foi inserida com sucesso!"
      contador_questoes = 0

      pagina.search('.q-discipline-item ul li').each do |assunto|
        tmp_assunto = assunto.text
        if (tmp_assunto.strip.start_with?(numeracao))
          if tmp_assunto.index(/questão/i)
            nome_assunto = tmp_assunto.sub(/questão/i, "").strip!
          else
            nome_assunto = tmp_assunto.sub(/questões/i, "").strip!
          end

          numeracao_assunto = nome_assunto.split(' ')[0]
          n_questoes_assunto = nome_assunto.split(' ')[nome_assunto.count(" ") - 1]
          aux = nome_assunto.sub(numeracao_assunto, "")
          nome_assunto = aux.sub(/#{n_questoes_assunto}/, "").strip!

          conn.exec "insert into assuntos (nome_assunto,qtd_questoes,materia_id)
          values ('#{nome_assunto}',#{n_questoes_assunto.to_i},#{chave_estrangeira.to_i})"
          puts "os assuntos foram inseridas com sucesso!"
          contador_questoes += n_questoes_assunto.to_i
        end
      end
      conn.exec "update materias set qtd_questoes =#{contador_questoes} where id =#{chave_estrangeira}"
    end
    conn.exec "update qconcursos_urls set status ='ok' where id ='#{registro['id']}'"
    puts "Dados inseridos com sucesso!"
  rescue => e
    puts e.inspect
  end
end