#include "include/lipila_flutter/lipila_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "lipila_flutter_plugin.h"

void LipilaFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  lipila_flutter::LipilaFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
