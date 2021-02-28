class User < ApplicationRecord

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable

  has_many :created_tests, class_name: "Test", foreign_key: :user_id, dependent: :nullify
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :gists, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  validates :email, presence: true

  def tests_passage(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end
end
