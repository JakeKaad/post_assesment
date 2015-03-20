Fabricator(:comment) do
  content { Faker::Lorem.words(50).join(" ") }
end