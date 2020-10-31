class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      checkbox = recipe.done? ? "[x]" : "[ ]"
      puts "#{index + 1} - #{checkbox} - #{recipe.name} - RATING: #{recipe.rating}"
    end
  end

  # Rather than using two separate methods that does essentially the same thing,
  # We can use a generic one as defined on line 16
  # def ask_for_name
  # end

  # def ask_for_description
  # end

  def ask_for(label)
    puts "What's the recipe's #{label}"
    print "> "
    return gets.chomp
  end
end
