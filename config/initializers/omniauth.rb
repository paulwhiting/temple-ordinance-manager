# To use the sandbox API
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :familysearch, Rails.application.secrets.familysearch_key, '',
    :client_options => { :site => 'https://integration.familysearch.org' }
end
