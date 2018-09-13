module ErrorHandlerHelper

  def response_error(params={})
    reasons_dict = params[:reasons].inject({}){ |hash, (k, v)| hash.merge( k.to_sym => (v.is_a?(Array) ? v.first : v) )  }
    render json: {
      error: {
        message: params[:title] || "Error",
        description: params[:description] || "Please, try again later.",
        reasons: reasons_dict.each{ |k,v| reasons_dict[k] = v.humanize } || {error: ["unknown"]}
      }
      }, status: params[:status_code] || 200
    end
    
end