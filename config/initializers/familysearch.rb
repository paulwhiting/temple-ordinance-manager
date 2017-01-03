FamilySearch::Client::ENV_CONF = {
	:production => {
		:base_url => 'https://familysearch.org',
		:discovery_path => '/.well-known/app-meta'
	},
	:integration => {
		:base_url => 'https://integration.familysearch.org',
		:discovery_path => '/.well-known/app-meta'
	}
}

#require 'familysearch/gedcomx'

module FamilySearch
	module Middleware
    class GedcomxParser < Faraday::Response::Middleware      
      def on_complete(env)
        content_type = env[:response_headers]['content-type']
        if ['application/x-gedcomx-atom+json','application/x-fs-v1+json'].include? content_type
          env[:body] = parse(env[:body], content_type) unless [204,304].index env[:status]
        end
      end
      
      # The method that has MultiJson parse the json string.
      def parse(body, content_type)
				return body
        #case content_type
        #when 'application/x-gedcomx-atom+json'
          #FamilySearch::Gedcomx::AtomFeed.new body
        #when 'application/x-fs-v1+json'
          #FamilySearch::Gedcomx::FamilySearch.new body
        #end
      end
    end
	end
end

