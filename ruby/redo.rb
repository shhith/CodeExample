# 「はい」と言うまで繰り返す処理
animals = ["cat", "dog", "wolf", "rabbit"]

count = 0
animals.each do |animal|
  puts "#{animal}は好きですか？"
  # sampleで配列からランダムに1要素を取得する
  answer = ["はい", "いいえ", "どちらでもない"].sample
  puts answer

  redo unless answer == "はい"
end