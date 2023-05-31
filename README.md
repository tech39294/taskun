# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| username           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :tasks
- has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
- has_many :following, through: :active_relationships, source: :followed
- has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
- has_many :followers, through: :passive_relationships, source: :follower

## tasks テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| task_title            | string     | null: false                    |
| task_deadline         | date       | null: false                    |
| importance_status_id  | integer    | null: false                    |
| memo                  | text       |                                |
| task_search_status| boolean    |                                |
| user                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :subtasks
- has_many :favorites

## subtasks テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| subtask_title    | string     | null: false                    |
| subtask_deadline | date       | null: false                    |
| task             | references | null: false, foreign_key: true |
### Association

- belongs_to :task

## relationships テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| follower  | references | null: false, foreign_key: true |
| following | references | null: false, foreign_key: true |

### Association

- belongs_to :follower, class_name: "User"
- belongs_to :following, class_name: "User"
