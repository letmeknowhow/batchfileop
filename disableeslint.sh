#!/bin/bash
#遍历文件夹、删除指定后缀名的文件
 
function scandir() {
    local cur_dir parent_dir workdir
    workdir=$1
    cd ${workdir}
    if [ ${workdir} = "/" ]
    then
        cur_dir=""
    else
        cur_dir=$(pwd)
    fi
 
    for dirlist in $(ls ${cur_dir})
    do
        if test -d ${dirlist};then
            cd ${dirlist}
            scandir ${cur_dir}/${dirlist} $2
            cd ..
        else
            local filename=$dirlist

        	if [[ ${filename:(-${#2})} = $2 ]] 
        	then
        		echo "修改文件："${cur_dir}"/"$filename
                sed -i '' '1i\
                /* eslint-disable */
                ' $filename
 			fi
            # 根据创建时间
            # local filename=$dirlist
        	# if [[ ${filename:(-${#2})} = $2 ]]
        	# then
            #     file=${cur_dir}/${filename}
            #     createtime=`stat -f %SB $file`
            #     t1=`date -d "$createtime" +%s`
            #     t2=`date -d "$3" +%s`
            #     if [ $t2 -gt $t1 ]
            #     then
        	# 	    echo "修改文件："${cur_dir}"/"$filename
            #         sed -i '' '1i\
            #         /* eslint-disable */
            #         ' $filename
            #     fi
 			# fi
        fi
    done
}
 
if test -d $1
then
    scandir $1 $2
elif test -f $1
then
    echo "you input a file but not a directory,pls reinput and try again"
    exit 1
else
    echo "the Directory isn't exist which you input,pls input a new one!!"
    exit 1
fi