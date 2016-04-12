10.times do |index|
  Company.where(name: "Company #{index}").first_or_create
end
