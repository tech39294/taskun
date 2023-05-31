# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| username           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :tasks
- has_many :task_templates

## tasks テーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| task_title            | string     | null: false                    |
| task_deadline         | date       | null: false                    |
| importance_status_id  | integer    | null: false                    |
| memo                  | text       |                                |
| user                  | references | null: false, foreign_key: true |
| task_template         | references | foreign_key: true              |

### Association

- belongs_to :user
- belongs_to :task_template, optional: true
- has_many :subtasks

## subtasks テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| subtask_title    | string     | null: false                    |
| subtask_deadline | date       | null: false                    |
| task             | references | null: false, foreign_key: true |
### Association

- belongs_to :task

## task_templates テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| task_template_title    | string     | null: false                    |
| task_template_deadline | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :tasks
- has_many :subtask_templates

## subtask_templates テーブル

| Column                     | Type       | Options                        |
| -------------------------- | ---------- | ------------------------------ |
| subtask_template_title     | string     | null: false                    |
| subtask_template_deadline  | integer    | null: false                    |
| task_template              | references | null: false, foreign_key: true |

### Association

- belongs_to :task_template

