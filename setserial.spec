Summary:	Serial interface configuration program
Summary(de):	Konfigurationsprogramm f�r die serielle Schnittstelle
Summary(fr):	Programme de configuration de l'interface s�rie
Summary(pl):	Program konfiguruj�cy interfejsy szeregowe
Summary(tr):	Seri aray�z ayarlama program�
Name:		setserial
Version:	2.15
Release:	8
Copyright:	GPL
Group:		Utilities/System
Group(pl):	Narz�dzia/System
Source0:	ftp://sunsite.unc.edu/pub/Linux/system/serial/%{name}-%{version}.tar.gz
Source1:	setserial-rc.serial
Source2:	setserial.8.pl
Patch0:		%{name}.patch
Patch1:		%{name}-debian.patch
Prereq:		/sbin/chkconfig
Buildroot:	/tmp/%{name}-%{version}-root

%description
Setserial is a program which allows you to look at and change various
attributes of a serial device, including its port, its IRQ, and other
serial port options. All parameters for automated setup serial port on
startup You can put in /etc/sysconfig/serial in format:

/dev/<serial_device>	<setup parameters>

%description -l de
Setserial ist ein Programm zum Einsehen und �ndern verschiedener Attribute
eines seriellen Ger�ts, z.B. Port, IRQ und andere Optionen des seriellen
Ports.

%description -l fr
setserial est un programme permettant de consulter et de modifier les
diff�rents attributs d"un p�riph�rique s�rie, dont son port, son IRQ et
autres options du port s�rie.

%description -l pl
Setserial umo�liwia odczytanie i zmian� wielu parametr�w portu szeregowego
(adres, przerwanie itp.). Wszystkie parametry dotycz�ce ustawiania
parametr�w port�w szeregowych w trakcie startu systemu mo�na wstawia� do
pliku /etc/sysconfig/serial w formacie:

/dev/<urz�dzenie>	<parametry>

%description -l tr
Setserial, bir seri ayg�t�n ba�lant� noktas�, kesme numaras� gibi
�zelliklerini denetlemenizi ve de�i�tirmenizi sa�layan bir programd�r.

%prep
%setup -q
%patch0 -p1
%patch1 -p1

%build
autoconf
LDFLAGS="-s"; export LDFLAGS
%configure
make   

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

gzip -9fn $RPM_BUILD_ROOT%{_mandir}/{man8/*,pl/man8/*} \
	README 

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc README.gz 

%attr(755,root,root) /bin/setserial
%attr(754,root,root) /etc/rc.d/rc.serial
%attr(640,root,root) %config %verify(not size mtime md5) /etc/sysconfig/*

%{_mandir}/man8/*
%lang(pl) %{_mandir}/pl/man8/*
