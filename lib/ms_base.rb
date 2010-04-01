# MsBase
@@global_ar_db_name = nil

def hack_determine_running_db_name
  return if @@global_ar_db_name.nil? == false
  mysql_return_value = ActiveRecord::Base.connection.select_value("SELECT count(TABLE_NAME) FROM information_schema.TABLES where table_schema = 'information_schema'") rescue nil
  if mysql_return_value.nil? == false
    @@global_ar_db_name = 'mysql'
    return
  end
  oracle_return_value = ActiveRecord::Base.connection.select_value("SELECT count(TABLE_NAME) FROM USER_TABLES") rescue nil
  if oracle_return_value.nil? == false
    @@global_ar_db_name = 'oracle'
    return
  end
  @@global_ar_db_name = 'db2'
end

def mysql?
  hack_determine_running_db_name
  @@global_ar_db_name == 'mysql'
end

def db2?
  hack_determine_running_db_name
  @@global_ar_db_name == 'db2'  
end

def oracle?
  hack_determine_running_db_name
  @@global_ar_db_name == 'oracle'
end
