# To use the sandbox API
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :familysearch, Rails.application.secrets.familysearch_key, '',
    :client_options => {
      site: Rails.configuration.familysearch['site'],
      api_site: Rails.configuration.familysearch['api_site']
     }
end
