# テーブル設計

## users テーブル

| Column                | Type   | Options     |
| --------------------- | ------ | ----------- |
| nickname              | string | null: false, unique: true |
| email                 | string | null: false, unique: true |
| password              | string | null: false |
| password_confirmation | string | null: false |
| name                  | string | null: false |
| name_kana             | string | null: false |
| birth_date            | date   | null: false |

### Association
- has_many :items
- has_many :buyers


## items テーブル

| Column           | Type    | Options     |
| ---------------- | ------- | ----------- |
| name             | string  | null: false |
| description      | string  | null: false |
| category         | string  | null: false |
| condition        | string  | null: false |
| shipping_fee     | string  | null: false |
| shipping_area    | string  | null: false |
| delivery_time    | string  | null: false |
| price            | integer | null: false |

### Association
- has_many :buyers
- belongs_to :user


## buyers テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user_id          | references | null: false, foreign_key: true |
| item_id          | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :shipping_address


## shipping_adresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| address          | string     | null: false                    |
| phone_number     | string     | null: false                    |
| buyer_id         | references | null: false, foreign_key: true |

### Association
- has_one :buyer