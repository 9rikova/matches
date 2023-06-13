require 'rails_helper'

RSpec.describe "/indicator_performances", type: :request do
  let!(:match) { create :match, :with_teams }
  let!(:indicator_id) { create(:indicator).id }
  let(:player_id) { match.first_team.players.first.id }

  describe 'POST /matches/:match_id/players/:player_id/indicator_performances' do
    it 'return success' do
      post "/matches/#{match.id}/players/#{player_id}/indicator_performances?indicator_id=#{indicator_id}"
      expect(response).to have_http_status(:success)
    end

    it 'create new indicator performance' do
      IndicatorPerformance.count

      expect{ post "/matches/#{match.id}/players/#{player_id}/indicator_performances?indicator_id=#{indicator_id}" }.to change(IndicatorPerformance, :count).by(1)
    end
  end
end