namespace :maintenance do

  task :private_share_setup => :environment do
    hashids = Hashids.new '113011262014'

    Recipe.all.each do |recipe|
      recipe.private_share = false
      recipe.private_id = hashids.encode(recipe.id * 11262014)
      recipe.save
      puts 'Recipe #' + recipe.id.to_s + ' now has ' + recipe.private_id
    end

    puts '_________'
    puts 'Finished!'
  end

end
