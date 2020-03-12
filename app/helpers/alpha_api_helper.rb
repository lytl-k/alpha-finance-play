require 'rest-client'

module AlphaApiHelper
  API_KEYS = %w[IAGCIG363UXUVTVS YEOGLREKC49Z9ZY4 FGJB44SYQGF44193 0JI2J39OKR9R1Z5Z C76E0P2NFTVE8EBM]

  def call(filters)
    begin
      filters[:apikey] = api_key

      uri = URI(api_url)
      uri.query = URI.encode_www_form(filters)

      p uri
      p uri.to_s

      JSON.parse rest_client.execute(method: :get, url: uri.to_s)
    rescue StandardError => e
      if e.message == 'Enhance your calm'
        swap_key!
        retry
      end

      raise e
    end
  end

  private

  def api_url
    @api_url ||= ENV['API_URL'] || 'https://www.alphavantage.co/query'
  end

  def api_key
    @keys ||= API_KEYS
    @keys.first
  end

  def rest_client
    @rest_client ||= RestClient::Request
  end

  def swap_key!
    @keys.rotate!(1)
  end
end