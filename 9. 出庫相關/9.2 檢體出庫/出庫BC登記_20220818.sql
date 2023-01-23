CREATE temporary table kao_practice_5.Total_speciem_20220818_BC_out as
SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC' #目前1915管
AND P_number IN (
"P042517","P042847","P101615","P101617","P101619","P101620","P101623","P101626","P101628","P101630",
"P101632","P101634","P101637","P101638","P101640","P101641","P101643","P101644","P101646","P101647",
"P101648","P101650","P101651","P101655","P101656","P101657","P101658","P101659","P101660","P101662",
"P101663","P101665","P101666","P101667","P101668","P101670","P101671","P101672","P101674","P101676",
"P101677","P101678","P101679","P101682","P101683","P101686","P101687","P101688","P101690","P101691",
"P101693","P101695","P101699","P101703","P101704","P101707","P101708","P101710","P101711","P101712",
"P101713","P101714","P101715","P101716","P101717","P101718","P101719","P101721","P101722","P101724",
"P101725","P101731","P101732","P101736","P101740","P101741","P101742","P101743","P101745","P101747",
"P101755","P101756","P101757","P101760","P101761","P110005","P110011","P110018","P110020","P110022",
"P110024","P110029","P110030","P110035")
GROUP BY P_number; #94

SELECT C_number,'1','20220818','林志郎',now()
FROM kao_practice_5.Total_speciem_20220818_BC_out;
# 此次送件 94管包含 林志郎醫師 20220805 申請 BC檢體出庫 名單

SELECT * FROM CMRC_DB_kaonthu.CMRC_sample_Database_Consent
WHERE `out` <> 1
AND specimen = 'BC'
AND C_Date >= 20210000; #目前1829管 出庫 94管後 剩下 1737 管 (其中有2管是出舊的) 

INSERT INTO CMRC_DB_kaonthu.CMRC_Sample_status
(`C_number`, `out`, `out_time`, `out_name`, `entry_time`)
SELECT C_number,'1','20220818','林志郎',now()
FROM kao_practice_5.Total_speciem_20220818_BC_out;