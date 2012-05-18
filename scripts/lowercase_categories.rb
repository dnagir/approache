require 'yaml'

Dir['source/_posts/*'].each do |fn|
  content = File.read(fn)
  rx = /---(.+?)---/m
  yml_content = content[rx]

  #puts content, '', '  ---\|/--- ', ''

  yml = YAML.load yml_content
  post_cats = yml['categories']
  if post_cats
    post_cats = post_cats.map &:downcase
    yml['categories'] = post_cats
    content = content.sub(rx) { yml.to_yaml + "---" }
    #puts content

    File.open(fn, "w") {|f| f.write(content) }
  else
    puts "NOT CATS IN #{fn}"
  end
end
