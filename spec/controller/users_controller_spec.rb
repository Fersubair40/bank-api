RSpec.describe UsersController, type: :controller do
  include RSpec::Rails::ControllerExampleGroup
  describe 'post users/' do
    subject { post 'api/v1/users'}

    it 'returns created' do
      subject

      expect(response).to have_http_status(201)
    end
  end
end