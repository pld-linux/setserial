Summary:	Serial interface configuration program
Summary(de):	Konfigurationsprogramm für die serielle Schnittstelle
Summary(fr):	Programme de configuration de l'interface série
Summary(pl):	Program konfiguruj±cy interfejsy szeregowe
Summary(ru): ğÒÏÇÒÁÍÍÁ ÄÌÑ ËÏÎÆÉÇÕÒÁÃÉÉ ĞÏÓÌÅÄÏ×ÁÔÅÌØÎÙÈ ÉÎÔÅÒÆÅÊÓÏ×
Summary(tr):	Seri arayüz ayarlama programı
Summary(uk):	ğÒÏÇÒÁÍÁ ÄÌÑ ËÏÎÆ¦ÇÕÒÁÃ¦§ ĞÏÓÌ¦ÄÏ×ÎÉÈ ¦ÎÔÅÒÆÅÊÓ¦×
Name:		setserial
Version:	2.17
Release:	7
License:	GPL
Group:		Applications/System
Source0:	ftp://sunsite.unc.edu/pub/Linux/system/serial/%{name}-%{version}.tar.gz
Source1:	%{name}-rc.serial
Source2:	%{name}.8.pl
Requires:	rc-scripts
BuildRequires:	autoconf
Buildrequires:	groff
ExcludeArch:	s390 s390x
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
Setserial is a program which allows you to look at and change various
attributes of a serial device, including its port, its IRQ, and other
serial port options. All parameters for automated setup serial port on
startup You can put in /etc/sysconfig/serial in format:

/dev/<serial_device> <setup parameters>

%description -l de
Setserial ist ein Programm zum Einsehen und Ändern verschiedener
Attribute eines seriellen Geräts, z.B. Port, IRQ und andere Optionen
des seriellen Ports.

%description -l fr
setserial est un programme permettant de consulter et de modifier les
différents attributs d"un périphérique série, dont son port, son IRQ
et autres options du port série.

%description -l pl
Setserial umo¿liwia odczytanie i zmianê wielu parametrów portu
szeregowego (adres, przerwanie itp.). Wszystkie parametry dotycz±ce
ustawiania parametrów portów szeregowych w trakcie startu systemu
mo¿na wstawiaæ do pliku /etc/sysconfig/serial w formacie:

/dev/<urz±dzenie> <parametry>

%description -l tr
Setserial, bir seri aygıtın bağlantı noktası, kesme numarası gibi
özelliklerini denetlemenizi ve değiştirmenizi sağlayan bir programdır.


%prep
%setup -q

%build
autoconf
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

gzip -9nf README

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc *.gz
%attr(755,root,root) /bin/setserial
%attr(754,root,root) /etc/rc.d/rc.serial
%attr(640,root,root) %config %verify(not size mtime md5) /etc/sysconfig/*

%{_mandir}/man8/*
%lang(pl) %{_mandir}/pl/man8/*
