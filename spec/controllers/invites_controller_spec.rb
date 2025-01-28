require 'rails_helper'

RSpec.describe InvitesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:admin1) { create(:admin) }
  let!(:admin2) { create(:admin) }
  let!(:company1) { create(:company) }
  let!(:company2) { create(:company) }
  let!(:invite1) { create(:invite, admin: admin1, company: company1, name: 'Invite 1', deactivated_at: nil) }
  let!(:invite2) { create(:invite, admin: admin2, company: company2, name: 'Invite 2', deactivated_at: 1.month.ago) }

  before do
    Rails.application.reload_routes_unless_loaded
    sign_in admin1
  end

  describe "GET #index" do
    context "with name filter" do
      it "returns invites that match the name" do
        get :index, params: { name: 'Invite 1' }
        expect(assigns(:invites)).to include(invite1)
        expect(assigns(:invites)).not_to include(invite2)
      end
    end

    context "with company filter" do
      it "returns invites that belong to the company" do
        get :index, params: { company_id: company1.id }
        expect(assigns(:invites)).to include(invite1)
        expect(assigns(:invites)).not_to include(invite2)
      end
    end

    context "with month filter" do
      it "returns invites that are active in the given month" do
        get :index, params: { month: Date.today.month }
        expect(assigns(:invites)).to include(invite1)
        expect(assigns(:invites)).not_to include(invite2)
      end
    end
  end
end
