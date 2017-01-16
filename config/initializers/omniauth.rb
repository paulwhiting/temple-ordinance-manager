# To use the sandbox API
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :familysearch, Rails.application.secrets.familysearch_key, '',
    :client_options => {
      site: 'https://identbeta.familysearch.org',
      api_site: 'https://beta.familysearch.org'
     }
end
