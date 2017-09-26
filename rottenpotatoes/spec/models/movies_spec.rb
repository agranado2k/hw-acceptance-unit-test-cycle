require 'rails_helper'

describe Movie do
    context "search director" do
        it 'should get list with similar directors' do
           star_wars = create(:movie)
           thx_1138 = create(:movie, title: "THX-1138")
           
           movies = Movie.search_directors(star_wars)
           
           expect(movies.size).to eq(1)
        end
   
        it 'should get empty list because there is no similar director' do
            star_wars = create(:movie)
            thx_1138 = create(:movie, title: "Blade Runner", director: "Ridley Scott")
           
            movies = Movie.search_directors(star_wars)
           
            expect(movies).to be_empty
        end
    end
end