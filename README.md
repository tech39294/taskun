# アプリケーション名
Taskun

# アプリケーション概要
タスクを一覧で確認でき、タスクごとにサブタスクを作成し、期日を確認できる。
また期日が近くなるとアラートする。

# URL
https://taskun.onrender.com

# テスト用アカウント
・Basic認証パスワード: 2222
・Basic認証ID: admin
・メールアドレス: test1@com
・パスワード: 111111

# 利用方法
## 目標投稿
1. 一覧ページでタスクの内容と期限が確認できる
2. 追加したいタスクがある場合は新規投稿できる
3. タスクごとにサブタスクを設定でき、サブタスクの期限が近くなるとアラートする

## テンプレート作成
1. タスクテンプレートを作成できる
2. タスクテンプレートからタスクを作成できる

# アプリケーションを作成した背景
家族や友人にヒアリングしたところ、多数のタスクがある場合効率的にタスクに取り組むことができず、期限を守るのが難しいという課題が判明した。課題を分析した結果、「さまざまなタスクを一覧で見られていない」「タスクをサブタスクまで分解できていないため見通しが立っていない」「期限が近い時にアラートされていない」ことが要因と仮説を立てた。
上記を解決するために、一覧機能・タスクの分解機能・アラート機能を有するアプリケーションを開発することとした。

# 洗い出した要件
https://docs.google.com/spreadsheets/d/137tGmt9njbxhmM39MsPwI85IQpw75gF9qO51ByF4n4Q/edit?usp=sharing

# 実装した機能
タスク新規投稿機能
タスク一覧機能

# 実装予定の機能
タスク詳細機能
タスク編集機能
タスク削除機能
テンプレート作成機能
アラート機能

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/04f997bade2211cfcd0e8579c0bc6c69.png)](https://gyazo.com/04f997bade2211cfcd0e8579c0bc6c69)


# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/73d7ef7940184044f13c8592f44817fd.png)](https://gyazo.com/73d7ef7940184044f13c8592f44817fd)


# 開発環境
・フロントエンド: HTML, CSS, JavaScript
・バックエンド: Ruby
・インフラ: Render.com
・テスト: RSpec
・テキストエディタ: Visual Studio Code
・タスク管理: GitHub


# ローカルでの動作方法
以下のコマンドを順に実行

% git clone https://github.com/tech39294/taskun.git
% cd taskun
% bundle install
% yarn install


# 工夫したポイント
よりユーザー目線に立って、必要である機能を洗い出すことに注力しました。
またいくつかの機能を実装する際に、ボタンや画面遷移がユーザーにとって使いやすいように調整しました。
限られた時間の中でアプリケーションを完成させるために、どの機能が重要であるのか、重みづけを行いました。

