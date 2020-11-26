# もし「今日の日付.md」というファイルがなければ、作ってくれる
today=$(date "+%Y%m%d")
if [ ! -e "${today}.md" ]; then
  touch "${today}.md"
fi