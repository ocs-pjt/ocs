require 'highline/import'
require 'faker'

ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require_relative '../config/environment'

require 'populator'

if agree("WARNING: This command should run only if the tables are empty. Are you sure you want to \ncontinue? [y/n]")
  files = Dir.glob(Rails.root.join('db', 'demo', '*.rb'))

  files.each do |file|
    load file
  end
end