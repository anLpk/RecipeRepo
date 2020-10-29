require_relative 'recipe'

class View
  def recipe_name
    puts "Recipe name:"
    print "> "
    return gets.chomp
  end

  def recipe_description
    puts "Recipe description:"
    print "> "
    return gets.chomp
  end

  def display(recipe_list)
    recipe_list.each_with_index do |recipe, index|
      puts "#{index + 1} - Name: #{recipe.name} Description: #{recipe.description}"
    end
  end

  def ask_for_index_to_destroy
    puts "Which index to delete?"
    print "> "
    return gets.chomp.to_i - 1
  end
end
