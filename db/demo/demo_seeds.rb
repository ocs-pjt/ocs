# TODO : eventually delete and reset need to be removed
# Set sequence id to specific value example
# ActiveRecord::Base.connection.execute("SELECT setval('parties_party_id_seq', 9, false);")
[User, Tag, Collector, CollectorVersion, UseCase, TagsUseCase, Statistic].each do |klass|
  klass.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)
end

user2 = User.new(email: 'vialette@univ-mlv.fr',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Stéphane Vialette',
                postal_address: '10 Rue Rivotte, Besançon, France')
user2.confirm!
user2.authentication_token = "GNp72m1Tmu9Hym4a7h6n"
user2.add_role :admin
user2.is_active = true
user2.save!

Statistic.create(user: user2, stats: {permutations: 10000})

sleep 0.1

user = User.new(email: 'albert@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Albert Jacquard',
                postal_address: '2 rue du Jour 75001 Paris')
user.confirm!
user.authentication_token = "GNp72m1Tmu9Hym4a7h6"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 20000})

sleep 0.1

user = User.new(email: 'joe@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Joe Letaxi',
                postal_address: 'Biaritz, France')
user.confirm!
user.authentication_token = "joe@fakeaddress.com"
user.add_role :normal
user.save!

sleep 0.1

user = User.new(email: 'raymond@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Raymond Michel',
                postal_address: '6 pl Antoine Renard, 93160 Noisy le Grand')
user.confirm!
user.authentication_token = "GNp72m1Tmu9Hym4a7h"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 30000})

sleep 0.1

user = User.new(email: 'jake@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Jake Johnson',
                postal_address: '36 W. 17 St. 5th Fl, New York, NY 10011')
user.confirm!
user.authentication_token = "GNp72m1Tmu9Hym4a7"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 50000})

sleep 0.1

user = User.new(email: 'james@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'James Stewart',
                postal_address: '235 W Van Buren St Chicago, IL 60607')
user.confirm!
user.authentication_token = "GNp72m1Tmu9Hym4a"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 100000})

sleep 0.1

user = User.new(email: 'bradley@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Bradley Snowden',
                postal_address: 'Illinois, United States')
user.confirm!
user.authentication_token = "GNp72m1Tmu9Hym4"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 200000})

sleep 0.1

user = User.new(email: 'vladimir@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Vladimir Lenin',
                postal_address: 'Moscow')
user.confirm!
user.authentication_token = "GNp72m1Tmu9Hym"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 25000})

sleep 0.1

user = User.new(email: 'sam@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Sam Gamgi',
                postal_address: 'Bombai')
user.confirm!
user.authentication_token = "GNp72m1Tmu9H"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 100000})

sleep 0.1

user = User.new(email: 'bob@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Bob Gamgi',
                postal_address: 'Pekin')
user.confirm!
user.authentication_token = "GNp72m1Tmu9"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 50000})

sleep 0.1

user = User.new(email: 'momo@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Momo Lesudafricain',
                postal_address: 'Pretoria')
user.confirm!
user.authentication_token = "GNp72m1Tmu"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 50000})

sleep 0.1

user = User.new(email: 'no-postal-address@fakeaddress.com',
                password: 'test1234',
                password_confirmation: 'test1234',
                name: 'Jacques Sansadresse')
user.confirm!
user.authentication_token = "GNp72m1Tm"
user.add_role :normal
user.save!

Statistic.create(user: user, stats: {permutations: 30000})

Tag.create!([
  {name: 'Genomic'}, 
  {name: 'Mathematic'},
  {name: 'Geometry'},
  {name: 'Analytic algorithm'},
  {name: 'Combinatory logic'},
  {name: 'Random generation'}
])

tag1 = Tag.first
tag2 = Tag.last

file = Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures', 'files', 'fake.txt')))
Collector.create!([{name: 'RUBY'},{name: 'PYTHON'}])

collector1 = Collector.first
collector2 = Collector.last

CollectorVersion.create!([
  {version: '1.0.0', collector_id: collector1.id, file: file }, 
  {version: '1.0.1', collector_id: collector1.id, file: file },
  {version: '2.0.0', collector_id: collector2.id, file: file },
  {version: '2.0.1', collector_id: collector2.id, file: file }
])

collector_version1 = CollectorVersion.first
collector_version2 = CollectorVersion.last

UseCase.create!([
  {key: "abc", user_id: user2.id, collector_version_id: collector_version1.id},
  {key: "def", user_id: user2.id, collector_version_id: collector_version2.id}
])

use_case1 = UseCase.first
use_case2 = UseCase.last

TagsUseCase.create!([
  {tag_id: tag1.id, use_case_id: use_case1.id},
  {tag_id: tag2.id, use_case_id: use_case1.id},
  {tag_id: tag2.id, use_case_id: use_case2.id}
])

