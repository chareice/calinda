#! /bin/sh

host='root@chareice.com'

echo 'buiding...'
middleman build &> /dev/null
echo 'finshed build, start archiving'
tar -czf chareice.com.tar.gz build
echo 'finshed archive, start uploading'
scp chareice.com.tar.gz $host:/www
ssh $host  << EOF
tar -zxf /www/chareice.com.tar.gz -C /www/calinda &>/dev/null;
rm /www/chareice.com.tar.gz;
EOF
rm chareice.com.tar.gz
echo 'all done, have fun.'
