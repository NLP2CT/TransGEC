import sys,re
import json

inputfile = sys.argv[1]
outputfile = sys.argv[2]

f_out = open(outputfile, "w", encoding='utf-8')

for line in open(inputfile, 'r'):
    line = line.strip()
    line = re.sub(r'\\','',line)
    line = re.sub(r'\"','\\"',line)
    line = line.split('\t')
    jsons = '{ "translation": { "error": "'+line[0]+'", "correct": "'+line[1]+'" } }'

    print (json.loads(jsons))
    f_out.write(jsons+"\n")

f_out.close()