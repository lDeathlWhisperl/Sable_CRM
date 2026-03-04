cmake_minimum_required(VERSION 3.16)

project(Sable_CRM VERSION 0.1 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Svg)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appSable_CRM
    main.cpp
)

target_include_directories(appSable_CRM PRIVATE
    external
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
        Authorization.qml
        LineEdit.qml
        PushButton.qml
        ErrorMessage.qml

    RESOURCES
        resources/fonts/Montserrat-Regular.ttf
        resources/fonts/Montserrat-Bold.ttf
        resources/fonts/Montserrat-SemiBold.ttf
        resources/images/lock.svg
        resources/images/user.svg
        resources/images/eye.svg
        resources/images/eye_slash.svg
        resources/images/lock_circle.svg
        resources/images/user_circle.svg
        resources/images/eye_circle.svg
        resources/images/eye_slash_circle.svg
        resources/images/Logo.png
        resources/images/Logo_alt.png
        resources/images/attention.svg

    SOURCES
        loginvalidator.h
        loginvalidator.cpp
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

target_link_libraries(appSable_CRM
    PRIVATE Qt6::Quick
)
target_link_libraries(appSable_CRM PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appSable_CRM
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
