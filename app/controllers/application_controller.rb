class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in  # 複数のControllerで使いたいメソッドなので、ApplicationControllerに書く
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def read(result)  # 検索結果（json形式）をハッシュ形式に変えて返す
    code = result['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
    
    {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end

end
