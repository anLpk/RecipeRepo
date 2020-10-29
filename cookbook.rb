require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    populate_recipes
  end

  def populate_recipes
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end

  def update_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recip|
        csv << [recip.name, recip.description]
      end
    end
  end
end
