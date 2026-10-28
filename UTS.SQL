CREATE DATABASE IF NOT EXISTS pasar_db;
USE pasar_db;

-- 1. Tabel PASAR
CREATE TABLE PASAR (
    id_pasar INT AUTO_INCREMENT PRIMARY KEY,
    nama_pasar VARCHAR(100) NOT NULL,
    alamat VARCHAR(200),
    lokasi VARCHAR(100)
);

-- 2. Tabel KIOS
CREATE TABLE KIOS (
    id_kios INT AUTO_INCREMENT PRIMARY KEY,
    nama_kios VARCHAR(100) NOT NULL,
    ukuran VARCHAR(50),
    id_pasar INT NOT NULL,

    CONSTRAINT fk_kios_pasar
        FOREIGN KEY (id_pasar)
        REFERENCES PASAR(id_pasar)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 3. Tabel PELAKU_PASAR
CREATE TABLE PELAKU_PASAR (
    id_pelaku INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(200),
    no_hp VARCHAR(20)
);

-- 4. Tabel PEDAGANG
CREATE TABLE PEDAGANG (
    id_pelaku INT PRIMARY KEY,
    id_kios INT NOT NULL,
    kategori_usaha VARCHAR(100),

    CONSTRAINT fk_pedagang_pelaku
        FOREIGN KEY (id_pelaku)
        REFERENCES PELAKU_PASAR(id_pelaku)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_pedagang_kios
        FOREIGN KEY (id_kios)
        REFERENCES KIOS(id_kios)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 5. Tabel PEMBELI
CREATE TABLE PEMBELI (
    id_pelaku INT PRIMARY KEY,

    CONSTRAINT fk_pembeli_pelaku
        FOREIGN KEY (id_pelaku)
        REFERENCES PELAKU_PASAR(id_pelaku)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 6. Tabel BARANG
CREATE TABLE BARANG (
    id_barang INT AUTO_INCREMENT PRIMARY KEY,
    nama_barang VARCHAR(100) NOT NULL,
    kategori VARCHAR(100),
    harga_satuan DECIMAL(12,2) NOT NULL,
    satuan VARCHAR(30),
    stok_min INT DEFAULT 0,
    id_kios INT NOT NULL,

    CONSTRAINT fk_barang_kios
        FOREIGN KEY (id_kios)
        REFERENCES KIOS(id_kios)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_harga_barang
        CHECK (harga_satuan >= 0),

    CONSTRAINT chk_stok_min
        CHECK (stok_min >= 0)
);

-- 7. Tabel STOK
CREATE TABLE STOK (
    id_stok INT AUTO_INCREMENT PRIMARY KEY,
    id_barang INT NOT NULL,
    tanggal DATE NOT NULL,
    stok_masuk INT DEFAULT 0,
    stok_keluar INT DEFAULT 0,
    stok_akhir INT DEFAULT 0,

    CONSTRAINT fk_stok_barang
        FOREIGN KEY (id_barang)
        REFERENCES BARANG(id_barang)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_stok_masuk
        CHECK (stok_masuk >= 0),

    CONSTRAINT chk_stok_keluar
        CHECK (stok_keluar >= 0),

    CONSTRAINT chk_stok_akhir
        CHECK (stok_akhir >= 0)
);

-- 8. Tabel TRANSAKSI
CREATE TABLE TRANSAKSI (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    tanggal DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metode_pembayaran VARCHAR(50),
    total_bayar DECIMAL(14,2) NOT NULL DEFAULT 0,
    id_pembeli INT NOT NULL,
    id_pedagang INT NOT NULL,

    CONSTRAINT fk_transaksi_pembeli
        FOREIGN KEY (id_pembeli)
        REFERENCES PEMBELI(id_pelaku)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_transaksi_pedagang
        FOREIGN KEY (id_pedagang)
        REFERENCES PEDAGANG(id_pelaku)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_total_bayar
        CHECK (total_bayar >= 0)
);

-- 9. Tabel DETAIL_TRANSAKSI
CREATE TABLE DETAIL_TRANSAKSI (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT NOT NULL,
    id_barang INT NOT NULL,
    jumlah INT NOT NULL,
    harga_satuan DECIMAL(12,2) NOT NULL,
    subtotal DECIMAL(14,2) NOT NULL,

    CONSTRAINT fk_detail_transaksi
        FOREIGN KEY (id_transaksi)
        REFERENCES TRANSAKSI(id_transaksi)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_detail_barang
        FOREIGN KEY (id_barang)
        REFERENCES BARANG(id_barang)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_jumlah
        CHECK (jumlah > 0),

    CONSTRAINT chk_harga_detail
        CHECK (harga_satuan >= 0),

    CONSTRAINT chk_subtotal
        CHECK (subtotal >= 0)
);
