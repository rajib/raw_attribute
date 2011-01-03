ActiveRecord::Schema.define(:version => 0) do
  create_table "users", :force => true do |t|
    t.string "title"
    t.string "address"
  end
  
  create_table "profiles", :force => true do |t|
    t.string "title"
    t.string "address"
  end
  
  create_table "people", :force => true do |t|
    t.string "title"
    t.string "address"
  end
end

