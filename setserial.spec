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

%changelog
* Thu Feb 18 1999 Wojtek ¦lusarczyk <wojtek@shadow.eu.org>
  [2.15-4d]
- compressed documentation,
- fixed Group.

* Thu Feb 18 1999 Arkadiusz Mi¶kiewicz <misiek@misiek.eu.org>
  [2.15-3d]
- configuration file in new location

* Thu Dec 24 1998 Arkadiusz Mi¶kiewicz <misiek@misiek.eu.org>
  [2.15-2d]
- removed /etc/rc.d/init.d/serial (this is now done by rc-scripts).

* Sat Nov 07 1998 Arkadiusz Mi¶kiewicz <misiek@misiek.eu.org>
  [2.15-1d]
- new upstream release (2.15),
- added /etc/rc.d/init.d/serial and /etc/serial.conf,
- added Group(pl),
- added %post and %preun.

* Mon Oct 26 1998 Wojtek ¦lusarczyk <wojtek@shadow.eu.org>
  [2.14-1d]
- updated to 2.14,
- minor changes.

* Sun Oct 18 1998 Marcin Korzonek <mkorz@shadow.eu.org>
  [2.12-5d]
- translations modified for pl,
- defined files permission,
- simplifications in %build and %install section.

* Thu Jul 23 1998 Wojtek ¦lusarczyk <wojtek@shadow.eu.org>
  [2.12-5]
- build against GNU libc-2.1.
