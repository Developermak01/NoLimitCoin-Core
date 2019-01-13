#ifndef LOADINGBLOCKCHAIN_H
#define LOADINGBLOCKCHAIN_H

#include <QWidget>

QT_BEGIN_NAMESPACE
class QModelIndex;
QT_END_NAMESPACE

namespace Ui {
	class LoadingBlockchain;
}
class ClientModel;

class LoadingBlockchain : public QWidget
{
    Q_OBJECT

public:
    explicit LoadingBlockchain(QWidget *parent = 0);
    ~LoadingBlockchain();

     void setModel(ClientModel *model);

private:
    Ui::LoadingBlockchain *ui;
    ClientModel *model;
    bool loadedBlockchain;
    QTimer *noConnectionTimer;

    private slots:
    void updateProgress();
    void emitNoConnectionWarning();
    void stopNoConnectionTimer();

signals:
	void blockchainLoaded();  
    void showNoConnectionWarning();  
};

#endif // LOADINGBLOCKCHAIN_H
