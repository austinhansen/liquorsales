# LiquorSales

I created this app for my father, who enjoys wine but also likes a good deal. I was inspired after speaking with someone at [Ruby YEG](http://yegrb.com/) who had developed a social media aggregator.

Notable technology:

* Nokogiri for scraping liquor store websites

* Cloudinary for automatically generating jpeg thumbnails from PDF sale flyers

* Sidekiq and Sidetiq for generating new sales on a recurring basis

* Unicorn for running a Sidekiq worker using only 1 dyno on Heroku

Things I learned from this project:

* This was my first time seeing Nokogiri. After learning how to use it, I feel like it really opens up the amount of projects I can take on.

* I'm a big fan of automation, so using Cloudinary and Sidetiq was especially interesting to me. I'm glad I learned how to use these tools, as I'll probably be needing them again.
