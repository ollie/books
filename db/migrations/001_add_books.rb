Sequel.migration do
  change do
    create_table :books do
      primary_key :id

      String :name,                   null: false
      String :author
      String :path,                   null: false
      Integer :page,       default: 0, null: false
      Integer :pages,      default: 0, null: false
      Float :percentage, default: 0, null: false
      FalseClass :read,       default: false
      DateTime :created_at,             null: false
      DateTime :updated_at,             null: false
    end
  end
end
