require 'active_record/migration'
require 'red_hill_consulting/core/active_record/base'
require 'red_hill_consulting/core/active_record/schema'
require 'red_hill_consulting/core/active_record/schema_dumper'
require 'red_hill_consulting/core/active_record/connection_adapters'

module ActiveRecord
  class Migrator

    def self.new(*args)
      instance = super
      ensure_redhill_on_rails_core_loaded
      instance
    end

    def self.ensure_redhill_on_rails_core_loaded
      return if @__redhill_on_rails_core_loaded == true
      
      ActiveRecord::Base.send(:include, RedHillConsulting::Core::ActiveRecord::Base)
      ActiveRecord::Schema.send(:include, RedHillConsulting::Core::ActiveRecord::Schema)
      ActiveRecord::SchemaDumper.send(:include, RedHillConsulting::Core::ActiveRecord::SchemaDumper)
      ActiveRecord::ConnectionAdapters::IndexDefinition.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::IndexDefinition)
      ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::TableDefinition)
      ActiveRecord::ConnectionAdapters::Column.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::Column)
      ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::AbstractAdapter)
      ActiveRecord::ConnectionAdapters::SchemaStatements.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::SchemaStatements)

      if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) then
        ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::PostgresqlAdapter)
      end
      if defined?(ActiveRecord::ConnectionAdapters::MysqlAdapter) then
        ActiveRecord::ConnectionAdapters::MysqlColumn.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::MysqlColumn)
        ActiveRecord::ConnectionAdapters::MysqlAdapter.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::MysqlAdapter)
      end
      if defined?(ActiveRecord::ConnectionAdapters::SQLite3Adapter) then
        ActiveRecord::ConnectionAdapters::SQLite3Adapter.send(:include, RedHillConsulting::Core::ActiveRecord::ConnectionAdapters::Sqlite3Adapter)
      end
      
      @__redhill_on_rails_core_loaded = true
    end
  end
    
end





