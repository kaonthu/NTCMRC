SELECT * FROM CMRC_DB_kaonthu_work.doctor_chen_20220913;


SELECT a.*,b.CMRC_ID,b.P_number,b.C_number,b.Box,b.Site,b.New_Box,b.New_Site,
b.Date_exam,b.C_date,b.Year_come,b.In_time,b.Source,b.ng_ul,b.Stock_ul,b.A260_A280_ratio,
b.`bk吳逸文`,b.`bk孫樵隱`,b.`bk陳志根林哲名魏怡嘉`,b.`bk陳立偉`,b.`bk林志郎`,b.`bk徐于喬`,b.bk_sum,
b.remark_1,b.remark_2,b.stock_remain_ul,b.stock_remain_ng,b.stock_after_bk,b.out_names,
b.out_times,b.stock_out_uls,b.stock_out_ngs,b.back_date,b.back_ver,b.back_type,b.back_yes,
b.DNA_date,b.DNA_ver,b.DNA_type,b.DNA_yes,b.New_date,b.New_ver,b.New_type,b.New_yes
FROM CMRC_DB_kaonthu_work.doctor_chen_20220913 as a
INNER JOIN CMRC_DB_kaonthu.CMRC_DNA_DB_kaonthu_back_DNA_New_consent_New_CMRC_id as b
ON a.CMRCNo = b.CMRC_ID 
GROUP BY b.p_id;

