SELECT
    UNNEST(food_items) AS items,
    COUNT(*) AS frequency
FROM (
    SELECT
        CASE
            WHEN
                XMLEXISTS('//total_count/text()' passing by ref menu_data)
                = 'true'
                THEN
                    (
                        XPATH(
                            '//total_count/text()', menu_data
                        )::varchar []::integer []
                    )[1]
            WHEN
                XMLEXISTS('//total_guests/text()' passing by ref menu_data)
                = 'true'
                THEN
                    (
                        XPATH(
                            '//total_guests/text()', menu_data
                        )::varchar []::integer []
                    )[1]
            WHEN
                XMLEXISTS('//guestCount/text()' passing by ref menu_data)
                = 'true'
                THEN
                    (
                        XPATH(
                            '//guestCount/text()', menu_data
                        )::varchar []::integer []
                    )[1]
            ELSE 0
        END AS guest_count,
        XPATH('//food_item_id/text()', menu_data)::varchar [] AS food_items
    FROM christmas_menus
)
WHERE guest_count > 78
GROUP BY items
ORDER BY frequency DESC
LIMIT 1;
