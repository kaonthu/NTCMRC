SELECT * FROM CMRC_DB.CMRC_Consent_DB;

CREATE TABLE kao_practice_5.CMRC_Consent_DB_kaonthu (
  `Session` varchar(14) DEFAULT NULL,
  `SID_old` varchar(16) DEFAULT NULL,
  `SID` varchar(20) DEFAULT NULL,
  `ID` varchar(10) DEFAULT NULL,
  `P_ID` varchar(8) DEFAULT NULL,
  `p_number` varchar(20) DEFAULT NULL,
  `cmrc_id` varchar(20) DEFAULT NULL,
  `Name` varchar(26) DEFAULT NULL,
  `Consent_date` varchar(16) DEFAULT NULL,
  `Approve_date` varchar(15) DEFAULT NULL,
  `Ver` varchar(27) DEFAULT NULL,
  `Obtained_by` varchar(24) DEFAULT NULL,
  `Note` varchar(87) DEFAULT NULL,
  `Type` varchar(20) DEFAULT NULL,
  date_kao date DEFAULT NULL,
  data_kao2	varchar(10) DEFAULT NULL,
  ver_kao varchar(20) DEFAULT NULL,
  type_kao varchar(10) DEFAULT NULL,
  note_kao varchar(87) DEFAULT NULL,
  yes_kao  int(2) DEFAULT NULL,
  sup      int(6) DEFAULT NULL,
  KEY `sid` (`SID`),
  KEY `pid` (`P_ID`),
  KEY `note` (`Note`),
  KEY `p_number` (`p_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


