# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|furigana_family_name|string|null: false|
|furigana_first_name|string|null: false|
|birthday|date|null: false|
|creditcard_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :creditcard
- has_many :products
- has_many :deliveries
- has_many :orders


## deliveriesテーブル

|Column|Type|Options|
|------|----|-------|
|for_family_name|string|null: false|
|for_first_name|string|null: false|
|for_furigana_family_name|string|null: false|
|for_furigana_first_name|string|null: false|
|address|string|null: false|
|postcode|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|city_number|integer|null: false|
|remarks|string||
|phone_number|integer||
|user_id|integer|null: false,foreign_key: true|

### Association
- belongs_to :user


### creditcards
|Column|Type|Options|
|------|----|-------|
|number|integer|null: false|
|year|integer|null: false|
|month|integer|null: false|
|code|integer|null: false|
|user_id|integer|null: false,foreign_key: true|

### Association
- belongs_to :user


### order
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|product_id|integer|null: false|
|order_date|date|null: false|

### Association
- belongs_to :user
- belongs_to :product


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|item|string|null: false, add_index: ture|
|item_info|text|null: false|
|brand|string|add_index: ture|
|status|string|null: false|
|size|string||
|delivery|string|null: false|
|region|string|null: false|
|days|string|null: false|
|price|integer|null: false|
|category_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :order
- belongs_to :category
- has_many :images, dependent: :destroy


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|parent_id|integer||
|name|string|add_index: ture|

### Association
- has_many :products
- has_ancestry


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|integer|null: false|
|product_id|string|null: false, foreign_key: true|

### Association
- belongs_to :product
