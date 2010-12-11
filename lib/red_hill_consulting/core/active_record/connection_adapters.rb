['abstract_adapter', 'column', 'foreign_key_definition', 'index_definition', 'mysql_adapter', 'mysql_column', 'postgresql_adapter', 'schema_statements', 'sqlite3_adapter', 'table_definition'].each do |file|
  require "red_hill_consulting/core/active_record/connection_adapters/#{file}"
end