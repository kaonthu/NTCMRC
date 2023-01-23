CREATE TABLE `Total_plasma_202110_11_new` (
  `row_names` varchar(45) DEFAULT NULL,
  `sid` varchar(40) CHARACTER SET utf8mb4 NOT NULL,
  `P_number` varchar(40) CHARACTER SET utf8mb4 DEFAULT NULL,
  `C_number` varchar(40) CHARACTER SET utf8mb4 NOT NULL,
  `Box` varchar(40) CHARACTER SET utf8mb4 DEFAULT NULL,
  `Site` int(5) DEFAULT NULL,
  `ML` float DEFAULT NULL,
  `Specimen` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `QC` tinyint(1) DEFAULT NULL,
  `C_Date` date DEFAULT NULL,
  `In_time` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `CMRC_Reserved` tinyint(1) DEFAULT NULL,
  `sup` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `kao_practice_5`.`Total_plasma_202110_11_new` 
ADD PRIMARY KEY (`C_number`);
;


SELECT * FROM kao_practice_5.Total_plasma_202110_11_new;
 
UPDATE kao_practice_5.Total_plasma_202110_11_new as a 
INNER JOIN kao_practice_5.Update_C_number_20211208 as b
ON a.C_number = b.C_number_old
SET a.C_number = b.C_number_new
WHERE a.Specimen = 'P'
AND a.C_Date >= 20211013 AND a.CMRC_reserved=0 ;