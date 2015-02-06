namespace :maintenance do

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
