require 'mechanize'
require 'pg'

conn = PG.connect(
    dbname: "qconcursos",
    port: 5432,
    user: "postgres",
    password: 123
)

agent = Mechanize.new
page = agent.get('http://google.com/')
google_form = page.form('f')
bancas = ["cespe", "fcc", "fgv", "vunesp", "funrio", "cesgranrio", "aocp", "Esaf"]
# banca = "cespe"
cargos = ["analista de sistemas", "analista de tecnologia da informação", "analista de informática"]
# cargo = "analista de ti"


for ano in 2017..2020 do
  bancas.each do |banca|
    cargos.each do |cargo|
      google_form.q = "prova #{banca} #{cargo} #{ano}"
      resultados = agent.submit(google_form)
      resultados.links.each do |link|
        if link.href.to_s.include? "https://www.qconcursos.com/questoes-de-concursos/provas/"
          url = link.href.to_s.delete_prefix("/url?q=")
          puts url
          conn.exec "insert into qconcursos_urls (url,status)
          values ('#{url}','pendente')"
        end
      end
    end
  end
end