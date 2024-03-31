**Big Data Analytics Kimia Farma x Rakamin Academy (Batch February 2024)**
---
SQL Tool: Google BigQuery - [Lihat Script SQL](https://github.com/fitriamaliaa/Big_Data_Analysis-Kimia_Farma_Business_Performance-Project_Based_Internship/blob/main/Query%20Tabel%20Analisa.sql)

Visualization Tool: Google Looker Studio - [Lihat Dashboard](https://lookerstudio.google.com/reporting/9cb4a9bc-55f8-4d86-8017-e49f75694159)


**Program Project Based Internship (PBI)**
---
Program Project Based Internship (PBI) merupakan program magang virtual yang berkolaborasi dengan beberapa perusahaan untuk pengembangan diri dan akselerasi karier serta menambah pengalaman bagi peserta PBI. Pada program ini, saya sebagai seorang Big Data Analytics Intern di Kimia Farma bertugas untuk mengevaluasi kinerja bisnis Kimia Farma dari tahun 2020 hingga 2023.

**Challenge**
1. Membuat tabel analisa
2. Membuat dashboard Performance Analytics Kimia Farma di Tahun 2020 - 2023

**Dataset**
- Product
- Inventory
- Kantor Cabang
- Final Transaction

**Tools**
- BigQuery
- Looker Studio


**Tabel Analisa**
---
Tabel analisa adalah tabel yang berisi data asli yang sudah menjadi satu dengan aggregat dengan beberapa kolom yaitu 'presentase_gross_laba', 'nett_profit', dan 'nett_sales'. 

**Query Tabel Analisa**


```sql
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
     ) kf;
```

**Hasil Tabel Analisa**

![Tabel Analisa 1](https://github.com/fitriamaliaa/Big_Data_Analysis-Kimia_Farma_Business_Performance-Project_Based_Internship/blob/main/assets/Tabel%20Analisa%201.png)

![Tabel Analisa 2](https://github.com/fitriamaliaa/Big_Data_Analysis-Kimia_Farma_Business_Performance-Project_Based_Internship/blob/main/assets/Tabel%20Analisa%202.png)


Pada challenge berikutnya, terdapat perintah untuk membuat visualisasi perbandingan pendapatan Kimia Farma dari tahun ke tahun di dashboard visualization. Berikut query untuk tabel 'total_revenue' :
```sql
CREATE TABLE dataset_kimia_farma_rakamin.total_revenue_per_year AS
SELECT EXTRACT(YEAR FROM date) AS year, SUM(nett_sales) AS total_revenue
FROM dataset_kimia_farma_rakamin.kf_tabelanalisis
GROUP BY year
ORDER BY year;
```

Dengan syntax di atas maka akan menghasilkan tabel 'total_revenue' sebagai berikut

![Total Revenue per Year](https://github.com/fitriamaliaa/Big_Data_Analysis-Kimia_Farma_Business_Performance-Project_Based_Internship/blob/main/assets/Total%20Revenue%20per%20Year.png)



Visualisasi Data
---

[Lihat visualisasi data disini](https://lookerstudio.google.com/reporting/9cb4a9bc-55f8-4d86-8017-e49f75694159)

![Dashboard](https://github.com/fitriamaliaa/Big_Data_Analysis-Kimia_Farma_Business_Performance-Project_Based_Internship/blob/main/assets/Dashboard.png)
