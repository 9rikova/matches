# frozen_string_literal: true

module PaginateHelper
  include Pagy::Backend

  def paginate_collection(chain)
    @pagy, chain = pagy(chain)
    chain
  end

  def meta_data(base_class = nil)
    if base_class.present?
      pagy_metadata(@pagy).merge(total_count: base_class.count)
    else
      pagy_metadata(@pagy)
    end
  end
end
