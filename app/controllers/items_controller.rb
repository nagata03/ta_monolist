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
        item = Item.find_or_initialize_by(read(result)) # すでに保存されているItemはitem.idの値も含める（item.idはフォームからUnwantする時に使用する
        @items << item
      end
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
    @have_users = @item.have_users
  end

end
