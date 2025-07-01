select * from category;

INSERT INTO category (name, description, parent_category_id) VALUES
('Consoles', 'Consoles de videogame de última geração',1),
('Jogos Físicos', 'Jogos em mídia física para diversos consoles',2),
('Jogos Digitais', 'Códigos para download de jogos digitais',3),
('Acessórios', 'Controles, headsets, carregadores e outros acessórios',4),
('Merchandising', 'Camisetas, action figures e outros itens colecionáveis',5),
('Assinaturas', 'Serviços de assinatura como Xbox Game Pass, PS Plus',6),
('PC Gaming', 'Hardware e acessórios para jogos no PC',7);

-- Consoles
TRUNCATE product cascade;

INSERT INTO product (product_name, quantity_per_unit, category_id, unit_price, units_in_stock, discontinued) VALUES
('PlayStation 5', 1, 1, 4499.90, 150, false),
('Xbox Series X', 1, 1, 4299.90, 120, false),
('Nintendo Switch OLED', 1, 1, 2299.90, 200, false),
('PlayStation 5 Digital Edition', 1, 1, 3999.90, 80, false),
('Xbox Series S', 1, 1, 2499.90, 180, false),
('Xbox One X', 1, 1, 1999.90, 75, false),       
('Xbox One', 1, 1, 1799.90, 60, true),       
('PlayStation 4 Pro', 1, 1, 2199.90, 90, false),
('PlayStation 4 Slim', 1, 1, 1899.90, 110, true);

