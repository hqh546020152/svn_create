#!/bin/bash
#
#参考的配置文件
CK_CONF=./conf

#创建的路径
SVN_D=/home/svn
XH=0

while [ $XH -eq 0 ];do
        read -p "请输入项目名称>>>" XM
        ls $SVN_D/$XM &> /dev/null
        [ $? -eq 0 ] && echo -e "该项目已存在，请重新输入。" && continue
        echo -e "确认信息：\nSVN路径为：$SVN_D/$XM"
        while :;do
                read -p "输入y为确认，n为取消，q为退出>>>" TT
                case $TT in
                y)
                        XH=1
                        break
                        ;;
                n)
                        break
                        ;;
                q)
                        exit 0
                        ;;
                *)
                        echo "你的输入有误，请重新输入！"
                        ;;
                esac
        done
done

sudo svnadmin create $SVN_D/$XM
sudo rm -fr $SVN_D/$XM/conf
sudo cp $CK_CONF $SVN_D/$XM/ -r
sudo sed -i 24s@TEST@$XM@g  $SVN_D/$XM/conf/authz
sudo sed -i 32s@TEST@$SVN_D/$XM@g  $SVN_D/$XM/conf/svnserve.conf
#echo "否需要添加新的用户"
#read -p "输入y为确认，n为取消，q为退出"
#打印提示信息
echo -e "SVN内网地址为：\nsvn://114.114.114.114:3690/$XM"
echo -e "SVN外网地址为：\nsvn://114.114.114.114:36900/$XM"
echo -e "测试账号:test\n密码:7arcUx6EQMqqdYvqfJFx"
