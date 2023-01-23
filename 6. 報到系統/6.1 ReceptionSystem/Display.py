def DisplaySometing():
	
	import ipywidgets as widgets
	import pandas as pd
	import os
	from IPython.display import display, clear_output, display_html
	from datetime import datetime
	from ipywidgets import interact
	from py.Outsidefunction import reception
	
	Today = datetime.now().strftime("%Y%m%d")
	
	# creating txet with them   
	IDCode = widgets.Text(
		placeholder = 'Type something',
		description = '身份證字號:',
		disabled = False
	)
	sequence_number = widgets.Text(
		placeholder = 'Type something',
		description = '編號:',
		disabled = False
	)
	name = widgets.Text(
		placeholder = 'Type something',
		description = '姓名:',
		disabled = False
	)
	birth = widgets.Text(
		placeholder = 'Ex: 910101',
		description = '生日(民國):',
		disabled = False
	)
	# button, output, function and linkage
	butt = widgets.Button(description='新增資料')
	outt = widgets.Output()
	
	try:
		def on_butt_clicked(b):
			with outt:
				
				clear_output()
				reception(sequence_number.value, IDCode.value, name.value, birth.value)
	
	except Exception as e:
		
		error_class = e.__class__.__name__ #取得錯誤類型
		detail = e.args[0] #取得詳細內容
		cl, exc, tb = sys.exc_info() #取得Call Stack
		lastCallStack = traceback.extract_tb(tb)[-1] #取得Call Stack的最後一筆資料
		fileName = lastCallStack[0] #取得發生的檔案名稱
		lineNum = lastCallStack[1] #取得發生的行號
		funcName = lastCallStack[2] #取得發生的函數名稱
		errMsg = "File \"{}\", line {}, in {}: [{}] {}".format(fileName, lineNum, funcName, error_class, detail)
		print(errMsg)
		
	butt.on_click(on_butt_clicked)
	
#**********************************************************查詢報到資訊*****************************************************************************************************				
	
	def displayinfo(查詢報到資訊):
		
		File_name = '{}_healthy_examination.csv'.format(Today)#要存檔的檔名，當天日期加上 '_healthy_examination'
		File_path = 'D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name)#檔案路徑
		clear_output()
		
		try:
		
			if os.path.isfile(File_path):
			
				InputData = pd.read_csv(r'D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name))
				InputDataSort = InputData.sort_values(by='流水號', ascending=True) #資料按照流水號排序
		
			else:
			
				InputDataColumn = ['編號', '流水號', '檢驗代號', 'Name', 'ID', 'P_ID', 'Barcode', 'Remark', 'YEAR', 'Birthday', 'funduscopy', 'Age', 'Stool', 'Echo', 'GS', 'Old_agreement', 'HPYAB', 'CKD', 'PBMC']
				InputDataSort = pd.DataFrame(columns = InputDataColumn)
				InputDataSort.to_csv('D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name), index=False, encoding="utf-8-sig") # Write file
		
		except Exception as e:
		
			print(e)
		
		InputData = pd.read_csv(r'D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name))
		InputDataSort = InputData.sort_values(by='流水號', ascending=True)
		
		display(InputDataSort)
		pd.set_option("display.max_rows", None)
		
		def Searching(查詢欄位):
			
			df1 = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}_healthy_examination.csv".format(Today))
			df1.set_index(['編號'], inplace = True)
			df2 = df1
		
			age = df1[['Name', 'Age']][df1['Age'] > 80]
			ListOfNumber = df2.loc[df2['Age'] > 80, ['Age']].index.tolist()
			print("80歲以上: {}人".format(len(age)))
			print("{}\n".format(ListOfNumber))
		
			Ckd = df1[['Name', 'CKD']][df1['CKD'] == 1]
			ListOfNumber = df2.loc[df2['CKD'] == 1, ['CKD']].index.tolist()
			print("CKD: {}人".format(len(Ckd)))
			print("{}\n".format(ListOfNumber))
		
			echo = df1[['Name', 'Echo']][df1['Echo'] == 'O']
			ListOfNumber = df2.loc[df2['Echo'] == 'O', ['Echo']].index.tolist()
			print("Echo O: {}人".format(len(echo)))
			print("{}\n".format(ListOfNumber))
			
			echo = df1[['Name', 'Echo']][df1['Echo'] == 'X']
			ListOfNumber = df2.loc[df2['Echo'] == 'X', ['Echo']].index.tolist()
			print("Echo X: {}人".format(len(echo)))
			print("{}\n".format(ListOfNumber))
		
			#Hpyab = df1[['Name', 'HPYAB']][df1['HPYAB'] == 'O']
			#ListOfNumber = df2.loc[df2['HPYAB'] == 'O', ['HPYAB']].index.tolist()
			#print("HPYAB O: {}人".format(len(Hpyab)))
			#print("{}\n".format(ListOfNumber))
			#
			#Hpyab = df1[['Name', 'HPYAB']][df1['HPYAB'] == 'X']
			#ListOfNumber = df2.loc[df2['HPYAB'] == 'X', ['HPYAB']].index.tolist()
			#print("HPYAB X: {}人".format(len(Hpyab)))
			#print("{}\n".format(ListOfNumber))
		
			GilbertSyndrome = df1[['Name', 'YEAR']][df1['GS'] == 1]
			ListOfNumber = df2.loc[df2['GS'] == 1, ['GS']].index.tolist()
			print("GS: {}人".format(len(GilbertSyndrome)))
			print("{}\n".format(ListOfNumber))
		
			stool = df1[['Name', 'Stool']][df1['Stool'] == 1]
			ListOfNumber = df2.loc[df2['Stool'] == 1, ['Stool']].index.tolist()
			print("糞檢: {}人".format(len(stool)))
			print("{}\n".format(ListOfNumber))
			
			RemainingBlood = df1[['Name', 'RemainingBlood']][df1['RemainingBlood'] == 1]
			ListOfNumber = df2.loc[df2['RemainingBlood'] == 1, ['RemainingBlood']].index.tolist()
			print("取走剩餘血液: {}人".format(len(RemainingBlood)))
			print("{}\n".format(ListOfNumber))
		
			Pbmc = df1[['Name', 'PBMC']][df1['PBMC'] == 'O']
			ListOfNumber = df2.loc[df2['PBMC'] == 'O', ['PBMC']].index.tolist()
			print("PBMC: {}人".format(len(Pbmc)))
			print("{}\n".format(ListOfNumber))
		
			FirstYear = df1[['Name', 'YEAR']][df1['YEAR'] == 1]
			ListOfNumber = df2.loc[df2['YEAR'] == 1, ['YEAR']].index.tolist()
			print("第一年參加: {}人".format(len(FirstYear)))
			print("{}\n".format(ListOfNumber))
		
		button_search = widgets.Button(description = '查找欄位資料', tooltip = '點擊按鈕查詢')   
		button_search.on_click(Searching)
		display(button_search)
		
	button_exit = widgets.Button(description = '輸出', tooltip = '點擊輸出')   
	button_exit.on_click(displayinfo)
#*********************************************************************************************************************************************************************
			
	
	def qgrid(update):
	
		import qgrid
		try:
		
			df_now = pd.read_csv(r"D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}_healthy_examination.csv".format(Today)) #要查詢的檔案名稱
			df_qgrid = qgrid.show_grid(df_now, show_toolbar = None)
		
			def storedata(store):
			
				dataupdate = df_qgrid.get_changed_df().sort_values(by='流水號', ascending=True)
				File_name = '{}_healthy_examination.csv'.format(Today)#要存檔的檔名，當天日期加上 '_healthy_examination'
				dataupdate.to_csv('D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name), mode='w', index=False, encoding="utf-8-sig")
			
			updatedata = widgets.Button(description = '確定', tooltip = '確定儲存')   
			updatedata.on_click(storedata)
			
			display(df_qgrid, updatedata)
		
		except Exception as e:
		
			print("{}\n檔案不存在".format(e))
			
	def onlydisply(查詢報到資訊):
		
		File_name = '{}_healthy_examination.csv'.format(Today)#要存檔的檔名，當天日期加上 '_healthy_examination'
		File_path = 'D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name)#檔案路徑
		clear_output()
		
		try:
		
			InputData = pd.read_csv(r'D:\Leeyu\JupyterWorkplace\ReceptionSystem\csv\{}'.format(File_name))
			InputDataSort = InputData.sort_values(by='流水號', ascending=True) #資料按照流水號排序
			
			display(tab)
			display(InputDataSort)
			pd.set_option("display.max_rows", None)	
		
		except FileNotFoundError:
		
			display(tab)
			print("還未新增資料，請先新增一筆資料")
			
	modifydata = widgets.Button(description = '修改', tooltip = '修改 Excel 資料')   
	modifydata.on_click(qgrid)
	
	b1ank_button = widgets.Button(description='', disabled=True)
	b1ank_button.style.button_color = 'white'
	
	SearchButton = widgets.Button(description='查詢')
	SearchButton.on_click(onlydisply)
	
	# display
	ButtonSet = widgets.HBox([b1ank_button, butt, b1ank_button, b1ank_button, b1ank_button, b1ank_button, button_exit])
	Menu = widgets.VBox([sequence_number,IDCode,name,birth,ButtonSet,outt])
	IDCode.on_submit(on_butt_clicked)
	sequence_number.on_submit(on_butt_clicked)
	name.on_submit(on_butt_clicked)
	birth.on_submit(on_butt_clicked)
	
	# defining a list with the contents of our windows
	children = [Menu, SearchButton, modifydata]
	# initializing a tab
	tab = widgets.Tab()
	# setting the tab windows 
	tab.children = children
	# changing the title of the first and second window
	tab.set_title(0, '新增')
	tab.set_title(1, '查詢')
	tab.set_title(2, '修改')
	tab
	
	display(tab)