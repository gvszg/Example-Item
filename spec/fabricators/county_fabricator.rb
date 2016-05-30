Fabricator(:county) do
  name { Faker::Address.state }
end