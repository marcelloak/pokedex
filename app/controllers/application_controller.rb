class ApplicationController < ActionController::API
  def tables
    tables = ActiveRecord::Base.connection.tables.select { |table| table != 'schema_migrations' && table != 'ar_internal_metadata' && !table.include?('timeline') && !table.include?('special_day') && !table.include?('limit') && !table.include?('caught') && !table.include?('seen') && !table.include?('purchases') && !table.include?('candies') }
    tables = tables.map { |table| { name: table, columns: ActiveRecord::Base.connection.columns(table), foreign_keys: foreign_keys(table) } }

    render :json => tables
  end

  def timeline_tables
    tables = ActiveRecord::Base.connection.tables.select { |table| (table.include?('timeline') || table.include?('special_day') || table.include?('limit')) && !table.include?('caught') }
    tables = tables.map { |table| { name: table, columns: ActiveRecord::Base.connection.columns(table), foreign_keys: foreign_keys(table) } }

    render :json => tables
  end

  def caught_tables
    tables = ActiveRecord::Base.connection.tables.select { |table| table.include?('caught') || table.include?('seen') || table.include?('purchases') || table.include?('candies') }
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
