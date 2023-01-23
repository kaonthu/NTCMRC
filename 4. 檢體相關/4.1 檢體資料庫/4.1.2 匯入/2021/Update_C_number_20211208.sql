CREATE TABLE `Update_C_number_20211208` (
  `P_number` varchar(20) DEFAULT NULL,
  `C_number_old` varchar(20) DEFAULT NULL,
  `C_number_new` varchar(20) DEFAULT NULL,
  `Specimen` varchar(20) DEFAULT NULL,
  `CMRC_Reserved` varchar(20) DEFAULT NULL,
  `sup` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`sup`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

SELECT * FROM kao_practice_5.Update_C_number_20211208;

ALTER TABLE `kao_practice_5`.`Update_C_number_20211208` 
CHANGE COLUMN `C_number_old` `C_number_old` VARCHAR(20) NOT NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`C_number_old`);
;

UPDATE kao_practice_5.Total_speciem_2021_1013_1130 as a 
INNER JOIN kao_practice_5.Update_C_number_20211208 as b
ON a.C_number = b.C_number_old
SET a.C_number = b.C_number_new
WHERE a.Specimen = 'P'
AND a.C_Date >= 20211013 AND a.CMRC_reserved=0 ;

UPDATE kao_practice_5.Total_speciem_2021_1013_1130
SET box = 691
WHERE box = 667;