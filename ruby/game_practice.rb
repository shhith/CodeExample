class Brave
  attr_reader :offense, :defense
  # セッターゲッターを一括定義
  attr_accessor :hp, :name

  # 必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  # 引数に**を記述：ハッシュしか受け取れなくなる
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  def attack(monster)
    puts "#{@name}の攻撃"

    # decision_attack_typeメソッドの呼び出し
    attack_type = decision_attack_type

    # キーワード引数を設定
    damage = calculate_damage(target: monster, attack_type: attack_type)
    # ダメージをHPに反映させる(キーワード引数を設定)
    cause_damage(target: monster, damage: damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private
  def decision_attack_type
    attack_num = rand(4)

    # 攻撃の種類（通常攻撃 or 必殺攻撃）を判定するメソッド
    if attack_num == 0
      puts "必殺攻撃"
      "special_attack"
    else
      puts "通常攻撃"
      "normal_attack"
    end
  end

  def calculate_damage(**params)
    # 変数に格納することによって将来ハッシュのキーに変更があった場合でも変更箇所が少なくて済む
    target = params[:target]
    attack_type = params[:attack_type]

    if attack_type == "special_attack"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end
  end

  # HPにダメージを反映させる
  def cause_damage(**params)
    # 変数に格納することによって将来ハッシュのキーに変更があった場合でも変更箇所が少なくて済む
    damage = params[:damage]
    target = params[:target]
    
    target.hp -= damage
    puts "#{target.name}は#{damage}のダメージを受けた"
  end

  def calculate_special_attack
    # 攻撃力が1.5倍
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end

class Monster
  attr_reader :name, :offense, :defense
  attr_accessor :hp

  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]

    # モンスターが変身したかどうかを判定するフラグ
    @transform_flag = false
    # 変身する際の閾値（トリガー）を計算
    @trigger_of_transform = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    # HPが半分以下、かつ、モンスター変身判定フラグがfalseの時に実行
    if @hp <= @trigger_of_transform && @transform_flag == false
      # モンスター変身判定フラグにtrueを代入
      @transform_flag = true
      # 変身メソッドを実行
      transform
    end
    puts "#{@name}の攻撃"
    # 勇者に与えるダメージの計算
    damage = @offense - brave.defense
    # 勇者クラスのHPにダメージを反映
    brave.hp -= damage

    puts "#{brave.name}は#{damage}のダメージを受けた"
    puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  private
    # 変身メソッドの定義
    def transform
      transform_name = "ドラゴン"

      # 変身メッセージ
      puts <<~EOS
      #{@name}は怒っている
      #{@name}は#{transform_name}に変身した
      EOS
      
      # モンスターの攻撃力を1.5倍にする
      @offense *= POWER_UP_RATE
      # モンスターの名前を変更
      @name = transform_name
    end
end

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

loop do
  brave.attack(monster)

  # モンスターのHPが0以下になったら無限ループを終了させる
  if monster.hp <= 0
    break
  end

  monster.attack(brave)

  # 勇者のHPが0以下になったら無限ループを終了させる
  if brave.hp <= 0
    break
  end
end