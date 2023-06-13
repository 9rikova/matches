# frozen_string_literal: true

class PlayerSerializer < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name
  field(:team_name) { |obj| obj.team.name }
end
