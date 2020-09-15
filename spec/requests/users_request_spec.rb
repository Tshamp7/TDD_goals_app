require 'rails_helper'
require 'spec_helper'
require 'capybara/rails'
require 'rails-controller-testing'



    RSpec.describe UsersController, type: :controller do

        describe 'GET #new' do
            it 'returns a success code' do
                get :new
                expect(response).to have_http_status(200)
            end
        end

        describe 'POST #create' do
            context 'with invalid params' do
                it 'validates the presence of email and password' do
                    post :create, params: { user: { email: "", password: "" } }
                    expect(response).to render_template('new')
                    expect(flash[:error]).to be_present
                end
            end

            context 'with valid params' do 
                it 'redirects to the users show page' do
                    post :create, params: { user: { email: Faker::Internet.name, password: "Example1234" } }
                    expect(response).to have_http_status(302)
                    expect(response).to redirect_to(user_url(User.last))
                end

            end
        
        end

        describe 'DELETE' do
            it 'should delete the specified user' do
                test_user = User.create(email: Faker::Internet.email, password: "Example1234")
                delete :destroy, params: { id: User.last.id }
                expect(User.last).not_to eq(test_user)
                expect(response).to have_http_status(200)
                expect(response).to render_template('new')
            end
        end

    end
