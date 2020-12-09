class ApplicationController < ActionController::API
  def tables
    tables = ActiveRecord::Base.connection.tables.select { |table| table != 'schema_migrations' && table != 'ar_internal_metadata' }
    tables = tables.map { |table| { name: table, columns: ActiveRecord::Base.connection.columns(table), foreign_keys: foreign_keys(table) } }

    render :json => tables
  end

  def foreign_keys(table)
    klass = table.singularize.split('_').map(&:capitalize).join('')
    keys = klass.constantize.reflect_on_all_associations(:belongs_to).map(&:name)
    tables = klass.constantize.reflect_on_all_associations(:belongs_to).map(&:table_name)
    foreign_keys = {}
    keys.each_with_index { |key, index| foreign_keys[key] = tables[index] }
    return foreign_keys
  end
end
