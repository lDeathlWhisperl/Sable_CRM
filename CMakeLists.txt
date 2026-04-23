cmake_minimum_required(VERSION 3.16)

project(Sable_CRM VERSION 0.1 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick Svg Sql)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appSable_CRM
    main.cpp
)

target_include_directories(appSable_CRM PRIVATE
    external
    Repository
)

target_sources(appSable_CRM PRIVATE
    external/qtbcrypt.cpp
    external/openwall_crypt/crypt_blowfish.c
    external/openwall_crypt/crypt_gensalt.c
    external/openwall_crypt/wrapper.c
    external/openwall_crypt/x86.S
)

qt_add_qml_module(appSable_CRM
    URI Sable_CRM
    VERSION 1.0

    QML_FILES
        View/Authorization.qml
        View/Window.qml
        View/WorkingArea.qml
        View/Theme.qml

        View/Components/LineEdit.qml
        View/Components/PushButton.qml
        View/Components/Message.qml
        View/Components/MenuBar.qml
        View/Components/PopupWindow.qml
        View/Components/ComboButton.qml
        View/Components/UserCard.qml
        View/Components/RoleTag.qml
        View/Components/Table.qml
        View/Components/CheckButton.qml

        View/Categories/Main.qml
        View/Categories/Employees.qml
        View/Categories/Settings.qml

        View/Categories/Instruments/AddEmployee.qml
        View/Categories/Instruments/AddRole.qml

        View/Structs/Colors.qml
        View/Structs/Category.qml
        View/Structs/User.qml

    RESOURCES
        Resources/fonts/Montserrat-Regular.ttf
        Resources/fonts/Montserrat-Bold.ttf
        Resources/fonts/Montserrat-SemiBold.ttf

        Resources/images/attention.svg
        Resources/images/light_lock.svg             Resources/images/dark_lock.svg
        Resources/images/light_lock_circle.svg      Resources/images/dark_lock_circle.svg
        Resources/images/light_user.svg             Resources/images/dark_user.svg
        Resources/images/light_user_circle.svg      Resources/images/dark_user_circle.svg
        Resources/images/light_eye_circle.svg       Resources/images/dark_eye_circle.svg
        Resources/images/light_eye_slash_circle.svg Resources/images/dark_eye_slash_circle.svg
        Resources/images/light_check.svg            Resources/images/dark_check.svg
        Resources/images/light_info.svg             Resources/images/dark_info.svg

        Resources/images/Logo.png
        Resources/images/Logo_alt.png

        Resources/DB/Script.sql

    SOURCES
        loginvalidator.h                loginvalidator.cpp
        databasemanager.h               databasemanager.cpp
        authservice.h                   authservice.cpp
        authviewmodel.h                 authviewmodel.cpp
        accessmanager.h                 accessmanager.cpp
        Repository/userrepository.h     Repository/userrepository.cpp
        Repository/clientsrepository.h  Repository/clientsrepository.cpp
        Repository/tasksrepository.h    Repository/tasksrepository.cpp
        Repository/dealsrepository.h    Repository/dealsrepository.cpp
        Repository/sessionsrepository.h Repository/sessionsrepository.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSable_CRM PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSable_CRM
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSable_CRM PRIVATE Qt6::Quick)
target_link_libraries(appSable_CRM PRIVATE Qt6::Core)
target_link_libraries(appSable_CRM PRIVATE Qt6::Sql)
target_link_libraries(appSable_CRM PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appSable_CRM
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
