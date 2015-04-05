import com.orientechnologies.orient.core.index.OCompositeKey

class Search < BackgroundJob
  def task(type:, **params)
    klass = store.raw_graph.metadata.immutable_schema_snapshot.get_class(type)
    query_keys = params.keys
    involved_indexes = klass.get_involved_indexes query_keys.to_java(:string).to_a
    return {
        type: 'error',
        info: 'No such index.',
        request: params.merge(type: type)
    } if involved_indexes.empty?

    index = involved_indexes.first

    # TODO support range queries
    # TODO support composite queries

    value = params[query_keys.first]

    {
        results: [*index.get(value)].map{ |record_id| record_id.to_s.delete '#' }
    }
  end
end