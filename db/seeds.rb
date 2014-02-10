# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html


require 'highline/import'

if ENV['OVERWRITE'].to_s.downcase == 'true' or agree("WARNING: This task will destroy data in database. Are you sure you want to \ncontinue? [y/n] ")

  # Loads seed data out of default dir
  default_path = File.join(File.dirname(__FILE__), 'default')

  Rake::Task['db:load_dir'].reenable
  Rake::Task['db:load_dir'].invoke(default_path)
end