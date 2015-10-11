namespace :maintenance do
  task fix_nil_shared_ids: :environment do
    Recipe.where(shared_id: 'zR').each do |recipe|
     recipe.shared_id = rand(32**8).to_s(32)
     recipe.save
     puts "Fixed recipe #{recipe.id}"
    end
    puts 'Finished!'
  end
end
