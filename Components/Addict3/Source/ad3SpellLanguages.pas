{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  10863: ad3SpellLanguages.pas
{
{   Rev 1.7    28/07/2005 2:04:54 pm  Glenn
{ Added Estonian Strings
}
{
{   Rev 1.6    28/07/2005 1:51:48 pm  Glenn
{ Improved German Strings
}
{
{   Rev 1.4    20/12/2004 3:24:34 pm  Glenn
}
{
{   Rev 1.3    2/21/2004 11:59:54 PM  mnovak
{ 3.4.1 Updates
}
{
{   Rev 1.2    2/16/2004 6:35:44 PM  mnovak
{ Italian Updates
}
{
{   Rev 1.1    12/3/2003 1:03:42 AM  mnovak
{ Version Number Updates
}
{
{   Rev 1.0    8/25/2003 1:01:52 AM  mnovak
}
{
{   Rev 1.3    7/30/2002 12:07:12 AM  mnovak
{ Prep for v3.3 release
}
{
{   Rev 1.2    7/29/2002 10:47:32 PM  mnovak
{ Polish update
}
{
{   Rev 1.1    27/07/2002 10:11:40 pm  glenn
}
(*************************************************************

Addict 3.4,  (c) 1996-2005, Addictive Software
Contact: addictsw@addictivesoftware.com

TAddictSpell3 Languages Module

History:
8/13/00     - Michael Novak         - Initial Write
3/9/01      - Michael Novak         - v3 Official Release
7/8/01      - Rafal Platek          - Polish translation
7/9/01      - Miloslav Skacel       - added TSpellLanguageType ltCzech
9/28/01     - Sverre H�rstadstrand  - Norwegian translation (Bokm�l)
12/9/03     - Stefano Spagna        - Italian translation
4/26/05     - Ilmar Kerm            - Estonian translation

**************************************************************)

unit ad3SpellLanguages;

{$I addict3.inc}

interface


type

    TSpellLanguageType = (
        ltEnglish,
        ltSwedish,
        ltBrPort,
        ltAfrikaans,
        ltGerman,
        ltSpanish,
        ltRussian,
        ltCzech,
        ltDutch,
        ltDanish,
        ltPolish,
        ltNorwegianBok,
        ltFrench,
        ltItalian,
        ltEstonian );

    TSpellLanguageString = (

        lsLiveSpelling,                     // check spelling as you type
	   lsLiveCorrect,                      // correct splling errors as you type
        lsIgnoreUpcase,                     // ignore uppercase
        lsIgnoreNumbers,                    // ignore numbers
        lsHTML,                             // ignore HTML
        lsInternet,                         // ignore Internet addresses
        lsQuoted,                           // ignore Quoted Lines
        lsAbbreviations,                    // ignore Abbreviations
        lsPrimaryOnly,                      // make suggestions from primary
        lsRepeated,                         // check for repeated words
        lsDUalCaps,                         // auto-correct DUal caps?

        lsConfirmation,                     // Confirmation dialog title
        lsRemoveCustomDict,                 // Remove this custom dict?

        lsIgnoreAllChangeAll,               // (Ignore All / Change All)

        lsSpelling,                         // Spell check and spell check completion title
        lsSpellingOptions,                  // Spelling options dialog title
        lsDictionaries,                     // Custom dictionaries dialog title
        lsIgnoreAllChangeAllTitle,          // Edit Dialog Caption for internal custom
        lsNewCustomTitle,                   // New Custom Dialog title

        lsDlgNotFound,                      // Not Found label
        lsDlgRepeatedWord,                  // Repeated Word label
        lsDlgReplaceWith,                   // Replace With label
        lsDlgSuggestions,                   // Suggestions label
        lsDlgUndo,                          // Undo button
        lsDlgOptions,                       // Options button
        lsDlgIgnoreAll,                     // Ignore All button
        lsDlgIgnore,                        // Ignore button
        lsDlgChangeAll,                     // Change All button
        lsDlgChange,                        // Change button
        lsDlgAdd,                           // Add button
        lsDlgAutoCorrect,                   // AutoCorrect button
        lsDlgHelp,                          // Help button
        lsDlgCancel,                        // Cancel Button
        lsDlgResetDefaults,                 // Reset Defaults Button

        lsDlgOptionsLabel,                  // Options groupbox label
        lsDlgDictionariesLabel,             // Dictionaries groupbox label
        lsDlgName,                          // Main Dictionaries name column
        lsDlgFilename,                      // Main Dictionaries filename column
        lsDlgCustomDictionary,              // Custom Dictionary combo label
	   lsDlgDictionaries,                  // Dictionaries button
        lsDlgBrowseForMain,                 // Browse for main dictionaries item
        lsDlgBrowseForMainTitle,            // Browse for main dictionaries title

        lsDlgCustomDictionaries,            // Custom Dictionaries group box
        lsDlgEdit,                          // Edit Button
        lsDlgDelete,                        // Delete Button
        lsDlgNew,                           // New Button
        lsDlgOK,                            // OK Button

        lsDlgNewCustom,                     // New Custom Edit label

        lsDlgAddedWords,                    // Added Words
        lsDlgAddedWordsExplanation,         // Added words explanation
        lsDlgIgnoreThisWord,                // Ignore This Word Label
        lsDlgAutoCorrectPairs,              // Auto-Corrected words
        lsDlgAutoCorrectPairsExplanation,   // Auto-Corrected words explanation
        lsDlgReplace,                       // Replace Label
        lsDlgWith,                          // With label
        lsDlgExcludedWords,                 // Excluded Words
        lsDlgExcludedWordsExplanation,      // Excluded words explanation
        lsDlgExcludeThisWord,               // Exclude this word label

        lsEndMessage,                       // The spell check end message
        lsWordsChecked,                     // The 'Words checked:' message
        lsEndSelectionMessage,              // The end-of-selection check message

        lsMnNoSuggestions,                  // No suggestions menu item
        lsMnIgnore,                         // Ignore menu item
        lsMnIgnoreAll,                      // Ignore all menu item
        lsMnAdd,                            // Add menu item
        lsMnChangeAll,                      // Change all menu item
        lsMnAutoCorrect,                    // Auto correct menu item
        lsMnSpelling                        // Spelling ... menu item
        );

{$IFNDEF T2H}
function GetString( LangString:TSpellLanguageString; Language:TSpellLanguageType ):String;
{$ENDIF}

implementation

{$IFDEF AD3ENGLISHONLY}
{$DEFINE AD3NOSWEDISH}
{$DEFINE AD3NOBRPORT}
{$DEFINE AD3NOGERMAN}
{$DEFINE AD3NOAFRIKAANS}
{$DEFINE AD3NOSPANISH}
{$DEFINE AD3NORUSSIAN}
{$DEFINE AD3NOCZECH}
{$DEFINE AD3NODUTCH}
{$DEFINE AD3NODANISH}
{$DEFINE AD3NOPOLISH}
{$DEFINE AD3NOFRENCH}
{$DEFINE AD3NONORWAYBOK}
{$DEFINE AD3NOITALIAN}
{$DEFINE AD3NOESTONIAN}
{$ENDIF}

function GetString( LangString:TSpellLanguageString; Language:TSpellLanguageType ):String;
begin
    Result := '';

    case (LangString) of
    lsLiveSpelling:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Check spelling as you type';                 {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Kontrollera stavningen n�r du skriver';      {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Verificar a ortografia enquanto escreve';    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Gaan spel re�ls na terwyl jy tik';           {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Automatische Rechtschreibpr�fung';           {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Verificar la ortograf�a mientras escribe';   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��������� ��&�������� ��� �����';            {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Kontrolovat pravopis p�i psan�';             {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Spelling controleren onder het typen';       {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'L&�bende stavekontrol';                      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Sprawdzaj pisowni� podczas pisania';         {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'V�rifier l''orthographe automatiquement';    {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Fortl�pende stavekontroll';                  {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Correzione ortografica durante la digitazione';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:      Result := '�igekirja kontrolli kirjutamise ajal';     {$ENDIF}
        end;
    lsLiveCorrect:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Correct spelling errors as you type';                {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'R�tta stavfel n�r du skriver';                       {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Corrigir erros de ortografia enquanto voc� escreve'; {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Maak spelling reg terwyl jy tik';                    {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Automatische Korrektur';                             {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Corregir errores ortogr�ficos mientras escribe';     {$ENDIF}
	   {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� ����� � �&������� ��� �����';             {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Opravovat chyby p�i psan�';                          {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Spellingsfouten verbeteren onder het typen';         {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Korriger stavefejl under indtastning';               {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Poprawiaj pisowni� podczas pisania';                 {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Corriger l''orthographe automatiquement';            {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Korriger stavefeil mens du skriver';                 {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Correggi errori di or&tografica durante la digitazione'; {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '�igekirjavead paranda kirjutamise ajal';             {$ENDIF}
        end;
    lsIgnoreUpcase:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Ignore words in &UPPERCASE';                 {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera ord med &STORA bokst�ver';          {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Ignorar palavras escritas com &Mai�sculas';  {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Ignoreer woorde in &HOOFLETTERS';            {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'W�rter in &Gro�buchstaben ignorieren';       {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Ignorar palabras en &MAY�SCULAS';            {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� ����� �� &��������� ����';        {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Ignorovat slova &VELK�MI p�smeny';           {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Woorden in hoofdletters negeren';            {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ignorer ord &med kun store bogstaver';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pomi� wyrazy pisane &WIELKIMI literami';     {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ignorer les mots en &majuscule';             {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ignorer ord med &STORE bokstaver';           {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Ignora parole in &MAIUSCOLO';                {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Ignoreeri S&UURT�HTEDEGA kirjutatud s�nu';      {$ENDIF}
        end;
    lsIgnoreNumbers:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Ignore words containing numbers';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera ord med siffror';               {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Ignorar palavras que cont�m n�meros';    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Ignoreer woorde met nommers';            {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'W�rter mit Zahlen ignorieren';           {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Ignorar palabras que contengan n�meros'; {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� ����� � &�������';            {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Ignorovat slova obsahuj�c� ��slice';     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Woorden met nummers negeren';            {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ignorer ord med tal';                    {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pomi� wyrazy zawieraj�ce liczby';        {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ignorer les mots contenants des nombres';{$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ignorer ord som inneholder &tall';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Ignora parole contenente n&umeri';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Ignoreeri numbreid sisaldavaid s�nu';    {$ENDIF}
        end;
    lsHTML:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Ignore markup languages (&HTML, XML, etc)';  {$ENDIF}
	   {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera &HTML, XML, etc';                   {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Ignorar &HTML, XML, etc';                    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Ignoreer &HTML';                             {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&HTML ignorieren';                           {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Ignorar &HTML, XML, etc';                    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� &�������� HTML � XML';            {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Ignorovat zna�ky &HTML, XML atd.';           {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&HTML negeren';                              {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ignorer &filadresser (HTML, XML, etc';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pomi� znaczniki (&HTML, XML, itp.)';         {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ignorer les languages &HTML, XML, etc';      {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ignorer &HTML, XML o.l.';                    {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Ignora linguaggi marcati (&HTML, XML, ecc)'; {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Ignoreeri m�rgistuskeeli (&HTML, XML jt)';      {$ENDIF}
        end;
    lsInternet:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Ignore Internet addresses';          {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera Internetaddresser';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Ignorar endere�os de Internet';      {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Ignoreer &Internet adresse';         {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Internet-Adressen ignorieren';       {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Ignorar direcciones de Internet';    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� ������ &���������';       {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Ignorovat internetov� adresy';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Internet adressen negeren';          {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ignorer &Internet adresser';         {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pomi� adresy internetowe';           {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ignorer les adresses Internet';      {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ignorer Internettaddresser';         {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'I&gnora Indirizzi Internet';         {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Ignoreeri internetiaadresse';      {$ENDIF}
        end;
    lsQuoted:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Ignore quoted lines';                    {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera citerade rader';                {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Ignorar linhas entre aspas';             {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Ignoreer lyne tussen aanhalings tekens'; {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Zeilen in Anf�hrungszeichen ignorieren'; {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Ignorar l�neas entre comillas';          {$ENDIF}
	   {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� ��&���������� �����';         {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Ignorovat ��dky v apostrofech';          {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Zinnen tussen aanhalingstekens negeren'; {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ignorer linier i anf�rselstegn';         {$ENDIF}
	   {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pomi� linie w cudzys�owach';             {$ENDIF}
	   {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ignorer les lignes en citation';    {$ENDIF}
	   {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ignorer linjer i anf�rselstegn';         {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Ignora parola tra &virgolette';           {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Ignoreeri jutum�rkides olevaid ridu';      {$ENDIF}
        end;
    lsAbbreviations:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Ignore abbreviations';       {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera f�rkortningar';     {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Ignorar abreviaturas';       {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Ignoreer afkortings';        {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Abk�rzungen ignorieren';     {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Ignorar abreviaturas';       {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� �&�����������';   {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Ignorovat zkratky';          {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'afkortingen negeren';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ignorer f&orkortelser';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pomi� skr�ty';               {$ENDIF}
	   {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ignorer les abr�viations';   {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ignorer forkortelser';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Ignora &abbreviazioni';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Ignoreeri l�hendeid';      {$ENDIF}
        end;
    lsPrimaryOnly:
	   case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Suggest from main dictionaries only';            {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'F�resl� ord endast ur huvudlexikon';             {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Sugerir somente dos dicion�rios principais';     {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Gebruik slegs die hoof woordeboeke';             {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Vorschl�ge nur aus Hauptw�rterbuch';             {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Sugerir s�lo de diccionarios principales';       {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� ������ �� &�������� ��������';        {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Nab�zet pouze z hlavn�ho slovn�ku';              {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Alleen van hoofd woordenboek' ;                  {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Kun forslag fra &hoved ordb�ger';                {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Sugeruj tylko z g��wnych s�ownik�w';             {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Sugg�rer du dictionnaire principal seulement';   {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'K&un forslag fra hovedordb�ker';                  {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Suggerisci solo da&l dizionario principale';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Soovitused v�ta ainult peas�nastikust';          {$ENDIF}
        end;
    lsRepeated:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Prompt on repeated word';            {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Varna f�r upprepade ord';            {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Indagar sobre palavra repetida';     {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Abfrage bei wiederholten Worten';    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Vra op herhalings';                  {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Detenerse en palabra repetida';      {$ENDIF}
	   {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '����&����� ������� ����';            {$ENDIF}
	   {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Upozornit na opakuj�c� se slovo';    {$ENDIF}
	   {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'vragen bij herhaald woord';          {$ENDIF}
	   {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Sp�rg ved &gentagne ord';            {$ENDIF}
	   {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pytaj przy powt�rzonym wyrazie';     {$ENDIF}
	   {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Indiquer les mots r�p�t�s';          {$ENDIF}
	   {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'S&p�r ved gjentatte ord';            {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Co&nferma sulla parola ripetuta';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Korduva s�na korral k�si uuesti';      {$ENDIF}
	   end;
    lsDUalCaps:
	   case (Language) of
	   {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Automatically correct DUal capitals';                         {$ENDIF}
	   {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'R�tta automatiskt TV� stora bokst�ver';                       {$ENDIF}
	   {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Corrigir DUas mai�sculas automaticamente';                    {$ENDIF}
	   {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'ZWei Gro�buchstaben am Wortanfang korrigieren';               {$ENDIF}
	   {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'TRANSLATION NEEDED: Automatically correct DUal capitals';     {$ENDIF}
	   {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Corregir autom�ticamente may�sculas DObles';                  {$ENDIF}
	   {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� &��� ��������� �����';                             {$ENDIF}
	   {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Automaticky opravit DVe poc�tecn� velk� p�smena';             {$ENDIF}
	   {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'TWee beginhoofdletters &corrigeren';                          {$ENDIF}
	   {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Automatisk rette DObbelte store bogstaver';                   {$ENDIF}
	   {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Automatycznie poprawiaj podw�jne WIelkie litery';             {$ENDIF}
	   {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Corriger automatiquement les DOubles majuscules';             {$ENDIF}
       {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'KOrriger to innledende store bokstaver';                      {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Correggi Automaticamente DOppie Maiuscole';                  {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Paranda TOpeltsuurt�hed automaatselt';      {$ENDIF}
       end;

    lsConfirmation:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Confirmation:';  {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Bekr�fta:';      {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Confirma��o:';   {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Best�tigung:';   {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Bevestig';       {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Confirmaci�n:';  {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������������:'; {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Potvrzen�:';     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Bevestiging:';   {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Bekr�ftelse:';   {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Potwierdzenie:'; {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Confirmation:';  {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Bekreftelse:';   {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Conferma:';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Kinnitus:';      {$ENDIF}
        end;
    lsRemoveCustomDict:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Delete this custom dictionary?';                             {$ENDIF}
	   {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Tag bort detta anv�ndarlexikon?';                            {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Apagar este dicion�rio personalizado?';                      {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Skrap hierdie privaat woordeboek';                           {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Soll dieses Benutzerw�rterbuch wirklich gel�scht werden?';   {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '�Borrar este diccionario personalizado?';                    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '������� ���� ��������������� �������?';                      {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Smazat u�ivatelsk� slovn�k?';                                {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Verwijder dit aangepaste woordenboek?';                      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Slet denne bruger ordbog?';                                  {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Czy usun�� ten s�ownik u�ytkownika?';                        {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Effacer ce dictionnaire personnel?';                         {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Slette denne brukerordbok?';                                 {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Cancellare questo dizionario predefinito?';                  {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Kas soovid selle abis�nastiku kustutada?';      {$ENDIF}
        end;

    lsIgnoreAllChangeAll:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '(Ignore All / Change All)';              {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '(Ignorera Allt / �ndra Allt)';           {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Ignorar Todas / Trocar Todas';           {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '(Ignoreer almal / Verander almal)';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '(Alles ignorieren / Alles �ndern)';      {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '(Ignorar Todas / Cambiar Todas)';        {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '(���������� ��� / �������� ���)';        {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '(Ignorovat v�e / Zam�nit v�e)';          {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '(Alles Negeren / Alles vervangen)';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '(Ignorer Alle / Ret Alle)';              {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '(Pomi� wszystkie / Popraw wszystkie)';   {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '(Ingorer tout / Changer tout)';          {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '(Ignorer Alle / Korriger Alle)';         {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '(Ignora Tutto / Sostituisci Tutto)';     {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '(Ignoreeri k�iki / Muuda k�ik)';      {$ENDIF}
        end;

    lsSpelling:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Spelling';               {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Stavning';               {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Ortografia';             {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Spelre�ls';              {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Rechtschreibpr�fung';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Ortograf�a';             {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '����������';             {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Pravopis';               {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Spellingscontrole';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Stavekontrol';           {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pisownia';               {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Orthographe';            {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Stavekontroll';          {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Controllo Ortografico';  {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '�igekiri';      {$ENDIF}
        end;
    lsSpellingOptions:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Spelling Options';               {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Stavningsinst�llningar';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Op��es de Ortografia';           {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Optionen';                       {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Spelkeuse';                      {$ENDIF}
	   {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Opciones de Ortograf�a';         {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��������� �������� ����������';  {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Volby kontroly pravopisu';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Spellingscontrole Opties';       {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Stavekontrol indstillinger';     {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Ustawienia pisowni';             {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Options orthographiques';        {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Innstillinger for stavekontroll';{$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Opzioni Controllo Ortografico';  {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '�igekirja s�tted';      {$ENDIF}
        end;
    lsDictionaries:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Dictionaries';   {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Lexikon';        {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Dicion�rios';    {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'W�rterb�cher';   {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Woordeboeke';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Diccionarios';   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������';        {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Slovn�ky';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Woordenboeken';  {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ordb�ger';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'S�owniki';       {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Dictionnaires';  {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ordb�ker';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Dizionari';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'S�nastikud';      {$ENDIF}
        end;
    lsIgnoreAllChangeAllTitle:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Words added with Ignore All / Change All';               {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ord som adderats med Ignorera Allt / �ndra Allt';        {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Palavras adicionadas com Ignorar Todas / Trocar Todas';  {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Woorde bygevoeg met (Ignoreer almal / Verander almal)';  {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'W�rter mit "Alles ignorieren" anf�gen / Alles �ndern';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Palabras agregadas con Ignorar Todas / Cambiar Todas';   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� ��� / �������� ���';                          {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Slova p�idan� Ignorovat v�e / Zam�nit v�e';              {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Woorden toegevoegd met Alles Negeren/Alles vervangen';   {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ord tilf�jet med Ignorer Alle / Ret Alle';               {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'S�owa dodane przez Pomi� wszystkie / Popraw wszystkie';  {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Mots ajout�s avec Ignore tout / Change tout';            {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ord lagt til med Ignorer Alle / Korriger Alle';          {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Parole aggiunte con Ignora Tutto / Cambia Tutto';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'K�suga Ignoreeri k�iki / Muuda k�ik lisatud s�nad';      {$ENDIF}
        end;
    lsNewCustomTitle:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'New Custom Dictionary';              {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Nytt anv�ndarlexikon';               {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Novo Dicion�rio Personalizado';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Neues Benutzerw�rterbuch';           {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Nuwe privaat woordeboek';            {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Nuevo Diccionario Personalizado';    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������� �������';                   {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Nov� u�ivatelsk� slovn�k';           {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Nieuw aangepast woordenboek';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ny Bruger Ordbog';                   {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Nowy s�ownik u�ytkownika';           {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Nouveau dictionnaire personnel';     {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ny brukerordbok';                    {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Nuovo Dizionario Predefinito';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Uus abis�nastik';                    {$ENDIF}
        end;

    lsDlgNotFound:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Not Found:';         {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ej funnet:';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'N�o encontrada:';    {$ENDIF}
	   {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Nicht gefunden:';    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Nie gevind nie';     {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'No Encontrada:';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��� � �������:';     {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Nen� ve slovn�ku:';  {$ENDIF}
	   {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Niet gevonden:';     {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ej fundet:';         {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Nie znaleziono:';    {$ENDIF}
	   {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Non trouv�:';        {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ikke funnet:';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Non T&rovata:';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Ei leitud:';      {$ENDIF}
        end;
    lsDlgRepeatedWord:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Repeated Word:';     {$ENDIF}
	   {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Upprepat ord:';      {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Palavra Repetida:';  {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Wiederholtes Wort:'; {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Herhaalde woord:';   {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Palabra Repetida:';  {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '������ ����';        {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Opakovan� slovo:';   {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Herhaald woord:';    {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Gentaget Ord:';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Powt�rzone s�owo:';  {$ENDIF}
	   {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Mot r�p�t�:';        {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Gjentatt ord:';      {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Ripeti Parola:';     {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Korduv s�na:';      {$ENDIF}
        end;
    lsDlgReplaceWith:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Replace With:';     {$ENDIF}
	   {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'E&rs�tt med:';       {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Substituir &por:';   {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Vervang met:';       {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'E&rsetzen mit:';     {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Reemplazar Con:';   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������� &��:';      {$ENDIF}
	   {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Nahradit ��m:';     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Vervangen met:';     {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Erstat med:';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Za&mie� na:';        {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Remplacer par:';    {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'E&rstatt med:';      {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Sostituisci Co&n:';  {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Asendus:';      {$ENDIF}
        end;
    lsDlgSuggestions:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Suggestions:';  {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'F�r&slag:';      {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Sugest�es:';    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Voorstelle:';    {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Vor&schl�ge:';   {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Sugerencias:';  {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��&������';      {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&N�vrhy:';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&Suggesties:';   {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Forslag:';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Propozycje:';   {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Suggestions:';  {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'For&slag';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Sugg&erimenti:'; {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'S&oovitused:';      {$ENDIF}
        end;
    lsDlgUndo:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Undo';          {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&�ngra';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Desfazer';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&R�ckg�ngig';    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Gaan terug';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Deshacer';      {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '����&���';       {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Zp�t';          {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Ongedaan maken'; {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Fortryd';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Cofnij';        {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&D�faire';       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Angre';         {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Ann. &Digitazione'; {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Unusta';      {$ENDIF}
        end;
    lsDlgOptions:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Options...';    {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&Inst�llningar'; {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Op��es';        {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&Optionen';      {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Keuse';         {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Opciones';      {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�&��������...';  {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Nastaven�';     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&Opties';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Indstillinger'; {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Ustawienia';    {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Options';       {$ENDIF}
	   {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'I&nnstillinger...'; {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Opzioni...';     {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&S�tted...';      {$ENDIF}
        end;
    lsDlgIgnoreAll:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Ignore All';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&Ignorera Allt';     {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Ignorar Todas';     {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Alles &ignorieren';  {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Ignoreer almal';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Ignorar Todas';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� &���';    {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Ignorovat v�e';     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Alles negeren';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ignorer Alle';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pom&i� wszystkie';   {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Ignorer tout';      {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Ignorer alle';      {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Ignora Tutto';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Ignoreeri k�iki';      {$ENDIF}
        end;
    lsDlgIgnore:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'I&gnore';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'I&gnorera';      {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'I&gnorar';       {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Ignoreer';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&Ignorieren';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'I&gnorar';       {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&����������';    {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'I&gnorovat';     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Negeren';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'I&gnorer';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Pomi�';         {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'I&gnorer';       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'I&gnorer';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'I&gnora';        {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'I&gnoreeri';      {$ENDIF}
        end;
    lsDlgChangeAll:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Change All';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '�ndra Allt';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Trocar Todas';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Alles �nde&rn';      {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Verander almal';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Cambiar Todas';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������� ��&�';      {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Zam�nit v�e';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Alles vervangen';    {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'R&et Alle';          {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Popraw wszystkie';  {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Changer tout';      {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Korriger alle';     {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Sostituisci Tutto'; {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Muuda k�ik';      {$ENDIF}
        end;
    lsDlgChange:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'C&hange';    {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&�ndra';     {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'T&rocar';    {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '�&ndern';    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Verander';  {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Ca&mbiar';   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&��������';  {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Z&am�nit';   {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Vervangen';  {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ret';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pop&raw';    {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'C&hanger';   {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Endre';     {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Sos&tituisci'; {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Muu&da';      {$ENDIF}
        end;
    lsDlgAdd:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Add';           {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&L�gg till';     {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Adicionar';     {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'V&oeg by';       {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Hinzu&f�gen';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Agregar';       {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&��������';      {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&P�idat';        {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Toevoegen';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Tilf�j';        {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Dodaj';         {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Ajouter';       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Legg til';      {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Aggiungi';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Lisa';      {$ENDIF}
        end;
    lsDlgAutoCorrect:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Au&to-Correct';          {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Autokorrigera';          {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Auto-Corrigir';          {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Auto-&Korrektur';        {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Vervang automaties';     {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Au&to-Corregir';         {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��&��������';            {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Au&tom. opravy';         {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Au&tomatisch Vervangen'; {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Au&to-korriger';         {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Au&to-korekta';          {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Au&to-Correction';       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Au&to-korriger';    {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Correzione A&uto.';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Auto-&parandus';      {$ENDIF}
        end;
    lsDlgHelp:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Help';      {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&Hj�lp';     {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'A&juda';     {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&Hilfe';     {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Hulp';      {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'A&yuda';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&�������';   {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&N�pov�da';  {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&Help';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Hj�lp';     {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pomo&c';     {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'A&ide';      {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Hjelp';     {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Aiuto';     {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'A&bi';      {$ENDIF}
        end;
    lsDlgCancel:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Cancel';         {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Avbryt';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Cancelar';       {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Abbrechen';      {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Kanselleer';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Cancelar';       {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '������';         {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Storno';         {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Annuleren';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Annuller';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Anuluj';         {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Annuler';        {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Avbryt';         {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Chiudi';        {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Loobu';      {$ENDIF}
        end;
    lsDlgResetDefaults:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Reset Defaults';                         {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Standardv�rden';                         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Configura��o Padr�o';                    {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Standard';                               {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Herstel standaard waardes';              {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Reestablecer Predeterminados';           {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '������������ ��������� �� ���������?';   {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Obnovit v�choz� nastaven�';              {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Standaard instellingen';                 {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Standard indstillinger';                 {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Ustawienia domy�lne';                    {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Valeurs par d�faut';                     {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Standard innstillinger';                 {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Ripristina Dizionari';                   {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Vaikev��rtused';                  {$ENDIF}
        end;

    lsDlgOptionsLabel:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := ' O&ptions: ';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := ' Inst�llningar: ';   {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := ' O&p��es ';          {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := ' O&ptionen: ';       {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := ' &Keuse: ';          {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := ' O&pciones: ';       {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := ' ���������: ';       {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := ' &Nastaven�: ';      {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := ' O&pties: ';         {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := ' &Indstillinger: ';  {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := ' &Ustawienia: ';     {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := ' O&ptions: ';        {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := ' &Innstillinger: ';  {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := ' O&pzioni: ';        {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := ' &S�tted: ';      {$ENDIF}
        end;
    lsDlgDictionariesLabel:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := ' D&ictionaries: ';   {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := ' Le&xikon: ';        {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := ' D&icion�rios';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := ' &W�rterb�cher: ';   {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := ' &Woordeboeke ';     {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := ' D&iccionarios: ';   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := ' ����&���: ';        {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := ' &Slovn�ky: ';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := ' &Woordenboeken: ';  {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := ' &Ordb�ger: ';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := ' &S�owniki: ';       {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := ' Dictionnaires: ';   {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := ' Or&db�ker: ';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := ' D&izionari: ';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := ' S�&nastikud: ';      {$ENDIF}
        end;
    lsDlgBrowseForMain:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Locate Dictionaries...';         {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'S�k reda p� lexikon...';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Localizar Dicion�rios...';       {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Soek vir woordeboeke ...';       {$ENDIF}
	   {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'W�rterb�cher suchen...';         {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Localizar Diccionarios...';      {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '������� ����� ...';              {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Vyhledat slovn�ky ...';          {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Woordenboeken zoeken...';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'S�g efter Ordb�ger...';          {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Wska� s�owniki...';              {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Localiser les dictionnaires...'; {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'S�k etter Ordb�ker...';          {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Trova Dizionari ...';            {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'S�nastike asukoht...';      {$ENDIF}
        end;
    lsDlgBrowseForMainTitle:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Choose Folder Containing Dictionaries';                  {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'V�lj katalog som inneh�ller lexikon';                    {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Selecione a Pasta que Cont�m os Dicion�rios';            {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Kies L�er wat woordeboeke bevat';                        {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'W�hlen Sie den Ordner, der die W�rterb�cher enth�lt';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Escoja la Carpeta que Contiene los Diccionarios';        {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������� ����� �� ���������';                            {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Vyberte slo�ku obsahuj�c� slovn�ky';                     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Kies de map die de woordenboeken bevat';                 {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'V�lg folder med Ordb�ger';                               {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Wska� folder zawieraj�cy s�owniki';                      {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Choisissez le r�pertoire contenant les dictionnaires';   {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Velg katalog som inneholder ordb�ker';                   {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Scegli la Cartella Contenete i Dizionari';               {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Vali s�nastike kataloog';      {$ENDIF}
        end;
    lsDlgName:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Name';       {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Namn';       {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Nome';       {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Name';       {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Naam';       {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Nombre';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��������';   {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'N�zev';      {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Naam';       {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Navn';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Nazwa';      {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Nom';        {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Navn';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Nome';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Nimi';      {$ENDIF}
        end;
    lsDlgFilename:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Filename';           {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Filnamn';            {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Nome do Arquivo';    {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Dateiname';          {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'L�er naam';          {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Nombre de Archivo';  {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��� �����';          {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'N�zev souboru';      {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Bestandsnaam';       {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Filnavn';            {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Nazwa pliku';        {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Nom du fichier';     {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Filnavn';            {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Nome del File';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Faili nimi';      {$ENDIF}
        end;
    lsDlgCustomDictionary:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Custom Dictionary:';            {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Anv�ndarlexikon:';               {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Dicion�rio &Personalizado:';     {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&Benutzer W�rterbuch:';          {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Privaat wooedeboek:';           {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Diccionario &Personalizado:';    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&��������������� �������:';      {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&U�ivatelsk� slovn�k:';          {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Aangepast woordenboek:';         {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Bruger Ordbog:';                {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'S�ownik &u�ytkownika:';          {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Di&ctionnaires personnels:';                 {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Brukerordbok';                  {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Di&zionario Predefinito:';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Abis�nastik:';      {$ENDIF}
        end;
    lsDlgDictionaries:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Dictionaries ...';  {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Lexikon ...';        {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Dicion�rios...';    {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&W�rterb�cher...';   {$ENDIF}
	   {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Woordeboeke...';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Diccionarios ...';  {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�&������...';        {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Slovn�ky...';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&Woordenboeken...';  {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ordb�ger ...';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&S�owniki ...';      {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Dictionnaires...';  {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ordb&�ker...';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Dizionari...';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&S�nastikud ...';    {$ENDIF}
        end;

    lsDlgCustomDictionaries:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := ' Custom Dictionaries: ';             {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := ' Anv�ndarlexikon: ';                 {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := ' Dicion�rios Personalizados: ';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := ' Benutzer W�rterbuch: ';             {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := ' Privaat woordeboeke';               {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := ' Diccionarios &Personalizados: ';    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := ' ��������������� �������: ';         {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := ' U�ivatelsk� slovn�ky: ';            {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := ' Aangepaste woordenboeken:';         {$ENDIF}
	   {$IFNDEF AD3NODANISH}   ltDanish:       Result := ' Bruger Ordb�ger: ';                 {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := ' S�owniki u�ytkownika: ';            {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := ' Dictionnaires personnels: ';        {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := ' Brukerordb�ker: ';                  {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := ' Dizionari Predefiniti: ';           {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := ' Abis�nastikud: ';                   {$ENDIF}
        end;
    lsDlgEdit:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Edit';          {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Redigera';       {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Editar';        {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Verander';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&Bearbeiten';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Editar';        {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&��������...';   {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Upravit';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Bewerken';       {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Rediger';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Edytuj';        {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Modifi&er';      {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Rediger';    {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Modifica';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Muuda';         {$ENDIF}
        end;
    lsDlgDelete:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Delete';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Tag &bort';      {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Apagar';        {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&L�schen';       {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Skrap';         {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Borrar';        {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&�������';       {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Smazat';        {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Verwijderen';    {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Slet';          {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Usu�';          {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Supprimer';     {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '$Slett';         {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Elimina';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Kustuta';      {$ENDIF}
        end;
    lsDlgNew:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&New';           {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&Nytt';          {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Novo';          {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&Neu';           {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Nuut';          {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Nuevo';         {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�&������...';    {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Nov�';          {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&Nieuw';         {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ny';            {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Nowy';          {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Nouveau';       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Ny';            {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Nuovo';         {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Uus';           {$ENDIF}
        end;
    lsDlgOK:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Ok';        {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Aanvaar';   {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Aceptar';    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��';         {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&OK';        {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Olgu';      {$ENDIF}
        end;

    lsDlgNewCustom:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Enter the new custom dictionary name:';                     {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Skriv in namnet p� det nya anv�ndarlexikonet:';              {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Entre com o nome do novo dicion�rio personalizado:';        {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Voeg die nuwe privaat woordeboek naam in:';                 {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Nam&e f�r neues Benutzerw�rterbuch:';                        {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Escriba el nombre del nuevo diccionario personalizado:';    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&�������� ������ �������:';                                  {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Zadejte n�zev nov�ho u�ivatelsk�ho slovn�ku:';              {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Geef een naam voor eigengemaakt woordenboek:';               {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Indtast nyt bruger ordbogs navn:';                          {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Wprowad� now� nazw� s�ownika u�ytkownika:';                 {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Entrer le nom du nouveau dictionnaire:';                    {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Skriv inn navnet p� den nye brukerordboken:';               {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Scrivi il nome del nuovo dizionario predefinito:';          {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Sisesta uue abis�nastiku nimi:';      {$ENDIF}
        end;

    lsDlgAddedWords:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Add&ed Words';           {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Adderade ord';           {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Palavras A&dicionadas';  {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Hin&zugef�gte W�rter';   {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Bygevoegde woorde:';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Palabras Agr&egadas';    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�����������';            {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&P�idan� slova';         {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Toegevoegde Woorden';    {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Tilf�jede ord';         {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Dodan&e s�owa';          {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Mots ajout&�s';          {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ord som er lagt &til';   {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Aggi&ungi Parole';       {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Lisatud s�nad';      {$ENDIF}
        end;
    lsDlgAddedWordsExplanation:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'These words will be considered correct during a spell check operation.';         {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Dessa ord kommer att anses riktiga vid en stavningskontroll.';                   {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Estas palavras ser�o consideradas corretas durante uma verifica��o ortogr�fica'; {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Hierdie woorde sal slegs oorweeg word tydens ''n proeflees operasie :';          {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'W�hrend der Rechtschreibpr�fung werden diese W�rter als korrekt angesehen.';     {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Estas palabras se considerar�n correctas durante una revisi�n de ortograf�a.';   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��� ����� ����� ��������� ����������� ��� �������� ����������';                  {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Tato slova budou b�hem kontroly pravopisu pova�ov�na za bezchybn�';              {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Deze woorden zullen als correct worden beschouwd.';                              {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Disse ord betragtes som korrekte under en stavekontrol gennemgang.';             {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Te s�owa b�d� uwzgl�dniane podczas operacji sprawdzania pisowni.';               {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ces mots seront accept�s durant une v�rication de l''orthographe.';              {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Disse ord betraktes som korrekte ved en stavekontroll.';                          {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Queste parole saranno considerate corrette durante il controllo ortografico.';   {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '�igekirjakontrolli ajal loetakse need s�nad �igeks.';      {$ENDIF}
        end;
    lsDlgIgnoreThisWord:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Ignore this word:';         {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera dessa ord:';        {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Ignorar esta palavra:';     {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Ignoreer hierdie woord:';   {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Dieses Wort &ignorieren:';   {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Ignorar esta palabra:';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&���������� ��� �����:';     {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Ignoruj slovo:';            {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Dit woord negeren:';         {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ignorer disse ord:';        {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pom&i� to s�owo:';           {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Ignorer ce mot:';           {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Ignorer f�lgende ord:';     {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Ignora questa parola:';     {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Ignoreeri seda s�na:';      {$ENDIF}
        end;
    lsDlgAutoCorrectPairs:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'A&uto-Correct Pairs';            {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Autokorrigera dessa par';        {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Pares de Auto-Corre��o';         {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Auto-&Korrektur Paare';          {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Automatiese vervangs pare:';     {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Pares de A&uto-Correcci�n';      {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '����������';                     {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'P�r pro a&utomatickou opravu';   {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Automatische verbetering paar';  {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'A&uto-korriger par';             {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pary A&uto-korekty';             {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'A&uto-Correction des paires';    {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'A&uto-korriger par';             {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Auto-corre&zione coppie';        {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Automaatse &paranduse s�napaarid';{$ENDIF}
        end;
    lsDlgAutoCorrectPairsExplanation:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'These words will automatically be corrected when encountered during a spelling check.';              {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Dessa ord kommer att r�ttas automatiskt under en stavningskontroll.';                                {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Estas palavras ser�o automaticamente corrigidas durante uma verifica��o ortogr�fica';                {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Hierdie woorde sal automaties reg gemaak word wanneer hulle tydens ''n spel toets teegekom word.';   {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Diese W�rter werden w�hrend der Rechtschreibpr�fung automatisch korrigiert.';                        {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Estas palabras ser�n corregidas autom�ticamente durante una revisi�n de ortograf�a.';                {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��� ����� ����� ������������� ���������� ��� �������� ����������';                                   {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Tato slova budou b�hem kontroly pravopisu automaticky opravena';                                     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Deze woorden worden automatisch verbeterd als spellingscontrol ze tegen komt.';                      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Disse ord vil automatisk blive korrigeret n�r de opdages under et stavekontrol check.';              {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Te s�owa b�d� automatycznie poprawiane podczas sprawdzania pisowni.';                                {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ces mots seront corrig�s automatiquements lors d''une v�rification.';                                {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Disse ord vil automatisk bli korrigert n�r de oppdages ved en stavekontroll.';                       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Queste parole saranno considerate in automatico sempre corrette durante il controllo ortografico.';                {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '�igekirjakontrolli ajal parandatakse need s�nad automaatselt.';      {$ENDIF}
        end;
    lsDlgReplace:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Replace:';      {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'E&rs�tt:';       {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Substituir:';   {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Vervang:';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'E&rsetzen:';     {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Reemplazar:';   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&��������:';     {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Zam�nit:';      {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Vervangen:';     {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Erstat:';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Zamie�:';       {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Remplacer';     {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Erstatt:';      {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Sostituisci:';  {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Asendatav s�na:';{$ENDIF}
        end;
    lsDlgWith:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&With:'; {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&med:';  {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Por:';  {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&mit:';  {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Met:';  {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Con:';  {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&��:';   {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&��m:';  {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&Met:';  {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Med:';  {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Na:';   {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'A&vec:'; {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Med:';  {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Con:';  {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Asendus&s�na:';      {$ENDIF}
        end;
    lsDlgExcludedWords:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Excluded Words';            {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Uteslutna ord';              {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Palavras &Exclu�das';        {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Uitgesluite woorde:';       {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Diese W�rter aus&schlie�en'; {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Palabras &Excluidas';        {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�����������';                {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Vy�at� slova';              {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Foute woorden:';             {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ekskluderede ord';          {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Opr�cz s��w';               {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Mots &exclus';               {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Utelatte ord';              {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Escludi &Parole';            {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'V�listatud s�nad';      {$ENDIF}
        end;
    lsDlgExcludedWordsExplanation:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'These words will always be considered incorrect during a spell check operation.';                    {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Dessa ord kommer alltid att anses felaktiga vid en stavningskontroll.';                              {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Estas palavras ser�o sempre consideradas incorretas durante uma verifica��o ortogr�fica.';           {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Hierdie woorde sal altyd as foutief gesien word wanneer hulle tydens ''n spel toets teegekom word';  {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'W�hrend der Rechtschreibpr�fung werden diese W�rter stets als falsch angenommen.';                   {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Estas palabras siempre ser�n consideradas incorrectas durante una revisi�n de ortograf�a';           {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�� ����� �������� ���������� ��� ����� ����� ��������������� ��� ���������';                         {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Tato slova budou b�hem kontroly pravopisu pova�ov�na za chybn�';                                     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Deze woorden zullen altijd als niet correct worden beschouwd.';                                      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Disse ord vil altid blive betragtet som ukorrekte under et stavekontrol check.';                     {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Te s�owa b�d� zawsze uwa�ane za nieprawid�owe podczas sprawdzania pisowni.';                         {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Ces mots seront rejet�s lors d''une v�rication de l''orthographe.';                                  {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Disse ord vil altlid bli betraktet som ukorrekte ved en stavekontroll.';                             {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Queste parole saranno considerate sempre non corrette durante il controllo ortografico.';            {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '�igekirjakontrolli ajal m�rgitakse need s�nad alati vigaseks.';      {$ENDIF}
        end;
    lsDlgExcludeThisWord:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'E&xclude this word:';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Uteslut detta ord:';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'E&xcluir esta palavra:';     {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Los hierdie woord';          {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Dieses &Wort ausschlie�en:'; {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'E&xcluir esta palabra:';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&��������� �����:';          {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Vyjmout slovo:';            {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Woord fout rekenen:';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ekskluder dette ord:';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Opr�cz tego s�owa:';        {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'E&xclure ce mot:';           {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Utelat dette ordet:';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Escludi &questa parola:';    {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&V�lista see s�na:';      {$ENDIF}
        end;

    lsEndMessage:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'The spelling check is complete.';            {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Stavningskontrollen �r klar.';               {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Verifica��o ortogr�fica completada.';        {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Die Proef lees het voltooi';                 {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Die Rechtschreibpr�fung ist abgeschlossen.'; {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Revisi�n de Ortograf�a Completada.';         {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������� ���������� ���������.';             {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Kontrola pravopisu byla dokon�ena.';         {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Spellingscontrol is voltooid.';              {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Stavekontrol er udf�rt.';                    {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Sprawdzanie pisowni jest zako�czone.';       {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'La v�rification est termin�e.';              {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Stavekontrollen er utf�rt.';                 {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Il Controllo Ortografico � terminato.';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '�igekirjakontroll l�petatud.';               {$ENDIF}
        end;
    lsWordsChecked:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'Words checked:';         {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Kontrollerade ord:';     {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Palavras verificadas:';  {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Woorde getoets';         {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Gepr�fte W�rter:';       {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'Palabras revisadas:';    {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '��������� ����:';        {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Zkontrolovan� slova:';   {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Woorden gecontroleerd:'; {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ord kontrolleret:';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Sprawdzone wyrazy:';     {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'Mots v�rifi�s:';         {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ord kontrollert:';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Parole selezionate:';    {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Kontrollitud s�nad:';    {$ENDIF}
        end;
    lsEndSelectionMessage:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'The selection has been checked.  Would you like to check the remainder of the document?';                        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Det markerade stycket �r kontrollerat. Vill du kontrollera resten av dokumentet?';                               {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'A verifica��o da sele��o foi conclu�da. Voc� gostaria de verificar o resto do documento?';                       {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Der selektierte Text wurde gepr�ft.  Wollen Sie den Rest des Dokumentes auch pr�fen?';                           {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Die seleksie is geproeflees.  Wil jy die res van die dokument proeflees?';                                       {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'La selecci�n ha sido revisada.  �Le gustar�a revisar el resto del documento?';                                   {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������� ����������� ��������� ��������. ���������� �������� ���������� ����� ���������?';                       {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'Ozna�en� text byl zkontrolov�n. Chcete zkontrolovat zbytek textu?';                                              {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'De selectie is gecontroleerd. Wilt u de rest van het document controleren?';                                     {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Selektionen er blevet kontrolleret.  Vil du gerne kontrollere resten af dette dokument?';                        {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Zaznaczenie uleg�o zmianie. Czy chcesz sprawdzi� reszt� dokumentu?';                                             {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'La s�lection a �t� v�rifi�e. Voulez-vous v�rifier le reste du document ?';                                       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Den valgte teksten er kontrollert. Vil du kontrollere resten av dokumentet?';                                    {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Questa parte � stata selezionata. Vuoi selezionare il resto del documento?';                                     {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'Valikus olev tekst on kontrollitud. Kas soovid kontrollida ka �lej��nud dokumenti?';      {$ENDIF}
        end;

    lsMnNoSuggestions:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '(no suggestions)';       {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '(inga f�rslag)';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '(sem sugest�es)';        {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '(keine Vorschl�ge)';     {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '(Geen voorstelle nie)';  {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '(sin sugerencias)';      {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '(�������� �����������)'; {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '(��dn� n�vrhy)';         {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '(geen suggesties)';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '(ingen forslag)';        {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '(brak propozycji)';      {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '(aucune suggestion)';    {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '(ingen forslag)';        {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '(nessun suggerimento)';  {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '(soovitusi ei ole)';      {$ENDIF}
        end;
    lsMnIgnore:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'I&gnore';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera';       {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'I&gnorar';       {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'I&gnorieren';    {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'I&gnoreer';      {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'I&gnorar';       {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&����������';    {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'I&gnorovat';     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Negeren';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ignorer';       {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pom&i�';         {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'I&gnorer';       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Ignorer';       {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'I&gnora';        {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'I&gnoreeri';     {$ENDIF}
        end;
    lsMnIgnoreAll:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Ignore All';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Ignorera Allt';      {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Ignorar Todas';     {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Alles &ignorieren';  {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Ignorrer almal';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Ignorar Todas';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '���������� &���';    {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Ignorovat v�e';     {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Alles Negeren';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'Ignorer &Alle';      {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pomi� &wszystkie';   {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Ignorer tout';      {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'Ignorer &Alle';      {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Ignora Tutto';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Ignoreeri k�iki';      {$ENDIF}
        end;
    lsMnAdd:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Add';           {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&L�gg till';     {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Adicionar';     {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := '&Voeg by';       {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&Hinzuf�gen';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Agregar';       {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&��������';      {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&P�idat';        {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Toevoegen';      {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Tilf�j';        {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Dodaj';         {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Ajouter';       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Legg til';      {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Aggiungi';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Lisa';          {$ENDIF}
        end;
    lsMnChangeAll:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Change All';        {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '�ndra allt';         {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Trocar Todas';      {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Al&les �ndern';      {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Skrap almal';        {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Cambiar Todas';     {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '�������� ��&�';      {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Zam�nit v�e';       {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'Alles Vervangen';    {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Ret Alle';          {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := '&Popraw szystkie';   {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Changer tout';      {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Korriger alle';     {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Sostituisci Tutto'; {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '&Muuda k�ik';        {$ENDIF}
        end;
    lsMnAutoCorrect:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := 'A&uto Correct';          {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := 'Autokorrigera';          {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := 'Auto-Corrigir';          {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := 'Auto-&Korrektur';        {$ENDIF}
        {$IFNDEF AD3NOAFRIKAANS}ltAfrikaans:    Result := 'Vervang &automaties';    {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := 'A&uto-Corregir';         {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&����������';            {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := 'A&utomatick� kontrola';  {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := 'A&uto Correctie';        {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := 'A&uto Korriger';         {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'A&uto Korekta';          {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := 'A&uto Correction';       {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := 'A&utokorriger';          {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := 'Correzione A&uto.';      {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := 'A&utomaatne parandus';   {$ENDIF}
        end;
    lsMnSpelling:
        case (Language) of
        {$IFNDEF AD3NOENGLISH}  ltEnglish:      Result := '&Spelling ...';              {$ENDIF}
        {$IFNDEF AD3NOSWEDISH}  ltSwedish:      Result := '&Stavning ...';              {$ENDIF}
        {$IFNDEF AD3NOBRPORT}   ltBrPort:       Result := '&Ortografia...';             {$ENDIF}
        {$IFNDEF AD3NOENGLISH}  ltAfrikaans:    Result := '&Spel toets ...';            {$ENDIF}
        {$IFNDEF AD3NOGERMAN}   ltGerman:       Result := '&Rechtschreibpr�fung ...';   {$ENDIF}
        {$IFNDEF AD3NOSPANISH}  ltSpanish:      Result := '&Ortograf�a ...';            {$ENDIF}
        {$IFNDEF AD3NORUSSIAN}  ltRussian:      Result := '&�������� ����������...';    {$ENDIF}
        {$IFNDEF AD3NOCZECH}    ltCzech:        Result := '&Pravopis ...';              {$ENDIF}
        {$IFNDEF AD3NODUTCH}    ltDutch:        Result := '&Spelling ...';              {$ENDIF}
        {$IFNDEF AD3NODANISH}   ltDanish:       Result := '&Stavekontrol ...';          {$ENDIF}
        {$IFNDEF AD3NOPOLISH}   ltPolish:       Result := 'Pi&sownia ...';              {$ENDIF}
        {$IFNDEF AD3NOFRENCH}   ltFrench:       Result := '&Orthographe ...';           {$ENDIF}
        {$IFNDEF AD3NONORWAYBOK}ltNorwegianBok: Result := '&Stavekontroll ...';         {$ENDIF}
        {$IFNDEF AD3NOITALIAN}  ltItalian:      Result := '&Ortografia ...';            {$ENDIF}
        {$IFNDEF AD3NOESTONIAN}  ltEstonian:    Result := '�ige&kiri ...';              {$ENDIF}
        end;
    end;
end;



end.

