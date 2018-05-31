import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0



Pane {
    id: page
    LinearGradient {
           anchors.fill: parent
           start: Qt.point(0, 0)
           end: Qt.point(0, 300)
           gradient: Gradient {
               GradientStop { position: 0.0; color: "#e6e6e6" }
               GradientStop { position: 1.0; color: "#333333" }
           }
       }



        Column {
            id:c1
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter







            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:dsnMySql
                wrapMode: TextArea.Wrap
                placeholderText: "dsnMysql"
                anchors.fill: parent
                text:ve.readSetting("dsnMySQL")
            }
            }




            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

                TextArea {


                    id:hostnamenMySql
                    wrapMode: TextArea.Wrap
                    placeholderText: "Mysql Hostname"
                    anchors.fill: parent
                    text:ve.readSetting("hostnameMySQL")
                }
            }

            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

                TextArea {


                    id:userMySql
                    wrapMode: TextArea.Wrap
                    placeholderText: "MySQL UserName"
                    anchors.fill: parent
                    text:ve.readSetting("userMySQL")
                }
            }




            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

                TextArea {


                    id:passMySql
                    wrapMode: TextArea.Wrap
                    placeholderText: "MySQL Password"
                    anchors.fill: parent
                    text:ve.readSetting("passMySQL")
                }
            }


            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

                TextArea {


                    id:dsnSqlServer
                    wrapMode: TextArea.Wrap
                    placeholderText: "SQL Server DSN"
                    anchors.fill: parent
                    text:ve.readSetting("dsnSQLServer")
                }
            }


            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

                TextArea {


                    id:userSqlServer
                    wrapMode: TextArea.Wrap
                    placeholderText: "SQL Server User"
                    anchors.fill: parent
                    text:ve.readSetting("userSQLServer")
                }
            }


            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

                TextArea {


                    id:passSqlServer
                    wrapMode: TextArea.Wrap
                    placeholderText: "SQL Server Password"
                    anchors.fill: parent
                    text:ve.readSetting("passSQLServer")
                }
            }





            Row{
                spacing: 25
            Button{
                id:btnok

                    Image {
                        anchors.fill: parent
                        source: "qrc:images/btnok.png"
                    }

                    onReleased: {
                        ve.writeSetting("dsnMySQL",dsnMySql.text);
                        ve.writeSetting("hostnameMySQL",hostnamenMySql.text);
                        ve.writeSetting("userMySQL",userMySql.text);
                        ve.writeSetting("passMySQL",passMySql.text);
                        ve.writeSetting("dsnSQLServer",dsnSqlServer.text);
                        ve.writeSetting("userSQLServer",userSqlServer.text);
                        ve.writeSetting("passSQLServer",passSqlServer.text);

                        stackView.pop()
                    }

            }

            Button{
                id:btncancel


                Image {
                    anchors.fill: parent
                    source: "qrc:images/cancel.png"
                }
                onReleased: {
                    stackView.pop()
                }
            }








}
        }

}

