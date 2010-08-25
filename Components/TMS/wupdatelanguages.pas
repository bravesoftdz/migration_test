{*******************************************************************}
{ TWEBUPDATE Wizard component                                       }
{ for Delphi & C++Builder                                           }
{ version 1.6                                                       }
{                                                                   }
{ written by                                                        }
{    TMS Software                                                   }
{    copyright � 1998-2005                                          }
{    Email : info@tmssoftware.com                                   }
{    Web   : http://www.tmssoftware.com                             }
{                                                                   }
{ The source code is given as is. The author is not responsible     }
{ for any possible damage done due to the use of this code.         }
{ The component can be freely used in any application. The source   }
{ code remains property of the writer and may not be distributed    }
{ freely as such.                                                   }
{*******************************************************************}

unit WUpdateLanguages;

interface

uses
  Classes, WUpdateWiz;

type

  TWebUpdateWizardEnglish = class(TWebUpdateWizardLanguage)
  end;

  TWebUpdateWizardDutch = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebUpdateWizardFrench = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebUpdateWizardGerman = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebUpdateWizardPortugese = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebUpdateWizardSpanish = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebUpdateWizardDanish = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;
  
  TWebUpdateWizardItalian = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebUpdateWizardNorwegian = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebUpdateWizardHungarian = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TWebUpdateWizardSwedish = class(TWebUpdateWizardLanguage)
  public
    constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TWebUpdateWizardDutch }

constructor TWebUpdateWizardDutch.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Druk start om te beginnen met controleren voor applicatie updates ...';
  StartButton := 'Start';
  NextButton := 'Volgende';
  ExitButton := 'Verlaten';
  CancelButton := 'Annuleren';
  RestartButton := 'Herstarten';
  GetUpdateButton := 'Update';
  NewVersionFound := 'Nieuwe version gevonden';
  NewVersion := 'Nieuwe versie';
  NoNewVersionAvail := 'Geen nieuwe versie beschikbaar.';
  NewVersionAvail := 'Nieuwe versie beschikbaar.';
  CurrentVersion := 'Huidige versie';
  NoFilesFound := 'Geen bestanden gevonden voor update';
  NoUpdateOnServer := 'geen update gevonden op server ...';
  CannotConnect := 'Er kan geen verbinding met de update server tot stand gebracht worden of';
  WhatsNew := 'Nieuw in update';
  License := 'Licentie overeenkomst';
  AcceptLicense := 'Ik aanvaard';
  NotAcceptLicense := 'Ik aanvaard niet';
  ComponentsAvail := 'Beschikbare applicatie componenten';
  DownloadingFiles := 'Downloaden bestanden';
  CurrentProgress := 'Vooruitgang huidig bestand';
  TotalProgress := 'Totale vooruitgang';
  UpdateComplete := 'Update volledig ...';
  RestartInfo := 'Druk Herstarten om de nieuwe versie te starten.';
end;

{ TWebUpdateWizardFrench }

constructor TWebUpdateWizardFrench.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Appuyez lancer pour controler la disponibilit� d''une version nouvelle ...';
  StartButton := 'Lancer';
  NextButton := 'Suivant';
  ExitButton := 'Quitter';
  CancelButton := 'Annuler';
  RestartButton := 'Relancer';
  GetUpdateButton := 'Update';
  NewVersionFound := 'Version nouvelle trouv�e';
  NewVersion := 'Version nouvelle';
  NoNewVersionAvail := 'Pas de version nouvelle disponible.';
  NewVersionAvail := 'Version nouvelle disponible.';
  CurrentVersion := 'Version actuelle';
  NoFilesFound := 'Pas de fichiers trouv�s pour version nouvelle';
  NoUpdateOnServer := 'pas trouv� de version nouvelle sur serveur ...';
  CannotConnect := 'Pas possible de faire connection avec serveur ou';
  WhatsNew := 'Nouveaut�s';
  License := 'Conditions de license';
  AcceptLicense := 'J''accepte';
  NotAcceptLicense := 'Je n''accepte pas';
  ComponentsAvail := 'Composants d''application disponible';
  DownloadingFiles := 'T�l�chargement des fichiers';
  CurrentProgress := 'Progr�s fichier';
  TotalProgress := 'Progr�s total';
  UpdateComplete := 'Update compl�t ...';
  RestartInfo := 'Appuyez Relancer pour lancer la version nouvelle';
end;

{ TWebUpdateWizardGerman }

constructor TWebUpdateWizardGerman.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Klicken Sie auf Start, um mit der Updatepr�fung zu beginnen...';
  StartButton := 'Start';
  NextButton := 'Weiter';
  ExitButton := 'Verlassen';
  RestartButton := 'Neu starten';
  CancelButton := 'Abbruch';
  GetUpdateButton := 'Update';
  NewVersionFound := 'Neue Version gefunden';
  NewVersion := 'Neue Version';
  NoNewVersionAvail := 'Keine neue Version verf�gbar.';
  NewVersionAvail := 'Neue Version verf�gbar';
  CurrentVersion := 'Aktuelle Version';
  NoFilesFound := 'Auf dem Server wurden keine Dateien gefunden';
  NoUpdateOnServer := 'Kein Update vorhanden auf Server ...';
  CannotConnect := 'Konnte den Updateserver nicht erreichen oder';
  WhatsNew := 'Was ist neu?';
  License := 'Lizenzvereinbar;ung';
  AcceptLicense := 'Ich nehme an' ;
  NotAcceptLicense := 'Ich lehne ab';
  ComponentsAvail := 'Verf�gbare Anwendungskomponenten';
  DownloadingFiles := 'Lade Dateien';
  CurrentProgress := 'Verlauf Dateidownload';
  TotalProgress := 'Verlauf Update';
  UpdateComplete := 'Update ist komplett ...';
  RestartInfo := 'Best�tigen Sie den Neustart, um die neue Anwendung zu starten.';
end;

{ TWebUpdateWizardPortugese }

constructor TWebUpdateWizardPortugese.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Clique iniciar para verificar se h� novas atualiza��es...';
  StartButton := 'Iniciar';
  NextButton := 'Pr�ximo';
  ExitButton := 'Sair';
  CancelButton := 'Cancelar';
  RestartButton := 'Reiniciar';
  GetUpdateButton := 'Obter atualiza��o';
  NewVersionFound := 'Nova vers�o encontrada';
  NewVersion := 'Nova vers�o';
  NoNewVersionAvail := 'N�o h� novas vers�es dispon�veis.';
  NewVersionAvail := 'Nova vers�o dispon�vel.';
  CurrentVersion := 'Vers�o atual';
  NoFilesFound := 'Nenhum arquivo encontrado para a atualiza��o';
  NoUpdateOnServer := 'Nenhuma atualiza��o encontrada no servidor...';
  CannotConnect := 'N�o foi poss�vel conectar ao servidor de atualiza��o ou';
  WhatsNew := 'O que h� de novo';
  License := 'Contrato de licen�a';
  AcceptLicense := 'Aceito';
  NotAcceptLicense := 'N�o aceito';
  ComponentsAvail := 'Componentes da aplica��o dispon�veis';
  DownloadingFiles := 'Fazendo o download dos arquivos';
  CurrentProgress := 'Progresso do arquivo atual';
  TotalProgress := 'Progresso total';
  UpdateComplete := 'Atualiza��o conclu�da...';
  RestartInfo := 'Clique reiniciar para iniciar a aplica��o atualizada.';
end;

{ TWebUpdateWizardSpanish }

constructor TWebUpdateWizardSpanish.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Presione iniciar para buscar actualizaciones disponibles de la aplicaci�n ...';
  StartButton := 'Iniciar';
  NextButton := 'Siguiente';
  ExitButton := 'Salir';
  CancelButton := 'Cancelar';
  RestartButton := 'Reiniciar';
  GetUpdateButton := 'Obtener actualizaci�n';
  NewVersionFound := 'Nueva versi�n encontrada';
  NewVersion := 'Nueva versi�n';
  NoNewVersionAvail := 'No hay una nueva versi�n disponible.';
  NewVersionAvail := 'Nueva versi�n disponible.';
  CurrentVersion := 'Versi�n actual';
  NoFilesFound := 'No se encontraron archivos para actualizar';
  NoUpdateOnServer := 'no se encontr� una nueva actualizaci�n en el servidor ...';
  CannotConnect := 'No se puedo establecer la conexi�n con el servidor de actualizaciones o ';
  WhatsNew := 'Lo nuevo';
  License := 'Acuerdo de licenciamiento';
  AcceptLicense := 'Acepto';
  NotAcceptLicense := 'No acepto';
  ComponentsAvail := 'Componentes de la aplicaci�n disponibles';
  DownloadingFiles := 'Descargando archivos';
  CurrentProgress := 'Progreso de archivo actual';
  TotalProgress := 'Progreso total';
  UpdateComplete := 'Actualizaci�n completada ...';
  RestartInfo := 'Presione reiniciar para ejecutar la aplicaci�n actualizada.';
end;

{ TWebUpdateWizardDanish }

constructor TWebUpdateWizardDanish.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Tryk p� Start-knappen for at checke for applikationsopdateringer ...';
  StartButton := 'Start';
  NextButton := 'N�ste';
  ExitButton := 'Afslut';
  CancelButton := 'Fortryd';
  RestartButton := 'Genstart';
  GetUpdateButton := 'Hent opdatering';
  NewVersionFound := 'Ny version blev fundet';
  NewVersion := 'Ny version';
  NoNewVersionAvail := 'Ingen ny version tilg�ngelig.';
  NewVersionAvail := 'Ny version tilg�ngelig.';
  CurrentVersion := 'Nuv�rende version';
  NoFilesFound := 'Ingen opdaterbare filer blev fundet';
  NoUpdateOnServer := 'ingen opdatering blev fundet p� serveren ...';
  CannotConnect := 'Kunne ikke f� kontakt til opdateringsserveren eller';
  WhatsNew := 'Hvad er nyt?';
  License := 'Licensaftale';
  AcceptLicense := 'Jeg accepterer';
  NotAcceptLicense := 'Jeg accepterer ikke';
  ComponentsAvail := 'Tilg�ngelige applikationskomponenter';
  DownloadingFiles := 'Downloader filer';
  CurrentProgress := 'Nuv�rende filforl�b';
  TotalProgress := 'Total filforl�b';
  UpdateComplete := 'Opdatering fuldf�rt ...';
  RestartInfo := 'Tryk p� genstart for at starte den opdaterede applikation.';
end;

{ TWebUpdateWizardItalian }

constructor TWebUpdateWizardItalian.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Premi Inizia per verificare la disponibilit� di aggiornamenti dell''applicazione...';
  StartButton := 'Inizia';
  NextButton := 'Avanti';
  ExitButton := 'Esci';
  CancelButton := 'Annulla';
  RestartButton := 'Riavvia';
  GetUpdateButton := 'Scarica l''aggiornamento';
  NewVersionFound := 'Trovata una nuova versione';
  NewVersion := 'Nuova versione';
  NoNewVersionAvail := 'Nessuna nuova versione disponibile.';
  NewVersionAvail := 'Nuova versione disponibile.';
  CurrentVersion := 'Versione corrente';
  NoFilesFound := 'file non trovati per l''aggiornamento';
  NoUpdateOnServer := 'non c''� un nuovo aggiornamento sul server...';
  CannotConnect := 'Impossibile stabilire la connessione con il server o ';
  WhatsNew := 'Novit�';
  License := 'Accordo di licenza';
  AcceptLicense := 'Accetto';
  NotAcceptLicense := 'Non accetto';
  ComponentsAvail := 'Componenti dell''applicazione disponibil';
  DownloadingFiles := 'Scarico i file';
  CurrentProgress := 'Avanzamento del file corrente';
  TotalProgress := 'Avanzamento complessivo';
  UpdateComplete := 'Aggiornamento completo...';
  RestartInfo := 'Premi riavvia per eseguire l''applicazione aggiornata.';
end;

{ TWebUpdateWizardNorwegian }

constructor TWebUpdateWizardNorwegian.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Klikk Start for � se etter tilgjengelige oppdateringer av programmet...';
  StartButton := 'Start';
  NextButton := 'Neste';
  ExitButton := 'Avslutt';
  CancelButton := 'Avbryt';
  RestartButton := 'Start p� nytt';
  GetUpdateButton := 'Hent oppdatering';
  NewVersionFound:= 'Ny versjon';
  NoNewVersionAvail := 'Ingen ny versjon er tilgjengelig.';
  NewVersionAvail := 'Ny versjon er tilgjengelig for nedlasting.';
  CurrentVersion := 'N�v�rende versjon';
  NoFilesFound := 'Fant ingen filer for oppdateringen';
  NoUpdateOnServer := 'fant ingen oppdatering p� serveren ...';
  CannotConnect := 'Kunne ikke koble til oppdateringsserveren eller ';
  WhatsNew := 'Hva er nytt';
  License := 'Lisensavtale';
  AcceptLicense := 'Jeg godtar';   //Too long for the current radio button width
  NotAcceptLicense := 'Jeg godtar ikke';  //Too long for the current radio button width
  ComponentsAvail := 'Tilgjengelige programkomponenter';
  DownloadingFiles := 'Laster ned filer';
  CurrentProgress := 'Nedlastingsforl�pet for n�v�rende fil';
  TotalProgress := 'Nedlastingsforl�pet for alle filer';
  UpdateComplete := 'Oppdateringen er ferdig ...';
  RestartInfo := 'Klikk Start p� nytt  for � starte det oppdaterte programmet.';
end;


constructor TWebUpdateWizardHungarian.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Kattints az ind�t gombra �s elindul a friss�t�sek keres�se ...';
  StartButton := 'Ind�t';
  NextButton := 'Tov�bb';
  ExitButton := 'Kil�p�s';
  CancelButton := 'M�gsem';
  RestartButton := '�jraind�t';
  GetUpdateButton := 'Friss�t';
  NewVersionFound := '�j verzi�t tal�ltam';
  NewVersion := '�j verzi�';
  NoNewVersionAvail := '�j verzi� nem tal�lhat�.';
  NewVersionAvail := '�j verzi� tal�lhat�.';
  CurrentVersion := 'Aktu�lis verzi�';
  NoFilesFound := 'A friss�t�sben nem tal�lhat� file';
  NoUpdateOnServer := 'nem tal�lhat� friss�t�s a kiszolg�l�n ...';
  CannotConnect := 'Nem tudok kapcsol�dni a friss�t� kiszolg�l�hoz';
  WhatsNew := 'Mi az �jdons�g';
  License := 'Szerz�d�si felt�tel';
  AcceptLicense := 'Elfogadom';
  NotAcceptLicense := 'Visszautas�tom';
  ComponentsAvail := 'Lehets�ges alkalmaz�s kopmponensek';
  DownloadingFiles := '�lom�nyok let�lt�se';
  CurrentProgress := 'Aktu�lis m�velet �llpota';
  TotalProgress := 'Teljes m�velet �llapota';
  UpdateComplete := 'Friss�t�s k�sz ...';
  RestartInfo := 'Kattints az Ujraind�t gombra, hogy elinduljon a friss�tett alkalmaz�s.';
end;


{ TWebUpdateWizardSwedish }

constructor TWebUpdateWizardSwedish.Create(AOwner: TComponent);
begin
  inherited;
  Welcome := 'Tryck p� Start-knappen f�r att leta efter tillg�ngliga uppdateringar ...';
  StartButton := 'Start';
  NextButton := 'N�sta';
  ExitButton := 'Avsluta';
  CancelButton := '�ngra';
  RestartButton := 'Starta om';
  GetUpdateButton := 'H�mta uppdatering';
  NewVersionFound := 'Ny version funnen';
  NewVersion := 'Ny version';
  NoNewVersionAvail := 'Ny version saknas.';
  NewVersionAvail := 'Ny version finns';
  CurrentVersion := 'Nuvarande version';
  NoFilesFound := 'Hittade inga uppdateringsbara filer';
  NoUpdateOnServer := 'hittade ingen uppdatering p� servern ...';
  CannotConnect := 'Kunde inte f� kontakt med servern eller';
  WhatsNew := 'Nyheter';
  License := 'Licensavtal';
  AcceptLicense := 'Jag accepterar';
  NotAcceptLicense := 'Jag accepterar inte';
  ComponentsAvail := 'Tillg�ngliga applikationskomponenter';
  DownloadingFiles := 'Laddar ner filer';
  CurrentProgress := 'Nuvarende filf�rlopp';
  TotalProgress := 'Totalt filf�rlopp';
  UpdateComplete := 'Uppdateringen klar ...';
  RestartInfo := 'Tryck p� Omstart f�r att starta den uppdaterade applikationen';
end;

end.
