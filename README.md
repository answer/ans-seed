ans-seed
========

rails の db/seed.rb で使用するユーティリティー


summary
-------

* Ans::Seed::Restruct : あるキーを持つ行のあるカラムの値を上書きする


Restruct
--------

キーで検索して、その行のカラムの値を指定したもので上書き

    restruct = Ans::Seed::Restruct.new(
      Model,
      keys:    [ :key_column, :key_column2 ],
      updates: [ :update_column, :update_column2 ],
      as: :seed, # Rails 3.1
    )

    restruct.update(
      key_column:     "key",      # keys に列挙されているため、このキーで検索
      key_column2:    "key2",     #
      update_column:  "update",   # updates に列挙されているため、上書き
      update_column2: "update2",  #
      other_column:   "default",  # updates に列挙されていないため、新規作成時のみ使用
      other_column2:  "default2", #
    )

new の第一引数には、操作する ActiveRecord を指定

第二引数は、どのカラムで検索して、どのキーを上書きするかを指定

* keys:    指定したカラムをプライマリキーとみなしてテーブルを検索
* updates: 指定したカラムの値を上書き
* as:      mass-assignment の role を指定する(Rails 3.1 以上)

update には、テーブルの行の内容を Hash で指定

new 時に :keys で指定したカラムが Hash に含まれない場合、そのカラムは null で検索

指定した行が見つからない場合、 Hash の内容で新しく作成

指定した行が見つかった場合、 :updates で指定したカラムのみ上書き

:updates で指定したカラムが Hash に含まれない場合、単に無視され、上書きは起こらない

