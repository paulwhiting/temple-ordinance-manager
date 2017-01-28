# To use the sandbox API
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :familysearch, Rails.application.secrets.familysearch_key, '',
    :client_options => {
      site: 'https://ident.familysearch.org',
      api_site: 'https://familysearch.org'
     }
end
