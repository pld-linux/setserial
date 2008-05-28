Summary:	Serial interface configuration program
Summary(de.UTF-8):	Konfigurationsprogramm für die serielle Schnittstelle
Summary(es.UTF-8):	Programa de configuración de interface serial
Summary(fr.UTF-8):	Programme de configuration de l'interface série
Summary(pl.UTF-8):	Program konfigurujący interfejsy szeregowe
Summary(pt_BR.UTF-8):	Programa de configuração de interface serial
Summary(ru.UTF-8):	Программа для конфигурации последовательных интерфейсов
Summary(tr.UTF-8):	Seri arayüz ayarlama programı
Summary(uk.UTF-8):	Програма для конфігурації послідовних інтерфейсів
Summary(zh_CN.UTF-8):	[系统]配置串口的工具
Summary(zh_TW.UTF-8):	[-A系$)B統]-A配置$)B串-A口$)B的-A工$)B具
Name:		setserial
Version:	2.17
Release:	17
License:	GPL
Group:		Applications/System
Source0:	ftp://tsx-11.mit.edu/pub/linux/sources/sbin/%{name}-%{version}.tar.gz
# Source0-md5:	c4867d72c41564318e0107745eb7a0f2
Source1:	%{name}-rc.serial
Source2:	%{name}.8.pl
BuildRequires:	autoconf
BuildRequires:	groff
Requires:	rc-scripts
ExcludeArch:	s390 s390x
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
Setserial is a program which allows you to look at and change various
attributes of a serial device, including its port, its IRQ, and other
serial port options. All parameters for automated setup serial port on
startup You can put in /etc/sysconfig/serial in format:

/dev/<serial_device> <setup parameters>

%description -l de.UTF-8
Setserial ist ein Programm zum Einsehen und Ändern verschiedener
Attribute eines seriellen Geräts, z.B. Port, IRQ und andere Optionen
des seriellen Ports.

%description -l es.UTF-8
setserial es un programa que permite visualizar y alterar varios
atributos de un dispositivo serial, incluyendo puerto, IRQ, y otras
opciones.

%description -l fr.UTF-8
setserial est un programme permettant de consulter et de modifier les
différents attributs d"un périphérique série, dont son port, son IRQ
et autres options du port série.

%description -l pl.UTF-8
Setserial umożliwia odczytanie i zmianę wielu parametrów portu
szeregowego (adres, przerwanie itp.). Wszystkie parametry dotyczące
ustawiania parametrów portów szeregowych w trakcie startu systemu
można wstawiać do pliku /etc/sysconfig/serial w formacie:

/dev/<urządzenie> <parametry>

%description -l pt_BR.UTF-8
O setserial é um programa que permite visualizar e alterar vários
atributos de um dispositivo serial, incluindo porta, IRQ, e outras
opções.

%description -l tr.UTF-8
Setserial, bir seri aygıtın bağlantı noktası, kesme numarası gibi
özelliklerini denetlemenizi ve değiştirmenizi sağlayan bir programdır.


%prep
%setup -q

%build
%{__autoconf}
%configure
%{__make}

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT/{bin,%{_mandir}/{man8,pl/man8},etc/{rc.d/init.d,sysconfig}}

install setserial $RPM_BUILD_ROOT/bin
install setserial.8 $RPM_BUILD_ROOT%{_mandir}/man8
install %{SOURCE2} $RPM_BUILD_ROOT%{_mandir}/pl/man8/setserial.8

install serial.conf $RPM_BUILD_ROOT/etc/sysconfig/serial

cat << EOF > $RPM_BUILD_ROOT/etc/sysconfig/serial
# File format:
# /dev/<serial_device>	<setup parameters>

EOF
install %{SOURCE1} $RPM_BUILD_ROOT/etc/rc.d/rc.serial

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc README
%attr(755,root,root) /bin/setserial
%attr(754,root,root) /etc/rc.d/rc.serial
%attr(640,root,root) %config(noreplace) %verify(not md5 mtime size) /etc/sysconfig/*

%{_mandir}/man8/*
%lang(pl) %{_mandir}/pl/man8/*
