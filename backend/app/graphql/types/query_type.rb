module Types
  class QueryType < Types::BaseObject
    field :categories, resolver: Resolvers::Categories
    field :taxes, resolver: Resolvers::Taxes
    field :discounts, resolver: Resolvers::Discounts

    # ---- User ----
    field :me, Types::UserType, null: true do
      description 'Returns the current user'
    end

    def me(demo: false)
      context[:current_user]
    end
  end
end
