#ifndef TASKSREPOSITORY_H
#define TASKSREPOSITORY_H

#include <QString>
#include <QDate>

struct Task
{
    int id;
    int client_id;
    int assigned_to;
    QDate deadline;
    QString description;
    int status_id;
};

class TasksRepository
{
public:
    TasksRepository();
};

#endif // TASKSREPOSITORY_H
