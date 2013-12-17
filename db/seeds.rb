Category.all.each do |c| 
  puts "generating slug for #{c.title}"
  c.generate_slug 
end