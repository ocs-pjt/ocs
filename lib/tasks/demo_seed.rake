namespace :db do
  desc "Apply fake demo data seed"
  task :demo_seed do
    puts "Applying db/demo_seeds.rb"
    system %q{ruby db/demo_seeds.rb}
  end
end