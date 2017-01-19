# Scraper of market price of metals.
Qiitaの[シェルスクリプトを使って「これから毎日金相場をスクレイピングしようぜ？」という話](http://qiita.com/furandon_pig/items/80562f6adcce53baeb0a)を見て、ちょっとだけ本業で活用してみた。
自分で使う用なのでエラーとか全然見てないです。  

## Usage | 使い方
環境変数HOMEが指定されている前提です。
インターネットに接続した状態でmetal.shを実行してください。  

curlのダウンロード進捗を表示したくない場合は"-s"オプションを付けてください。  

[日刊鉄鋼新聞](http://www.japanmetaldaily.com)のウェブサイトからよく使いそうな以下７点の市中価格を拾ってきます。
地域ごとに高値と安値がありますが、東京の高値を取得してキロ単価に換算して表示します。  

- 冷延ステンレス鋼板（SUS304）  
- 溶融亜鉛めっき鋼板（SGC）  
- 電気亜鉛めっき鋼板（SEC）  
- 銅小板（C1100）  
- アルミ大板（A1050P）  
- アルミ合金板（A5052P）  
- アルミ合金形（A6063）  

```
pi@raspberrypi:~ $ metal
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 23712    0 23712    0     0  21674      0 --:--:--  0:00:01 --:--:-- 21694
20160808(Mon)22:27
SUS304 310
SGCC   155
SECC    86
C1100  810
A1050P 675
A5052P 695
A6063  600
```

curlとnkfがインストールされていない環境では動作しません。  

mailが正しく設定されている場合にはスクリプト内のMAIL\_ADDRESSにメールアドレスを設定しておくと、取得した結果をメール送信します。
また、取得結果を蓄積したい場合にはスクリプト内のLOG\_DIRECTORYにディレクトリ名を設定しておくと、ログを追記してゆきます。
ただしログディレクトリはホームディレクトリ下になくてはいけません。  


## PowerShell version
<strike>cronで実行するとcurlが上手くデータをダウンロードできなかったので、急遽PowerShell版を作りました。
wgetに変えてもダメだったのはなぜだろう？？？</strike>  

会社のPowerShellが古くてSelect-Stringを通した後のオブジェクトが行単位で扱いづらいので、文字切り出しがかなり力技っぽいです。
ダサいね。  

```
PS C:\Users\takeru> .\metal.ps1

2016年4月6日 19:18:06
主要金属材料市中価格
SUS304	@310
SGCC	@155
SECC	@88
C1100	@850
A1050P	@675
A5052P	@695
A6063	@600
```

## License
This script has released under the MIT license.  
[http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT)
