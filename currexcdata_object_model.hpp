#ifndef CURREXCDATAOBJECTMODEL_HPP
#define CURREXCDATAOBJECTMODEL_HPP

#include <QAbstractListModel>

#include "currexcdata_object.hpp"

class CurrExcDataObjectModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum CurrencyExchangeDataObjectRoles
    {
        CurrencyRole = Qt::UserRole + 1,
        ChangeRole,
        CostRole
    };

    CurrExcDataObjectModel(QObject *parent = 0);

    void addCurrExcDataObject(const CurrExcDataObject &object);

    int rowCount(const QModelIndex & parent = QModelIndex()) const override;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;
private:
    QList<CurrExcDataObject> objects_;
};

#endif // CURREXCDATAOBJECTMODEL_HPP
