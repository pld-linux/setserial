Summary:	Serial interface configuration program
Summary(de):	Konfigurationsprogramm für die serielle Schnittstelle
Summary(fr):	Programme de configuration de l'interface série
Summary(pl):	Program konfiguruj±cy interfejsy szeregowe
Summary(tr):	Seri arayüz ayarlama programý
Name:		setserial
Version:	2.15
Release:	4d
Copyright:	GPL
Group:		Utilities/System
Group(pl):	Narzêdzia/System
URL:		ftp://sunsite.unc.edu/pub/Linux/system/serial
Source:		%{name}-%{version}.tar.gz
Patch0:		%{name}.patch
Prereq:		/sbin/chkconfig
Buildroot:	/tmp/%{name}-%{version}-root

%description
Setserial is a program which allows you to look at and change various
attributes of a serial device, including its port, its IRQ, and other
serial port options.

%description -l de
Setserial ist ein Programm zum Einsehen und Ändern verschiedener
Attribute eines seriellen Geräts, z.B. Port, IRQ und andere 
Optionen des seriellen Ports.

%description -l fr
setserial est un programme permettant de consulter et de modifier les
différents attributs d"un périphérique série, dont son port, son IRQ et
autres options du port série.

%description -l pl
Setserial umo¿liwia odczytanie i zmianê wielu parametrów portu
szeregowego (adres, przerwanie itp.)

%description -l tr
Setserial, bir seri aygýtýn baðlantý noktasý, kesme numarasý gibi
özelliklerini denetlemenizi ve deðiþtirmenizi saðlayan bir programdýr.

%prep
%setup -q
%patch -p1

%build
autoconf
CFLAGS=$RPM_OPT_FLAGS LDFLAGS=-s \
    ./configure %{_target_platform} \
	--prefix=/usr
make   

%install
rm -rf $RPM_BUILD_ROOT

install -d $RPM_BUILD_ROOT/{bin,usr/man/man8,etc/{rc.d/init.d,sysconfig}}

install setserial $RPM_BUILD_ROOT/bin
install setserial.8 $RPM_BUILD_ROOT%{_mandir}/man8
install serial.conf $RPM_BUILD_ROOT/etc/sysconfig/serial

gzip -9fn $RPM_BUILD_ROOT%{_mandir}/man8/*
bzip2 -9  README 

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc README.bz2 

%attr(755,root,root) /bin/setserial
%attr(640,root,root) %config %verify(not size mtime md5) /etc/sysconfig/*
%{_mandir}/man8/*
