module ExploreHelper
  include ScrapingHelper

  def find_explore_results(src, q)
    query = q.to_s.squish.downcase
    case src
    when 'nyt'
      load 'explore/nyt.rb'
      results = NYTSearchScraper.new.scrape(query)
    when 'epicurious'
      load 'explore/epicurious.rb'
      results = EpicuriousSearchScraper.new.scrape(query)
    when 'allrecipes'
      load 'explore/allrecipes.rb'
      results = AllrecipesSearchScraper.new.scrape(query)
    end
    results
  end

  def prepare_explore_preview(recipe_data)
    Recipe.new(
      title: recipe_data[:title],
      description: recipe_data[:description].to_s.squish,
      ingredients: process_recipe_ingredients(recipe_data[:ingredients]).to_s,
      instructions: process_recipe_instructions(recipe_data[:instructions]).to_s,
      source: recipe_data[:source].to_s,
      author: recipe_data[:author].to_s,
      serves: recipe_data[:serves].to_s,
      notes: recipe_data[:notes].to_s
    )
  end
end
