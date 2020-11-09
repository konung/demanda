# frozen_string_literal: true

module Types
  class UserType < BaseObject
    field :id, String, null: false, method: :uuid
    field :email, String, null: true
    field :name, String, null: false
    field :role, String, null: false
    field :phone, String, null: true
    field :cart, Types::CartType, null: true
    field :account, Types::AccountType, null: false
    field :autogenerated, Boolean, null: false
  end
end
