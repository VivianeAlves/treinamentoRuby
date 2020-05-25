require 'mechanize'

agent = Mechanize.new
pagina = agent.get('http://127.0.0.1:5500/index.html')

# result = agent.page.link_with(:text => 'Kick Ass 3 será lançado ainda neste ano').click
#
# pp pagina

# pagina.search(".lae-post-title a").each { |x|  puts x}

pagina.links.each do |link|
  puts link.text
end