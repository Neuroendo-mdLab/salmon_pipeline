import pandas as pd
import glob

#Get the path of the datafiles
file_paths = glob.glob('./salmon_output/*sf')

#Make the dataframe to import the result
result = pd.DataFrame()

#
if __name__ == "__main__":
	for i, file in enumerate(file_paths):
		df = pd.read_table(file, usecols=[4], header=0, names=[file])
		cols = df.columns.tolist()
		header_str = [col.replace('./', '').replace('_result.sf', '') for col in cols]
		df.columns = header_str
		if i == 0:
			result['ID'] = pd.read_table(file, usecols=[0])
		result = pd.concat([result, df], axis=1)

result.to_csv('./salmon_output/NumReads_merged.csv', index=False)
