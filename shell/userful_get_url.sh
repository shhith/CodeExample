# 引数に指定したファイル名.mdから「参考にした記事」のURLを一覧表示

function print_usage_and_exit(){
  echo >&2 "Usage: You need to enter an argument. If you choose example.md, enter 「example」 as an argument"
  exit 1
}

if [ $# -ne 1 ]; then
  print_usage_and_exit
else
  find . -name "$1.md" -exec grep -Hn "https:" {} \;
fi