SELECT bd.* FROM bi_dim bd
LEFT JOIN bi_dim_attribute bda  ON bd.DIM_ID = bda.DIM_ID
WHERE (bda.ATTRIBUTE_NAME = '${filterName}' OR bd.TEXT_FIELD = '${filterName}');
