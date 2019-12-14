# コンセプト
「買って良かったと思える物」を共有する投稿サイトです。  
<img width="1439" alt="sample" src="https://user-images.githubusercontent.com/56299538/70850293-04264500-1ecc-11ea-9622-ea4b7d289810.png">
# 技術内容
* 言語：ruby 2.5.1
* フレームワーク：Ruby on Rails 5.1.7
* DB:  
  * 開発環境: Mysql 8.0.18  
  * 本番環境: Mysql 8.0.18
* バージョン管理：Git
* インフラ: AWS(EC2、DBサーバーにRDSを使用)
* circleciによる自動テスト  
  * 統合テスト/単体テストにはrspecを使用
* 環境構築 : docker/docker-composeを使用  
  * 開発環境には、Nginx/Puma/Mysqlコンテナを使用  
  * 本番環境には、Nginx/Pumaコンテナを使用し、RDS内でMysqlを使用

# 機能内容
* gemを使わずにページネーション
	(この部分に関して記事を書いています)
 	<https://qiita.com/Keisuke8000/items/063eb10415be82c974a4>
* ログイン機能
* 管理者機能
* ajaxを用いたお気に入り機能
* お気に入り一覧閲覧機能
* 画像のアップロード機能
* URLを認識/改行を認識
* 投稿一覧閲覧機能
* 投稿機能
* 投稿削除機能
* 投稿編集機能
* 画像投稿機能
* ユーザー登録機能
* ユーザー編集機能
* ユーザー削除機能
* ユーザー詳細表示機能
* 登録ユーザー一覧機能
* DBテーブルのリレーション機能
* gem(bcrypt)によるパスワード暗号化
* レスポンシブルデザイン


# テストユーザー 
ログイン画面に、下記と同じ内容が直接記載されています。 
* (管理者) メールアドレス: admin@example.com パスワード: 1234  
* (一般ユーザー) メールアドレス: user@example.com パスワード: 1111

# Setup

〜
# 製作者
Keisuke Yamane



