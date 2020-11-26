# カレントディレクトリの中身を、ファイルの名前順に並べる
ls | sort -n

# nginxのプロセスのみ、出力するために「ps」コマンドの標準出力を「grep」コマンドにわたす
ps aux | grep nginx