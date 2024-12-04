SELECT string_agg(symbol, '')
FROM (
    SELECT chr(value) AS symbol
    FROM letters_a
    WHERE chr(value) SIMILAR TO '[a-zA-Z,.!?: ]'
    UNION ALL
    SELECT chr(value) AS symbol
    FROM letters_b
    WHERE chr(value) SIMILAR TO '[a-zA-Z,.!?: ]'
);
