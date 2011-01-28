puts "Generating some nonsense data"
Post.destroy_all
(0..50).each do |i|
  Post.create(:title => Faker::Company.bs, :content => Faker::Lorem.paragraphs(rand(10)).join("\n\n"), :author => Faker::Name.name, :tag_list => Faker::Lorem.words(rand(7)).join(","), :published_at => Time.now - rand(1000).days)
end

User.destroy_all
puts "Creating super user:"
new_password = ActiveSupport::SecureRandom.hex(3)
super_user = User.create(:email => "admin@involved.com.au", :password => new_password, :password_confirmation => new_password, :first_name => "Admin", :last_name => "User")
puts "#{super_user.email} | #{new_password}"