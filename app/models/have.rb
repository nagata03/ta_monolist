class Have < Ownership
  # クラスメソッド（インスタンスからは呼び出せない）
  def self.ranking
    self.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)  # count_item_idは一時的なカウント用カラム
  end

end
