module Terjira
  module Client
    module JQLQueryBuilder
      JQL_KEYS = %w(board sprint assignee issuetype priority project status statusCategory).freeze

      def build_jql_query(options = {})
        q_options = options.inject({}) do |memo,(k,v)|
          memo[k.to_s] = v
          memo
        end.slice(*JQL_KEYS)

        query = q_options.map do |key, value|
          if value.is_a? Array
            values = value.map { |v| "\"#{v.key_value}\""}.join(",")
            "#{key} IN (#{values})"
          else
            "#{key}=#{value.key_value}"
          end
        end.reject(&:blank?).join(" AND ")

        query
      end
    end
  end
end
