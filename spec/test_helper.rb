module TestHelper

  def auth_as(user)
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end

  def auth_by_api_token(api_token)
    headers = { 'Api-Token': api_token }
  end

  def check_authorization(request, endpoint, user, params = nil)
    self.send(request, endpoint, headers: user ? auth_as(user) : nil, params: params)
    expect(response).to have_http_status(:unauthorized)
  end

  def check_no_authorization(request, endpoint, params = nil)
    self.send(request, endpoint, params: params)
    expect(response).to have_http_status(:successful)
  end

  def load_request(req, dir = nil)
    requests_dir = File.dirname(self.class.metadata[:file_path]) << "/#{(dir || "__requests__")}"
    request_path = File.join(requests_dir, "#{req}.json")
    file = File.new(request_path)
    @result = ERB.new(file.read).result(binding)
    file.close
    JSON.parse(@result)
  end
end