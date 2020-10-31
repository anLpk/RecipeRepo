require_relative "view"
require 'pry-byebug'
require 'nokogiri'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  # Goal: List all recipes
  def list
    # Grab all recipe
    recipes = @cookbook.all
    # Display to the user
    @view.display(recipes)
  end

  # Goal: Create a new recipe
  def create
    # Ask the user for a recipe name
    name = @view.ask_for("name")
    # Ask the user for a recipe description
    description = @view.ask_for("description")
    # Ask the user for a recipe rating
    rating = @view.ask_for("rating").to_i
    # Ask the user for a prep time
    prep_time = @view.ask_for("prep time").to_i
    # Create the `Recipe` instance
    recipe = Recipe.new(name: name, description: description, rating: rating, prep_time: prep_time)
    # Store the new in `Cookbook`
    @cookbook.add_recipe(recipe)
  end

  # Goal: removing a recipe
  def destroy
    # List all recipes
    list
    # Grab an index of a recipe
    index = @view.ask_for("index").to_i - 1
    # Remove the recipe of the chosen index
    @cookbook.remove_recipe(index)
  end

  # def scrape (with SERVICE OBJECT)
  #   # ask for an ingredient
  #   ingredient = @view.ask_for("ingredient")
  #   #call the service object
  #   recipes = RecipesScraperService.new(ingredient).call
  #   # display it to the user
  #   @view.display(recipes)
  #   # user has to pick one recipe
  #   index_to_import = @view.ask_for("index").to_i - 1
  #   # select the recipe
  #   recipe_to_import = recipes[index_to_import]
  #   # ask the repository (cookbook) to store the recipe
  #   @cookbook.add_recipe(recipe_to_import)
  # end

  def scrape
    # ask for an ingredient
    ingredient = @view.ask_for("ingredient")
    url = "https://www.allrecipes.com/search/results/?wt=#{@ingredient}"
    # open the url and read it with  open_uri
    # transfomr the page in a ruby-friendly object -> Nokogiri
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    # search for the info that we need
    recipes = doc.search('.fixed-recipe-card__info').take(5).map do |card|
    # return an array with 5 recipes
      title = card.search("h3").text.strip
      description = card.search(".fixed-recipe-card__description").text.strip
      rate = card.search(".stars").attribute("aria-label").value.split[1].to_i
      Recipe.new(name: title, description: description, rating: rate)
    end
    # display it to the user
    @view.display(recipes)
    # user has to pick one recipe
    index_to_import = @view.ask_for("index").to_i - 1
    # select the recipe
    recipe_to_import = recipes[index_to_import]
    # ask the repository (cookbook) to store the recipe
    @cookbook.add_recipe(recipe_to_import)
  end


  def mark_as_done
    # List all the recipes
    list
    # Ask for an index
    index_to_mark = @view.ask_for("index").to_i - 1
    # Select the recipe
    @cookbook.mark_recipe(index_to_mark)
    #Save it in the repository + csv
  end
end
