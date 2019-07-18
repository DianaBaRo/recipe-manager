# RecipeManager

The app provides a database and web interface for users to:

* Sign up, login or log out securely as an admin user or user.
* This app includes a third party signup/login via Github thanks to the OmniAuth gem.
* Users can see the recipes, rate and comment them.
* Admin users can create, read, update, and delete (CRUD) a recipe, and create and delete ingredients and categories.
* User can browse recipes by name and author and comments by author and recipe.
* User inputs are validated.
* The app include an ActiveRecord scope method to get the newest recipe that can be seen in its own URL, in this case: http://localhost:3000/newest_recipe.

RecipeManager was built with [Ruby on Rails](https://rubyonrails.org/) and [Bootstrap](https://getbootstrap.com/).


## Getting Started


### Prerequisites

You will need to have the following installed on your computer in order to use RecipeManager:

* Ruby
* Rails 5+
* bundler

```
$ sudo gem install bundler
```

### Installation

To install this app onto your local machine:

* Fork and clone this repository with HTTPS
* Open your terminal and change to the local directory where you want to clone your repository and run:

```
$ git clone + the link copied before.
```

* After checking out the repository, run the following code and automatically a file will be created or updated in your directory: Gemfile.lock with all the gems installed.

```
$ bundle install
```

* Set up the database:

```
$ rake db:create
```

```
$ rake db:migrate
```
* The app uses the dotenv gem for environment variables. Create a `.env` file in the root of the app and add `GITHUB_CLIENT_ID=your_key` and `GITHUB_CLIENT_SECRET=your_secret`. If you do not already have a GitHub account, you will need to do so in order to get these keys through Oauth on GitHub for developers, in order to log in through GitHub.

### Usage
* Run `rails s` and navigate to `http://localhost:3000`. 

```
$ rails s
```

* You can play with and create data via your console: `rails c`.

```
$ rails c
```

### Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/DianaBaRo/recipe-manager. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org/) code of conduct.

## Author

* **Diana Badas** - *Initial work* - [DianaBaRo](https://github.com/DianaBaRo)

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).