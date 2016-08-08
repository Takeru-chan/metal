#! /bin/bash
# @(#) metal.sh ver.0.2.1  2016.8.8  (c)Takeru.
#
#      Copyright (c) 2016 Takeru.
#      Released under the MIT license
#      http://opensource.org/licenses/MIT
#
#######################################################################
if test "$1" == "-s"; then
    SILENT="$1"
fi
keywd="冷延ステンレス鋼板 溶融亜鉛めっき鋼板 電気亜鉛めっき鋼板 銅小板 アルミ大板 アルミ合金板 アルミ合金形"
metal="SUS304 SGCC SECC C1100 A1050P A5052P A6063"
line="2 2 2 2 2 3 3"
URL='http://www.japanmetaldaily.com/market/details/index.php'
TMP_FILE=${HOME}/metal_temp     # ホームディレクトリを正しく指定のうえ、ご利用ください
TMP_LOG=${HOME}/metal_log
MAIL_ADDRESS=''                 # 結果をメール送信したい場合に指定する
LOG_DIRECTORY=''                # ログを保管したい場合に指定する
PATH=/usr/local/bin:$PATH

curl $SILENT $URL | nkf -w8 > $TMP_FILE

date +%Y%m%d\(%a\)%H:%M > $TMP_LOG
for num in `seq 1 7`;
do
    printf "%-6s" `echo $metal | cut -d ' ' -f $num` >> $TMP_LOG
    printf "%4d\n" `grep -e "\`echo $keywd | cut -d ' ' -f $num\`" $TMP_FILE -A \`echo $line | cut -d ' ' -f $num\` |\
        tail -1 | tr "\<|\>|," "\n" | head -3 | tail -1` >> $TMP_LOG
done

if test "$MAIL_ADDRESS" != ""; then                 # mailコマンドを正しく設定のうえ、ご利用ください
    mail -s "The market price of materials." $MAIL_ADDRESS < $TMP_LOG
fi
if test "$LOG_DIRECTORY" != ""; then
    echo >> ${HOME}/${LOG_DIRECTORY}/metal.log      # ホームディレクトリ以下に実在するログディレクトリを指定のこと
    cat $TMP_LOG >> ${HOME}/${LOG_DIRECTORY}/metal.log
else
    cat $TMP_LOG
fi

rm $TMP_FILE
rm $TMP_LOG
