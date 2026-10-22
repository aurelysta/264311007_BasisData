CREATE DATABASE IF NOT EXISTS uts_basisdata;
USE uts_basisdata;


CREATE TABLE barang (
    id_barang     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_kios       INT UNSIGNED NOT NULL,
    nama_barang   VARCHAR(100) NOT NULL,
    kategori      VARCHAR(50)  NOT NULL,
    harga_satuan  DECIMAL(12,2) NOT NULL,
    stok_min      INT NOT NULL DEFAULT 0,
    satuan        VARCHAR(20)  NOT NULL,
    PRIMARY KEY (id_barang)
);

CREATE TABLE transaksi (
    id_transaksi      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    id_pembeli        INT UNSIGNED NOT NULL,
    id_pedagang       INT UNSIGNED NOT NULL,
    tanggal           DATE NOT NULL,
    metode_pembayaran VARCHAR(30) NOT NULL,
    total_bayar       DECIMAL(14,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_transaksi)
);

CREATE TABLE detail_transaksi (
    id_transaksi  INT UNSIGNED NOT NULL,
    id_barang     INT UNSIGNED NOT NULL,
    jumlah        INT NOT NULL,
    harga_satuan  DECIMAL(12,2) NOT NULL,
    subtotal      DECIMAL(14,2) NOT NULL,
    PRIMARY KEY (id_transaksi, id_barang),
    CONSTRAINT fk_detail_transaksi
        FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi),
    CONSTRAINT fk_detail_barang
        FOREIGN KEY (id_barang) REFERENCES barang(id_barang)
);
