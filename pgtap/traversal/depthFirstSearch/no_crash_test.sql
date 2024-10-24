BEGIN;

UPDATE edge_table SET cost = sign(cost), reverse_cost = sign(reverse_cost);
SELECT CASE WHEN min_version('3.2.0') THEN plan (59) ELSE plan(1) END;

PREPARE edges AS
SELECT id, source, target, cost, reverse_cost  FROM edge_table;

PREPARE null_ret AS
SELECT id FROM edge_table_vertices_pgr  WHERE id IN (-1);

PREPARE null_ret_arr AS
SELECT array_agg(id) FROM edge_table_vertices_pgr  WHERE id IN (-1);



CREATE OR REPLACE FUNCTION no_crash()
RETURNS SETOF TEXT AS
$BODY$
DECLARE
params TEXT[];
subs TEXT[];
BEGIN
  IF NOT min_version('3.2.0') THEN
    RETURN QUERY
    SELECT skip(1, 'Function is new on 3.2.0');
    RETURN;
  END IF;

  RETURN QUERY
  SELECT isnt_empty('edges', 'Should be not empty to tests be meaningful');
  RETURN QUERY
  SELECT is_empty('null_ret', 'Should be empty to tests be meaningful');
  RETURN QUERY
  SELECT set_eq('null_ret_arr', 'SELECT NULL::BIGINT[]', 'Should be empty to tests be meaningful');

    -- depthFirstSearch Single vertex
    params = ARRAY[
    '$$SELECT id, source, target, cost, reverse_cost  FROM edge_table$$',
    '5::BIGINT'
    ]::TEXT[];
    subs = ARRAY[
    'NULL',
    '(SELECT id FROM edge_table_vertices_pgr  WHERE id IN (-1))'
    ]::TEXT[];

    RETURN query SELECT * FROM no_crash_test('pgr_depthFirstSearch', params, subs);

    subs = ARRAY[
    'NULL',
    'NULL::BIGINT'
    ]::TEXT[];
    RETURN query SELECT * FROM no_crash_test('pgr_depthFirstSearch', params, subs);

    -- depthFirstSearch Single vertex with max_depth
    params = ARRAY[
    '$$edges$$',
    '5::BIGINT',
    'max_depth => 3::BIGINT'
    ]::TEXT[];
    subs = ARRAY[
    'NULL',
    '(SELECT id FROM edge_table_vertices_pgr  WHERE id IN (-1))',
    'max_depth => (SELECT id FROM edge_table_vertices_pgr  WHERE id IN (-1))'
    ]::TEXT[];

    RETURN query SELECT * FROM no_crash_test('pgr_depthFirstSearch', params, subs);

    subs = ARRAY[
    'NULL',
    'NULL::BIGINT',
    'max_depth => NULL::BIGINT'
    ]::TEXT[];
    RETURN query SELECT * FROM no_crash_test('pgr_depthFirstSearch', params, subs);

    -- depthFirstSearch Multiple vertices
    params = ARRAY[
    '$$edges$$',
    'ARRAY[5,3]::BIGINT[]'
    ]::TEXT[];
    subs = ARRAY[
    'NULL',
    '(SELECT array_agg(id) FROM edge_table_vertices_pgr  WHERE id IN (-1))'
    ]::TEXT[];

    RETURN query SELECT * FROM no_crash_test('pgr_depthFirstSearch', params, subs);

    subs = ARRAY[
    'NULL',
    'NULL::BIGINT[]'
    ]::TEXT[];
    RETURN query SELECT * FROM no_crash_test('pgr_depthFirstSearch', params, subs);

    -- depthFirstSearch Multiple vertices with max_depth
    params = ARRAY[
    '$$edges$$',
    'ARRAY[5,3]::BIGINT[]',
    'max_depth => 3::BIGINT'
    ]::TEXT[];
    subs = ARRAY[
    'NULL',
    '(SELECT array_agg(id) FROM edge_table_vertices_pgr  WHERE id IN (-1))',
    'max_depth => (SELECT id FROM edge_table_vertices_pgr  WHERE id IN (-1))'
    ]::TEXT[];

    RETURN query SELECT * FROM no_crash_test('pgr_depthFirstSearch', params, subs);

    subs = ARRAY[
    'NULL',
    'NULL::BIGINT[]',
    'max_depth => NULL::BIGINT'
    ]::TEXT[];
    RETURN query SELECT * FROM no_crash_test('pgr_depthFirstSearch', params, subs);

END
$BODY$
LANGUAGE plpgsql VOLATILE;


SELECT * FROM no_crash();

ROLLBACK;
