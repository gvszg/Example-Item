Fabricator(:town) do
  name { Faker::Address.city }
end