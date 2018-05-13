module Huobi
  module Rest
    module Private
      module Accounts

        # id: account id
        # state: working, lock
        # type: spot, margin
        def accounts(id: nil, state: nil, type: nil, options: {})
          options[:authenticate] = true

          params    =   {
            id:     id,
            state:  state,
            type:   type
          }

          params.delete_if { |key, value| value.nil? }

          get("/v1/account/accounts", params: params, options: options)#&.fetch("data", [])
        end

        def balance(account_id: nil)
          options = { authenticate: true }
          get("/v1/hadax/account/accounts/#{account_id}/balance", options: options)&.fetch("data", [])
        end

        def deposits(currency, options = {})
          options[:authenticate] = true
          params = {
            currency: currency.to_s.downcase,
            type: 'deposit',
            from: options.delete(:from) || 1,
            size: options.delete(:size) || 50
          }
          params.delete_if { |key, value| value.nil? }
          get("/v1/query/deposit-withdraw", params: params, options: options)&.fetch("data", [])
        end

        def withdraws(currency, options = {})
          options[:authenticate] = true
          params = {
            currency: currency.to_s.downcase,
            type: 'withdraw',
            from: options.delete(:from) || 1,
            size: options.delete(:size) || 50
          }
          params.delete_if { |key, value| value.nil? }

          get("/v1/query/deposit-withdraw", params: params, options: options)&.fetch("data", [])
        end
      end
    end
  end
end
