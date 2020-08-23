module Ekylibre
  module Schema
    autoload :Column, 'ekylibre/schema/column'

    class << self
      def setup_extensions
        # TODO: rename postgis schema to extensions
        ActiveRecord::Base.connection.execute 'CREATE SCHEMA IF NOT EXISTS postgis;'
        ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS "postgis" SCHEMA postgis;'
        ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA postgis;'
        ActiveRecord::Base.connection.execute 'CREATE EXTENSION IF NOT EXISTS "unaccent" SCHEMA postgis;'
      end

      def root
        Rails.root.join('db')
      end

      def models
        @models ||= read_models.freeze
      end

      def references(table = nil, column = nil)
        if table.present? && column.present?
          if t = tables[table]
            if c = t[column]
              return c.references
            end
          end
          nil
        else
          @references ||= tables.each_with_object({}) do |table, h|
            h[table.first] = table.second
            h
          end.freeze
        end
      end

      def tables
        @tables ||= read_tables.freeze
      end

      def table_names
        @table_names ||= tables.keys.map(&:to_sym)
      end

      def columns(table)
        tables[table].values
      end

      def model_names
        @model_names ||= models.collect { |m| m.to_s.camelcase.to_sym }.sort.freeze
      end

      def reset!
        @models = nil
        @model_names = nil
        @tables = nil
        @table_names = nil
        @references = nil
      end

      protected

      def read_models
        YAML.load_file(root.join('models.yml')).map(&:to_sym)
      end

      def read_tables
        hash = begin
                 YAML.load_file(root.join('tables.yml')).deep_symbolize_keys
               rescue
                 {}
               end
        tables = {}.with_indifferent_access
        for table, columns in hash
          tables[table] = columns.each_with_object({}.with_indifferent_access) do |pair, h|
            options = pair.second
            type = options.delete(:type)
            options[:null] = !options.delete(:required)
            if ref = options[:references]
              options[:references] = (ref.start_with?('~') ? ref[1..-1] : ref.to_sym)
            end
            h[pair.first] = Column.new(pair.first, type, options).freeze
            h
          end
        end
        tables
      end
    end
  end
end
