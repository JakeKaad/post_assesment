Fabricator(:comment) do
  content { Faker::Lorem.words(50).join(" ") }
  user_id { 1 }
end
