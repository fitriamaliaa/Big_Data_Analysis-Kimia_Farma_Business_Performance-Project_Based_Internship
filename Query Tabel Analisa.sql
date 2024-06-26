-- Membuat tabel analisa

CREATE TABLE dataset_kimia_farma_rakamin.kf_tabelanalisis AS
SELECT
kf.transaction_id,
kf.date, 
kf.branch_id, 
kf.branch_name, 
kf.kota, kf.provinsi, 
kf.rating_cabang, 
kf.customer_name, 
kf.product_id, 
kf.product_name, 
kf.actual_price, 
kf.discount_percentage,
kf.persentase_gross_laba,
kf.nett_sales,
(kf.persentase_gross_laba-(kf.actual_price-kf.nett_sales)) nett_profit, 
kf.rating_transaksi
FROM ( 
  SELECT
    ft.transaction_id,
    ft.date,
    kc.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating as rating_cabang,
    ft.customer_name,
    ft.product_id,
    pd.product_name,
    ft.price as actual_price,
    ft.discount_percentage,
      CASE
        WHEN pd.price <= 50000 THEN 0.1
        WHEN pd.price > 50000  AND pd.price <=100000 THEN 0.15
        WHEN pd.price > 10000 AND pd.price<= 300000 THEN 0.20
        WHEN pd.price > 300000 AND pd.price<= 500000 THEN 0.25
        WHEN pd.price > 500000 then 0.30
     END AS persentase_gross_laba,
        (pd.price-(pd.price*ft.discount_percentage))nett_sales,
    ft.rating as rating_transaksi
  FROM
    dataset_kimia_farma_rakamin.kf_final_transaction as ft
  LEFT JOIN
     dataset_kimia_farma_rakamin.kf_kantor_cabang as kc ON ft.branch_id = kc.branch_id
  LEFT JOIN
    dataset_kimia_farma_rakamin.kf_product as pd ON ft.product_id = pd.product_id
     ) kf