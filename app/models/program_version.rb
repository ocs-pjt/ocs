class ProgramVersion < ActiveRecord::Base
  belongs_to :program

  validates :program, presence: true

  validates :version, format: { 
    with: /\A([0-9]|[1-9]\d{0,1})\.([0-9]|[1-9]\d{0,1})\.\d{0,2}\Z/, 
    message: "Wrong version format. Should be something like 0.0.1"
  }

end
