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


[![Image from Gyazo](https://i.gyazo.com/e9b6d0879e3fca6a3c210db150533e4e.png)](https://gyazo.com/e9b6d0879e3fca6a3c210db150533e4e)  
このアプリは、フリーマーケットのようにユーザー間で売買、商取引が行えるサービスです。

## 概要
FURIMAはメルカリやラクマのようなフリマアプリです。Ruby、Ruby on Rails、jQuery、MySQLで書かれています。    
FURIMAには、ログイン/ログアウト機能、商品一覧一覧ページ、商品投稿機能、商品削除機能、商品編集機能、カテゴリ別検索機能、
商品名検索機能、商品購入機能などがあります。  
クレジットカードの情報を登録することで、商品購入できるようになります。  
購入済みの商品にはSOLDが書かれ、その商品を購入できないようになっています。  

## 説明文
以下のURLは、私がFURIMA開発時に担当した箇所に関しての説明文です。  
開発環境やテスト方法に関しても記してあります。  
https://docs.google.com/document/d/1wGReMjeFLp2qzbHAvM5mCUIK-L9TT5qKAzTOy4n6RcI/edit?usp=sharing

## 著者
関 嵐丸  
E-Mail: m78.seki.ranmaru@gmail.com
<br />
<br />


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

### Association
- has_one :creditcard
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
|postcode|integer|null: false|
|prefecture_id(acitve_hash)|integer|null: false|
|city|string|null: false|
|city_number|integer|null: false|
|remarks|string||
|phone_number|string||
|user_id|integer|null: false,foreign_key: true|

### Association
- belongs_to :user


### creditcards
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user


### order
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|product_id|integer|null: false, foreign_key: true|
|order_date|date|null: false|

### Association
- belongs_to :user
- belongs_to :product


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, add_index: ture|
|item_info|text|null: false|
|brand|string|add_index: ture|
|status_id(acitve_hash)|integer|null: false|
|size|string||
|delivery_id(acitve_hash)|integer|null: false|
|region_id(acitve_hash)|integer|null: false|
|day_id(acitve_hash)|integer|null: false|
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
|ansestry|integer||
|name|string|add_index: ture|

### Association
- has_many :products
- has_ancestry


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|src|string|null: false|
|product_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :product
