# Scraper of market price of metals.
Qiitaの[シェルスクリプトを使って「これから毎日金相場をスクレイピングしようぜ？」という話](http://qiita.com/furandon_pig/items/80562f6adcce53baeb0a)を見て、ちょっとだけ本業で活用してみた。
自分で使う用なのでエラーとか全然見てないです。  

## Usage | 使い方
環境変数HOMEが指定されている前提です。
インターネットに接続した状態でmetal.shを実行してください。  

[日刊鉄鋼新聞](http://www.japanmetaldaily.com)のウェブサイトからよく使いそうな以下６点の市中価格を拾ってきます。
地域ごとに高値と安値がありますが、東京の高値を取得してキロ単価に換算して表示します。  

- 冷延ステンレス鋼板（SUS304）  
- 溶融亜鉛めっき鋼板（SGC）  
- 電気亜鉛めっき鋼板（SEC）  
- 銅小板（C1100）  
- アルミ合金板（A5052P）  
- アルミ合金形（A6063）  

```
pi@raspberrypi:~ $ metal
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 23712    0 23712    0     0  21674      0 --:--:--  0:00:01 --:--:-- 21694
20160402(Sat)21:09
SUS304 310
SGCC   155
SECC    88
C1100  870
A5052P 695
A6063  600
```

curlがインストールされていない環境では動作しません。  

mailが正しく設定されている場合にはスクリプト内のMAIL\_ADDRESSにメールアドレスを設定しておくと、取得した結果をメール送信します。
また、取得結果を蓄積したい場合にはスクリプト内のLOG\_DIRECTORYにディレクトリ名を設定しておくと、ログを追記してゆきます。
ただしログディレクトリはホームディレクトリ下になくてはいけません。  

cronで定期的に実行する前提で作りました。  

## License
This script has released under the MIT license.  
[http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT)
