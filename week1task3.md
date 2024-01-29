-- is_empty_fct_model_naming_conventions_ --
| RESOURCE_NAME | PREFIX | MODEL_TYPE | APPROPRIATE_PREFIXES |
| ------------- | ------ | ---------- | -------------------- |
| mrr           | mrr_   | marts      | dim_, fct_           |

Resolution: Rename `mrr` table to `fct_mrr`



-- is_empty_fct_model_fanout_ --
| PARENT                | PARENT_MODEL_TYPE | LEAF_CHILDREN                                                     |
| --------------------- | ----------------- | ----------------------------------------------------------------- |
| stg_bingeflix__events | staging           | fct_active_users, fct_events, int_sessions_pivoted_to_event_names |
