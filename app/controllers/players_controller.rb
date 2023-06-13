class PlayersController < ApplicationController
  def index
    success(PlayerSerializer.render_as_json(scope))
  end

  def check_indicator
    success(Players::CheckIndicator.new(resource, **params.to_unsafe_h.symbolize_keys.slice(:indicator_id, :times, :match_number)).call)
  end

  private

  def scope
    scope = base_scope
    scope = filter_collection(scope)
    scope = paginate_collection(scope)
    scope
  end

  def base_scope
    Player.all
  end

  def filter_collection(scope)
    ::Queries::Players::Fetch.call(scope, params: params)
  end

  def resource
    base_scope.find(params[:player_id])
  end
end
