module PaginationHelper
  def next_url_for(scope, params)
    p = params.except(:page)
    next_page = scope.current_page + 1
    url_for(p.to_unsafe_h.merge({page: next_page}))
  end

  def prev_url_for(scope, params)
    p = params.except(:page)
    prev_page = scope.current_page > 1 ? scope.current_page - 1 : 1
    url_for(p.to_unsafe_h.merge({page: prev_page}))
  end

  def current_url_for(scope, params)
    url_for(params.to_unsafe_h)
  end

  def pagination_for(scope, params)
    {
      current_url: current_url_for(scope, params),
      next_url: next_url_for(scope, params),
      previous_url: prev_url_for(scope, params),
      current: scope.current_page,
      per_page: scope.limit_value,
      pages: scope.total_pages,
      count: scope.total_count
    }
  end
end
