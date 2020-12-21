class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    #raise params.inspect


    @pet = Pet.create(params[:pet])
  #  binding.pry
    #if it doesn't have an owner id make a new owner and associate
    if @pet.owner_id == nil
      owner = Owner.create(params[:owner])
      @pet.owner = owner
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    #binding.pry
    #@owner = Owner.find_by_id(@pet.owner_id)
    erb :'/pets/show'
  end
  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  patch '/pets/:id' do
    #raise params.inspect
    #update pet's name
    @pet = Pet.find_by_id(params[:id])
    @pet.name = params[:pet][:name]
    # if a new owner was made
    if params[:owner][:name] != ""
      #make a new owner and save shit
      @owner = Owner.new(params[:owner])
      @pet.owner = @owner
    else
    #if an existing was selected
      @pet.owner_id = params[:pet][:owner_id]
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
