class Pessoa
  def initialize(nome)
    @nome = nome
  end

  def muda_nome(novo_nome)
    @nome = novo_nome
  end

  def diz_nome
    puts "meu nome é #{@nome}"
  end

  #função que recebe um numero infinito de argumentos
  def compra(*produtos)
    # produtos é uma array
    puts produtos.size

    produtos.each do |produto|
      print "#{produto} "
    end
  end

end

