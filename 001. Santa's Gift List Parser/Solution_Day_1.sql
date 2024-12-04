SELECT
    name,
    wishes ->> 'first_choice' AS primary_wish,
    wishes ->> 'second_choice' AS backup_wish,
    wishes #>> '{colors,0}' AS favourite_color,
    json_array_length(wishes::json -> 'colors') AS color_count,
    CASE
        WHEN difficulty_to_make = 1 THEN 'Simple Gift'
        WHEN difficulty_to_make = 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
    END AS gift_complexity,
    CASE
        WHEN category = 'outdoor' THEN 'Outside Workshop'
        WHEN category = 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
    END AS workshop_assignment
FROM wish_lists
LEFT JOIN children
    ON wish_lists.child_id = children.child_id
LEFT JOIN toy_catalogue
    ON wishes::json ->> 'first_choice' = toy_catalogue.toy_name
ORDER BY name ASC
LIMIT 5;
