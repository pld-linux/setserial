Summary:     Serial interface configuration program
Name: 	     setserial
Version:     2.15
Release:     2d
Copyright:   GPL
Group: 	     Utilities/System
Group(pl):   U¿ytki/System
URL:         ftp://sunsite.unc.edu/pub/Linux/system/serial
Source:      %{name}-%{version}.tar.gz
Patch: 	     %{name}.patch
Buildroot:   /var/tmp/%{name}-%{version}-root
Prereq:	     /sbin/chkconfig
Summary(de): Konfigurationsprogramm für die serielle Schnittstelle
Summary(fr): Programme de configuration de l'interface série
Summary(pl): Program konfiguruj±cy interfejsy szeregowe
Summary(tr): Seri arayüz ayarlama programý

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
./configure --prefix=/usr

make   

%install
rm -rf $RPM_BUILD_ROOT

install -d $RPM_BUILD_ROOT/{bin,usr/man/man8,etc/rc.d/init.d}

install setserial $RPM_BUILD_ROOT/bin
install setserial.8 $RPM_BUILD_ROOT/usr/man/man8
install serial.conf $RPM_BUILD_ROOT/etc

bzip2 -9 $RPM_BUILD_ROOT/usr/man/man8/*

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc README 

%attr(711,root,root) /bin/setserial
%attr(640,root,root) %config(noreplace) %verify(not size mtime md5) /etc/*.conf
%attr(644,root, man) /usr/man/man8/*

%changelog
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

* Thu May 07 1998 Prospector System <bugs@redhat.com>

- translations modified for de, fr, tr


* Thu Oct 23 1997 Donnie Barnes <djb@redhat.com>

- pulled into distribution
- used setserial-2.12_CTI.tgz instead of setserial-2.12.tar.gz (former is
  all that sunsite has) - not sure what the difference is.

* Thu Sep 25 1997 Christian 'Dr. Disk' Hechelmann <drdisk@ds9.au.s.shuttle.de>
- added %attr's
- added sanity check for RPM_BUILD_ROOT
- setserial is now installed into /bin, where util-linux puts it and all
  startup scripts expect it.
