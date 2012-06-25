Requirements
============

  * Homebrew
  * Ruby-build / rbenv
    * `brew install rbenv`
    * `brew install ruby-build`
  * Ruby 1.9.3-p194 (other Ruby 1.9's should work, but let's keep things consistent just in case)
    * `rbenv install 1.9.3-p194`
  * MongoDB
    * `brew install mongodb`
  
Getting Started
===============

  1. Clone this repo `git clone git@github.com:mhayes/deployfx.git`
  1. Run `bundle install`
  1. Run `script/bootstrap` which will copy `config/*.yml.sample` to `config/*.yml` files.
  1. Run the server `bundle exec rails s`

Login / Become Admin
====================


  1. Go to `http://localhost:3000/auth/twitter` to login
  1. To become an admin you'll need to manually set the `admin` flag to true.
    * `bundle exec rails c`
    * `irb> User.first.update_attribute(:admin, true)`

Deployment
==========

`bundle exec cap deploy`