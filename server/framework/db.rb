import com.orientechnologies.orient.core.db.document.ODatabaseDocumentTx
import com.orientechnologies.orient.core.db.ODatabaseRecordThreadLocal
import com.orientechnologies.orient.core.command.script.OCommandScript
import com.orientechnologies.orient.core.Orient

module DB
  PATH = 'db/orient'

  TYPE_MAPPING = {

  }

  class << self
    def open
      ODatabaseRecordThreadLocal.INSTANCE.get
    end

    def run(sql)
      cmd = OCommandScript.new sql
      open.command(cmd).execute
    end

    def init
      FileUtils.rmtree PATH
      ODatabaseRecordThreadLocal.INSTANCE.set ODatabaseDocumentTx.new("plocal:#{PATH}").create

      # classes & properties
      models = App.sketch_of :models

      sql = ''

      models.map { |class_name, values|
        # create class

        sql << "create class #{class_name}\n"

        props = values.except :links

        props.each{ |prop_name, prop_type|
          sql << "create property #{class_name}.#{prop_name} #{prop_type}\n"
        }
      }

      models.map{ |class_name, values|
        links = values[:links]

        links.each{ |link_name, link_type|
          if link_name.to_s == link_name.to_s.singularize # one-to-one
            sql << "create property #{class_name}.#{link_name} link\n"
          else # one-to-many
            sql << "create property #{class_name}.#{link_name} linklist #{link_type}\n"
          end
        }
      }

      models = App.sketch_of :indices

      models.each{ |model, indices|
        indices.each{ |index|
          props, type = index.values_at :props, :type
          sql << "create index #{model}.#{props.gsub ' ', '_'} on #{model} (#{props.gsub ' ', ','}) #{type}\n";
        }
      }

      run sql
    end

    def close
      ODatabaseRecordThreadLocal.INSTANCE.get_if_defined.try(:close)
    end
  end

end