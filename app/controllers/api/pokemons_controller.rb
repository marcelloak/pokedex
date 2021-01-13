class Api::PokemonsController < ApplicationController
  def index
    puts '------------------------------'
    puts 'received request'
    puts DateTime.now
    pokemons = Pokemon.all.order(:id)
    generations = Generation.all
    families = Family.all
    types = Type.all
    pokemons = pokemons.as_json.map { |pokemon|
      {
        **pokemon.symbolize_keys,
        evolves_from_id: { id: pokemon.symbolize_keys[:evolves_from_id], name: pokemon.symbolize_keys[:evolves_from_id] ? (pokemons.find {|x| x[:id] == pokemon.symbolize_keys[:evolves_from_id]})[:name] : pokemon.symbolize_keys[:evolves_from_id] },
        generation_id: { id: pokemon.symbolize_keys[:generation_id], name: (generations.find {|x| x[:id] == pokemon.symbolize_keys[:generation_id]})[:name] },
        family_id: { id: pokemon.symbolize_keys[:family_id], name: (families.find {|x| x[:id] == pokemon.symbolize_keys[:family_id]})[:name] },
        primary_type_id: { id: pokemon.symbolize_keys[:primary_type_id], name: (types.find {|x| x[:id] == pokemon.symbolize_keys[:primary_type_id]})[:icon] },
        secondary_type_id: { id: pokemon.symbolize_keys[:secondary_type_id], name: pokemon.symbolize_keys[:secondary_type_id] ? (types.find {|x| x[:id] == pokemon.symbolize_keys[:secondary_type_id]})[:icon] : pokemon.symbolize_keys[:secondary_type_id] }
      }
    }

    puts '------------------------------'
    puts 'returning data'
    puts DateTime.now
    render :json => pokemons
  end

  def show
    pokemon = Pokemon.find(params[:id])

    render :json => pokemon
  end

  def create
    pokemon = Pokemon.new(pokemon_params)

    if pokemon.save
      render :json => pokemon
    else
      render :json => {
        error: 'Pokemon was not saved'
      }
    end
  end

  def update
    pokemon = Pokemon.find(params[:id])

    if pokemon.update(pokemon_params)
      render :json => pokemon
    else
      render :json => {
        error: 'Pokemon was not updated'
      }
    end
  end

  def destroy
    pokemon = Pokemon.find(params[:id])
    pokemon.destroy

    render :json => {
      message: 'Pokemon was destroyed'
    }
  end

  def foreign_keys
    pokemons = Pokemon.all.order(:id)

    render :json => pokemons
  end

  private
    def pokemon_params
      params.permit(:name, :number, :attack, :defence, :stamina, :evolve_candy, :trade_discount, :evolve_requirement, :gender_variant, :gendered, :legendary, :mythical, :region, :evolves_from_id, :generation_id, :family_id, :primary_type_id, :secondary_type_id)
    end
end
