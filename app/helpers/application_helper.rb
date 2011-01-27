module ApplicationHelper
  def avatar_url(user, options = {})
    options[:size] ||= 64
    
    if user.avatar_url.present?  
      user.avatar_url
    else
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase  
      "http://gravatar.com/avatar/#{gravatar_id}.png?d=mm&r=pg&s=#{options[:size]}"  
    end
  end
  
  def avatar(user, options = {})
    options[:size] ||= 64
    image_tag avatar_url(user, options), :width => options[:size], :height => options[:size]
  end
  
  def ujs_func
    "javascript:void(0)"
  end
end
