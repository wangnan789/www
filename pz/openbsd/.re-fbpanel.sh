#	chengws@outlook.com
echo -n 'kill -9 ' >/tmp/1
ps -A  | grep fbpanel |grep -v grep | awk '{print $1}'  >>/tmp/1
chmod 777 /tmp/1
sh /tmp/1
rm /tmp/1
fbpanel &