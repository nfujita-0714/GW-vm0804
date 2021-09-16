# ========================================================================	
# irb	
# require './vm2.rb'	
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）	
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）	
# vm = VendingMachine.new

# ========================================================================	
# 【ステップ０】：お金の投入と払い戻し	

# 作成した自動販売機に〇〇円を入れる（操作は複数回出来る）	
# vm.slot_money (10)	
# vm.slot_money (50)	
# vm.slot_money (100)
# vm.slot_money (500)
# vm.slot_money (1000)	

# 投入金額の総額を取得できる（作成した自動販売機に入れたお金がいくらかを確認する（表示する））	
# vm.current_slot_money	

# 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する（作成した自動販売機に入れたお金を返してもらう）	
# vm.return_money	

# ========================================================================	
# 【ステップ1】：扱えないお金	

# 想定外の通貨（1円、5円、10000円）は投入金額に加算せず、そのまま釣銭としてユーザーに出力する	
# vm.slot_money (1)	
# vm.slot_money (5)	
# vm.slot_money (10000)	

# ========================================================================	
# 【ステップ2】：ジュースの管理	

# 初期状態でコーラ（120円、名前"コーラ"）を5本格納している	
# vm.stocks	

# 格納されているジュースの情報（値段と名前と在庫）を取得できる	
# vm.drink_info	

# ========================================================================	
# 【ステップ3】：購入	

# 投入金額、在庫の点でコーラが購入できるかを取得できる	
# vm.purchase

# ジュースの値段以上の投入金額が投入されている条件下で購入操作を行うと、
# ジュースの在庫を減らし、売り上げ金額を増やす	
# 投入金額が足りない場合、もしくは在庫がない場合、購入操作を行っても何もしない	
# vm.buy(Drink.cola)	

# 売上金額の確認、釣銭を出力できる	
# vm.sale_amount	
# vm.return_money

# 払い戻し操作では現在の投入金額からジュースの購入金額を引いた釣り銭を出力する	
# vm.current_slot_money	

# ========================================================================	
# 【ステップ4】：拡張機能	
# ジュースを3種類管理出来るようにする	
  # 在庫にレッドブル（値段:200円、名前”レッドブル”）5本を追加する。
  # vm.add_drink(Drink.redbull,5)

  # 在庫に水（値段:100円、名前”水”）5本を追加する。
  # vm.add_drink(Drink.water,5)

  # 投入金額、在庫の点で購入可能なリストを取得できる	
  # vm.purchase	

# ========================================================================	
# 【ステップ5】：釣り銭と売り上げ管理	

  # ジュース値段以上の投入金額が投入されている条件下で購入操作を行うと、
  # 釣り銭（投入金額とジュース値段の差分）を出力する。	
    # ジュースと投入金額が同じ場合、つまり、釣り銭0円の場合も、釣り銭0円と出力する。
    # （釣り銭の硬貨の種類は考慮しなくてよい。）
  # vm.buy(Drink.cola)

# ========================================================================	
class Drink
	attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.cola
    self.new( 'コーラ', 120, )
  end

  def self.water
    self.new( '水', 100, )
  end

  def self.redbull
    self.new( 'レッドブル', 200, )
	end
end

class VendingMachine
  attr_reader :slot_money, :sale_amount, :stocks

  MONEY = [10, 50, 100, 500, 1000].freeze

def initialize
  @slot_money = 0
    @sale_amount = 0
    @stocks = {コーラ: 5, 水: 0, レッドブル: 0}
    @drinks = [Drink.cola, Drink.water, Drink.redbull]
  end

  def current_slot_money
    @slot_money
  end

  def current_sale_amount
    @sale_amount	
  end

  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money	
  end

  def return_money
    puts "お釣り:#{@slot_money}円"
    "投入金額:#{@slot_money = 0}円"
  end

  def buy(drink)
    if current_slot_money >= drink.price && @stocks[drink.name.to_sym] > 0
      @slot_money -= drink.price
      @stocks[drink.name.to_sym] -= 1
      @sale_amount += drink.price
      puts "#{drink.name}を購入しました"
    else
      puts "在庫なし。もしくは投入金額不足のため購入できません"
  end
      "お釣り:#{@slot_money}"
  end

  def add_drink(drink, add)
    @stocks[drink.name.to_sym] += add
    "#{drink.name}の在庫は#{@stocks[drink.name.to_sym]}本になります"
  end

  def drink_info
    puts "購入できる飲み物リスト"
    @drinks.each do |drink|
      if @stocks[drink.name.to_sym] != 0
        puts "#{drink.name}・・・在庫数:#{@stocks[drink.name.to_sym]}本(１本#{drink.price}円)"
      end
    end
    "_______"
    "好きな飲み物を購入してね♪"
  end

  def purchase    
    puts "購入できる飲み物リスト"
      @drinks.each do |drink|
    if current_slot_money >= drink.price && @stocks[drink.name.to_sym] > 0
      puts "#{drink.name}・・・在庫数:#{@stocks[drink.name.to_sym]}本(１本#{drink.price}円)"
    else
      puts "#{drink.name}:購入できません"
    end
  end 
  "_______"
  "好きな飲み物を購入してね♪"
  end
end

