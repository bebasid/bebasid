import os
from socket import gethostbyname
from sys import argv, path
#
# --- INTRODUCTION ---
# BEBASID DOMAIN TO IP
# Based on Python 3
#
# --- HOW TO USE ---
# CLI: python scan.py yourfile.txt or python scan.py
# 
# --- NOTE ---
# Domain on yourfile.txt must be above subdomain
#
# Example [Right]:
# domain.com
# n1.domain.com
#
# Example [Wrong]:
# n1.domain.com
# domain.com
# 
# ------------------------
#
# Copyright (c) 2021 Haibara - KINI
# Copyright (c) 2020 Komunitas Internet Netral Indonesia (KINI)  
#
# The copyright holders grant the freedom to copy, modify, convey, adapt, and/or redistribute this work
# under the terms of the Massachusetts Institute of Technology License.
# A copy of that license is available at https://github.com/bebasid/bebasid/blob/master/LICENSE
#
def execute(file):
    hostnameFile = open(os.path.join(path[0],file),'r')
    resultFile = open(os.path.join(path[0],"hosts-"+file), 'w')
    hostnameList = hostnameFile.read().splitlines()
    lineFile = len(hostnameList)
    lenLiveHostname = lenDieHostname = lenCantWrite = resultHostname = 0
    print("\nMemulai Proses\n")
    for hostname in hostnameList:
        try:
            hasWritten = False
            hostnameIp = gethostbyname(hostname)
            resultFile = open(os.path.join(path[0],"hosts-"+file), 'r')
            resultFileList = resultFile.readlines()
            for result in resultFileList:
                if "# [" in result:
                    if result.split('[', 1)[1].split(']')[0] in hostname:
                        hostnameIndex = resultFileList.index(result)
                        resultFileList[hostnameIndex+1] = "{0} {1}\n{2}".format(hostnameIp, hostname,resultFileList[hostnameIndex+1])
                        resultFile.close()
                        resultFile = open(os.path.join(path[0],"hosts-"+file), 'w')
                        for line in resultFileList:
                            if(resultFile.write(line)):
                                success = True
                            else:
                                success = False
                        if(success):
                            hasWritten = True
                            lenLiveHostname += 1
                            print("Domain: {0}\nIP Address: {1}\n".format(hostname, hostnameIp))
                        else:
                            lenCantWrite +=1
                            print("Gagal Menulis File Result")
                        break
            if not(hasWritten):
                resultFile = open(os.path.join(path[0],"hosts-"+file), 'a')
                hostsText = "\n\n# [{0}]\n{1} {2}".format(hostname,hostnameIp, hostname)
                if(resultFile.write(hostsText)):
                    lenLiveHostname += 1
                    print("Domain: {0}\nIP Address: {1}\n".format(hostname, hostnameIp))
                else:
                    lenCantWrite += 1
                    print("Gagal Menulis File Result")
            resultFile.close()
        except:
            lenDieHostname += 1
            print("Domain {0} tidak aktif".format(hostname))
    hostnameFile.close()
    print("Result:\nFile\t\t: {0}\nDomain Aktif\t: {1}\nDomain Mati\t: {2}\nGagal Ditulis\t: {3}".format("hosts"+file,lenLiveHostname,lenDieHostname,lenCantWrite))

try:
    execute(argv[1])
except:
    file = str(input("Masukkan nama file:"))
    execute(file)
