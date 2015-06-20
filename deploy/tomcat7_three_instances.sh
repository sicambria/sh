sudo -s

apt-get purge openjdk-6-jre-headless icedtea-6-jre-cacao openjdk-6-jre-lib icedtea-6-jre-jamvm
apt-get install -y tomcat7 tomcat7-admin apache2 libapache2-mod-jk

sudo perl -pi -e 's?JAVA_OPTS="-Djava\.awt\.headless=true -Xmx128m -XX:\+UseConcMarkSweepGC"?JAVA_OPTS="-Djava.awt.headless=true -Xms2048m -Xmx2048m -XX:PermSize=1024m -XX:MaxPermSize=1024m -XX:+UseConcMarkSweepGC"?g' /etc/default/tomcat7

cd /var/lib/tomcat7/
mkdir instance1 instance2 instance3
cd instance1
mkdir conf logs temp work webapps
cd ..

cd instance2
mkdir conf logs temp work webapps
cd ..

cd instance3
mkdir conf logs temp work webapps
cd ..

chown -R tomcat7.tomcat7 instance1 instance2 instance3

cd instance1/conf
ln -s /etc/tomcat7/catalina.properties .
ln -s /etc/tomcat7/web.xml .
ln -s /etc/tomcat7/policy.d/ .

cp /etc/tomcat7/server.xml ./

sudo perl -pi -e 's?Server port="8005"?Server port="8001"?g' server.xml
sudo perl -pi -e 's?Connector port="8080"?Connector port="8081"?g' server.xml
sudo perl -pi -e 's?Connector port="8009"?Connector port="8101"?g' server.xml
cd ..
cd ..


cd instance2/conf
ln -s /etc/tomcat7/catalina.properties .
ln -s /etc/tomcat7/web.xml .
ln -s /etc/tomcat7/policy.d/ .

cp /etc/tomcat7/server.xml ./

sudo perl -pi -e 's?Server port="8005"?Server port="8002"?g' server.xml
sudo perl -pi -e 's?Connector port="8080"?Connector port="8082"?g' server.xml
sudo perl -pi -e 's?Connector port="8009"?Connector port="8102"?g' server.xml
cd ..
cd ..


cd instance3/conf
ln -s /etc/tomcat7/catalina.properties .
ln -s /etc/tomcat7/web.xml .
ln -s /etc/tomcat7/policy.d/ .

cp /etc/tomcat7/server.xml ./

sudo perl -pi -e 's?Server port="8005"?Server port="8003"?g' server.xml
sudo perl -pi -e 's?Connector port="8080"?Connector port="8083"?g' server.xml
sudo perl -pi -e 's?Connector port="8009"?Connector port="8103"?g' server.xml
cd ..
cd ..


cd /etc/init.d
cp tomcat7 tomcat7-instance1

sed -i '31iINSTANCE=instance1' tomcat7-instance1

sudo perl -pi -e 's?DESC="Tomcat servlet engine.*"?DESC="Tomcat servlet engine \$INSTANCE "?g' tomcat7-instance1
sudo perl -pi -e 's?CATALINA_BASE=/var/lib/\$NAME?CATALINA_BASE=/var/lib/\$NAME/\$INSTANCE?g' tomcat7-instance1
sudo perl -pi -e 's?CATALINA_PID="/var/run/\$NAME.pid"?CATALINA_PID="/var/run/\$NAME-\$INSTANCE.pid"?g' tomcat7-instance1

cp tomcat7-instance1 tomcat7-instance2
cp tomcat7-instance1 tomcat7-instance3

sudo perl -pi -e 's?instance1?instance2?g' tomcat7-instance2
sudo perl -pi -e 's?instance1?instance3?g' tomcat7-instance3

service tomcat7-instance1 start
service tomcat7-instance2 start
service tomcat7-instance3 start

service tomcat7-instance1 status
service tomcat7-instance2 status
service tomcat7-instance3 status

update-rc.d tomcat7-instance1 defaults
update-rc.d tomcat7-instance2 defaults
update-rc.d tomcat7-instance3 defaults

update-rc.d tomcat7 disable
