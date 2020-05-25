require "classifier-reborn"

classifier = ClassifierReborn::Bayes.new('geral', 'especifica')

classifier.train_geral("português", "matemática", "legislação", "constituição", "jurídico",
                       "português estuda as palavras, a linguagem e sua classificação",
                       "a constituição trabalha com leis, regimentos, súmulas e doutrinas", "lógica", "lógico", "geografia",
                       "história", "estatuto", "engenharia", "arquitetura", "texto", "direito", 'raciocínio', "química", "física", "artigo", "paragrafo",
                       "constitucional", "Contabilidade", "Estatística", "Economia", "Inglês", "Redação", "Finanças",
                       "Financeiras", "Biologia", "Econômica", "administração", "processual", "administrativo", "auditoria",
                       "redação", "humano", "desenvolvimento", "Atualidades", "Não definido", "Análise", 'Saúde', "pública", "público", "justiça", "materiais",
                       "recursos", "ambiente", "meio", "segurança", "geral", "gerais", "governamental", "governamentais", "controle",
                       "conhecimentos", "gerência", "gerenciamento", "fiscal", "teoria", "ética",
                       "governo", "federal", "estadual", "municipal", "tse", "tre", "eleitoral",
                       "eleitorais", "gestão", "tst", "trt","trabalho")

classifier.train_especifica("banco de dados", "programação", "dados", "informática", "TI",
                            "redes", "computadores", "neurais", "governança", "informação",
                            "software", "dados", "hardware", "linux", "windows", "sistemas",
                            "operacionais", "internet", "modelagem", 'bpm', "infraestrutura",
                            "computação", "distribuído", "ciência", "cbok", "pmbok", "tecnologia", "algoritmos",
                            "constitucional", "cobit", "bpmn", "togaf", "integência artificial",
                            "java", "python", "php", "c#", "c++", "objeto", "POO", "projeto",
                            "grafo", "pilha", "fila", "data","tribunal", "tribunais")


classifier_snapshot = Marshal.dump classifier
File.open("classifier.dat", "w") {|f| f.write(classifier_snapshot)}

puts classifier.classify("Legislação dos Tribunais do Trabalho (TST e TRTs)")