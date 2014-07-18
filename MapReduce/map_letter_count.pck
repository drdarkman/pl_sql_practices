CREATE OR REPLACE PACKAGE map_letter_count IS

  -- Author  : DARKMAN
  -- Created : 2014.07.16. 10:32:20
  -- Purpose : tutorial

  -- Public function and procedure declarations
  FUNCTION result_set(p_key_value_pairs IN SYS_REFCURSOR)
    RETURN map_reduce_type.key_value_pairs
    PIPELINED
    PARALLEL_ENABLE(PARTITION p_key_value_pairs BY ANY);

END map_letter_count;
/
CREATE OR REPLACE PACKAGE BODY map_letter_count IS

  FUNCTION result_set(p_key_value_pairs IN SYS_REFCURSOR)
    RETURN map_reduce_type.key_value_pairs
    PIPELINED
    PARALLEL_ENABLE(PARTITION p_key_value_pairs BY ANY) IS
  
    l_in1_key_value_pair       map_reduce_type.key_value_pair;
    l_out_key_value_pair       map_reduce_type.key_value_pair;
  
  BEGIN
  
    FETCH p_key_value_pairs
      INTO l_in1_key_value_pair.key_item;
  
    l_out_key_value_pair.key_item   := l_in1_key_value_pair.key_item;
    l_out_key_value_pair.value_item := 0;
  
    LOOP
      EXIT WHEN p_key_value_pairs%NOTFOUND;
    
      IF l_out_key_value_pair.key_item = l_in1_key_value_pair.key_item THEN
      
        l_out_key_value_pair.value_item := l_out_key_value_pair.value_item +
                                           l_in1_key_value_pair.value_item;
      
      ELSE
      
        PIPE ROW(l_out_key_value_pair);
      
        l_out_key_value_pair.key_item   := l_in1_key_value_pair.key_item;
        l_out_key_value_pair.value_item := 1;
      
      END IF;
    
      FETCH p_key_value_pairs
        INTO l_in1_key_value_pair;
    
    END LOOP;
  
    PIPE ROW(l_out_key_value_pair);
  
    RETURN;
  
  END result_set;

END map_letter_count;
/
