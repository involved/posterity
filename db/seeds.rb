Post.destroy_all
(0..50).each do |i|
  Post.create(:title => Faker::Company.bs, :content => Faker::Lorem.paragraphs(rand(10)).join("\n\n"), :author => Faker::Name.name, :tag_list => Faker::Lorem.words(rand(7)).join(","), :published_at => Time.now - rand(1000).days)
end