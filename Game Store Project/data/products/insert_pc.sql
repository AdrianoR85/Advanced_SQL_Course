INSERT INTO product (product_name, category_id, quantity_per_unit, unit_price, units_in_stock, discontinued, description) VALUES
-- Linha Básica (1080p)
('PC Gamer Starter RX 6600', 7, 1, 4299.90, 15, false, 'Processador AMD Ryzen 5 5600, Placa de Vídeo RX 6600 8GB, 16GB DDR4, SSD 512GB, Fonte 550W'),
('PC Gamer Essential GTX 1660 Super', 7, 1, 3899.90, 12, false, 'Processador Intel i5-12400F, GTX 1660 Super 6GB, 16GB DDR4, SSD 480GB, Fonte 500W'),
('PC Gamer AMD Ryzen 5 5600G', 7, 1, 3199.90, 18, false, 'Processador AMD Ryzen 5 5600G (Vídeo Integrado), 16GB DDR4, SSD 512GB, Fonte 450W'),

-- Linha Intermediária (1440p)
('PC Gamer Advanced RTX 3060', 7, 1, 5999.90, 10, false, 'Processador Intel i5-13400F, RTX 3060 12GB, 16GB DDR5, SSD 1TB, Fonte 650W 80+ Bronze'),
('PC Gamer Performance RX 6700 XT', 7, 1, 6499.90, 8, false, 'Processador AMD Ryzen 7 5700X, RX 6700 XT 12GB, 32GB DDR4, SSD 1TB NVMe, Fonte 750W'),
('PC Gamer Intel Arc A750', 7, 1, 5299.90, 6, false, 'Processador Intel i5-13400F, Intel Arc A750 8GB, 16GB DDR5, SSD 1TB, Fonte 600W'),

-- Linha Avançada (1440p/4K)
('PC Gamer Pro RTX 4070', 7, 1, 10999.90, 5, false, 'Processador AMD Ryzen 7 7700X, RTX 4070 12GB, 32GB DDR5, SSD 2TB NVMe, Fonte 850W 80+ Gold'),
('PC Gamer Elite RX 7800 XT', 7, 1, 11999.90, 4, false, 'Processador AMD Ryzen 7 7800X3D, RX 7800 XT 16GB, 32GB DDR5, SSD 2TB NVMe, Fonte 850W Platinum'),
('PC Gamer Intel i7 + RTX 4070 Ti', 7, 1, 12999.90, 3, false, 'Processador Intel i7-13700K, RTX 4070 Ti 12GB, 32GB DDR5, SSD 2TB NVMe, Water Cooler 240mm'),

-- Linha Premium (4K/VR)
('PC Gamer Ultimate RTX 4090', 7, 1, 24999.90, 2, false, 'Processador AMD Ryzen 9 7950X3D, RTX 4090 24GB, 64GB DDR5, SSD 4TB NVMe, Fonte 1200W 80+ Titanium'),
('PC Gamer Creator RTX 4080', 7, 1, 18999.90, 3, false, 'Processador Intel i9-13900K, RTX 4080 16GB, 64GB DDR5, SSD 4TB NVMe, Water Cooler 360mm RGB'),
('PC Gamer Dual RX 7900 XTX', 7, 1, 17999.90, 2, false, 'Processador AMD Ryzen 9 7900X, RX 7900 XTX 24GB, 32GB DDR5, SSD 2TB NVMe, Gabinete Full Tower'),

-- Kits Especiais
('PC Gamer Streaming Edition', 7, 1, 8999.90, 5, false, 'Processador AMD Ryzen 7 5800X3D, RTX 3070 8GB, 32GB DDR4, SSD 1TB + HDD 2TB, Capture Card incluído'),
('PC Gamer RGB Edition', 7, 1, 7599.90, 7, false, 'Processador Intel i5-13600KF, RTX 4060 Ti 8GB, 32GB DDR5 RGB, SSD 1TB NVMe, Gabinete com 6 Fans RGB'),
('PC Gamer Compact SFF', 7, 1, 6899.90, 4, false, 'Processador AMD Ryzen 5 7600, RTX 4060 8GB, 32GB DDR5, SSD 1TB NVMe, Gabinete Mini-ITX'),

-- Workstations
('Workstation Pro AMD Threadripper', 7, 1, 32999.90, 1, false, 'Processador AMD Threadripper PRO 5975WX, RTX A6000 48GB, 128GB DDR4 ECC, SSD 4TB NVMe + 8TB HDD'),
('Workstation Intel Xeon RTX 5000', 7, 1, 28999.90, 1, false, 'Processador Intel Xeon W9-3495X, RTX 5000 Ada 32GB, 256GB DDR5 ECC, SSD 8TB NVMe');