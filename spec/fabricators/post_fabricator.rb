Fabricator(:post) do
  title { Faker::Lorem.words(5).join(" ") }
  content { Faker::Lorem.words(50).join(" ") }
end