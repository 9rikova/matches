# frozen_string_literal: true

module ResponseHelper
  def respond_with_op(op, serializer)
    if op.success?
      success(serializer.render_as_json(op.options[:model].reload))
    else
      failure(op.error)
    end
  end

  def success(data, **options)
    render json: respond(true, data: data, **options)
  end

  def failure(error, **options)
    render json: respond(false, error: error, **options), status: options[:status] || :bad_request
  end

  def respond(success, **options)
    res = {
      success: success
    }
    res.merge!(data: options[:data]) unless options[:data].nil?
    res.merge!(meta: options[:meta]) if options[:meta]
    res.merge!(error: options[:error]) if options[:error]
    res
  end
end
