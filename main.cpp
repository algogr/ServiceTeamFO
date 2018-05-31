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

        settings.setValue("dsnSQLServer","soft1");
        settings.setValue("userSQLServer","sa");
        settings.setValue("passSQLServer","tt123!@#");
        settings.setValue("s1Company","1002");
        settings.setValue("s1Series","1");
        settings.sync();
    }
    st.close();







    QSqlDatabase db=QSqlDatabase::addDatabase("QODBC",settings.value("dsnSQLServer").toString());

    db.setDatabaseName(settings.value("dsnSQLServer").toString());
    //db2.setHostName("192.168.2.248  ");
    //db2.setPort(1433);
    db.setUserName(settings.value("userSQLServer").toString());
    db.setPassword(settings.value("passSQLServer").toString());




    if (db.open()==false)
    {
        qDebug()<<"Error on Soft1:"<< db.lastError().text();
        exit(0);
    }


    Email taskemail;

    AlgoSqlTableModel* cusLModel = new AlgoSqlTableModel(0,db);
    cusLModel->setTable("cccsubscriber");
    cusLModel->sort(1,Qt::SortOrder::AscendingOrder);
    cusLModel->generateRoleNames();
    cusLModel->setFilter("");
    cusLModel->select();
    qDebug()<<cusLModel->roleNames();





    AlgoSqlTableModel* origLModel = new AlgoSqlTableModel(0,db);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    origLModel->setTable("ccceteria");
    origLModel->sort(1,Qt::SortOrder::AscendingOrder);
    origLModel->generateRoleNames();
    origLModel->setFilter("");
    origLModel->select();


    AlgoSqlTableModel* techLModel = new AlgoSqlTableModel(0,db);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    techLModel->setTable("ccctexnikos");
    techLModel->sort(1,Qt::SortOrder::AscendingOrder);
    techLModel->generateRoleNames();
    techLModel->setFilter("");
    techLModel->select();
    qDebug()<<techLModel->roleNames();



    AlgoSqlTableModel* districtLModel = new AlgoSqlTableModel(0,db);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    districtLModel->setTable("ccctexnikos");
    districtLModel->sort(1,Qt::SortOrder::AscendingOrder);
    districtLModel->generateRoleNames();
    districtLModel->setFilter("");
    districtLModel->select();

/*

    AlgoSqlTableModel* appointmentLModel = new AlgoSqlTableModel(0,db1);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    appointmentLModel->setTable("appointment");
    appointmentLModel->sort(3,Qt::SortOrder::AscendingOrder);
    appointmentLModel->generateRoleNames();
    appointmentLModel->setFilter("");
    appointmentLModel->select();


*/



    AlgoSqlTableModel* techDistrictLModel = new AlgoSqlTableModel(0,db);
    //origLModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
    techDistrictLModel->setTable("ccctechdistrict");
    techDistrictLModel->generateRoleNames();
    techDistrictLModel->setFilter("");
    techDistrictLModel->select();



    AlgoSqlTableModel* ticketLModel = new AlgoSqlTableModel(0,db);
    ticketLModel->setTable("findoc");
    ticketLModel->sort(1,Qt::SortOrder::AscendingOrder);
    ticketLModel->generateRoleNames();
    ticketLModel->setFilter("company="+settings.value("s1Company").toString()+" and sodtype=13 and series='"+settings.value("s1Series").toString()+"'");
    ticketLModel->select();
    qDebug()<<ticketLModel->roleNames();





    QString querystr= "SELECT c.cccsubscriber cid,\
            0 cerpid,\
            c.name cname,\
            c.cccperioxi clocation,\
            c.city ccity,\
            c.cccnomos ccounty,\
            c.address caddress,\
            '' cemail,\
            c.phone01 cphone1,\
            c.phone02 cphone2,\
            c.cccpostalcode cpostalcode,\
            c.cccdbf cloopnumber,\
            c.longitude clongtitude,\
            c.latitude clatitude,\
            f.ccceteria toriginatorid,\
            0 terporiginatorid,\
            0 terpcusid,\
            f.cccergasia ttitle,\
            '' tservice,\
            f.cccreporteddate treporteddate,\
            f.cccpriority tpriority,\
            f.cccdescription tdescription,\
            f.cccticket tcustomerticketno,\
            f.cccappointmentfrom tappointmentfrom,\
            '' tappointmentto,\
            f.fincode tincident,\
            '' tdepartment,\
            f.ccckatastash tstatus,\
            f.ccctexnikos ttechid,\
            f.findoc tid,\
            f.cccnewappointmentdate tnewappointmentdate,\
            o.name oname\
            FROM findoc f,cccsubscriber c,ccceteria o\
            where f.cccsubscriber=c.cccsubscriber and f.ccceteria=o.ccceteria\
            and f.ccckatastash=1 and o.name like '%'";

    AlgoSqlQueryModel* custTicketLModel=new AlgoSqlQueryModel(&db,querystr);






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







    querystr= "select t.findoc tid,t.fincode tincident,c.name cname,\
            t.cccappointmentfrom tappointmentfrom,t.ccckatastash tstatus,tc.name tcname,\
            o.name oname,t.cccversion tversion,t.ccctexnikos ttechid from findoc t,ccceteria o\
            ,cccsubscriber c,ccctexnikos tc where t.ccceteria=o.ccceteria \
            and t.cccsubscriber=c.cccsubscriber\
             and t.ccctexnikos=tc.ccctexnikos";

    AlgoSqlQueryModel* techTicketLModel=new AlgoSqlQueryModel(&db,querystr);

    techTicketLModel->setQuery();
            nbCols = techTicketLModel->columnCount();

            for (int i = 0; i < nbCols; i++)
            {
                qDebug()<<techTicketLModel->headerData(i, Qt::Horizontal).toString();
            }

    techTicketLModel->generateRoleNames();
    qDebug()<<techTicketLModel->roleNames();
/*

    QString querystr1="SELECT c.cccsubscriber cid,\
            0 cerpid,\
            c.name cname,\
            c.cccperioxi clocation,\
            c.city ccity,\
            c.cccnomos ccounty,\
            c.address` cddress,\
            '' cemail,\
            c.phone01 cphone1,\
            cphone02 cphone2,\
            c.cccpostalcode cpostalcode,\
            c.cccdbf cloopnumber,\
            c.longitude clongtitude,\
            clatitude clatitude,\
            t.ccceteria toriginatorid,\
            0 terporiginatorid,\
            0 terpcusid,\
            t.cccergasia ttitle,\
            '' tservice,\
            t.cccreporteddate treporteddate,\
            t.cccpriority tpriority,\
            t.cccdescription tdescription,\
            t.cccticket tcustomerticketno,\
            t.cccappointmentfrom tappointmentfrom,\
            '' tappointmentto,\
            t.fincode tincident,\
            '' tdepartment,\
            t.findoc tid,\
            oname oname,\
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
*/
    QString querystr1="SELECT ccctechdistrict tdid,d.name ddescription,td.techid tdtechid,td.refdate tdrefdate from ccctexnikos d inner join\
    ccctechdistrict td on d.ccctexnikos=td.districtid";





    AlgoSqlQueryModel* techDistrictQLModel=new AlgoSqlQueryModel(&db,querystr1);


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
    //engine.rootContext()->setContextProperty("appointmentModel",appointmentLModel);
    engine.rootContext()->setContextProperty("techDistrictQModel",techDistrictQLModel);
    engine.rootContext()->setContextProperty("techDistrictModel",techDistrictLModel);
    //engine.rootContext()->setContextProperty("appCustomerTicketModel",appCustTicketLModel);
    engine.rootContext()->setContextProperty("taskEmail",&taskemail);
    engine.rootContext()->setContextProperty("ve",ve);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));



    return app.exec();
}
