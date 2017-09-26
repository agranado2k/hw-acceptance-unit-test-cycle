require 'rails_helper'

describe MoviesController do
    context 'create movie' do
        let(:movie_params) {{title: "Star Wars", rating: "P", release_date: "1977-05-25"}}
        let(:movie) {double('movie', title: "Star Wars")}
        
        it 'should create a new movie' do
            expect(Movie).to receive(:create!)
                .with(movie_params).and_return(movie)
            
            post :create, {movie: movie_params}
        end
        
        it 'should create a new movie' do
            allow(Movie).to receive(:create!)
                .with(movie_params).and_return(movie)
            
            post :create, {movie: movie_params}
            
            expect(response).to redirect_to(movies_path)
        end
        
        it 'should render edit form' do
            get :new
            
            expect(response).to render_template(:new)
        end
    end
    
    context 'edit/update movie' do
        let(:movie_params) {{title: "Star Wars", rating: "P", release_date: "1977-05-25"}}
        
        before :each do
           @movie = create(:movie) 
        end
        
        it 'should update a movie' do
            post :update, {id: @movie.id, movie: movie_params}
            
            expect(response).to redirect_to(movie_path)
        end
        
        it 'should render edit form' do
            get :edit , {id: @movie.id}
            
            expect(response).to render_template(:edit)
        end
    end
    
    context 'search directors' do
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
    
    context 'remove movie' do
        let(:movie_params) {{title: "Star Wars", rating: "P", release_date: "1977-05-25"}}
        
        before :each do
           @movie = create(:movie) 
        end
        
       it 'should remove movie' do
            delete :destroy, {id: @movie.id}
            
            expect(Movie.all.size).to eq(0)
       end
    end
end