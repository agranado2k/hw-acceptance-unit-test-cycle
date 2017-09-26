require 'rails_helper'

describe MoviesController do
    let(:movie) {double('movie', id: "1", title: "Star Wars")}
    let(:fake_response) {[double('movie1'), double('movie2')]}
    
    it 'should call mehtod search_directors on Movie' do
       allow(Movie).to receive(:find)
        .with(movie.id)
        .and_return(movie) 
       expect(Movie).to receive(:search_directors)
        .with(movie)
        .and_return(fake_response) 
        
        get :search_directors, {id: movie.id}
    end
    
    context 'there are similar movies' do    
        before :each do
            allow(Movie).to receive(:find)
                .with(movie.id)
                .and_return(movie)
            allow(Movie).to receive(:search_directors)
                .with(movie)
                .and_return(fake_response) 
            
            get :search_directors, {id: movie.id}
        end
        
        it 'should render template search_directors' do
            expect(response).to render_template(:search_directors) 
        end
        
        it 'should assign the instance variable @movies' do
            expect(assigns(:movies)).to eq(fake_response) 
        end
    end
    
    context 'there is no similar movies' do
        let(:fake_response) {[]}
        
        before :each do
            allow(Movie).to receive(:find)
                .with(movie.id)
                .and_return(movie)
            allow(Movie).to receive(:search_directors)
                .with(movie)
                .and_return(fake_response) 
            
            get :search_directors, {id: movie.id}
        end
        
        it 'should render template search_directors' do
            expect(response).to redirect_to(:root) 
        end
        
        it 'should assign the instance variable @movies' do
            expect(assigns(:movies)).to eq(fake_response) 
        end
    end
    
end