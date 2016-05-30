Fabricator(:road) do
  name { Faker::Address.street_name }
end