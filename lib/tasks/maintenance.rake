namespace :maintenance do
  task fix_blatant_collection_arrays: :environment do
    Recipe.where(['collections IS NOT NULL']).find_each do |recipe|
      if recipe.collections.any?
        recipe.collections.reject!(&:blank?)
        recipe.save
        puts "Fixed recipe #{recipe.id}"
      end
    end
    puts 'Finished!'
  end
end
