# 渡された引数の回数分だけディレクトリを作成するスクリプトを作成

for i in `seq $1`
do
  mkdir -p out/dir-$i
  touch out/dir-$i/file-{1..$i}
done