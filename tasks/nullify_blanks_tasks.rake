desc "Nullify all the nullable text columns in the model specified in MODEL"
task :nullify_blanks do
  raise RuntimeError, "Please specify a model to nullify" if ENV["MODEL"].blank?

  Rake::Task[:environment].invoke

  klass = ENV["MODEL"].constantize
  klass.columns.each do |column|
    quoted_column = klass.connection.quote_column_name(column.name)
    klass.update_all("#{quoted_column} = NULL", "#{quoted_column} = ''") if column.text? && column.null
  end
end
