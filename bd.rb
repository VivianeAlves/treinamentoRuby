require "pg"

conn = PG.connect(
    dbname: "abc",
    port: 5432,
    user: "postgres",
    password: 123
)

# registros = conn.exec "select * from materia"
#
# registros.each {|registro| puts registro}


ultimo_id = conn.exec "insert into materia (banca, nomemateria,ano,qtd_questoes,tipo)
values ('cespe','Matemática',2020,10,'geral') returning id"

id=ultimo_id[0]
puts id["id"]

# id = conn.exec "select currval(pg_get_serial_sequence('materia','id'))"
# puts id[0]


