# justext

## just another Tool, um Textschnipsel in die Windows-Zwischenablage zu kopieren

Textschnipsel-Tools gibt es viele. Mein Favorit unter Windows ist [Beeftext](https://beeftext.org/), plattformübergreifend ist [expanso](https://espanso.org/) stark.
Doch keines der Tools funktioniert in Umgebungen, in denen die Ausführung von Fremd-Software durch organisatorische oder erst recht technische Schutzmechanismen ([Software Restrictions Policies](https://learn.microsoft.com/de-de/windows-server/identity/software-restriction-policies/administer-software-restriction-policies)) verhindert wird. Das ist in vielen Kundenprojekten so, in denen ich arbeite.

### Einsatzzweck

Der Einsatzzweck von **justext** sind Situationen, in denen dieselben Phrasen wieder und wieder eingefügt werden müssen. Das sind Texte wie:  "Moin, bezüglich des Themas blablub würde ich gern mit Ihnen sprechen. Wann passt es Ihnen?" oder "Kunde telefonisch nicht erreicht, Nachricht mit Bitte um Rückruf geschrieben." oder "Anleitung für den Antrag zur Erteilung eines Antragformulars zur Bestätigung der Nichtigkeit des Durchschriftexpemplars" oder, oder, oder.

Natürlich bieten manche Programme direkt Möglichkeiten solche Phrasen/Textbausteine einzufügen. Doch alle funktionieren anders und in vielen Programmen gibt es einfach keine Möglichkeit dafür. Menschen, die täglich zigmal dasselbe schreiben müssen, helfen sich dann oft mit Abkürzungen: "Kd tne, RR!" oder "tel m Kd, KB08154711", was dann nur Eingeweihte verstehen.

Teamübergreifend gibt es oft das eine Dokument mit den aktuellen Textschnipseln: "abgenommene Kundendialogtexte V2, aktualisierte Version 1.4.b - DRAFT.doc", die sich jeder in seinen Dokumentenordner kopiert und oft die finale Version verpasst.

**justext** einfach zu konfigurieren, Textschnipsel können einfach als Textdatei gespeichert werden und über einen (stets geöffneten) Ordner werden die Textschnipsel per Doppelklick in die Zwischenablage kopiert.

Klar, eigentlich sollten gerade Programme, in denen viel dokumentiert wird, Möglichkeiten bieten Textbausteine einfach definieren und schnell einfügen zu können. Nach meiner Erfahrung ist dies selten der Fall. Darum erstellte ich für mich **justext** und ich kann mir vorstellen, dass es anderen ebenfalls hilft.

## Funktionsweise

Die Kernkomponenten von **justext** sind cmd-Skripte und die clip.exe". Die clip.exe gehört zum Lieferumfang von Windows und wird daher praktisch nie geblockt. cmd-Skripte werden in den meisten Umgebungen für administrative Zwecke genutzt und sind ebenfalls meist nicht von Einschränkungen betroffen.

Der Mechanismus ist immer gleich: Text wird an die clip.exe übergeben und die tut, was sie soll:

> **CLIP**
>
> Beschreibung:  
> Leitet die Ausgabe von Befehlszeilenprgrammen in die Windows-Zwischenablage um.  
> Diese Textausgabe kann in andere Programme eingefügt werden.  
> Parameterliste:  
> /?                  Zeigt diese Hilfe an.  
> Beispiele:  
> DIR | CLIP          Erstellt eine Kopie des aktuellen Verzeichnisinhalts in der Windows-Zwischenablage.  
> CLIP < README.TXT   Erstellt eine Textkopie von readme.txt in der Windows-Zwischenablage.

## Verwendung

Im Ordner **#justext** kann eine Textschnipsel-Skript-Datei mittels Doppelklick gestartet werden. Sogleich wird der Textschnipsel in der Zwischenablage kopiert und kann eingefügt werden.

Manche Textschnipsel können komplexer sein und bieten z.B. eine Eingabemöglichkeit oder verwenden Variablen wie das Datum oder den Windows-Usernamen.

## Bestandteile

**justext** besteht im Wesentlichen aus 3 Ordnern, in denen die Textschnipsel liegen und dem Skript "Textschnipsel-machen", das aus der Datei "\_justext.template" ausführbare Textschnipsel-Skript-Dateien im Ordner #justext erstellt.

#justext
eigeneTexte
gemeinsameTexte
\_justext.template
Textschnipsel-machen.cmd

### Ordner "#justext"

In diesem Ordner werden die fertigen Textschnipsel bereitgestellt. Beim Doppelklick auf eine der Textschnipsel-Dateien wird der jeweilige Inhalt in die Zwischenablage kopiert.
In diesem Ordner liegen ebenfalls .dat-Dateien, die den zu kopierenden Text enthalten. Diese .dat-Dateien werden versteckt, sodass sie in der Ansicht nicht stören.

### Ordner "eigeneTexte"

In diesem Ordner werden die persönlichen Textschnipsel, z.B. die eigenen eMail-Adressen gespeichert. Reine Textschnipsel haben die Endung ".txt".

Eigene Skripte müssen die Endung ".cmd" haben und sie können Variablen aus ".ini"-Dateien auslesen.

Mögliche Endungen: .txt, .cmd, .ini

### Ordner "gemeinsameTexte"

Diese Textschnipsel sind für mehrere Benutzer gleich, z.B. die eMail vom Gruppenpostfach oder Phrasen, die alle verwenden sollten. Die aktuellen Gruppentexte könnten z.B. mittels Verteilskripten in die jeweiligen Benutzerverzeichnisse kopiert werden. Der Ordner "eigeneTexte" bleibt davon unberührt.

### Datei "\_justext.template"

Diese Datei enthält zwei Zeilen Code:

```cmd
@chcp 65001 > nul
@clip < "%~dpn0.dat"
```

### Datei "Textschnipsel-machen.cmd"

Mittels dieses Skripts werden aus den ".txt"- und ".cmd"-Dateien die Textschnipsel-Skript-Dateien im Ordner "#justext" erstellt. 

Im ersten Teil des Skripts werden eigene Skripte ".cmd" und ".ini"-Dateien lediglich in den Ordner "#justext" kopiert. Anschließend werden die ".ini"-Dateien versteckt, sodass lediglich die ".cmd"-Dateien sichtbar sind.

```cmd
copy .\Beispiele\*.cmd .\#justext\ /y|find "cmd"
copy .\Beispiele\*.ini .\#justext\ /y
attrib +h ".\#justext\*.ini" > nul
```
Im zweiten Teil geschieht die Magie: Zunächst wird die Datei "\_justext.template" in den Ordner "#justext" kopiert. Jedoch wird der Dateiname gleich dem Namen der ".txt"-Datei gesetzt. Gibt es z. B. eine Datei namens "toll.txt", wird die Datei "\_justext.template" als "toll.cmd" in in den Ordner "#justext" kopiert. Diese "toll.cmd" wird dann später ausgeführt.
Die "toll.cmd" benötigt jedoch eine ".dat"-Datei, die den Text enthält, der in die Zwischenablage kopiert werden soll. Dies wird in der nächsten Zeile des Codes erledigt, sprich die ".txt"-Datei wird als ".dat"-Datei in den Ordner "#justext" kopiert und im nächsten Schritt versteckt, damit auch hier lediglich die ausführbaren ".cmd"-Dateien angezeigt werden.

```cmd
copy "_justext.template" ".\#justext\%%~nf.cmd" /y > nul
copy   ".\gemeinsameTexte\%%~nf.txt" ".\#justext\%%~nf.dat" /y > nul
attrib +h ".\#justext\%%~nf.dat" > nul
```
## eigene Textschnipsel-Skripte

Mittels Skripten können komplexere Textschnipsel generiert werden, die beispielsweise Variablen wie das Datum oder eine Texteingaben abwarten und dann verarbeiten.

So wird im "Beispiel Datum-rückwärts" aus ...

```cmd
@echo %date:~6,4%-%date:~3,2%-%date:~0,2%|clip
```

das Datum rückwärts, also

```cmd
1976-04-24
```

Mit Skripten können Programme gestartet werden.
Im "Beispiel open-Autostart" wird der Autostart-Ordner von Windows geöffnet:

```cmd
start %SystemRoot%\EXPLORER.EXE /E, shell:Startup
```

## Good Pratices

### Zwischenablageverlauf anknipsen

Mittels der Funktion "Zwischenablageverlauf", die ab Windows 10 dabei ist, lassen sich nacheinander in die Zwischenablage kopierte Inhalte anzeigen und einfügen.

Aufgerufen wird der "Zwischenablageverlauf" über die Tastenkombi "Windows-v".  
Beim ersten Aufruf kann diese Funktion grundsätzlich eingeschaltet werden.

## Bekannte Probleme

### Leerzeichen im Dateinamen von Textdateien funktionieren nicht

Die Programmschleife kommt damit nicht klar. Bei Skripten gilt dies wiederum nicht, da sie lediglich kopiert werden. Mit Dateien ohne Leerzeichen macht man alles richtig.

## Changelog

- 0.3.0 - 26.06.2025
  - Nun können auch Sonderzeichen verarbeitet werden.
- 0.2.1 - 16.06.2025
  - Readme erweitert
- 0.2.0 - 22.04.2025
  - Redesign "Textschnipsel-machen.cmd"
- 0.1.0 - 19.03.2025 Initiale Version
  - 10.03.2025 Lösungsansatz mittels PowerShell eingefügt.
  - 14.02.2025 Neue Farbe :) Viele kleine Verbesserungen, bei Skripten können Variablen in ".ini"-Dateien verarbeitet werden.
  - 07.02.2025 Neu ist je eine Setupdatei, die eine Verknüpfung ins Startmenü oder in den Autostart Ordner des angemeldeten Users kopiert.