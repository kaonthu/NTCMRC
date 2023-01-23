import ipywidgets as widgets
import pandas as pd
import os
from datetime import datetime
from IPython.display import display
from ipywidgets import interact
from IPython.display import clear_output
from py.RSMainFunction import Register
import traceback

ReportTime = datetime.now().strftime("%Y-%m-%d %I:%M:%S %p")
print("現在時間: {}".format(ReportTime))

df = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\社區報到資訊v5.csv")   #出社區的大表

def reception(sequence_number, identity, name, birth):
	
	print("開始執行報到程式!")
	People_data_list = []
		
	Today = datetime.now().strftime("%Y%m%d")
	
	try:
		
		SnumberCheck = int(sequence_number)
	
		if len(identity[1:]) != 9 or (identity[0].isalpha()) == False:
			print("身分證錯誤, 請再重新輸入。")
			
		else:
			
			File_name = '{}_healthy_examination.csv'.format(Today)#要存檔的檔名，當天日期加上 '_healthy_examination'
			File_path = 'D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name)#檔案路徑
		
			try:
			
				if os.path.isfile(File_path):
				
					InputData = pd.read_csv(r'D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name))
					InputDataSort = InputData.sort_values(by='流水號', ascending=True) #資料按照流水號排序
					InputDataSort.to_csv('D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name), mode='w', index=False, encoding="utf-8-sig") # Write file
			
				else:
				
					InputDataColumn = ['編號', '流水號', '檢驗代號', 'Name', 'ID', 'P_ID', 'Barcode', 'Remark', 'YEAR', 'Birthday', 'funduscopy', 'Age', 'Stool', 'Echo', 'GS', 'Old_agreement', 'CKD', 'PBMC', 'RemainingBlood']
					InputDataSort = pd.DataFrame(columns = InputDataColumn)
					InputDataSort.to_csv('D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name), index=False, encoding="utf-8-sig") # Write file
			except:
			
				print("Excel已被開啟，請確定關閉Excel檔案後再點輸入資訊的按鈕。")
			
			if SnumberCheck not in InputDataSort['編號'].values: #檢查是否重複輸入
				
				try:
					
					PeopleData = Register(identity, Today, sequence_number, name, birth)
					People_data_list.append(PeopleData) #將資訊儲存
					
					File_name = '{}_healthy_examination.csv'.format(Today)#要存檔的檔名，當天日期加上 '_healthy_examination'
					File_path = 'D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name)
					items = ['編號', '流水號', '檢驗代號', 'Name', 'ID', 'P_ID', 'Barcode', 'Remark', 'YEAR', 'Birthday', 'funduscopy', 'Age', 'Stool', 'Echo', 'GS', 'Old_agreement', 'CKD', 'PBMC', 'RemainingBlood'] # New Dataframe Column's name
					
					try:
					
						attendant = pd.DataFrame(People_data_list, columns = items) # New Dataframe
						attendant.to_csv('D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name), mode='a', header=False, index=False, encoding="utf-8-sig") # Write file
						People_data_list = []
						
					except:
						
						print("Excel已被開啟或其他錯誤，檢查後再點新增資料的按鈕。")
				
				except Exception as e:
					traceback.print_exc()
					print("Error: {}，請檢查輸入的資料。".format(e))
			else:
			
				print("編號已經重複，請再輸入一次。")
	
	except ValueError:
	
		print("編號或者某個空格輸入錯誤, 請再重新輸入。")
	