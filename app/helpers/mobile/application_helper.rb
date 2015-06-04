module Mobile::ApplicationHelper
  def mobile_paginate
    page = params[:page].presence || 1
    next_page = page.to_i + 1
    parameters = request.query_parameters.merge(page: next_page)

    link_to '下一页', url_for(parameters), class: 'btn btn-warning btn-lg btn-block'
  end
end