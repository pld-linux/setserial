.\" {PTM/PB/0.1/02-04-1999/"pobierz/ustaw informacje o porcie szeregowym"}
.\" Translation 1999 Przemek Borys <pborys@dione.ids.pl>
.\" Buu... Znowu trudny tekst :(
.\" Copyright 1992, 1993 Rickard E. Faith (faith@cs.unc.edu)
.\" May be distributed under the GNU General Public License
.\" Portions of this text are from the README in setserial-2.01.tar.z,
.\" but I can't figure out who wrote that document.  If anyone knows,
.\" please tell me
.\"
.\" [tytso:19940519.2239EDT]  I did... - Ted Ts'o (tytso@mit.edu)
.\" Sat Aug 27 17:08:38 1994 Changes from Kai Petzke
.\" (wpp@marie.physik.tu-berlin.de) were applied by Rik Faith
.\" (faith@cs.unc.edu)
.\" "
.TH SETSERIAL 8 "27 Sierpie� 1994" "Setserial 2.10" "Podr�cznik programisty linuxowego"
.SH NAZWA
setserial \- pobierz/ustaw informacje o porcie szeregowym
.SH SK�ADNIA
.B setserial
.B "[ \-abqvVW ]"
device
.BR "[ " parameter1 " [ " arg " ] ] ..."

.B "setserial -g"
.B "[ \-abv ]"
device1 ...
.SH OPIS
.B setserial
jest programem przeznaczonym do ustawiania i/lub raportowania informacji
konfiguracyjnych zwi�zanych z portem szeregowym. Informacje te zawieraj�
port I/O, numer IRQ, to czy klawisz break powinien by� interpretowane jako
Secure Attention Key, itd.

Podczas normalnego bootowania, inicjalizowane s� tylko porty COM 1-4;
u�ywane s� domyslne warto�ci port�w I/O i IRQ. Aby zainicjalizowa� dodatkowe
porty szeregowe, lub aby zmieni� konfiguracje port�w 1-4, u�yj programu
.BR setserial .
Zazwyczaj jest on wo�any ze skryptu
.IR rc.serial ,
kt�ry jest normalnie uruchomiany z
.IR /etc/rc.local .

Argument(y)
.I device
okre�laj�, kt�re urzadzenie szeregowe ma by� skonfigurowane, lub zapytane.
Zazwyczaj przyjmuje posta�
.BR /dev/cua[0-3] .

Bez parametr�w,
.B setserial
wydrukuje rodzaj portu np. 8250, 16450, 16550, 16550A), sprz�towy port I/O,
sprz�tow� lini� IRQ, szybko�� i niekt�re flagi operacyjne.

Przy podanej opcji
.BR \-g ,
argumenty setserial s� interpretowane jako lista urz�dze�, dla kt�rych
trzeba wydrukowa� charakterystyk�.

Bez opcji
.BR \-g ,
pierwszy argument setserial jest interpretowany jako urz�dzenie do
zmodyfikowania lub do wydrukowania charakterystyki, a dodatkowe argumenty s�
interpretowane jako parametry, kt�re powinny by� za��czone do tego
urz�dzenia.

W wi�kszo�ci wypadk�w wymagane s� uprawnienia superu�ytkownika. Jednak kilka
opcji port�w mog� ustawia� zwykli u�ytkownicy i opcje te zostan� zaznaczone
jako wyj�tki w tym podr�czniku.

.SH OPCJE
.B Setserial
przyjmuje nast�puj�ce opcje:

.TP
.B \-a
Podczas raportowania konfiguracji urz�dzenia szeregowego, wydrukuj wszelkie
dost�ne informacje.
.TP
.B \-b
Podczas raportowania konfiguracji urz�dzenia szeregowego, wydrukuj
podsumowanie konfiguracji urz�dzenia, kt�re mo�e by� wystarczaj�ca do
wydrukowania podczas procesu bootowania w skrypcie /etc/rc.
.TP
.B \-q
B�d� cicho.
.B Setserial
wydrukuje mniej linii na wyj�ciu.
.TP
.B \-v
B�d� gadatliwy.
.B Setserial
wydrukuje dodatkowy status na wyj�ciu.
.TP
.B \-V
Wy�wietl wersj� i zako�cz.
.TP
.B \-W
Dokonaj dzikiej inicjalizacji przerwa� i zako�cz.

.SH PARAMETRY
Portowi szeregowemu mo�na przyzna� nast�puj�ce parametry.

Wszystkie warto�ci argument�w s� warto�ciami dzi�si�tnymi, chyba �e
poprzedzone s� "0x".

.TP
.BR port " port_number"
Opcja
.B port
ustawia port I/O, jak opisano wy�ej.
.TP
.BR irq " irq_number"
Opcja
.B irq
ustawia sprz�towe IRQ, jak opisano wy�ej.
.TP
.BR uart " uart_type"
Opcja ta jest u�ywana do ustawienia typu UART-a. Dozwolone typy to
.BR none ,
8250, 16450, 16550, i 16550A. Poniewa� UART-y 8250 i 16450 nie maj� FIFO, i
poniewa� oryginalne 16550 maj� b��dy czyni�ce FIFO bezu�ytecznym, FIFO mo�e
by� u�ywane tylko na chipach zidentyfikowanych jako UART-y 16550A.
Ustawienie typu UART na 8250, 16450, lub 16550 w��czy port szeregowy bez
pr�by u�ywania FIFO. U�ycie typu UART
.B none
wy��czy port.

Niekt�re modemy wewn�trzne s� oznaczone jako maj�ce "UART 16550A z buforem 1K"
Jest to k�amstwo. Nie maj� w rzeczywisto�ci UART-a kompatybilnego z 16550A;
zamiast niego maj� UART kompatybilny z 16450 z 1K buforem odbiorczym dla
zapobiegania spustoszeniom u odbiorcy. Jest to istotne, poniewa� nie maj�
one transmituj�cego FIFO. Dlatego nie s� kompatybilne z UART-em 16550A i
proces autokonfiguracji zidentyfikuje je prawid�owo jako 16450. Je�li
spr�bujesz obej�� to, u�ywaj�c parametru
.BR uart ,
pojawi� si� porzucone znaki podczas transmisji plik�w. UART-y te maj� zwykle
inne problemy: parametr
.B skip_test
powinien by� r�wnie� cz�sto podawany.
.TP
.B autoconfig
Gdy podano ten parametr,
.B setserial
poprosi j�dro o pr�b� automatycznego skonfigurowania portu szeregowego. Port
I/O musi by� ustawiony prawid�owo; j�dro spr�buje okre�li� typ UART, a
dodatkowo je�li podano parametr
.BR auto_irq ,
Linux spr�buje te� automatycznie okre�li� IRQ.
Parametr
.B autoconfigure
powinien by� podawany po parametrach
.BR port , auto_irq ", i" skip_test .
parameters have been specified.
.TP
.B auto_irq
Spr�buj podczas autokonfiguracji okre�li� IRQ. W�a�ciwo�� ta nie zawsze musi
da� prawid�owy wynik; niekt�re konfiguracje sprz�towe mog� og�upi� j�dro.
Og�lnie, bezpieczniej jest nie u�ywa� w�a�ciwo�ci
.BR auto_irq ,
lecz raczej samemu podawa� warto�� IRQ, u�ywaj�c parametru
.BR irq .
.TP
.B ^auto_irq
.I Nie
pr�buj okre�li� IRQ podczas autokonfiguracji.
.TP
.B skip_test
Pomi� test UART podczas autokonfiguracji. Niekt�re modemy wewn�trzne nie
maj� UART-�w kompatybilnych z National Semiconductor, lecz zamiast nich
tanie imitacje. Niekt�re z nich nie wspieraj� w pe�ni trybu detekcji
loopback, kt�rego u�ywa j�dro do upewnienia si�, czy pod podanym adresem
jest rzeczywi�cie UART. Dlatego dla niekt�rych modem�w b�dzie trzeba poda�
ten parametrm aby mo�na by�o zainicjalizowa� UART prawid�owo.
.TP
.B ^skip_test
.I Nie
pomijaj testu UART podczas autokonfiguracji.
.TP
.BR baud_base " baud_base"
Opcja ta ustawia podstawow� pr�dko�� (baud rate), kt�ra jest cz�stotliwo�ci�
zegara podzielon� przez 16. Normalnie jest to 115200, co jest zarazem najwi�ksz�
pr�dko�ci� wspieran� przez UART.
.TP
.B
spd_hi
Gdy aplikacja ��da 38.4kb, u�ywaj 57.6kb. Parametr ten mo�e by� ustawiany
przez nieuprzywilejowanego u�ytkownika.
.TP
.B spd_vhi
Gdy aplikacja ��da 38.4kb, u�ywaj 115kb. Parametr ten mo�e by� ustawiany
przez nieuprzywilejowanego u�ytkownika.
.TP
.B spd_cust
Gdy aplikacja ��da 38.4kb, u�yj ustawionego dzielnika do ustawienia
szybko�ci. W tym wypadku, prz�dko�� jest okre�lona przez
.B baud_base
podzielone przez
.BR divisor (dzielnik).
Parametr ten mo�e byc podawany przez nieuprzywilejowanego u�ytkownika.
.TP
.B spd_normal
Gdy aplikacja ��da 38.4kb, u�ywaj 38.4kb. Parametr ten mo�e by� ustawiany
przez nieuprzywilejowanego u�ytkownika.
.TP
.BR divisor " divisor"
Opcja ta ustawia konfigurowalny dzielnik. Dzielnik b�dzie u�ywany gdy
wybrana zostanie opcja
.BR spd_cust ,
a port szeregowy b�dzie ustawiony przez aplikacj� na 38.4kb.
Parametr ten mo�e by� podawany przez nieuprzywilejowanego u�ytkownika.
.TP
.B sak
Ustaw klawisz break na Secure Attention Key.
.TP
.B ^sak
wy��cz Secure Attention Key.
.TP
.B fourport
Skonfiguruj port jako kart� AST Fourport.
.TP
.B ^fourport
Wy��cz konfiguracj� AST Fourport.
.TP
.BR close_delay " delay"
Podaj ilo�� czasu w setnych sekundy, podczas kt�rych DTR powinien zosta� w
stanie obni�onym na linii szeregowej po tym, jak urz�dzenie wydzwaniaj�ce
(callout device) jest zamykane, zanim blokowane urz�dzenie wdzwaniaj�ce si�
(dialin device) zn�w podniesie DTR. Domy�ln� warto�ci� tej opcji jest 50 lub
p� sekundy.
.TP
.B session_lockout
Lokuj dost�p do portu wydzwaniaj�cego (/dev/cuaXX) na przestrzeni r�nych
sesji. To znaczy, �e gdy proces otworzy port, to �aden inny proces nie mo�e
go ju� otworzy�, dop�ki pierwszy proces go nie zamknie.
.TP
.B ^session_lockout
Nie lokuj portu wydzwaniaj�cego na przestrzeni sesji.
.TP
.B pgrp_lockout
Lokuj port wydzwaniaj�cy (/dev/cuaXX) na przestrzeni r�nych grup proces�w.
To znaczy, �e gdy proces otworzy� port, to �aden inny proces z innej grupy
proces�w nie mo�e go otworzy�, dop�ki ten proces go nie zamknie.
.TP
.B ^pgrp_lockout
Nie lokuj portu wydzwaniaj�cego na przestrzeni r�nych grup proces�w.
.TP
.B hup_notify
Poinformuj proces blokowany na otwieraniu linii wdzwaniaj�cej, gdy
proces sko�czy u�ywa� linii wydzwaniaj�cej (zar�wno przez zamkni�cie jej,
lub przez zawieszenie jej) przez zwr�cenie (funkcji?) open EAGAIN.

Zastosowanie tego parametru odnosi si� do getty, kt�re sa blokowane na
liniach wdzwaniaj�cych port�w szeregowych. Umo�liwia to getty zresetowanie
modemu (kt�ry mo�e mie� dzi�ki aplikacji u�ywaj�cej urz�dzenia wydzwaniaj�cego
zmienion� konfiguracj�) przed ponownym blokowaniem.
.TP
.B ^hup_notify
Nie informuj procesu blokowanego na otwieraniu linii wdzwaniaj�cej, gdy
urz�dzenie wydzwaniaj�ce jest odwieszone.
.TP
.B split_termios
Traktuj ustawienia termios u�ywane przez urz�dzenie wydzwaniaj�ce i
ustawienia urz�dzenia wdzwaniaj�cego osobno.
.TP
.B ^split_termios
U�ywaj tej samej struktury termios do przechowywania ustawie� urz�dzenia
wdzwaniaj�cego i wydzwaniaj�cego.
.TP
.B callout_nohup
Je�li dany port szeregowy jest otworzony jako urz�dzenie wydzwaniaj�ce, nie
odwieszaj tty gdy porzucony zostanie CD.
.TP
.B ^callout_nohup
Nie pomijaj odwieszania tty gdy port szeregowy jest otworzony jako
urz�dzenie wydzwaniaj�ce. Oczywi�cie musi by� w��czona flaga HUPCL termios,
je�li odwieszenie ma si� pojawi�.
.SH ROZWA�ANIA O KONFIGUROWANIU PORT�W SZEREGOWYCH
Wa�nym jest, by zauwa�y� i� setserial zwyczajnie m�wi j�dru Linuxa, gdzie
powinien spodziewa� si� znale�� port I/O i linie IRQ okre�lonego portu
szeregowego. Nie konfiguruje on sprz�tu! Aby to uczyni�, musisz fizycznie
zaprogramowa� kart� szeregow�, zazwyczaj przez przestawienie zworek, lub
prze��czenie prze��cznik�w DIP.

Sekcja ta udost�pni pewne wskaz�wki pomocne w decydowaniu jak skonfigurowa�
porty szeregowe.

"Standardowe powi�zania MS-DOS" zosta�y pokazane ni�ej:

.nf
.RS
/dev/ttyS0 (COM1), port 0x3f8, irq 4
/dev/ttyS1 (COM2), port 0x2f8, irq 3
/dev/ttyS2 (COM3), port 0x3e8, irq 4
/dev/ttyS3 (COM4), port 0x2e8, irq 3
.RE
.fi

Z powodu ogranicze� w projekcie architektury szyn AT/ISA, normalnie linia
IRQ nie mo�e by� dzielona mi�dzy dwoma lub wi�cej portami szeregowymi. Je�li
spr�bujesz tak zrobi�, jeden lub obydwa z tych port�w stan� si� niedost�pne,
gdy spr�bujesz u�ywa� ich naraz. Ograniczenie to mo�na obej�� prez specjalne
wieloportowe karty szeregowe, kt�re s� skonstruowane do dzielenia wielu
port�w szeregowych na jednej linii IRQ. Karty wspierane przez Linuxa
zawieraj� AST FourPort, Accent Async, Usenet Serial II, Bocaboard BB-1004,
BB-1008, i BB-2016, oraz HUB-6.

Wyb�r alternatywnej linii IRQ jest trudny, gdy� prawie wszystkie z nich s�
ju� w u�ytku. Nast�puj�ca tabela zawiera wykaz "standardowych przydzia��w
MS-DOS" dla linii IRQ:

.nf
.RS
IRQ 3: COM2
IRQ 4: COM1
IRQ 5: LPT2
IRQ 7: LPT1
.RE
.fi

Wiele os�b uwa�a, �e IRQ 5 jest dobrymw wyborem, zak�adaj�c �e w komputerze
aktywny jest tylko jeden port r�wnoleg�y. Innym dobrym wyborem jest IRQ 2
(aka IRQ 9); chocia� to IRQ jest czasem u�ywane przez karty sieciowe i
bardzo rzadko przez karty VGA (dla przerwania vertical retrace). Je�li twoja
karta VGA jest tak skonfigurowana, spr�buj to wy��czy�, tak by� m�g�
wykorzysta� to IRQ dla innej karty. Nie jest to niezb�dne pod GNU/Linuxem i
wi�kszo�ci� innych system�w operacyjnych.

Jedynymi innymi dost�pnymi liniami IRQ s� 3, 4 i 7, a s� one prawdopodobnie
u�ywane przez inne porty szeregowe i r�wnoleg�e. (Je�li twoja karta
szeregowa ma 16-bitowy edge connector i wspiera wy�sze numery IRQ, to
dost�pne sa te� IRQ 10, 11, 12 i 15.)

W maszynach klasy AT, IRQ 2 jest widziane jako IRQ 9 i Linux interpretuje je
w ten spos�b.

Przerwania inne ni� 2 (9), 3, 4, 5, 7, 10, 11, 12, i 15,
.I nie
powinny by� u�ywane, gdy� s� przyznane innym elementom sprz�towym i og�lnie
nie mog� by� zmieniane. Oto "standardowe" przyznania:

.nf
.RS
IRQ  0      Kana� timera 0
IRQ  1      Klawiatura
IRQ  2      Kaskada kontrolera 2
IRQ  3      Port szeregowy 2
IRQ  4      Port szeregowy 1
IRQ  5      Port r�wnoleg�y 2 (Zarezerwowane w PS/2)
IRQ  6      Stacja dysk�w
IRQ  7      Port r�wnoleg�y 1
IRQ  8      Zegar czasu rzeczywistego
IRQ  9      Przekierowane na IRQ2
IRQ 10      Zarezerwowane
IRQ 11      Zarezerwowane
IRQ 12      Zarezerwowane (Pomocnicze urz�dzenie w PS/2)
IRQ 13      Koprocesor matematyczny
IRQ 14      Kontroler dysku twardego
IRQ 15      Zarezerwowane
.RE
.fi


.SH UWAGA
UWAGA: U�ywanie nieprawid�ego portu mo�e zalokowa� twoj� maszyn�.
.SH PLIKI
.BR /etc/rc.local
.BR /etc/rc.serial
.SH "ZOBACZ TAK�E"
.BR tty (4),
.BR ttys (4),
kernel/chr_drv/serial.c
.SH AUTOR
Oryginalna wersja setserial zosta�a napisana przez Ricka Sladkeya
(jrs@world.std.com), i zosta�a zmodyfikowana przez Michaela K. Johnsona
(johnsonm@stolaf.edu).

Ta wersja zosta�a w mi�dzyczasie przerobiona przez Theodore Ts'o
(tytso@mit.edu) 1/1/93. Wszelkie b��dy i problemy podlegaj� jego
odpowiedzialno�ci.
