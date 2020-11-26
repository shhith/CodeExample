# コマンドライン引数に"ok"を渡すと標準出力をok.txtへリダイレクト
# コマンドライン引数に"ng"を渡すと標準エラー出力をng.txtへリダイレクト

if [ "$@" = "ok" ]; then
  echo "標準出力です" > ok.txt
elif [ "$@" = "ng" ]; then
  echo "標準エラー出力です" >&2 >ng.txt