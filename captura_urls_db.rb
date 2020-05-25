# require 'pg'
#
# conn = PG.connect(
#     dbname: "qconcursos",
#     port: 5432,
#     user: "postgres",
#     password: 123
# )

# lista_urls = ["http://127.0.0.1:5500/Provas%20de%20Concursos_%20CESPE%20-%202018%20-%20BNB%20-%20Especialista%20Técnico%20-%20Analista%20de%20Sistema.html",
#               "http://127.0.0.1:5500/Provas%20de%20Concursos_%20CESPE%20-%202019%20-%20TJ-AM%20-%20Analista%20Judiciário%20-%20Analista%20de%20Sistemas.html"]
#
# lista_urls.each do |url|
#   conn.exec "insert into qconcursos_urls (url,status)
#   values ('#{url}','pendente')"
# end
#
# rs = conn.exec 'select * from qconcursos_urls'
#
# rs.each do |x|
#   puts "#{x['url']} status: #{x['status']}"
# end