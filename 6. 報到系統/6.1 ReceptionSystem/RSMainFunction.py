import pandas as pd
from IPython.display import display, clear_output
from py.PBMCCheck_version2 import PbmcChek
from datetime import date
import ipywidgets as widgets

df = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\社區報到資訊v5.csv")   #出社區的大表
#df2 = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\fatty_family.csv") #肥胖家族
df2 = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\stool.csv") #糞便採檢
df3 = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\分檢後剩餘血液清單.csv")  #葉醫師拿剩餘血液
df4 = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\20210319_Community_biodata_13-20_NonDup.csv", low_memory=False)
df6 = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\有瑕疵的同意書(全部).csv")

def Register(identity, Today, sequence_number, name, birth):
	
	clear_output()
	s_number = sequence_number
	Name = name
	People_data = []
	Identity = identity.upper().strip() 
	

	#If People exist
	if Identity in df['ID'].values: #檢查身分證字號是否存在，來判斷是否來過
		
		#stool 糞便檢查
		stool = "0"
		#input the patient's data   //print(df.loc[df['ID'] == Identity])
		ID              = df.loc[df['ID']==Identity, 'ID']
		Name            = df.loc[df['ID']==Identity, 'Name']
		P_ID            = df.loc[df['ID']==Identity, 'P_ID']
		Birthday        = df.loc[df['ID']==Identity, 'birthday']
		Year            = df.loc[df['ID']==Identity, 'year']
		Old_agreement   = df.loc[df['ID']==Identity, 'old']
		Remark          = df.loc[df['ID']==Identity, 'remark']
		echo            = df.loc[df['ID']==Identity, 'echo']

		#The above data's type is series. 'ID2 = ID.values' can get value of series, but is numpy.array
		ID2              = ID.values
		Name2            = Name.values
		P_ID2            = P_ID.values
		Birthday2        = Birthday.values
		Year2            = int(Year.values) + 1
		Old_agreement2   = Old_agreement.values
		Barcode          = ""
		Remark2          = Remark.values
		echo2            = echo.values
		T_Bilirubin      = df4.loc[df4['pid']==P_ID2[0], 'Total_Bilirubin']
		T_Bilirubin2     = T_Bilirubin.values                               
		D_Bilirubin      = df4.loc[df4['pid']==P_ID2[0], 'D_Bilirubin']     
		D_Bilirubin2     = D_Bilirubin.values
		Alb_Cre_ratio    = df4.loc[df4['pid']==P_ID2[0], 'Alb_Cre_ratio']
		Alb_Cre_ratio2   = Alb_Cre_ratio.values
		TP_U_Cre_ratio   = df4.loc[df4['pid']==P_ID2[0], 'TP_U_Cre_ratio']
		TP_U_Cre_ratio2  = TP_U_Cre_ratio.values
		egfrn            = df4.loc[df4['pid']==P_ID2[0], 'egfrn']
		egfrn2           = egfrn.values
		Protein          = df4.loc[df4['pid']==P_ID2[0], 'Protein']
		Protein2         = Protein.values
		HemoglobinCol    = df4.loc[df4['pid']==P_ID2[0], 'Hemoglobin']
		HemoglobinValue  = HemoglobinCol.values
		MCVCol           = df4.loc[df4['pid']==P_ID2[0], 'MCV']
		MCVValue         = MCVCol.values
		FerritinCol      = df4.loc[df4['pid']==P_ID2[0], 'Ferritin']
		FerritinValue    = FerritinCol.values
		SexCol           = df4.loc[df4['pid']==P_ID2[0], 'sex']
		SexValue         = SexCol.values
		
		#回簽同意書
		Sign_Old_agreement = ""
		if Old_agreement2[0] == 0:
			Sign_Old_agreement = "O"
		else:
			Sign_Old_agreement = "X"
		
		if Alb_Cre_ratio2[0] == 'ND' or Alb_Cre_ratio2[0] == 'NONE' or Alb_Cre_ratio2[0] == 'nan' or Alb_Cre_ratio2[0] == '缺漏':
			Alb_Cre_ratio2[0] = -99
		
		if TP_U_Cre_ratio2[0] == 'ND' or TP_U_Cre_ratio2[0] == 'NONE' or TP_U_Cre_ratio2[0] == 'nan' or TP_U_Cre_ratio2[0] == '缺漏':
			TP_U_Cre_ratio2[0] = -99
		
		Alb_Cre_ratio2[0]  = float(Alb_Cre_ratio2[0])
		TP_U_Cre_ratio2[0] = float(TP_U_Cre_ratio2[0])
		
		#CKD
		CKD = ""
		if egfrn2[0] == 'nan':
			CKD = "0"
		else:
			if float(egfrn2[0]) < 60:
				CKD = "1"
			else:
				if Alb_Cre_ratio2[0] >= 30 or TP_U_Cre_ratio2[0] >= 150 or '+' in str(Protein2[0]):
					CKD = "1"
				else:
					CKD = "0"
				

		# Gilber Syndrome
		GS = ""
		T_Bilirubin4 = ""
		
		try:
		
			if type(T_Bilirubin2[0]) == str and "<" in T_Bilirubin2[0]:
			
				if " " in T_Bilirubin2[0]:
					
					T_Bilirubin_split    = T_Bilirubin2[0].split('<')
					T_Bilirubin_str      = T_Bilirubin_split[1].strip()
					T_Bilirubin_final    = float(T_Bilirubin_str)
					#print(T_Bilirubin_final)
				
				else:
					
					T_Bilirubin_split = T_Bilirubin2[0].split('<')
					T_Bilirubin_final = float(T_Bilirubin_split[1])
					#print(T_Bilirubin_final)
	
			elif T_Bilirubin2[0] == "NONE":
			
				T_Bilirubin_final = float(0)
		
		
			else:
			
				T_Bilirubin_final = float(T_Bilirubin2[0])
				#print(T_Bilirubin_final)
		
			
			if type(D_Bilirubin2[0]) == str and "<" in D_Bilirubin2[0]:
		
				if " " in D_Bilirubin2[0]:
					
					D_Bilirubin_split    = D_Bilirubin2[0].split('<')
					D_Bilirubin_str      = D_Bilirubin_split[1].strip()
					D_Bilirubin_final    = float(D_Bilirubin_str)
				
				else:
					
					D_Bilirubin_split = D_Bilirubin2[0].split('<')
					D_Bilirubin_final = float(D_Bilirubin_split[1])
					#print(D_Bilirubin_final)
	
			elif D_Bilirubin2[0] == "NONE" or "nan":
			
				D_Bilirubin_final = float(0)
		
			else:
			
				D_Bilirubin_final = float(D_Bilirubin2[0])
				#print(T_Bilirubin2)
	
		
		
			GS = ""
			if T_Bilirubin_final >= 1.2 and (D_Bilirubin_final/T_Bilirubin_final*100) < 20:
			
				GS = "1"
		
			else:
			
				GS = "0"
				
		except:
		
			GS = ""
			

		#超音波2年照一次
		if echo2[0] == 1:
			
			echo3 = "X"
		else:
			
			echo3 = "O"

		#Is he/she over 80 years old ?
		Age = ""
		Birthday2_string = str(Birthday2[0]) # Birthday2 is not string type 
		YY = 1911 + int(Birthday2_string[0:2])
		MM = int(Birthday2_string[2:4])
		DD = int(Birthday2_string[4:])
		Current_age_days = date.today()-date(YY,MM,DD)
		Current_age = int(Current_age_days.days/365)
		Age = Current_age
		
		#Is he/she over 65 years old ?
		funduscopy = ""
		if Age >= 65:
			
			funduscopy = "O"
		
		else:
		
			funduscopy = "X"
		
		#給助理看的流水號
		if len(s_number) == 1:
			s_number = "{}00{}".format(Today, s_number)
		elif len(s_number) == 2:
			s_number = "{}0{}".format(Today, s_number)
		else:
			s_number = "{}{}".format(Today, s_number)
		
		Examination_code = "C" + Today[4:8] + "40" + s_number[8:] #產生病理科檢驗代號
		People_number = s_number[8:] 
		
		#判斷貧血的條件值 貧血要做PBMC
		Hemoglobin  = HemoglobinValue[0]
		MCV         = MCVValue[0]
		Ferritin    = FerritinValue[0]
		Sex         = str(SexValue[0])
		
		PersonID = ID2[0]
		PBMC = PbmcChek(GS, Age, PersonID, CKD, Hemoglobin, MCV, Ferritin, Sex)
		
		if PBMC == 1:
				
			PBMC = "O"
					
		else:
				
			PBMC = "X"
		
		if P_ID2[0] in df2['病歷號'].values:
			
			if P_ID2[0] in df3['病歷號'].values:
				
				stool = "1"
				RemainingBlood = "1"
				
				Outputlist = []
				Outputlist.append(str(Name2[0]))
				Outputlist.append(str(Year2))
				Outputlist.append(str(ID2[0]))
				Outputlist.append(str(Birthday2[0]))
				Outputlist.append(str(Age))
				Outputlist.append('O')
				Outputlist.append(str(funduscopy))
				Outputlist.append(str(PBMC))
				Outputlist.append(str(echo3))
				Outputlist.append(str(Sign_Old_agreement))
				print("{:<8} {:<8} {:<15} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8}".format('姓名','第幾年','身分證字號', '生日', '年齡', 'OB', '65y', 'PBMC', 'ECHO', '回簽'))
				na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre = Outputlist
				#print ("-"*105)
				print("{:<11} {:<6} {:<18} {:<11} {:<9} {:<8} {:<8} {:<8} {:<8} {:<8}".format(na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre))
				
			else:
				
				stool = "1"
				RemainingBlood = "0"
				
				Outputlist = []
				Outputlist.append(str(Name2[0]))
				Outputlist.append(str(Year2))
				Outputlist.append(str(ID2[0]))
				Outputlist.append(str(Birthday2[0]))
				Outputlist.append(str(Age))
				Outputlist.append('O')
				Outputlist.append(str(funduscopy))
				Outputlist.append(str(PBMC))
				Outputlist.append(str(echo3))
				Outputlist.append(str(Sign_Old_agreement))
				Outputlist.append(str(RemainingBlood))
				print("{:<8} {:<8} {:<15} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8}".format('姓名','第幾年','身分證字號', '生日', '年齡', 'OB', '65y', 'PBMC', 'ECHO', '回簽'))
				na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre, rebl = Outputlist
				#print ("-"*105)
				print("{:<11} {:<6} {:<18} {:<11} {:<9} {:<8} {:<8} {:<8} {:<8} {:<8}".format(na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre))
				
		else:
			
			if P_ID2[0] in df3['病歷號'].values:
				
				stool = "0"
				RemainingBlood = "1"
				
				Outputlist = []
				Outputlist.append(str(Name2[0]))
				Outputlist.append(str(Year2))
				Outputlist.append(str(ID2[0]))
				Outputlist.append(str(Birthday2[0]))
				Outputlist.append(str(Age))
				Outputlist.append('X')
				Outputlist.append(str(funduscopy))
				Outputlist.append(str(PBMC))
				Outputlist.append(str(echo3))
				Outputlist.append(str(Sign_Old_agreement))
				print("{:<8} {:<8} {:<15} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8}".format('姓名','第幾年','身分證字號', '生日', '年齡', 'OB', '65y', 'PBMC', 'ECHO', '回簽'))
				na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre = Outputlist
				#print ("-"*105)
				print("{:<11} {:<6} {:<18} {:<11} {:<9} {:<8} {:<8} {:<8} {:<8} {:<8}".format(na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre))
			
			else:
				
				stool = "0"
				RemainingBlood = "0"
				
				Outputlist = []
				Outputlist.append(str(Name2[0]))
				Outputlist.append(str(Year2))
				Outputlist.append(str(ID2[0]))
				Outputlist.append(str(Birthday2[0]))
				Outputlist.append(str(Age))
				Outputlist.append('X')
				Outputlist.append(str(funduscopy))
				Outputlist.append(str(PBMC))
				Outputlist.append(str(echo3))
				Outputlist.append(str(Sign_Old_agreement))
				print("{:<8} {:<8} {:<15} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8}".format('姓名','第幾年','身分證字號', '生日', '年齡', 'OB', '65y', 'PBMC', 'ECHO', '回簽'))
				na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre = Outputlist
				#print ("-"*105)
				print("{:<11} {:<6} {:<18} {:<11} {:<9} {:<8} {:<8} {:<8} {:<8} {:<8}".format(na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre))
			
		
		People_data = [People_number, s_number, Examination_code, Name2[0], ID2[0], P_ID2[0], Barcode, Remark2[0], Year2, Birthday2[0], funduscopy, Age, stool, echo3, GS, Sign_Old_agreement, CKD, PBMC, RemainingBlood]
		#print("姓名: {}, 身分證字號: {}, 出生年月日: {}, 年齡: {}".format(Name2[0], ID2[0], Birthday2[0], Age))
		if P_ID2[0] in df6['病歷號碼'].values:
			
			#AgreementNumber = df6.loc[df6['病歷號碼']==P_ID2[0], '流水號']
			#AgreementAnnotate = df6.loc[df6['病歷號碼']==P_ID2[0], '備註']
			filter = (df6['病歷號碼'] == P_ID2[0])
			print("\n同意書有瑕疵需補簽名↓")
			#print("同意書:{}".format(AgreementNumber.values))
			#print("備註 :{}".format(AgreementAnnotate.values))
			print(df6[filter])
			
		return People_data
	
	#If People not exist
	else:
		
		NameString = Name
		BirthString = birth
		
		if NameString == '' and BirthString =='':
		
			print('這位民眾沒有來過，請輸入姓名還有生日後再新增資料')
			
		else:
		
			if NameString.isspace() or NameString.isdigit() or NameString == None:
			
				print("姓名輸入錯誤，請重新輸入")
			
			else:
			
		
				if len(s_number) == 1:
					s_number = "{}00{}".format(Today, s_number)
				elif len(s_number) == 2:
					s_number = "{}0{}".format(Today, s_number)
				else:
					s_number = "{}{}".format(Today, s_number)
					
				Examination_code = "C" + Today[4:8] + "40" + s_number[8:] #產生病理科檢驗代號
				People_number = s_number[8:] #給助理看的流水號
				
				ID = Identity
				Birthday = birth
				
				if Birthday.isdigit() and len(Birthday) == 6:
				
					print("這位居民第一次前來參加活動")
					
					P_ID = ""
					Year = "1"
					Age = ""
					Barcode = ""
					Remark = ""
					echo = "O"
					GS = ""
					CKD = "0"
					#判斷貧血的條件值 貧血要做PBMC
					Hemoglobin  = 0
					MCV         = 0
					Ferritin    = 0
					if ID[1] == "1":
						
						Sex = "1"
					
					else:
					
						Sex = "0"
					
					#Is he/she 80 years old ?
					YY = 1911 + int(Birthday[0:2])
					MM = int(Birthday[2:4])
					DD = int(Birthday[4:])
					Current_age_days = date.today()-date(YY,MM,DD)
					Current_age = int(Current_age_days.days/365)
					Age = Current_age
					
					PersonID = Identity
					#PBMC = PbmcChek(GS, Age, PersonID, CKD, Hemoglobin, MCV, Ferritin, Sex) 第一年來要做
					
					#if PBMC == 1:
					#
					#	PBMC = "O"
					#	
					#else:
					#
					#	PBMC = "X"
					PBMC = "O" #第一年來要做
					
					funduscopy = ""
					if Age >= 65:
					
						funduscopy = "O"
					
					else:
					
						funduscopy = "X"
					
					stool = "0" #不用做
					Old_agreement = "X" #新人不需要簽舊檢體轉移同意書
					RemainingBlood = "0" #新人不會在葉醫師要的剩餘血液名單
					
					
					Outputlist = []
					Outputlist.append(str(Name))
					Outputlist.append(str(Year))
					Outputlist.append(str(ID))
					Outputlist.append(str(Birthday))
					Outputlist.append(str(Age))
					Outputlist.append('X')
					Outputlist.append(str(funduscopy))
					Outputlist.append(str(PBMC))
					Outputlist.append(str(echo))
					Outputlist.append(str(Old_agreement))
					print("{:<8} {:<8} {:<15} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8} {:<8}".format('姓名','第幾年','身分證字號', '生日', '年齡', 'OB', '65y', 'PBMC', 'ECHO', '回簽'))
					na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre = Outputlist
					#print ("-"*105)
					print("{:<11} {:<6} {:<18} {:<11} {:<9} {:<8} {:<8} {:<8} {:<8} {:<8}".format(na, ye, ide, bir, ag, sto, fs, pbmc, ec, agre))
					
					People_data = [People_number, s_number, Examination_code, Name, ID, P_ID, Barcode, Remark, Year, Birthday, funduscopy, Age, stool, echo, GS, Old_agreement, CKD, PBMC, RemainingBlood]
					
					return People_data
				
				else:
					
					print("出生年月日格式錯誤，請重新輸入")
			#People_data_list.setdefault(Identity, []).append(Name)
			#print(People_data_list)
			#print(Name.query(姓名 == identity)) #error
			#print(Name.get_group(identity)) #不存在的會有error
