# Add a declarative step here for populating the DB with movies.
Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  part1 = page.body.split(e1)
  part2 = part1[2].match(e2)
  expect(part2).not_to be_nil
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: "(.*)"/ do |uncheck, rating_list|
  rating_list.split(",").each do |rating|
    rating = "ratings_"+rating
    if uncheck
      steps %Q{When I uncheck "#{rating}"}
    else
      steps %Q{When I check "#{rating}"}  
    end
  end
end

Then /I should see all the (\d+) movies/ do |movies|
  rows = all("table#movies tr").count-1
  expect(rows).to eq movies.to_i
end
