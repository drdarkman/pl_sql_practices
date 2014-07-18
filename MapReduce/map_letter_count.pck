CREATE OR REPLACE PACKAGE map_letter_count IS

  -- Author  : DARKMAN
  -- Created : 2014.07.16. 10:32:20
  -- Purpose : tutorial

  -- Public function and procedure declarations
  FUNCTION result_set(p_documents IN SYS_REFCURSOR)
    RETURN map_reduce_type.key_value_pairs
    PIPELINED
    PARALLEL_ENABLE(PARTITION p_documents BY ANY);

END map_letter_count;
/
CREATE OR REPLACE PACKAGE BODY map_letter_count IS

  FUNCTION result_set(p_documents IN SYS_REFCURSOR)
    RETURN map_reduce_type.key_value_pairs
    PIPELINED
    PARALLEL_ENABLE(PARTITION p_documents BY ANY)
      IS
  
    TYPE document_type IS RECORD(
      doc_id NUMBER,
      text   VARCHAR2(4000));
  
    l_document       document_type;
    l_key_value_pair map_reduce_type.key_value_pair;
  
  BEGIN
  
    FETCH p_documents
      INTO l_document;
    LOOP
      EXIT WHEN p_documents%NOTFOUND;
    
      FOR i IN 1 .. length(l_document.text) LOOP
      
        l_key_value_pair.key_item   := substr(l_document.text, i, 1);
        l_key_value_pair.value_item := 1;
      
        PIPE ROW(l_key_value_pair);
      
      END LOOP;
    
      FETCH p_documents
        INTO l_document;
    
    END LOOP;
  
    RETURN;
  
  END result_set;

END map_letter_count;
/
