# UBI_K_GPS App

App UbiK in Flutter

## Introduccion

Aplicacion desarrollada en el framework Flutter a traves del lenguaje Dart
Para utilizar o probar los script del app es necesario descargar el SDK del framework, cualquier version a partir del
2.0.0 hasta la actual, ya contiene por defecto la version del lenguaje Dart para el diseño centralizado del APP.

- Descargar [aqui](https://docs.flutter.dev/get-started/install) el framework para testing de esta APP, descargar el SDK de windows

Una vez descargado, descomprimir el archivo en el _**disco local (C:)**_ fuera de las carpetas de archivos de programas y
archivos de programas(x86).

NOTA: Es necesario para pruebas de virtualizacion tener descargado Android Studio, para poder utilizar los dispositivos
de virtualizacion (AVD manager).

Dentro de las variables de entorno del sistema y de usuario, colocar la direccion de la carpeta de flutter descargada
_**C:flutter/bin**_. </br><p>De igual manera, colocar las variables de entorno de Android Studio en las variables de usuario. 
</br><p> Se crea una nueva varriable llamada: 
_**ANDROID_HOME**_ y colocar la direccion del SDK de android studio ubicada en los archivos
ocultos dentro del AppData:
</br>_**C:\Users\\('nombre de su maquina')\AppData\Local\Android\Sdk**_

Dentro del Path de las variables de entorno de usuario agregar los siguientes valores:
</br>- _**%ANDROID_HOME%\platform-tools**_
</br>- _**%ANDROID_HOME%\tools**_

NOTA 2: Para pruebas en VS(Visual Studio Code): descargar las extensiones de flutter y dart para poder obtener el interprete del
framework.

NOTA 3: En caso de pruebas en dispositivos fisicos, preferible utilizar dispositivos android de momento.

NOTA 4: Los archivos subido a este repositorio son solamente codigo y de dependencias necesarias para operar el app, es necesario que:
<p> 1. Se cree un "New project FLutter",</p> 
<p> 2. Eliminar la carpeta "lib" del proyecto creado y añadir la carpeta "lib" de este repositorio con el codigo actualizado,</p> 
<p> 3. Asi tambien colocar el achivo pubspec.yaml de este repositorio, quitando el que viene creado por defecto, ya que este consta con las dependencias necesarias aplicadas en la aplicacion.</p>
<p> 4. Una vez copiado el archivo pubspec.yaml se realiza un _**flutter pub get**_ desde el terminal del IDE.</p>
<p> 5. Se empezara a descargar los archvos necesarios para la ejecucion del proyecto. Esperar.</p>
<p> 6. La carpeta "images" contiene los iconos e imagenes utilizados en el desarrollo de la app.</p>

En caso de alguna inquietud, contactar a los desarroladores.
