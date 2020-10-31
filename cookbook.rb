require "csv"
require "pry-byebug"
require_relative "recipe"

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_recipe(index_to_mark)
    recipe_to_mark = @recipes[index_to_mark]
    recipe_to_mark.done!
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: true, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options ) do |row|

      #row behave like a hash row[:name] / row[:description]
      #normal if/else
      # if row[:done] == "true"
      #   row[:done] = true
      # elsif row[:done] == "false"
      #   row[:done] = false
      # end
      #

      #ternary
      #                #or true or false
      # row[:done] = (row[:done] == "true") ? true : false

      #shorter way
      row[:done] = (row[:done] == "true")
      recipe = Recipe.new(row)
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ["name", "description", "rating", "done", "prep_time"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.prep_time]
      end
    end
  end
end
