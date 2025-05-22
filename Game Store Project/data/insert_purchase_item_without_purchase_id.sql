DO $$
DECLARE
    r RECORD;
    product_id INT;
    unit_price NUMERIC(10,2);
    quantity INT;
BEGIN
    FOR r IN (
        SELECT p.purchase_id
        FROM purchase p
        LEFT JOIN purchase_item pi ON pi.purchase_id = p.purchase_id
        WHERE pi.purchase_id IS NULL
    ) LOOP
        -- Insere de 1 a 3 itens por nota
        FOR i IN 1..FLOOR(random() * 2 + 1)::INT LOOP
            -- Seleciona um produto aleatório
            SELECT p.product_id, p.unit_price
            INTO product_id, unit_price
            FROM product p
            ORDER BY random()
            LIMIT 1;

            -- Gera quantidade aleatória entre 1 e 3
            quantity := FLOOR(random() * 3 + 1);

            -- Insere o item
            INSERT INTO purchase_item (purchase_id, product_id, quantity, price)
            VALUES (r.purchase_id, product_id, quantity, unit_price);
        END LOOP;
    END LOOP;
END $$;
