namespace :maintenance do

  task :shared_id_setup => :environment do
   hashids = Hashids.new '113011262014'

   Recipe.all.each do |recipe|
     recipe.shared_id = hashids.encode(recipe.id * 11262014)
     recipe.save
     puts "Recipe #{recipe.id.to_s} gets #{recipe.shared_id}"
   end

   puts "_________"
   puts "Finished!"
 end


  task :collection_id_setup => :environment do
    hashids = Hashids.new "60001302015"

    Collection.all.each do |collection|
      collection.hash_id = hashids.encode(collection.id * 1302015)
      collection.save
      puts "Collection #{collection.id.to_s} gets #{collection.hash_id}"
    end

    puts "_________"
    puts "Finished!"
  end

end
