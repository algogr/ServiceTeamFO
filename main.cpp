#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "algosqltablemodel.h"
#include "algosqlrelationaltablemodel.h"
#include "algosqlquerymodel.h"
#include <QDebug>
#include <QSqlError>
#include "email.h"
#include <QSettings>
#include "variousexposed.h"



int main(int argc, char *argv[])
{


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QList <QAbstractItemModel*> TableModelsList;

    QFile st(QCoreApplication::applicationDirPath()+"/settings.ini");
    QString settingsFile=QCoreApplication::applicationDirPath() +"/settings.ini";
    QSettings settings(settingsFile,QSettings::IniFormat);

    if (!st.open(QIODevice::ReadOnly | QIODevice::Text))
    {

        settings.setValue("dsnMySQL","serviceteam");
        settings.setValue("hostnameMySQL","localhost");
        settings.setValue("userMySQL","root");
        settings.setValue("passMySQL","101264");
        settings.setValue("dsnSQLServer","soft1");
        settings.setValue("userSQLServer","sa");
        settings.setValue("passSQLServer","tt123!@#");
        settings.sync();
    }
    st.close();

    QSqlDatabase db1=QSqlDatabase::addDatabase("QODBC",settings.value("dsnMySQL").toString());
    //QSqlDatabase db1=QSqlDatabase::addDatabase("QODBC","serviceteam");
    db1.setDatabaseName(settings.value("dsnMySQL").toString());
    db1.setHostName(settings.value("hostnameMySQL").toString());
    db1.setPort(3306);
    db1.setUserName(settings.value("userMySQL").toString());
    db1.setPassword(settings.value("passMySQL").toString());

    qDebug()<<"dsnMysql:"<<settings.value("dsnMySQL").toString();
    qDebug()<<"hostnameMysql:"<<settings.value("hostnameMySQL").toString();
    qDebug()<<"userMysql:"<<settings.value("userMySQL").toString();
    qDebug()<<"passMysql:"<<settings.value("passMySQL").toString();

    QSqlQuery qry(db1);




    QSqlDatabase db2=QSqlDatabase::addDatabase("QODBC",settings.value("dsnSQLServer").toString());

    db2.setDatabaseName(settings.value("dsnSQLServer").toString());
    //db2.setHostName("192.168.2.248  ");
    //db2.setPort(1433);
    db2.setUserName(settings.value("userSQLServer").toString());
    db2.setPassword(settings.value("passSQLServer").toString());

    if (db1.open()==false)
    {
        qDebug()<<"Error on MySQL:"<< db1.lastError().text();
        exit(0);
    }


    if (db2.open()==false)
    {
        qDebug()<<"Error on Soft1:"<< db2.lastError().text();
        exit(0);
    }
     qry.exec("SET wait_timeout = 3600");

    Email taskemail;

    AlgoSqlTableModel* cusLModel = new AlgoSqlTableModel(0,db1);
    cusLModel->setTable("customer");
    cusLModel->sort(1,Qt::SortOrder::AscendingOrder);
    cusLModel->generateRoleNames();
    cusLModel->setFilter("");
    cusLModel->select();
    qDebug()<<cusLModel->roleNames();





    AlgoSqlTableModel* origLModel = new AlgoSqlTableModel(0,db1);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    origLModel->setTable("originator");
    origLModel->sort(1,Qt::SortOrder::AscendingOrder);
    origLModel->generateRoleNames();
    origLModel->setFilter("");
    origLModel->select();


    AlgoSqlTableModel* techLModel = new AlgoSqlTableModel(0,db1);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    techLModel->setTable("technician");
    techLModel->sort(1,Qt::SortOrder::AscendingOrder);
    techLModel->generateRoleNames();
    techLModel->setFilter("");
    techLModel->select();

    AlgoSqlTableModel* districtLModel = new AlgoSqlTableModel(0,db1);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    districtLModel->setTable("district");
    districtLModel->sort(1,Qt::SortOrder::AscendingOrder);
    districtLModel->generateRoleNames();
    districtLModel->setFilter("");
    districtLModel->select();



    AlgoSqlTableModel* appointmentLModel = new AlgoSqlTableModel(0,db1);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    appointmentLModel->setTable("appointment");
    appointmentLModel->sort(3,Qt::SortOrder::AscendingOrder);
    appointmentLModel->generateRoleNames();
    appointmentLModel->setFilter("");
    appointmentLModel->select();






    AlgoSqlTableModel* techDistrictLModel = new AlgoSqlTableModel(0,db1);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    techDistrictLModel->setTable("techdistrict");
    techDistrictLModel->generateRoleNames();
    techDistrictLModel->setFilter("");
    techDistrictLModel->select();



    AlgoSqlTableModel* ticketLModel = new AlgoSqlTableModel(0,db1);
    ticketLModel->setTable("ticket");
    ticketLModel->sort(1,Qt::SortOrder::AscendingOrder);
    ticketLModel->generateRoleNames();
    ticketLModel->setFilter("");
    ticketLModel->select();
    qDebug()<<ticketLModel->roleNames();

    QString querystr= "SELECT `customer`.`id` cid,\
            `customer`.`erpid` cerpid,\
            `customer`.`name` cname,\
            `customer`.`location` clocation,\
            `customer`.`city` ccity,\
            `customer`.`county` ccounty,\
            `customer`.`address` caddress,\
            `customer`.`email` cemail,\
            `customer`.`phone1` cphone1,\
            `customer`.`phone2` cphone2,\
            `customer`.`postalcode` cpostalcode,\
            `customer`.`loopnumber` cloopnumber,\
            `customer`.`longitude` clongtitude,\
            `customer`.`latitude` clatitude,\
            `ticket`.`originatorid` toriginatorid,\
            `ticket`.`erporiginatorid` terporiginatorid,\
            `ticket`.`erpcusid` terpcusid,\
            `ticket`.`title` ttitle,\
            `ticket`.`service` tservice,\
            `ticket`.`reporteddate` treporteddate,\
            `ticket`.`priority` tpriority,\
            `ticket`.`description` tdescription,\
            `ticket`.`customerticketno` tcustomerticketno,\
            `ticket`.`appointmentfrom` tappointmentfrom,\
            `ticket`.`appointmetto` tappointmentto,\
            `ticket`.`incident` tincident,\
            `ticket`.`department` tdepartment,\
            `ticket`.`status` tstatus,\
            `ticket`.`techid` ttechid,\
            `ticket`.`id` tid,\
            `ticket`.`newappointmentdate` tnewappointmentdate,\
            `originator`.`name` oname\
            FROM `serviceteam`.`ticket`,`serviceteam`.`customer`,`serviceteam`.`originator`\
            where `ticket`.`cusid`=`customer`.`id` and `ticket`.`originatorid`=`originator`.`id`\
            and `ticket`.`status`=1 and `originator`.`name` like '%'";
    AlgoSqlQueryModel* custTicketLModel=new AlgoSqlQueryModel(&db1,querystr);






    custTicketLModel->setQuery();
            int nbCols = custTicketLModel->columnCount();

            for (int i = 0; i < nbCols; i++)
            {
                qDebug()<<custTicketLModel->headerData(i, Qt::Horizontal).toString();
            }
    //custTicketLModel->setRelation(2,QSqlRelation("customer","id","name"));
    //custTicketLModel->setRelation(2,QSqlRelation("customer","id","county"));
    //custTicketLModel->setSort(5,Qt::SortOrder::DescendingOrder);
    //custTicketLModel->select();
    custTicketLModel->generateRoleNames();
    qDebug()<<custTicketLModel->roleNames();







    querystr= "select t.id tid,t.incident tincident,c.name cname,t.appointmentfrom tappointmentfrom,t.status tstatus,tc.name tcname,\
            o.name oname,t.version tversion,t.techid ttechid from ticket t,originator o,customer c,technician tc where t.originatorid=o.id and t.cusid=c.id\
             and t.techid=tc.id";

    AlgoSqlQueryModel* techTicketLModel=new AlgoSqlQueryModel(&db1,querystr);

    techTicketLModel->setQuery();
            nbCols = techTicketLModel->columnCount();

            for (int i = 0; i < nbCols; i++)
            {
                qDebug()<<techTicketLModel->headerData(i, Qt::Horizontal).toString();
            }

    techTicketLModel->generateRoleNames();
    qDebug()<<techTicketLModel->roleNames();


    QString querystr1="SELECT `customer`.`id` cid,\
            `customer`.`erpid` cerpid,\
            `customer`.`name` cname,\
            `customer`.`location` clocation,\
            `customer`.`city` ccity,\
            `customer`.`county` ccounty,\
            `customer`.`address` caddress,\
            `customer`.`email` cemail,\
            `customer`.`phone1` cphone1,\
            `customer`.`phone2` cphone2,\
            `customer`.`postalcode` cpostalcode,\
            `customer`.`loopnumber` cloopnumber,\
            `customer`.`longitude` clongtitude,\
            `customer`.`latitude` clatitude,\
            `ticket`.`originatorid` toriginatorid,\
            `ticket`.`erporiginatorid` terporiginatorid,\
            `ticket`.`erpcusid` terpcusid,\
            `ticket`.`title` ttitle,\
            `ticket`.`service` tservice,\
            `ticket`.`reporteddate` treporteddate,\
            `ticket`.`priority` tpriority,\
            `ticket`.`description` tdescription,\
            `ticket`.`customerticketno` tcustomerticketno,\
            `ticket`.`appointmentfrom` tappointmentfrom,\
            `ticket`.`appointmetto` tappointmentto,\
            `ticket`.`incident` tincident,\
            `ticket`.`department` tdepartment,\
            `ticket`.`id` tid,\
            `originator`.`name` oname,\
            `appointment`.`appdate` appdate,\
            `appointment`.`techid` atechid\
            FROM `serviceteam`.`ticket`,`serviceteam`.`customer`,`serviceteam`.`originator`,`serviceteam`.`appointment`\
            where `ticket`.`cusid`=`customer`.`id` and `ticket`.`originatorid`=`originator`.`id` and `ticket`.`id`=`appointment`.`ticketid` \
            and `ticket`.`status`=1 ";
    AlgoSqlQueryModel* appCustTicketLModel=new AlgoSqlQueryModel(&db1,querystr1);

    appCustTicketLModel->setQuery();

            nbCols = appCustTicketLModel->columnCount();

            for (int i = 0; i < nbCols; i++)
            {
                qDebug()<<appCustTicketLModel->headerData(i, Qt::Horizontal).toString();
            }
    //custTicketLModel->setRelation(2,QSqlRelation("customer","id","name"));
    //custTicketLModel->setRelation(2,QSqlRelation("customer","id","county"));
    //custTicketLModel->setSort(5,Qt::SortOrder::DescendingOrder);
    //custTicketLModel->select();
    appCustTicketLModel->generateRoleNames();
    qDebug()<<appCustTicketLModel->roleNames();
    qDebug()<<appCustTicketLModel->rowCount();

    querystr1="SELECT td.id tdid,d.description ddescription,td.techid tdtechid,td.refdate tdrefdate from district d inner join\
    techdistrict td on d.id=td.districtid inner join technician t on t.id=td.techid";





    AlgoSqlQueryModel* techDistrictQLModel=new AlgoSqlQueryModel(&db1,querystr1);


    techDistrictQLModel->setQuery();

            nbCols = techDistrictQLModel->columnCount();

            for (int i = 0; i < nbCols; i++)
            {
                qDebug()<<techDistrictQLModel->headerData(i, Qt::Horizontal).toString();
            }

    techDistrictQLModel->generateRoleNames();
    qDebug()<<techDistrictQLModel->roleNames();







    TableModelsList.append(cusLModel); //0
    TableModelsList.append(origLModel); //2
    TableModelsList.append(ticketLModel); //4




    VariousExposed* ve=new VariousExposed;




    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("customerModel",cusLModel);
    engine.rootContext()->setContextProperty("ticketModel",ticketLModel);
    engine.rootContext()->setContextProperty("customerTicketModel",custTicketLModel);
    engine.rootContext()->setContextProperty("techTicketModel",techTicketLModel);
    engine.rootContext()->setContextProperty("techModel",techLModel);
    engine.rootContext()->setContextProperty("districtModel",districtLModel);
    engine.rootContext()->setContextProperty("appointmentModel",appointmentLModel);
    engine.rootContext()->setContextProperty("techDistrictQModel",techDistrictQLModel);
    engine.rootContext()->setContextProperty("techDistrictModel",techDistrictLModel);
    engine.rootContext()->setContextProperty("appCustomerTicketModel",appCustTicketLModel);
    engine.rootContext()->setContextProperty("taskEmail",&taskemail);
    engine.rootContext()->setContextProperty("ve",ve);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));



    return app.exec();
}
