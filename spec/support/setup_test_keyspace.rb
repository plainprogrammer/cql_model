require 'cql'

def setup_cql_test
  cql_client = Cql::Client.connect(host: '127.0.0.1')

  begin
    cql_client.use('cql_model_test')
  rescue Cql::QueryError
    keyspace_definition = <<-KSDEF
    CREATE KEYSPACE cql_model_test
    WITH replication = {
      'class': 'SimpleStrategy',
      'replication_factor': 1
    }
    KSDEF

    cql_client.execute(keyspace_definition)
    cql_client.use('cql_model_test')
  end

  begin
    table_definition = <<-TABLEDEF
      CREATE TABLE people (
        id INT,
        first_name VARCHAR,
        last_name VARCHAR,
        dob TIMESTAMP,
        PRIMARY KEY (id)
      )
    TABLEDEF

    cql_client.execute(table_definition)
  rescue Exception
  end

  cql_client.execute("INSERT INTO people (id,first_name,last_name,dob) VALUES (1,'John','Doe','1942-06-08')")
  cql_client.execute("INSERT INTO people (id,first_name,last_name) VALUES (2,'Jane','Doe')")
  cql_client.execute("INSERT INTO people (id,first_name,last_name) VALUES (3,'Will','Smith')")

  begin
    table_definition = <<-TABLEDEF
      CREATE TABLE events (
        id INT,
        location VARCHAR,
        date TIMESTAMP,
        PRIMARY KEY (id)
      )
    TABLEDEF

    cql_client.execute(table_definition)
  rescue Exception
  end
end
