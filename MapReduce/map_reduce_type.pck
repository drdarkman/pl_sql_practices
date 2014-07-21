CREATE OR REPLACE PACKAGE map_reduce_type AS
  TYPE key_value_pair IS RECORD(
    key_item   VARCHAR2(32),
    value_item NUMBER);

  TYPE key_value_pairs IS TABLE OF key_value_pair;
  TYPE key_value_pair_cursor IS REF CURSOR
    RETURN key_value_pair;
  
END map_reduce_type;
/
