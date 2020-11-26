text = <<-TEXT
名前：ねこ
電話：06-1234-5678
電話：090-1234-5678
電話：0795-12-3456
電話：06(1234)5678
電話：06(12345678
電話: 9999-99-9999
住所：大阪府箕面市山中町1-2-3
TEXT
p text.scan /\d\d-\d\d\d\d-\d\d\d\d/
# (直前の文字が2個以上5個以下)-(1個以上4個以下)-(ちょうど4個)
p text.scan /\d{2,5}-\d{1,4}-\d{4}/
# [-(]でハイフンかカッコ、\d{1,4}で1文字以上4文字以下、[-)]でハイフンか閉じカッコ
p text.scan /\d{2,5}[-(]\d{1,4}[-)]\d{4}/
# 一文字目は0、二文字目は0以外の半角数字
p text.scan /0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}/

birthday = '私の誕生日は1990年1月1日です'
string = /(\d+)年(\d+)月(\d+)日/.match(birthday)
p string[1]
p string[2]
p string[3]
if string = /(\d+)年(\d+)月(\d+)日/.match(birthday)
  puts "誕生日の入力ありがとうございます"
else
  puts "誕生日を正確に入力してください"
end

number = '123,456-789'
# split
p number.split
p number.split(/,|-/)
# gsub
p number.gsub(/,|-/, ':')