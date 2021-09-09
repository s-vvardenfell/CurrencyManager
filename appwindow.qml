import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls 2.12

//import PurchaseTableModel 0.1
import SortFilterProxyModel 0.1


Window
{
    width: 1024
    height: 740
    visible: true
    title: qsTr("Currency Manager")


    RowLayout
    {
        id: rlayout
        anchors.fill: parent
        spacing: 10

        ColumnLayout
        {
            id: clmn1

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: rlayout.width * 0.4

            Label
            {

                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: clmn1.height / 20

                Text
                {
                    id: realblncTxt
                    anchors.left: parent.left
                    text: 'Data base account balance'
                }

                background: Rectangle
                {
                    color: "green"
//                    border.color:  "#2b5278"
//                    radius: 2
//                    border.width: 2
                }
            }


            Label
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: clmn1.height / 20

                Text
                {
                    id: virtblncTxt
                    anchors.centerIn: parent
                    text: Account.getBankAccountBalanceFromDB()
                }

                background: Rectangle
                {
                    color: "green"
//                    border.color:  "#2b5278"
//                    radius: 2
//                    border.width: 2
                }
            }

            Label
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: clmn1.height / 20

                Text
                {
                    id: realblncTxtRub
                    anchors.left: parent.left
                    text: 'Real account on site balance'
                }

                background: Rectangle
                {
                    color: "green"
//                    border.color:  "#2b5278"
//                    radius: 2
//                    border.width: 2
                }
            }


            Label
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: clmn1.height / 20

                Text
                {
                    id: virtblncTxtRub
                    anchors.centerIn: parent
                    text: Account.getBankAccountBalanceFromSite()
                }

                background: Rectangle
                {
                    color: "green"
//                    border.color:  "#2b5278"
//                    radius: 2
//                    border.width: 2
                }
            }

            Rectangle
            {
                Layout.fillHeight: true
                Layout.fillWidth: true

                color: 'lightgrey'

                 Text
                 {
                     anchors.centerIn: parent
                     text: 'predictions and forecasts'
                 }
             }

            ListView
            {
                id: lv2
                model : cmodel
                spacing: 6

                Layout.fillWidth: true
                Layout.fillHeight: true

//                ScrollBar.vertical: ScrollBar {}

                delegate: Rectangle
                {
                    height: lv2.height / 5
                    width: lv2.width

                    border.color:  "black"
                    radius: 5
                    border.width: 2
//                    color: "red"

                    required property string currency
                    required property string change
                    required property string cost

//                    Button
//                    {
//                        anchors.centerIn: parent
//                    }

                    Text
                    {
                        anchors.fill: parent
                        text: qsTr(currency + ", " + change + ", " + cost)
                    }

                }

            }
        }

        ColumnLayout
        {
            id: clmn2

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: rlayout.width * 0.6

            RowLayout
            {
                Layout.maximumHeight: clmn2.height / 15
                Layout.fillWidth: true

                Button
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        anchors.centerIn: parent
                        text: "BUY"
                    }

                    onPressed:
                    {
                        Account.buy(spinboxBuy.value);
                        spinboxBuy.value = 0.0
                        virtblncTxt.text = Account.getBankAccountBalanceFromDB();
                    }
                }

                SpinBox
                {
                    id: spinboxBuy
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Text {
                        anchors.centerIn: parent
                    }
                }

                Button
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        anchors.centerIn: parent
                        text: "BUY ALL"
                    }

                    onPressed:
                    {
                        Account.sellAll();
                        spinboxBuy.value = 0.0
                        spinboxSell.value = 0.0
                        virtblncTxt.text = Account.getBankAccountBalanceFromDB();
                    }
                }

            }

            RowLayout
            {
                Layout.maximumHeight: rlayout.height / 15

                Button
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        anchors.centerIn: parent
                        text: "SELL"
                    }

                    onPressed:
                    {
                        Account.sell(spinboxSell.value);
                        spinboxSell.value = 0.0
                        virtblncTxt.text = Account.getBankAccountBalanceFromDB();
                    }
                }

                SpinBox
                {
                    id: spinboxSell
                    Layout.fillWidth: true
                    Layout.fillHeight: true


                    Text {
                        anchors.centerIn: parent
                    }
                }

                Button
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Text {
                        anchors.centerIn: parent
                        text: "SELL ALL"
                    }

                    onPressed:
                    {
                        Account.sellAll();
                        spinboxBuy.value = 0.0
                        spinboxSell.value = 0.0
                        virtblncTxt.text = Account.getBankAccountBalanceFromDB();
                    }
                }

            }

            Rectangle
            {
                color: 'plum'
                 Layout.fillWidth: true
                 Layout.fillHeight: true

                 Text
                 {
                     anchors.centerIn: parent
                     text: 'another buttons and options'
                 }
            }

            ToolBar
            {

             Layout.fillWidth: true
                Label{
                    text: "Operations"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    id: searchBox

                    placeholderText: "Search..."
                    inputMethodHints: Qt.ImhNoPredictiveText

                    width: clmn2.width / 2
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            TableView
            {
                id: tableView
                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.maximumHeight: clmn2.height / 1.5

                TableViewColumn {
                    id: dateColumn
                    title: "Date"
                    role: "date"
                    movable: false
                    resizable: false
                    width: tableView.viewport.width / 7
                }

                TableViewColumn {
                    id: ptypeColumn
                    title: "Type"
                    role: "ptype"
                    movable: false
                    resizable: false
                    width: tableView.viewport.width / 7
                }

                TableViewColumn {
                    id: amountColumn
                    title: "Amount"
                    role: "amount"
                    movable: false
                    resizable: false
                    width: tableView.viewport.width / 7
                }

                TableViewColumn {
                    id: priceColumn
                    title: "Price"
                    role: "price"
                    movable: false
                    resizable: false
                    width: tableView.viewport.width / 7
                }

                TableViewColumn {
                    id: sumColumn
                    title: "Sum"
                    role: "sum"
                    movable: false
                    resizable: false
                    width: tableView.viewport.width / 7
                }

                TableViewColumn {
                    id: accountColumn
                    title: "Account"
                    role: "account"
                    movable: false
                    resizable: false
                    width: tableView.viewport.width / 7
                }

                TableViewColumn {
                    id: bankColumn
                    title: "Bank"
                    role: "bank_name"
                    movable: false
                    resizable: false
                    width: tableView.viewport.width / 7
                }

                model: SortFilterProxyModel {
                    id: proxyModel
                    source: ptmodel.columnCount() > 0 ? ptmodel : null
                    sortOrder: tableView.sortIndicatorOrder
                    sortCaseSensitivity: Qt.CaseInsensitive
                    sortRole: sourceModel.columnCount() > 0 ?
                                  tableView.getColumn(tableView.sortIndicatorColumn).role : ""

                    filterString: "*" + searchBox.text + "*"
                    filterSyntax: SortFilterProxyModel.Wildcard
                    filterCaseSensitivity: Qt.CaseInsensitive
                }

            }

        }

    }
}