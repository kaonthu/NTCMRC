import pandas as pd

WES = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\People_Wes.csv")
WGS = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\People_Wgs.csv")
AbnormalEcho = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\People_abnormal_echo.csv")

def PbmcChek(GS, Age, PersonID, CKD, Hemoglobin, MCV, Ferritin, Sex):
	
	PersonID = str(PersonID)
	Sex = str(Sex)
	
	try:
	
		Hemoglobin = float(Hemoglobin)
		MCV        = float(MCV)
		Ferritin   = float(Ferritin)
		
	except:
	
		print("檢查最近1次的檢驗值的檔案, Hemoglobin or MCV or Ferritin可能有問題")
	
	PBMC = 0
	i = 0
	
	if Age >= 80:
	
		i = i + 1
	
	else:
	
		i = i
		
	if GS == '1':
	
		i = i + 1
		
	else:
	
		i = i
		
	if PersonID in WES['id'].values:
	
		i = i + 1
		
	else:
	
		i = i
		
	if PersonID in WGS['id'].values:
	
		i = i + 1
		
	else:
	
		i = i
		
	#if PersonID in AbnormalEcho['id'].values:
	#	
	#	i = i + 1
	#	
	#else:
	#
	#	i = i
		
	#if CKD == "1":
	#
	#	i = i + 1
	#	
	#else:
	#
	#	i = i
		
	#是否貧血--判斷的標準為 1.Hemoglobin 男生小於13.5 女生小於12 且 2.MCV小於80(男女皆同) 且 3.Ferritin 男生大於30 女生大於13
	#try:
	#
	#	if Sex == "1" or Sex == "男":
	#	
	#		if Hemoglobin < 13.5 and MCV < 80 and Ferritin > 30:
	#		
	#			i = i + 1
	#		
	#		elif Hemoglobin == 0.0 and MCV == 0.0 and Ferritin == 0.0:
	#		
	#			i = i
	#		
	#		else:
	#			
	#			i = i
	#			
	#	else:
	#		
	#		if Hemoglobin < 12 and MCV < 80 and Ferritin > 13:
	#		
	#			i = i + 1
	#			
	#		else:
	#			
	#			i = i
		
	#except:
	#
	#	i = i
	#	print("無法判斷是否有貧血")
		
	if i > 0:
	
		PBMC = 1
		
	else:
	
		PBMC = 0
		
	return PBMC

#if __name__ == '__main__':
#
#	print('this is a pbmc check program')