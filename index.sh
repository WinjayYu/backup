#!/bin/bash

file_list_path="filelist.txt"
time=`date +%Y_%m_%d__%H_%M_%S`

if [[ -d "tmp"  ]]; then
    rm -rf tmp
fi

mkdir tmp

while IFS= read -r line
do 
    if [[ -f $line  ]] || [[ -d $line ]]; then
        cp -r $line tmp
    fi   
done < "$file_list_path"

tar -zcf packages/config_file_$time.tar.gz tmp 

rm -rf tmp

newst_package=$(ls -t packages | awk '{printf($0);exit}')

echo "newst package is here" | mutt -s "Config files" bill.jj@qq.com -a packages/$newst_package
