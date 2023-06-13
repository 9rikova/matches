require 'rails_helper'

RSpec.describe "/players", type: :request do
  let(:match) { create :match, :with_teams }
  let(:first_team) { match.first_team }
  let(:first_team_name) { first_team.name }
  let(:second_team) { match.second_team }
  let(:indicators) { create_list(:indicator, 2) }
  let(:indicator_id) { indicators.first.id }
  let(:per_page) { Player.count }

  describe 'GET /index' do
    it 'return success' do
      get "/players?per_page=#{per_page}"
      expect(response).to have_http_status(:success)
    end

    context 'when team_id param present' do
      it 'return success' do
        get "/players?per_page=#{per_page}&team_id=#{first_team.id}"
        expect(response).to have_http_status(:success)
      end

      it 'return players from specified team' do
        get "/players?per_page=#{per_page}&team_id=#{first_team.id}"
        expect(JSON.parse(response.body)['data'].collect { |obj| obj['team_name'] }.uniq.size).to eq(1)
        expect(JSON.parse(response.body)['data'].collect { |obj| obj['team_name'] }.uniq.first).to eq(first_team_name)
      end
    end

    context 'when sort by indicator' do
      let(:top_1_player) { first_team.players.first }
      let(:top_2_player) { first_team.players.second }
      let(:top_3_player) { first_team.players.third }
      let(:top_4_player) { second_team.players.first }
      let(:top_5_player) { second_team.players.second }
      before do
        create_list :indicator_performance, 10, player: top_1_player, match: match, indicator_id: indicator_id
        create_list :indicator_performance, 9, player: top_2_player, match: match, indicator_id: indicator_id
        create_list :indicator_performance, 8, player: top_3_player, match: match, indicator_id: indicator_id
        create_list :indicator_performance, 7, player: top_4_player, match: match, indicator_id: indicator_id
        create_list :indicator_performance, 6, player: top_5_player, match: match, indicator_id: indicator_id
      end

      context 'when team_id present' do
        it 'return success' do
          get "/players?per_page=#{per_page}&team_id=#{first_team.id}&sort=indicator&indicator_id=#{indicator_id}"
          expect(response).to have_http_status(:success)
        end

        it 'return players sort by indicator players from specified team in indicator performance sort' do
          get "/players?per_page=#{per_page}&team_id=#{first_team.id}&sort=indicator&indicator_id=#{indicator_id}"
          expect(JSON.parse(response.body)['data'].collect { |obj| obj['id'] }).to eq([top_1_player.id, top_2_player.id, top_3_player.id])
        end
      end

      context 'when team_id absence' do
        it 'return success' do
          get "/players?per_page=5&sort=indicator&indicator_id=#{indicator_id}"
          expect(response).to have_http_status(:success)
        end

        it 'return players sort by indicator players in indicator performance sort' do
          get "/players?per_page=#{per_page}&sort=indicator&indicator_id=#{indicator_id}"
          expect(JSON.parse(response.body)['data'].collect { |obj| obj['id'] }).to eq([top_1_player.id, top_2_player.id, top_3_player.id, top_4_player.id, top_5_player.id])
        end
      end
    end
  end

  describe 'GET /:player_id/check_indicator' do
    let(:player) { first_team.players.first }
    let(:matches) { create_list(:match, 10, first_team: first_team, second_team: second_team) }

    context 'when player performed indicator at least one time in last five matches' do
      before do
        create(:indicator_performance, player: player, match: matches.last, indicator_id: indicator_id)
      end

      it 'return success' do
        get "/players/#{player.id}/check_indicator?indicator_id=#{indicator_id}"
        expect(response).to have_http_status(:success)
      end

      it 'return true' do
        get "/players/#{player.id}/check_indicator?indicator_id=#{indicator_id}"
        expect(JSON.parse(response.body)['data']).to be_truthy
      end
    end

    context 'when player didnt perform indicator at least one time in last five matches' do
      before do
        create(:indicator_performance, player: player, match: matches.first, indicator_id: indicator_id)
      end

      it 'return success' do
        get "/players/#{player.id}/check_indicator?indicator_id=#{indicator_id}"
        expect(response).to have_http_status(:success)
      end

      it 'return false' do
        get "/players/#{player.id}/check_indicator?indicator_id=#{indicator_id}"
        expect(JSON.parse(response.body)['data']).to be_falsey
      end
    end
  end
end