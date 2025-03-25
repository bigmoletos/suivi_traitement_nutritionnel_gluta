# Guide d'Installation Flutter et Résolution des Problèmes

## Prérequis

1. **Java JDK**
   - Télécharger et installer Eclipse Temurin JDK 21 (ou plus récent) depuis : https://adoptium.net/
   - Chemin d'installation par défaut : `C:\Program Files\Eclipse Adoptium\jdk-21.0.6.7-hotspot`
   - Configurer JAVA_HOME dans les variables d'environnement système

2. **Android SDK**
   - Télécharger les Command-line tools depuis : https://developer.android.com/studio#command-tools
   - Créer la structure de dossiers :
     ```
     C:\Users\[USERNAME]\AppData\Roaming\android\Sdk\
     ├── cmdline-tools\
     │   └── latest\
     ├── platform-tools\
     └── platforms\
     ```
   - Extraire les command-line tools dans le dossier `latest`

## Installation

1. **Configuration des Variables d'Environnement**
   - ANDROID_HOME : `C:\Users\[USERNAME]\AppData\Roaming\android\Sdk`
   - JAVA_HOME : `C:\Program Files\Eclipse Adoptium\jdk-21.0.6.7-hotspot`
   - Ajouter au PATH :
     - `%ANDROID_HOME%\platform-tools`
     - `%ANDROID_HOME%\cmdline-tools\latest\bin`

2. **Installation des Composants Android**
   ```cmd
   cd %ANDROID_HOME%\cmdline-tools\latest\bin
   sdkmanager.bat "platform-tools" "platforms;android-34" "build-tools;34.0.0"
   ```

3. **Installation de Flutter**
   - Télécharger Flutter SDK depuis : https://flutter.dev/docs/get-started/install/windows
   - Extraire dans : `C:\Users\[USERNAME]\AppData\Roaming\flutter`
   - Ajouter `C:\Users\[USERNAME]\AppData\Roaming\flutter\bin` au PATH

## Problèmes Rencontrés et Solutions

### 1. Problème de Java
**Symptôme** : `Could not determine java version`
**Solution** :
- Installer Java 21 (ou plus récent)
- Configurer JAVA_HOME correctement
- Redémarrer tous les terminaux

### 2. Problème de SDK Android
**Symptôme** : `Unable to locate Android SDK`
**Solution** :
- Créer le fichier `android/local.properties` avec :
  ```
  sdk.dir=C:\\Users\\[USERNAME]\\AppData\\Roaming\\android\\Sdk
  flutter.sdk=C:\\Users\\[USERNAME]\\AppData\\Roaming\\flutter
  ```
- Vérifier que ANDROID_HOME pointe vers le bon dossier

### 3. Problème de Licences Android
**Symptôme** : `Android license status unknown`
**Solution** :
```cmd
flutter doctor --android-licenses
```
Accepter toutes les licences en tapant 'y'

### 4. Problème de Variables d'Environnement
**Symptôme** : Les commandes ne reconnaissent pas les variables
**Solution** :
- Modifier les variables dans "Paramètres système" > "Variables d'environnement"
- Redémarrer tous les terminaux et IDE
- Vérifier avec `echo %VARIABLE_NAME%`

## Vérification de l'Installation

1. **Vérifier Flutter** :
```cmd
flutter doctor -v
```

2. **Vérifier Java** :
```cmd
java -version
```

3. **Vérifier Android SDK** :
```cmd
adb version
```

## Test de l'Application

1. **Sur le Web** :
```cmd
flutter run -d chrome
```

2. **Sur un Appareil Android Physique** :
- Activer le mode développeur
- Activer le débogage USB
- Connecter l'appareil
- Exécuter `flutter run`

3. **Sur Windows** :
```cmd
flutter run -d windows
```

## Notes Importantes
- Toujours redémarrer les terminaux après modification des variables d'environnement
- Vérifier les chemins d'installation exacts
- S'assurer que tous les composants sont installés dans les bons dossiers
- Garder les versions de Java et Android SDK à jour