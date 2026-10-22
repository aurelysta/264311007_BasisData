barang
INSERT INTO barang (id_barang, id_kios, nama_barang, kategori, harga_satuan, stok_min, satuan) VALUES
(1, 1, 'Beras Premium', 'Sembako', 14000.00, 20, 'kg'),
(2, 1, 'Minyak Goreng', 'Sembako', 18000.00, 10, 'liter'),
(3, 2, 'Cabai Merah',   'Sayuran', 45000.00, 5,  'kg'),
(4, 2, 'Bawang Merah',  'Sayuran', 32000.00, 8,  'kg'),
(5, 3, 'Telur Ayam',    'Sembako', 28000.00, 10, 'kg');

transaksi
INSERT INTO transaksi (id_transaksi, id_pembeli, id_pedagang, tanggal, metode_pembayaran, total_bayar) VALUES
(1, 1, 1, '2026-10-01', 'Tunai',    42000.00),
(2, 2, 1, '2026-10-02', 'Transfer', 64000.00),
(3, 3, 2, '2026-10-03', 'Tunai',    122000.00);

detail transaksi
INSERT INTO detail_transaksi (id_transaksi, id_barang, jumlah, harga_satuan, subtotal) VALUES
(1, 1, 3, 14000.00, 42000.00),
(2, 2, 2, 18000.00, 36000.00),
(3, 3, 2, 45000.00, 90000.00),
(3, 4, 1, 32000.00, 32000.00),
(2, 5, 1, 28000.00, 28000.00);
