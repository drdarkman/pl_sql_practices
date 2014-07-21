SELECT *
  FROM (SELECT /*+ parallel */
         *
          FROM TABLE(map_letter_count.result_set(CURSOR (SELECT doc_id,
                                                         text
                                                    FROM documents))));

SELECT * FROM v$pq_sesstat;

SELECT *
  FROM TABLE(reduce_letter_count.result_set(CURSOR
                                            (SELECT *
                                               FROM TABLE(single_map_letter_count.result_set('Hello, world!')))))
ORDER BY key_item;  




SELECT /*+ parallel */
         *
          FROM TABLE(reduce_letter_count.result_set(CURSOR (SELECT /* +parallel */ *
                                                    FROM table(map_letter_count.result_set(cursor(select * from documents)))
                                                     )))
ORDER BY key_item ;

SELECT * FROM v$pq_sesstat;
                                             
