import QtQuick
import QtQuick.Controls
import Theme

Item
{
    id: root
    property var headerModel: []
    property var rowsModel: []
    property var model: []
    property Component delegate
    property int rowSpacing: 0
    property int columnSpacing: 0

    property alias currentColumn: tableView.currentColumn
    property alias currentRow: tableView.currentRow
    property alias resizableColumns: tableView.resizableColumns
    property alias resizableRows: tableView.resizableRows

    HorizontalHeaderView
    {
        id: horizontalHeader
        anchors.left: tableView.left
        anchors.top: parent.top
        syncView: tableView
        model: headerModel
        delegate: Text
        {
            text: modelData
            font.bold: true
            color: Theme.palette.text.primary
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    VerticalHeaderView
    {
        id: verticalHeader
        anchors.top: tableView.top
        anchors.left: parent.left
        syncView: tableView
        model: rowsModel
        delegate: Item
        {
            implicitWidth: label.implicitWidth + 20
            Text
            {
                id: label
                anchors.centerIn: parent
                text: modelData
                font.bold: true
                color: Theme.palette.text.primary
            }

            Rectangle
            {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: Theme.palette.border.primary
            }
        }
    }

    TableView
    {
        id: tableView
        anchors.left: verticalHeader.right
        anchors.top: horizontalHeader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        rowSpacing: root.rowSpacing
        columnSpacing: root.columnSpacing
        delegate: root.delegate
        model: root.model

        columnWidthProvider: function(column)
        {
            return tableView.width / headerModel.length
        }

        rowHeightProvider: function(row)
        {
            return tableView.height / rowsModel.length
        }
    }
}
