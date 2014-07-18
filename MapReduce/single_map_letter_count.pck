CREATE OR REPLACE PACKAGE single_map_letter_count IS

  -- Author  : DARKMAN
  -- Created : 2014.07.18. 10:59:04
  -- Purpose : tutorial

  FUNCTION result_set(p_input VARCHAR2)
    RETURN map_reduce_type.key_value_pairs
    PIPELINED;

END single_map_letter_count;
/
CREATE OR REPLACE PACKAGE BODY single_map_letter_count IS

   
  FUNCTION result_set(p_input VARCHAR2)
    RETURN map_reduce_type.key_value_pairs
    PIPELINED
     IS
    
    l_key_value_pair  map_reduce_type.key_value_pair;        
     
  BEGIN
    
    FOR i IN 1..length(p_input) LOOP
      
      l_key_value_pair.key_item   := substr(p_input, i, 1);
      l_key_value_pair.value_item := 1;
    
      PIPE ROW(l_key_value_pair);
    
    END LOOP;
  
    RETURN;
    
  END result_set;
    
END single_map_letter_count;
/
