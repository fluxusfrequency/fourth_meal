Restaurant.all.each do |r|
  r.items.each do |i|
    puts "updating item #{i} for #{r.name}..."
    i.update(photo: File.open("app/assets/images/seed/#{r.slug.gsub(/\d+/, "")}/#{rand(5) + 1}.jpg", 'r'))
  end
end