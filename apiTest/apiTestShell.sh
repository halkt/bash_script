#!/bin/bash
set -Ceu

##############################################################################
# APIの検証をテストするためのbashスクリプト
# url.txtに検証したいエンドポイントを一覧で記述しておくと検証ができる
##############################################################################

# APIコマンドの一覧を取得する
urlList=(`cat url.txt|xargs`);

# 変数用意
i=1;
ok_count=0;
ng_count=0;

# url.txtのエンドポイントの数だけ検証を実施
for v in "${urlList[@]}"; do
  response=$(curl -sL $v)
  if [[ ${response} == *XML* ]]; then
    echo "[OK]: ${i}行目";
    ok_count=$((++ok_count));
  else
    echo "[NG]: ${i}行目 「${v}」";
    ng_count=$((++ng_count));
  fi
  let i++;
done

# 結果を出力
echo 成功回数:${ok_count}回;
echo 失敗回数:${ng_count}回;

