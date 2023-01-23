SELECT sid, n_1, p_id, sex, birth, Leptin, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20220300 ;
    
    
SELECT sid, n_1, p_id, sex, birth, Leptin, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20220300 and Leptin = ' ';
    
SELECT sid, n_1, p_id, sex, birth, Leptin, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20220300 and Leptin != ' ';
    
    SELECT sid, n_1, p_id, sex, birth, Anti_HCV_x,TotalVitaminD, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20220300
    AND (Anti_HCV_x is NULL or Anti_HCV_x IN (' ','缺漏'))
    AND TotalVitaminD is NULL;
    
        SELECT sid, n_1, p_id, sex, birth, Anti_HCV_x,TotalVitaminD, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20220300
    AND (Anti_HCV_x is NULL or Anti_HCV_x IN (' ','缺漏'))
    AND TotalVitaminD is not NULL;
    
	SELECT sid, n_1, p_id, sex, birth, Anti_HCV_x,TotalVitaminD, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20220300
    AND (Anti_HCV_x is not NULL AND Anti_HCV_x not IN (' ','缺漏'))
    AND TotalVitaminD is NULL;
    
	SELECT sid, n_1, p_id, sex, birth, Anti_HCV_x,TotalVitaminD, year_come
    FROM CMRC_DB_2022_import_work.new_CMRC_db_20963_desc_20220310
	WHERE data_exam >= 20220300
    AND (Anti_HCV_x is not NULL AND Anti_HCV_x not IN (' ','缺漏'))
    AND TotalVitaminD is not NULL;
    