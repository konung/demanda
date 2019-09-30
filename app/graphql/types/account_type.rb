module Types
  class AccountType < Types::BaseObject
    field :uuid, String, null: false
    field :name, String, null: false
    field :addresses, [Types::AddressType], null: true
  end
end
