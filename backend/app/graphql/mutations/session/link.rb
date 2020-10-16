module Mutations
  module Session
    class Link < Mutations::BaseMutation
      graphql_name 'LoginLink'

      argument :code, String, required: true

      field :errors, [String], null: true
      field :token, String, null: true

      def resolve(code:)
        user = ::User.load_from_magic_login_token(code)

        if user
          token = Jwt::TokenProvider.issue_token(user_id: user.uuid, name: user.name, role: user.role, account_id: user.account.uuid)

          { token: token, errors: [] }
        else
          invalid_response
        end
      end

      protected

      def invalid_response
        { token: '', errors: ['Invalid code'] }
      end
    end
  end
end
