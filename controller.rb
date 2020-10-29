require_relative 'view'
require_relative 'recipe'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Get name and  description of recipe
    recipe_name = @view.recipe_name
    recipe_description = @view.recipe_description
    # Create new Recipe
    recipe = Recipe.new(recipe_name, recipe_description)
    # Add to Cookbook repo
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    index = @view.ask_for_index_to_destroy
    @cookbook.remove_recipe(index)
    puts "Cookbook now includes: "
    display_recipes
  end

  private

  def display_recipes
    # 1. Fetch recipes from repo
    recipes = @cookbook.all
    # 2. Send them to view for display
    @view.display(recipes)
  end
end
