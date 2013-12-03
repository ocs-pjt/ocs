class Permutation < ActiveRecord::Base
  belongs_to :use_case


  def self.insert(items, use_case)
    time = Time.now
    inserts = []
    items.each do |h|
      inserts.push "('#{h['data']}', '#{h['function']}', #{use_case.id}, '#{time}')"
    end
    sql = "INSERT INTO permutations (data, function, use_case_id, created_at) VALUES #{inserts.join(", ")}"
    ActiveRecord::Base.connection.execute sql
  end
end
