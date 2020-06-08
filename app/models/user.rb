class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :records

  def seed n=10
    n.times do |i|
      self.records.create(
        record_type: rand(0..1),
        amount: rand(10..20000),
        notes: "Seeded record",
        category_id: rand(1..Category.count),
        date: Date.today - rand(0..30).day
      )
    end
  end
end
