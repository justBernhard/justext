# justext


## Just another Tool, um Textschnipsel in die Windows-Zwischenablage zu kopieren

Textschnipsel-Tools gibt es viele. Mein Favorit ist [Beeftext](https://beeftext.org/). Plattformübergreifend ist [expanso](https://espanso.org/) stark.
Doch keines der Tools funktioniert in Umgebungen, in denen die Ausführung von Fremd-Software durch technische Schutzmechanismen ([Software Restrictions Policies](https://learn.microsoft.com/de-de/windows-server/identity/software-restriction-policies/administer-software-restriction-policies)) verhindert wird.


## Funktionsweise

Die Kernkomponenten von justext sind cmd-Skripte und die clip.exe". Beides gehört bei Windows dazu und wird daher praktisch nie geblockt.

Der Mechanismus ist immer gleich: Text wird an die clip.exe übergeben und die tut, was sie soll:

> **CLIP**  
>   
> Beschreibung:  
>     Leitet die Ausgabe von Befehlszeilenprgrammen in die Windows-Zwischenablage um.  
>     Diese Textausgabe kann in andere Programme eingefügt werden.  
>  Parameterliste:  
>     /?                  Zeigt diese Hilfe an.  
>  Beispiele:  
>     DIR | CLIP          Erstellt eine Kopie des aktuellen Verzeichnisinhalts in der Windows-Zwischenablage.  
>      CLIP < README.TXT   Erstellt eine Textkopie von readme.txt in der Windows-Zwischenablage.


## Verwendung

Im Ordner **#justext** kann eine Textschnipsel Datei mittels Doppelklick gestartet werden. Sogleich ist der Textschnipsel in der Zwischenablage und kann eingefügt werden.

Manche Textschnipsel können komplexer sein und bieten nach dem Start z.B. eine Eingabemöglichkeit oder verwenden Variablen wie das Datum oder den Windows-Username.


## Bestandteile

justext besteht aus 4 Ordnern, in denen die Ausgangsdateien liegen und dem Skript "Textschnipsel-machen", das die Textschnipspel mittels "_justext.cmd" umwandelt und in den Ordner #justext kopiert, wo sie dann gestartet werden können.

#justext
GruppenSkripte
GruppenTexte
meineSkripte
meineTexte
_justext.template
Textschnipsel-machen.cmd
readme.md

### GruppenTexte

Diese Textschnipsel sind für mehrere Benutzer gleich, z.B. die eMail vom Gruppenpostfach oder Phrasen, die alle verwenden sollten.
Die aktuellen Gruppentexte könnten z.B. mittels Anmeldeskript kopiert werden.
Der Ordner "meineTexte" bleibt davon unberührt.

### meineTexte

Im Gegensatz zum Ordner "GruppenTexte" sind hier die persönlichen Textschnipsel, z.B. die eigenen eMail-Adressen gespeichert. 

### GruppenSkripte

Mittels Skripten können komplexere Textschnipsel generiert werden, die beispielsweise Variablen wie das Datum oder eine Texteingaben abwarten und dann verarbeiten.

So wird im "Beispiel Datum-rückwärts" aus ...

```
@echo %date:~6,4%-%date:~3,2%-%date:~0,2%|clip
```

das Datum rückwärts, also

```
1976-04-24
```

Mit Skripten können Programme gestartet werden.
Im "Beispiel open-Autostart" wird der Autostart-Ordner von Windows geöffnet:

```
start %SystemRoot%\EXPLORER.EXE /E, shell:Startup
```

### meineSkripte

Im Gegensatz zum Ordner "GruppenTexte" sind das die persönliche Skripte.


## Bekannte Probleme

Sonderzeichen funtionieren nicht - aus ä wird ├ñ, ö Â und ü ├╝.
Die clip.exe funktioniert auf der Windows-Kommandozeile. Dort gilt ein anderer, einfacherer Zeichensatz ohne Sonderzeichen.
Das ist sicher die größte Einschränkung. In manchen Fällen hilft ein Blick auf https://www.openthesaurus.de/ um Wörter ohne Umlaute zu finden.

Das Umlautproblem ließe sich mittels Powershell lösen:
```powershell
# Holen Sie den Skriptpfad
$scriptPath = $MyInvocation.MyCommand.Path
# Extrahieren Sie den Verzeichnispfad
$directoryPath = [System.IO.Path]::GetDirectoryName($scriptPath)
# Extrahieren Sie den Dateinamen ohne Erweiterung
$scriptNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($scriptPath)
# Pfad zur zum Skript gehörenden Textdatei
$filePath = "$directoryPath\$scriptNameWithoutExtension.txt"
# Textdatei einlesen
$text = Get-Content -Path $filePath -Encoding String
# Kopieren des Inhalts in die Zwischenablage
Set-Clipboard -Value $text
```

Doch ein Powershell-Skript lässt sich nicht einfach mittels Doppelklick starten. Damit ist die Usability dahin.

Leerzeichen im Dateinamen von Textdateien (GruppenTexte und MeineTexte) funktionieren nicht - die Programmschleife kommt damit nicht klar.
Bei Skripten gilt dies wiederum nicht, da sie lediglich kopiert werden.
Mit Dateien ohne Leerzeichen macht man alles richtig.

## Changelog

28.05.2024 erstellt werden ini Dateien, damit kein doppelten txt Dateien vorkommen, die User verwirren könnten.  
29.05.2024 Dateien in "%USERPROFILE%\\Documents#justxt" werden irgendwie nicht gefunden. Statt dessen wird OneDrive genutzt. Verwirrend.  
30.05.2024 Auch in OneDrive wird nix gefunden. Also bleibt doch alles in dem Verzeichnis.  
04.06.2024 statt .dat statt .ini, weil die Ikone dann komplett weiß ist und .cmd besser heraussticht ist.  
05.06.2024 die .dat werden versteckt  
17.06.2024 nach einigen Tagen Test verabschiede ich mich von der Idee die Datenamen mit "#" zu beginnen und die Dateien dann über das Startmenü und "#" schnell finden zu können. Es hat einfach nicht so funktioniert. Somit lässt sich die Idee, darüber so eine Art Schnellzugriff auf einzelne Textschnipsel zu erschaffen, nicht umsetzen.  
12.12.2024 Laut "clip /?" kann Text mittels "clip < text.txt" in die Zwischenablage kopiert werden. Der kleine Umweg über "type %0|clip" kann damit entfallen.  
30.01.2025 Neu ist der Ordner GruppenSkripte, in dem Organisationen Skripte zur Verfügung stellen können.  
07.02.2025 Neu ist der Ordner BeispielSkripte, in dem verschiedene Beispiele enthalten sind.  
07.02.2025 Neu ist je eine Setupdatei, die eine Verknüpfung ins Startmenü oder in den Autostart Ordner des angemeldeten Users kopiert.  
14.02.2025 Neue Farbe :) Viele kleine Verbesserungen, bei Skripten können Variablen in .ini Dateien verarbeitet werden.  
25.02.2025 Beispiele überarbeitet  
10.03.2025 Lösungsansatz mittels Powershell eingefügt  
