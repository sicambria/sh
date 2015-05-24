sudo apt-get install -y apache2
sudo apt-get install -y munin munin-node
sudo mkdir /var/www/munin
sudo chown munin:munin /var/www/munin

sudo perl -pi -e 's?#.*dbdir.*/var/lib/munin?dbdir /var/lib/munin?g' /etc/munin/munin.conf
sudo perl -pi -e 's?# htmldir /var/cache/munin/www?htmldir /var/www/munin?g' /etc/munin/munin.conf
sudo perl -pi -e 's?# logdir /var/log/munin?logdir /var/log/munin?g' /etc/munin/munin.conf
sudo perl -pi -e 's?# rundir  /var/run/munin?rundir  /var/run/munin?g' /etc/munin/munin.conf
sudo perl -pi -e 's?#.*tmpldir.*/etc/munin/templates?tmpldir /etc/munin/templates?g' /etc/munin/munin.conf

sudo perl -pi -e 's?Alias /munin /var/cache/munin/www?Alias /munin /var/www/munin?g' /etc/munin/apache.conf
sudo perl -pi -e 's?<Directory /var/cache/munin/www>?<Directory /var/www/munin>?g' /etc/munin/apache.conf
sudo perl -pi -e 's?Allow from localhost 127.0.0.0/8 ::1?Allow from all?g' /etc/munin/apache.conf

sudo service munin-node restart
sudo service apache2 restart
