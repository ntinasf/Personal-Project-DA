import os
import csv

def merge_csv(path):

  """
  Merges the csv files included in the path directory.
  
  Args: path - string: The path to a directory containing only the csv files to be merged.
  
  """

  # Create a list that contains the current directory's files.
  files_list = os.listdir(path)

  # Keep only the csv files.
  csv_files = [f for f in files_list if f.endswith('.csv')]

  i = 0
  for  item in sorted(csv_files):
     with open(item, 'r', newline='') as file_1, open('merged_data.csv', 'a', newline='') as merged:
        reader = csv.reader(file_1)
        if i != 0:
           # Skip the header row for every file except from the first.
           next(reader)
        writer = csv.writer(merged)
        for row in reader:
           writer.writerow(row)
        i += 1

# The main function runs for the current working directory.           
def main():
   path = os.getcwd() # You can specify your own path here.
   return merge_csv(path)

if __name__ == '__main__':
   main()