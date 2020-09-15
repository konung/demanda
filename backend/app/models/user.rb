# frozen_string_literal: true

class User < ApplicationRecord
  include Uuidable
  include Directionable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  authenticates_with_sorcery!

  before_destroy :check_empty_orders

  belongs_to :account
  belongs_to :language, optional: true

  has_one :cart
  has_many :orders
  has_many :comments, dependent: :destroy

  enum role: { customer: 0, admin: 1, manager: 2 }

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true
  validates :email, length: { maximum: 255 }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true
  validates :role, presence: true

  after_initialize :setup_new_user, if: :new_record?

  class << self
    def generate_from_email(email, account)
      account.users.find_or_create_by(email: email) do |user|
        user.name = email
        user.autogenerated = true
        user.password = SecureRandom.base58
      end
    end
  end

  def is_manager?
    admin? || manager?
  end

  private

  def check_empty_orders
    if orders.any?
      errors.add(:base, 'User should have no orders associated')
      throw :abort
    end
  end

  def setup_new_user
    self.role ||= :customer
  end
end
