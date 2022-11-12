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
- 「count」機能を追加実装
  タイムアウトするごとに「count」を＋１する。タイムアウトから復活する際の「count」が「N(プログラム内ではnum)」以上なら「all_errors」に挿入する。

## 設問3
sample.txtに記述されたログを解析する<br>
ruby seek_log3.rb　で実行<br><br>
途中に起こるタイムアウトをどのように処理するかについて明記されていないため、過負荷状態は故障状態とは区別して考える。つまり、m回以上pingが返されている区間について、直近m回のping値の平均がtを超える区間を分析する。<br>
「ping_list」という配列を用意し直近m回のping値を保存する。新しくログを読み込むとき、先頭の値を削除してから新たなping値を後ろから挿入することで直近m回のping値を更新している。その都度総和を取り、m*Nを超えていた場合に過負荷状態であるとした。<br><br>
期間の定義やタイムアウトの処理の仕方（上限の時間とするなど）方法によって考え方も変わるため、設問として曖昧さを感じる。

## 設問4（未完成）
sample.txtに記述されたログを解析する<br>
ruby seek_log4.rb　で実行<br><br>
