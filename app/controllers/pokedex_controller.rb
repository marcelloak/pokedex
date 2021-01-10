class PokedexController < ApplicationController
  def released_pokemon
    const records = []
    render :json => conversion(records)
  end
  
  def released_shinies
    const records = []
    render :json => conversion(records)
  end
  
  def routes
    render :json => ['released_pokemon', 'released_shinies']
  end

  def conversion(records)
    return records ? [records[0].keys, **records] : ['None', { None: '' }]
  end
end
