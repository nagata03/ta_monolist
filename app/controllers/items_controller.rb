class ItemsController < ApplicationController
  def new
    @items = []
    @keyword = params[:keyword]
    if @keyword.present?
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })
      
      results.each do |result|  # 検索結果からItemインスタンスを作成し、items配列に追加していく
        item = Item.new(read(result))
        @items << item
      end
    end
  end
  
  private
  
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
