class Permutation
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :data,              type: String
  field :function,          type: String
  field :email,             type: String
  field :collector_name,    type: String
  field :collector_version, type: String
  field :program_name,      type: String
  field :program_version,   type: String    
  field :tags,              type: String

  validates :data, :function, :email, :collector_name, :collector_version, presence: true

  def user
    User.find_by(email: self.email)
  end

  def collector
    ::Collector.find_by(collector_name: self.collector_name)
  end

  def program
    Program.find_by(name: self.program_name)
  end

end
