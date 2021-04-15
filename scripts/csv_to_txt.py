import csv
csv_file = "test_labels.csv"
input_file = open(csv_file,"r")
next(input_file)
for row in csv.reader(input_file):
    txt_file=row[0]
    output_file=open(txt_file,'a')
    output_file.write(row[3]+" "+str(float(row[6])/2)+" "+str(float(row[7])/2)+" "+row[1]+" "+row[2]+'\n')
    output_file.close()