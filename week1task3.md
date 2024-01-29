## Resolutions for DBT Project Evaluator Issues

*Note: I believe that I accidentally resolved some expected DBT Project Evaluator issues during Task 2*.

### Issue 1
```
-- is_empty_fct_model_naming_conventions_ --
| RESOURCE_NAME | PREFIX | MODEL_TYPE | APPROPRIATE_PREFIXES |
| ------------- | ------ | ---------- | -------------------- |
| mrr           | mrr_   | marts      | dim_, fct_           |
```

--> **Resolution**: Rename `mrr` table to `fct_mrr` to follow naming conventions for a fact table.


### Issue 2
```
-- is_empty_fct_model_fanout_ --
| PARENT                | PARENT_MODEL_TYPE | LEAF_CHILDREN                                                     |
| --------------------- | ----------------- | ----------------------------------------------------------------- |
| stg_bingeflix__events | staging           | fct_active_users, fct_events, int_sessions_pivoted_to_event_names |
```

--> **Resolution**: Update the models_fanout_threshold variable to 5. There are no currently-known performance issue in our DAG to dissuade us from resolving this issue in this manner.
