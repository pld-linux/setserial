.\" {PTM/PB/0.1/02-04-1999/"pobierz/ustaw informacje o porcie szeregowym"}
.\" Translation 1999,2000 Przemek Borys <pborys@dione.ids.pl>
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
.TH SETSERIAL 8 "Styczeñ 2000" "Setserial 2.17" "Podrêcznik programisty linuksowego"
.SH NAZWA
setserial \- pobierz/ustaw informacje o porcie szeregowym
.SH SK£ADNIA
.B setserial
.B "[ \-abqvVWz ]"
device
.BR "[ " parameter1 " [ " arg " ] ] ..."

.B "setserial -g"
.B "[ \-abGv ]"
device1 ...
.SH OPIS
.B setserial
jest programem przeznaczonym do ustawiania i/lub raportowania danych
konfiguracyjnych zwi±zanych z portem szeregowym. Dane te zawieraj±
port I/O, numer IRQ, to czy klawisz break powinien byæ interpretowany jako
Secure Attention Key, itd.

Podczas normalnego bootowania, inicjalizowane s± jedynie porty COM 1-4;
u¿ywane s± przy tym domy¶lne warto¶ci portów I/O i IRQ. Aby zainicjalizowaæ
dodatkowe porty szeregowe, lub aby zmieniæ konfiguracje portów 1-4, musisz
u¿yæ programu
.BR setserial .
Zazwyczaj jest on wo³any ze skryptu
.IR rc.serial ,
który z kolei jest normalnie uruchamiany z
.IR /etc/rc.local .

Argument(y)
.I device
okre¶la, które urz±dzenie szeregowe ma byæ skonfigurowane lub odpytane.
Zazwyczaj przyjmuje postaæ
.BR /dev/cua[0-3] .

Bez parametrów,
.B setserial
drukuje rodzaj portu np. 8250, 16450, 16550, 16550A), sprzêtowy port I/O,
sprzêtow± liniê IRQ, szybko¶æ i niektóre flagi operacyjne.

Przy podanej opcji
.BR \-g ,
argumenty setserial s± interpretowane jako lista urz±dzeñ, dla których
nale¿y wydrukowaæ charakterystykê.

Bez opcji
.BR \-g ,
pierwszy argument jest interpretowany jako urz±dzenie do
zmodyfikowania lub do wydrukowania charakterystyki, a dodatkowe argumenty
interpretowane s± jako parametry, które powinny byæ zaaplikowane do tego
urz±dzenia.

W wiêkszo¶ci wypadków wymagane s± uprawnienia superu¿ytkownika. Jednak kilka
opcji portów mog± ustawiaæ zwykli u¿ytkownicy i opcje te zostan± zaznaczone
jako wyj±tki w tym podrêczniku.

.SH OPCJE
.B Setserial
przyjmuje nastêpuj±ce opcje:

.TP
.B \-a
Podczas raportowania konfiguracji urz±dzenia szeregowego, drukuj wszelkie
dostêpne informacje.
.TP
.B \-b
Podczas raportowania konfiguracji urz±dzenia szeregowego, drukuj
zestawienie konfiguracji urz±dzenia, które mo¿e byæ wystarczaj±ce do
wypisania podczas procesu bootowania w skrypcie /etc/rc.
.TP
.B \-G
Wydrukuj informacjê o konfiguracji portu szeregowego w postaci, która mo¿e
zostaæ zassana do setseriala jako argumenty linii poleceñ.
.TP
.B \-q
B±d¼ cicho.
.B Setserial
wydrukuje wtedy mniej linii na wyj¶ciu.
.TP
.B \-v
B±d¼ gadatliwy.
.B Setserial
wydrukuje wtedy dodatkowy status na wyj¶ciu.
.TP
.B \-V
Wy¶wietl wersjê i zakoñcz.
.TP
.B \-W
Dokonaj dzikiej inicjalizacji przerwañ i zakoñcz. Opcja ta nie jest istotna
w j±drach po wersji 2.1.
.TP
.B \-z
Zeruj flagi szeregowe przed rozpoczêciem ich ustawiania. Jest to zwi±zane z
automatycznym zachowywaniem flag szeregowych z flag± \-G.

.SH PARAMETRY
Portowi szeregowemu mo¿na przyznaæ ni¿ej wymienione parametry.

Wszystkie warto¶ci argumentów s± warto¶ciami dziesiêtnymi, chyba ¿e
poprzedzone s± "0x".

.TP
.BR port " port_number"
Opcja
.B port
ustawia port I/O, jak opisano wy¿ej.
.TP
.BR irq " irq_number"
Opcja
.B irq
ustawia sprzêtowe IRQ, jak opisano wy¿ej.
.TP
.BR uart " uart_type"
Opcja ta jest u¿ywana do ustawienia typu UART-a. Dozwolone typy to
.BR none ,
8250, 16450, 16550, 16550A, 16650, 16650V2, 16654, 16750, 16850, 16950,
i 16954.
U¿ycie typu UART
.B none
wy³±czy port.

Niektóre modemy wewnêtrzne s± oznaczone jako maj±ce "UART 16550A z buforem 1K"
Jest to k³amstwo. Nie maj± w rzeczywisto¶ci UART-a kompatybilnego z 16550A;
zamiast niego maj± UART kompatybilny z 16450 z 1K buforem odbiorczym dla
zapobiegania spustoszeniom u odbiorcy. Jest to istotne, poniewa¿ nie maj±
one transmituj±cego FIFO. Dlatego nie s± kompatybilne z UART-em 16550A i
proces autokonfiguracji zidentyfikuje je prawid³owo jako 16450. Je¶li
spróbujesz obej¶æ to, u¿ywaj±c parametru
.BR uart ,
pojawi± siê porzucone znaki podczas transmisji plików. UART-y te maj± zwykle
inne problemy: parametr
.B skip_test
powinien byæ równie¿ czêsto podawany.
.TP
.B autoconfig
Gdy podano ten parametr,
.B setserial
poprosi j±dro o próbê automatycznego skonfigurowania portu szeregowego. Port
I/O musi byæ ustawiony prawid³owo; j±dro spróbuje okre¶liæ typ UART, a
dodatkowo je¶li podano parametr
.BR auto_irq ,
Linux spróbuje te¿ automatycznie okre¶liæ IRQ.
Parametr
.B autoconfig
powinien byæ podawany po parametrach
.BR port , auto_irq ", i " skip_test .
.TP
.B auto_irq
Spróbuj podczas autokonfiguracji okre¶liæ IRQ. W³a¶ciwo¶æ ta nie zawsze musi
daæ prawid³owy wynik; niektóre konfiguracje sprzêtowe mog± og³upiæ j±dro.
Ogólnie, bezpieczniej jest nie u¿ywaæ w³a¶ciwo¶ci
.BR auto_irq ,
lecz raczej samemu podawaæ warto¶æ IRQ, u¿ywaj±c parametru
.BR irq .
.TP
.B ^auto_irq
.I Nie
próbuj okre¶liæ IRQ podczas autokonfiguracji.
.TP
.B skip_test
Pomiñ test UART podczas autokonfiguracji. Niektóre modemy wewnêtrzne nie
maj± UART-ów kompatybilnych z National Semiconductor, lecz zamiast nich
tanie imitacje. Niektóre z nich nie wspieraj± w pe³ni trybu detekcji
loopback, którego u¿ywa j±dro do upewnienia siê, czy pod podanym adresem
jest rzeczywi¶cie UART. Dlatego dla niektórych modemów bêdzie trzeba podaæ
ten parametr aby mo¿na by³o zainicjalizowaæ UART prawid³owo.
.TP
.B ^skip_test
.I Nie
pomijaj testu UART podczas autokonfiguracji.
.TP
.BR baud_base " baud_base"
Opcja ta ustawia podstawow± prêdko¶æ (baud rate), która jest czêstotliwo¶ci±
zegara podzielon± przez 16. Normalnie jest to 115200, co jest zarazem najwiêksz±
prêdko¶ci± wspieran± przez UART.
.TP
.B
spd_hi
Gdy aplikacja ¿±da 38.4kb, u¿ywaj 57.6kb. Parametr ten mo¿e byæ ustawiany
przez nieuprzywilejowanego u¿ytkownika.
.TP
.B spd_vhi
Gdy aplikacja ¿±da 38.4kb, u¿ywaj 115kb. Parametr ten mo¿e byæ ustawiany
przez nieuprzywilejowanego u¿ytkownika.
.TP
.B spd_shi
U¿yj 230kb gdy aplikacja ¿±da 38.4kb. Parametr ten mo¿e byæ podawany przez
u¿ytkownika nieuprzywilejowanego.
.TP
.B spd_warp
U¿yj 460kb gdy aplikacja ¿±da 38.4kb. Parametr ten mo¿e byæ podawany przez
u¿ytkownika nieuprzywilejowanego.
.TP
.B spd_cust
Gdy aplikacja ¿±da 38.4kb, u¿yj ustawionego dzielnika do ustawienia
szybko¶ci. W tym wypadku, prêdko¶æ jest okre¶lona przez
.B baud_base
podzielone przez
.BR divisor (dzielnik).
Parametr ten mo¿e byæ podawany przez nieuprzywilejowanego u¿ytkownika.
.TP
.B spd_normal
Gdy aplikacja ¿±da 38.4kb, u¿ywaj 38.4kb. Parametr ten mo¿e byæ ustawiany
przez nieuprzywilejowanego u¿ytkownika.
.TP
.BR divisor " divisor"
Opcja ta ustawia konfigurowalny dzielnik. Dzielnik bêdzie u¿ywany gdy
wybrana zostanie opcja
.BR spd_cust ,
a port szeregowy bêdzie ustawiony przez aplikacjê na 38.4kb.
Parametr ten mo¿e byæ podawany przez nieuprzywilejowanego u¿ytkownika.
.TP
.B sak
Ustaw klawisz break na Secure Attention Key.
.TP
.B ^sak
wy³±cz Secure Attention Key.
.TP
.B fourport
Skonfiguruj port jako kartê AST Fourport.
.TP
.B ^fourport
Wy³±cz konfiguracjê AST Fourport.
.TP
.BR close_delay " delay"
Podaj ilo¶æ czasu w setnych sekundy, podczas których DTR powinien zostaæ w
stanie obni¿onym na linii szeregowej po tym, jak urz±dzenie wydzwaniaj±ce
(callout device) jest zamykane, zanim blokowane urz±dzenie wdzwaniaj±ce siê
(dialin device) znów podniesie DTR. Domy¶ln± warto¶ci± tej opcji jest 50 lub
pó³ sekundy.
.TP
.BR closing_wait " opó¼nienie"
Podaj ilo¶æ czasu w setnych sekundy, podczas której j±dro powinno czekaæ na
dane nadawane z portu szeregowego podczas jego zamykania. Je¶li podane
zostanie "none", nie bêdzie oczekiwania. Je¶li podane zostanie "infinite",
j±dro bêdzie czekaæ w nieokre¶lenie d³ugo na przybycie buforowanych danych.
Domy¶lnym ustawieniem jest 3000 lub 30 sekund opó¼nienia. Ta warto¶æ
domy¶lna jest wskazana dla wiêkszo¶ci urz±dzeñ. Je¶li wybrane zostanie
d³ugie opó¼nienie, to port szeregowy mo¿e siê zawiesiæ na d³ugi czas podczas
zamykania. Je¶li wybrany bêdzie zbyt krótki czas, to istnieje ryzyko utraty
danych. Je¶li urz±dzenie jest bardzo wolne, jak w ploterze, to mo¿na wybraæ
wiêksze warto¶ci.
.TP
.B session_lockout
Blokuj dostêp do portu wydzwaniaj±cego (/dev/cuaXX) na przestrzeni ró¿nych
sesji. To znaczy, ¿e gdy proces otworzy port, to ¿aden inny proces nie mo¿e
go ju¿ otworzyæ, dopóki pierwszy proces go nie zamknie.
.TP
.B ^session_lockout
Nie blokuj portu wydzwaniaj±cego na przestrzeni sesji.
.TP
.B pgrp_lockout
Blokuj port wydzwaniaj±cy (/dev/cuaXX) na przestrzeni ró¿nych grup procesów.
To znaczy, ¿e gdy proces otworzy³ port, to ¿aden inny proces z innej grupy
procesów nie mo¿e go otworzyæ, dopóki ten proces go nie zamknie.
.TP
.B ^pgrp_lockout
Nie blokuj portu wydzwaniaj±cego na przestrzeni ró¿nych grup procesów.
.TP
.B hup_notify
Poinformuj proces blokowany na otwieraniu linii wdzwaniaj±cej, gdy
proces skoñczy u¿ywaæ linii wydzwaniaj±cej (zarówno przez zamkniêcie jej,
lub przez zawieszenie jej) przez zwrócenie (funkcji?) open EAGAIN.

Zastosowanie tego parametru odnosi siê do getty, które s± blokowane na
liniach wdzwaniaj±cych portów szeregowych. Umo¿liwia to getty zresetowanie
modemu (który mo¿e mieæ dziêki aplikacji u¿ywaj±cej urz±dzenia wydzwaniaj±cego
zmienion± konfiguracjê) przed ponownym blokowaniem.
.TP
.B ^hup_notify
Nie informuj procesu blokowanego na otwieraniu linii wdzwaniaj±cej, gdy
urz±dzenie wydzwaniaj±ce jest odwieszone.
.TP
.B split_termios
Traktuj ustawienia termios u¿ywane przez urz±dzenie wydzwaniaj±ce i
ustawienia urz±dzenia wdzwaniaj±cego osobno.
.TP
.B ^split_termios
U¿ywaj tej samej struktury termios do przechowywania ustawieñ urz±dzenia
wdzwaniaj±cego i wydzwaniaj±cego.
.TP
.B callout_nohup
Je¶li dany port szeregowy jest otworzony jako urz±dzenie wydzwaniaj±ce, nie
odwieszaj tty gdy porzucony zostanie CD.
.TP
.B ^callout_nohup
Nie pomijaj odwieszania tty gdy port szeregowy jest otworzony jako
urz±dzenie wydzwaniaj±ce. Oczywi¶cie musi byæ w³±czona flaga HUPCL termios,
je¶li odwieszenie ma siê pojawiæ.
.TP
.B low_latency
Minimalizuj opó¼nienia odbioru z urz±dzenia szeregowego kosztem 
wiêkszego zaanga¿owania CPU. (Normalnie jest 5-10ms opó¼nienie nim znaki
zostan± przekazane dyscyplinie linii.) Jest to domy¶lnie wy³±czone, lecz
niektóre aplikacje czasu rzeczywistego mog± tego potrzebowaæ.
.TP
.B ^low_latency
Optymalizuj efektywne przetwarzanie przez CPU znaków szeregowych kosztem
p³acenia ¶redniego opó¼nienia 5-10ms nim znaki zostan± przetworzone. Jest to
domy¶lne.

.SH ROZWA¯ANIA O KONFIGUROWANIU PORTÓW SZEREGOWYCH
Wa¿nym jest, by zauwa¿yæ i¿ setserial zwyczajnie mówi j±dru Linuksa, gdzie
powinien spodziewaæ siê znale¼æ port I/O i linie IRQ okre¶lonego portu
szeregowego. Nie konfiguruje on sprzêtu! Aby to uczyniæ, musisz fizycznie
zaprogramowaæ kartê szeregow±, zazwyczaj przez przestawienie zworek, lub
prze³±czenie prze³±czników DIP.

Sekcja ta udostêpni pewne wskazówki pomocne w decydowaniu jak skonfigurowaæ
porty szeregowe.

"Standardowe powi±zania MS-DOS" zosta³y pokazane ni¿ej:

.nf
.RS
/dev/ttyS0 (COM1), port 0x3f8, irq 4
/dev/ttyS1 (COM2), port 0x2f8, irq 3
/dev/ttyS2 (COM3), port 0x3e8, irq 4
/dev/ttyS3 (COM4), port 0x2e8, irq 3
.RE
.fi

Z powodu ograniczeñ w projekcie architektury szyn AT/ISA, normalnie linia
IRQ nie mo¿e byæ dzielona miêdzy dwoma lub wiêcej portami szeregowymi. Je¶li
spróbujesz tak zrobiæ, jeden lub obydwa z tych portów stan± siê niedostêpne,
gdy spróbujesz u¿ywaæ ich naraz. Ograniczenie to mo¿na obej¶æ przez specjalne
wieloportowe karty szeregowe, które s± skonstruowane do dzielenia wielu
portów szeregowych na jednej linii IRQ. Karty wspierane przez Linuksa
zawieraj± AST FourPort, Accent Async, Usenet Serial II, Bocaboard BB-1004,
BB-1008, i BB-2016, oraz HUB-6.

Wybór alternatywnej linii IRQ jest trudny, gdy¿ prawie wszystkie z nich s±
ju¿ w u¿ytku. Nastêpuj±ca tabela zawiera wykaz "standardowych przydzia³ów
MS-DOS" dla linii IRQ:

.nf
.RS
IRQ 3: COM2
IRQ 4: COM1
IRQ 5: LPT2
IRQ 7: LPT1
.RE
.fi

Wiele osób uwa¿a, ¿e IRQ 5 jest dobrym wyborem, zak³adaj±c ¿e w komputerze
aktywny jest tylko jeden port równoleg³y. Innym dobrym wyborem jest IRQ 2
(aka IRQ 9); chocia¿ to IRQ jest czasem u¿ywane przez karty sieciowe i
bardzo rzadko przez karty VGA (dla przerwania vertical retrace). Je¶li twoja
karta VGA jest tak skonfigurowana, spróbuj to wy³±czyæ, tak byæ móg³
wykorzystaæ to IRQ dla innej karty. Nie jest to niezbêdne pod GNU/Linuksem i
wiêkszo¶ci± innych systemów operacyjnych.

Jedynymi innymi dostêpnymi liniami IRQ s± 3, 4 i 7, a s± one prawdopodobnie
u¿ywane przez inne porty szeregowe i równoleg³e. (Je¶li twoja karta
szeregowa ma 16-bitowy edge connector i wspiera wy¿sze numery IRQ, to
dostêpne sa te¿ IRQ 10, 11, 12 i 15.)

W maszynach klasy AT, IRQ 2 jest widziane jako IRQ 9 i Linux interpretuje je
w ten sposób.

Przerwania inne ni¿ 2 (9), 3, 4, 5, 7, 10, 11, 12, i 15,
.I nie
powinny byæ u¿ywane, gdy¿ s± przyznane innym elementom sprzêtowym i ogólnie
nie mog± byæ zmieniane. Oto "standardowe" przyznania:

.nf
.RS
IRQ  0      Kana³ timera 0
IRQ  1      Klawiatura
IRQ  2      Kaskada kontrolera 2
IRQ  3      Port szeregowy 2
IRQ  4      Port szeregowy 1
IRQ  5      Port równoleg³y 2 (Zarezerwowane w PS/2)
IRQ  6      Stacja dysków
IRQ  7      Port równoleg³y 1
IRQ  8      Zegar czasu rzeczywistego
IRQ  9      Przekierowane na IRQ2
IRQ 10      Zarezerwowane
IRQ 11      Zarezerwowane
IRQ 12      Zarezerwowane (Pomocnicze urz±dzenie w PS/2)
IRQ 13      Koprocesor matematyczny
IRQ 14      Kontroler dysku twardego
IRQ 15      Zarezerwowane
.RE
.fi


.SH KONFIGURACJA WIELOPORTOWA

Niektóre wieloportowe uk³ady szeregowe, dziel±ce wiele portów na jednym IRQ
u¿ywaj± jednego lub wiêcej portów do okre¶lania czy s± tam aktywne porty,
które nale¿y obs³u¿yæ. Je¶li twój uk³ad wieloportowy obs³uguje te porty, to
powiniene¶ z nich skorzystaæ aby zapobiec potencjalnym zablokowaniom, gdy
zginie przerwanie.

Aby ustawiæ te porty, musisz przekazaæ
.B set_multiport
jako parametr i wypisaæ za nim parametry wieloportowe. Parametry
wieloportowe przybieraj± postaæ podania sprawdzanego
.IR portu ,
.IR maski ,
wskazuj±cej, które bity rejestru s± znacz±ce oraz, ostatecznie parametru
.IR dopasowania ,
(match), okre¶laj±cego, które bity znacz±ce tego rejestru musz± pasowaæ, gdy
nie ma ju¿ niczego do zrobienia.

Mo¿na podaæ do czterech takich kombinacji. Pierwsze kombinacje powinny byæ
podawane przez ustawianie parametrów
.BR port1 ,
.BR mask1 
i
.BR match1 .
Nastêpne przez ustawianie
.BR port2 ,
.BR mask2 
i
.BR match2 ,
itd. Aby wy³±czyæ sprawdzanie wieloportowe, ustaw
.B port1
na zero.

Aby obejrzeæ bie¿±ce ustawienia wieloportowe, podaj w linii poleceñ parametr
.BR get_multiport .

Oto pewne ustawienia wieloportowe dla popularnych uk³adów szeregowych:

.nf
.RS
AST FourPort    port1 0x1BF mask1 0xf match1 0xf

Boca BB-1004/8  port1 0x107 mask1 0xff match1 0

Boca BB-2016    port1 0x107 mask1 0xff match1 0
                port2 0x147 mask2 0xff match2 0
.RE
.fi

.SH Konfiguracja ESP Hayesa
.B Setserial
mo¿e byæ równie¿ u¿ywany do konfigurowania portów na uk³adzie ESP Hayesa.
.PP
Mo¿na do tego u¿ywaæ nastêpuj±cych parametrów:
.TP
.B rx_trigger
Jest to poziom wyzwalania (w bajtach) FIFO odbiorczego. Wiêksze warto¶ci
powoduj± mniej przerwañ i lepsz± wydajno¶æ; jednak zbyt du¿e warto¶ci
powoduj± utratê danych. Dostêpne warto¶ci to 1 do 1023.
.TP
.B tx_trigger
Jest to poziom wyzwalania (w bajtach) FIFO nadawczego. Wiêksze warto¶ci mog±
powodowaæ mniej przerwañ i lepsz± wydajno¶æ; jednak zbyt du¿e warto¶ci
powoduj± zdegradowan± wydajno¶æ nadawania. Dostêpne warto¶ci to 1 do 1023.
.TP
.B flow_off
Jest to poziom (w bajtach) przy którym port ESP zrobi "flow off" dla
zdalnego nadajnika (tj. powie mu by przesta³ nadawaæ wiêcej
bajtów). Dostêpne warto¶ci to 1 do 1023. Warto¶æ ta powinna byæ wiêksza od
poziomu wyzwalania odbiorczego i poziomu flow on.
.TP
.B flow_on
Jest to poziom (w bajtach) przy którym port ESP zrobi "flow on" dla zdalnego
nadajnika (tzn. powie mu by wznowi³ nadawanie bajtów) po "flow off".
Dostêpne warto¶ci to 1 do 1023. Warto¶æ ta powinna byæ mniejsza ni¿ poziom
"flow off", lecz wiêksza ni¿ poziom wyzwalania odbiorczego.
.TP
.B rx_timeout
Jest to ilo¶æ czasu, przez któr± port ESP powinien czekaæ po odebraniu
ostatniego znaku przed sygnalizowaniem przerwania. Prawid³owe warto¶ci to 0
do 255. Zbyt du¿a warto¶æ zwiêkszy opó¼nienia, a zbyt ma³a spowoduje
niepotrzebne przerwania.

.SH UWAGA
UWAGA: Skonfigurowanie portu szeregowego tak, by u¿ywa³ nieprawid³owego
portu I/O mo¿e zablokowaæ twoj± maszynê.
.SH PLIKI
.BR /etc/rc.local
.BR /etc/rc.serial
.SH "ZOBACZ TAK¯E"
.BR tty (4),
.BR ttys (4),
kernel/chr_drv/serial.c
.SH AUTOR
Oryginalna wersja setserial zosta³a napisana przez Ricka Sladkeya
(jrs@world.std.com) i zosta³a zmodyfikowana przez Michaela K. Johnsona
(johnsonm@stolaf.edu).

Ta wersja zosta³a od tej pory napisana ponownie od zera przez Theodore Ts'o
(tytso@mit.edu) 1/1/93. Wszelkie b³êdy i problemy s± wy³±cznie jego
odpowiedzialno¶ci±.
