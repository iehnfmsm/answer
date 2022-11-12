# ファイルの説明
- seek_log*.rb      :  解答のプログラム（*は設問番号）
- make_sample.rb    :  サンプル用ログファイル作成プログラム（設問１〜３）
- make_sample4.rb   :  サンプル用ログファイル作成プログラム（設問４）
- sample.txt        :  設問１〜設問３で使用したログファイル
- sample4.txt       :  設問４で使用したログファイル
- sort_sample.rb    :  ログファイルをサーバー毎に並べ替え、同じサーバーについては時間で昇順に並べ替えるプログラム
- sorted_sample.txt :  sort_sample.rbで出力されるファイル

# 解答
## 設問１
sample.txtに記述されたログを解析する<br>
ruby seek_log.rb　で実行<br><br>
初めにタイムアウトした時にその時刻を「check_time」に代入、「check_time」が空出ない時にタイムアウトしなかった場合に「all_errors」配列に[ サーバー情報 , タイムアウト開始時刻 , タイムアウト終了時刻 ]を挿入。<br>
全ログを確認後に一覧として表示する

## 設問２
sample.txtに記述されたログを解析する<br>
ruby seek_log2.rb　で実行<br><br>

## 設問3
sample.txtに記述されたログを解析する<br>
ruby seek_log3.rb　で実行<br><br>

## 設問4
sample.txtに記述されたログを解析する<br>
ruby seek_log4.rb　で実行<br><br>
