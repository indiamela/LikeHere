# LikeHere


### 「旅にでよう。好きな居場所を見つけよう。」

好きな場所のシェアに特化したSNSアプリ
友達とつながったり、自分のいまいる場所を簡単にシェアすることができます。

フィーリングタグ機能で、気持ちをワンタップで表現でき、場所探しも簡単！

気になる場所を見つけたら「行きたい！」ボタンをタップしてチェックしておきましょう！
  
# SCREENS
<img src="https://user-images.githubusercontent.com/57088740/126062566-7c7d5f1d-9cf6-4474-86af-6c2c91b90c6f.jpeg" width="200"> <img src="https://user-images.githubusercontent.com/57088740/126062600-1eb83d4a-79f0-4607-a732-438a4f9e2173.jpeg" width="200"> <img src="https://user-images.githubusercontent.com/57088740/126062603-3cd5987d-a537-44b9-9cd5-30660b532151.jpeg" width="200"> 

<img src="https://user-images.githubusercontent.com/57088740/126062595-6c280f2a-3319-41bf-a90c-cbcc803a3a0d.jpeg" width="200"> <img src="https://user-images.githubusercontent.com/57088740/126062744-d7bdf46c-d470-486f-a352-c507019a8a41.jpeg" width="200"> <img src="https://user-images.githubusercontent.com/57088740/126062604-e7a4268c-88fa-441a-9763-270a46b9d29a.jpeg" width="200">

# Features

- Appleログイン
- Googleログイン
- 記事投稿機能
- カメラ撮影
- フォトライブラリからインポート
- 画像ダウンロード / アップロード
- タグ機能
- 行きたい場所のチェック
- 行った場所のチェック

# Requirement

### 使用言語
wift / swiftUI

### ライブラリ
- Firebase/Firestore
- Firebase/Auth
- Firebase/Storage
- WaterfallGrid

### 工夫した点

- Firebaseを利用するにあたり、通信のエラー処理をしっかり行った
- WaterFallGridを使用して画像サイズを綺麗に並べた
- ローディング中はインジケータをまわすようにした
- タグ機能で投稿を動的にしぼりこんだ
- 画像のローディングは処理が重いのでグローバルスレッドで処理

# Author
 
Taishi Kusunose
