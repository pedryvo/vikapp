# spec/models/invite_spec.rb
require 'rails_helper'

RSpec.describe Invite, type: :model do
  it { should belong_to(:admin) }
  it { should belong_to(:company) }

  describe 'validations' do
    subject { create(:invite) }
    it { should validate_uniqueness_of(:admin_id).scoped_to(:company_id).with_message('already has an invite for this company') }
  end

  describe 'scopes' do
    describe '.active_in_month' do
      let!(:admin1) { create(:admin) }
      let!(:admin2) { create(:admin) }
      let!(:company1) { create(:company) }
      let!(:company2) { create(:company) }
      let!(:invite_active) { create(:invite, admin: admin1, company: company1, deactivated_at: nil) }
      let!(:invite_deactivated) { create(:invite, admin: admin2, company: company2, deactivated_at: 1.month.ago) }

      it 'returns invites that are active in the given month' do
        expect(Invite.active_in_month(Date.today.month)).to include(invite_active)
        expect(Invite.active_in_month(Date.today.month)).not_to include(invite_deactivated)
      end
    end
  end
end
