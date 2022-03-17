import re, os
import sys

def read_file(input_file):

    trans = []
    native = []
    n = 0
    m = 0

    for line in open(input_file,"r"):
        line = line.strip().split('\t')
        if float(line[1]) > 0.9:
            n += 1
            trans.append(line)
        if float(line[0]) > 0.9:
            m += 1
            native.append(line)
    print("translationese: ",n)
    print("native: ",m)
    return trans, native

def write_file(input, trans, native):

    trans_write = open(trans,"w")
    native_write = open(native,"w")
    trans_list, native_list = read_file(input)

    for trans_line in trans_list:
        trans_write.write(trans_line[2]+"\n")
    for  native_line in native_list:
        native_write.write(native_line[2]+"\n")

    trans_write.close()
    native_write.close()

if __name__ == "__main__":
    write_file(sys.argv[1],sys.argv[2],sys.argv[3])
    