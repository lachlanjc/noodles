require "wombat"

=begin
TODO: THIS IS UNFINISHED.
I worked on this on Aug 15, 2015, and got tired of it and stopped.
The issue is that King Arthur has some recipes that were published prior to 2008,
and have a totally different DOM structure. My first idea was to just say that was
unspported, though perhaps that's not so great and I should just run two different
scrapers depending on the inital scrape's date result.

This is really not a very important feature to have, so I'm putting it on hold.
=end

class KingArthurFlourScraper
  include Wombat::Crawler

  def scrape(url_path)
    # If the recipe was published prior to 2008, it's un-scrapable :(

    recipe_is_old_test = Wombat.crawl do
      base_url "http://www.kingarthurflour.com"
      path url_path

      date_published css: "#recipe-summary #microdata_published"
    end

    return "unsupported" if recipe_is_old_test["date_published"].to_s.match("prior to 2008")

    recipe = Wombat.crawl do
      base_url "http://www.kingarthurflour.com"
      path url_path # sample: "/recipes/pumpkin-cake-bars-with-cream-cheese-frosting-recipe"

      title css: "h1#MoreTitleURL"

      has_ingredient_sets "true"
      ingredient_sets "css=#v_ingredients #IngredientSet", :iterator do
        header "css=#IngredientHeading"
        lines({ css: ".ingredient-list li" }, :list)
      end

      instructions({ css: "#InstructionSection p" }, :list)

      serves css: "#recipe-summary #Yield"
      notes css: ".tips-list"
    end

    recipe["ingredients"] = recipe["ingredient_sets"]

    recipe["instructions"].each do |line|
      # Removes their step numbers
      line.gsub!(/(\d+)\)\s/, "")
    end

    # Remove yield "instruction"
    recipe["instructions"].pop

    recipe
  end
end
