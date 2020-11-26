class CoordinateAssistant
  def initialize
    @colors = ["black", "white", "red", "blue", "green", "brown", "gray"]
    @accessories = ["earrings", "bracelet", "necklace", "ring"]
    @bags = ["totebag", "clutchbag", "shoulderbag", "rucksack"]
    @perfume_overviews = {
      spring: "フレッシュなフローラル系、グリーン系",
      summer: "さわやかなシトラス系、マリン系",
      autumn: "セクシーなオリエンタル系",
      winter: "落ち着きのあるウッディ系、フルーティー系"
    }
  end

  def usage
    puts <<-EOS
    USAGE: You need to enter an argument.

    OPTIONS:
    -spring             Randomly choose tops and bottoms colors. Show more recommended perfumes.
    -summer             Randomly choose tops and bottoms colors. Show more recommended perfumes.
    -autumn             Randomly choose tops, bottoms and socks colors. Show more recommended perfumes.
    -winter             Randomly choose tops, bottoms and socks colors. Show more recommended perfumes.
    -accessory          Randomly select one accessory.
    -size               Show size chart.
    -weight             Calculate proper weight and beauty weight from the entered height.
                        For example, if you height is 170cm,
                        you enter 「ruby coordinate_assistant.rb 170」.

    If you don't like the color combination, run the file again.
    EOS
  end

  def choose_clothes_color
    @colors.sample
  end

  def choose_accessory
    @accessories.sample
  end

  def choose_bag
    @bags.sample
  end

  def output_recommended_perfume(user_choise)
    case user_choise
    when /^(?=.*spring).*$/
      puts "春におすすめの香水は「#{@perfume_overviews[:spring]}」です！"
    when /^(?=.*summer).*$/
      puts "夏におすすめの香水は「#{@perfume_overviews[:summer]}」です！"
    when /^(?=.*autumn).*$/
      puts "秋におすすめの香水は「#{@perfume_overviews[:autumn]}」です！"
    when /^(?=.*winter).*$/
      puts "冬におすすめの香水は「#{@perfume_overviews[:winter]}」です！"
    end
  end

  def output_the_color_selected_tops
    puts "今日のトップスの色は、#{choose_clothes_color}にしましょう！"
  end

  def output_the_color_selected_bottoms
    puts "今日のボトムスの色は、#{choose_clothes_color}にしましょう！"
  end

  def output_the_color_selected_socks
    puts "今日の靴下の色は、#{choose_clothes_color}にしましょう！"
  end

  def output_selected_accessory
    puts "今日のアクセサリーは#{choose_accessory}にしましょう！"
  end

  def output_selected_bag
    puts "今日のバッグは#{choose_bag}にしましょう！"
  end

  def calculate_proper_weight(users_height)
    (users_height.to_f / 100)**2 * 22
  end

  def calculate_beauty_weight(users_height)
    (users_height.to_f / 100)**2 * 20
  end
  
  def output_calculated_weight(users_height)
    puts "あなたの身長(#{users_height}cm)から計算した適正体重は#{calculate_proper_weight(users_height).round(1)}kgです。"
    puts "また、美容体重は#{calculate_beauty_weight(users_height).round(1)}kgです。"
  end

  def output_size_chart
    puts <<-EOS
    サイズ   身長(cm)   体重(kg)  ウエスト(cm)  胸囲(cm)
      S       ~165        ~56        ~76         ~86
      M       162~172     55~63      76~82       85~94
      L       168~178     60~72      79~85       90~100
      LL      172~184     70~85      82~88       98~105
      3L      175~        80~95      85~91       103~113
    EOS
  end

  def run(user_choise, users_height)
    case user_choise
    when "-spring", "-summer"
      output_the_color_selected_tops
      output_the_color_selected_bottoms
      output_recommended_perfume(user_choise)
    when "-autumn", "-winter"
      output_the_color_selected_tops
      output_the_color_selected_bottoms
      output_the_color_selected_socks
      output_recommended_perfume(user_choise)
    when "-accessory"
      output_selected_accessory
    when "-bag"
      output_selected_bag
    when "-size"
      output_size_chart
    when "-weight"
      output_calculated_weight(users_height)
    end
  end
end

if __FILE__ == $0
  coordinate_assistant = CoordinateAssistant.new
  if ARGV.size == 0
    coordinate_assistant.usage
  end
  coordinate_assistant.run(ARGV[0].to_s, ARGV[1].to_i)
end