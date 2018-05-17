class CreateSecrets < ActiveRecord::Migration[5.0]
  def change
    create_table :secrets do |t|
      t.string :title #데이터 타입이 string인 칼럼 title.
      t.text :content #데이터 타입이 text인 content.
      #많은 데이터를 저장하기 위해서 string이 아닌 text를 쓴다.
      t.timestamps
    end
  end
end
