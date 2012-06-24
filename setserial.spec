Summary:	Serial interface configuration program
Summary(de):	Konfigurationsprogramm f�r die serielle Schnittstelle
Summary(es):	Programa de configuraci�n de interface serial
Summary(fr):	Programme de configuration de l'interface s�rie
Summary(pl):	Program konfiguruj�cy interfejsy szeregowe
Summary(pt_BR):	Programa de configura��o de interface serial
Summary(ru):	��������� ��� ������������ ���������������� �����������
Summary(tr):	Seri aray�z ayarlama program�
Summary(uk):	�������� ��� ���Ʀ����æ� ���̦������ ��������Ӧ�
Summary(zh_CN):	[ϵͳ]���ô��ڵĹ���
Summary(zh_TW):	[-A�t$)B��]-A�t�m$)B��-A�f$)B��-A�u$)B��
Name:		setserial
Version:	2.17
Release:	9
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
Setserial ist ein Programm zum Einsehen und �ndern verschiedener
Attribute eines seriellen Ger�ts, z.B. Port, IRQ und andere Optionen
des seriellen Ports.

%description -l es
setserial es un programa que permite visualizar y alterar varios
atributos de un dispositivo serial, incluyendo puerto, IRQ, y otras
opciones.

%description -l fr
setserial est un programme permettant de consulter et de modifier les
diff�rents attributs d"un p�riph�rique s�rie, dont son port, son IRQ
et autres options du port s�rie.

%description -l pl
Setserial umo�liwia odczytanie i zmian� wielu parametr�w portu
szeregowego (adres, przerwanie itp.). Wszystkie parametry dotycz�ce
ustawiania parametr�w port�w szeregowych w trakcie startu systemu
mo�na wstawia� do pliku /etc/sysconfig/serial w formacie:

/dev/<urz�dzenie> <parametry>

%description -l pt_BR
O setserial � um programa que permite visualizar e alterar v�rios
atributos de um dispositivo serial, incluindo porta, IRQ, e outras
op��es.

%description -l tr
Setserial, bir seri ayg�t�n ba�lant� noktas�, kesme numaras� gibi
�zelliklerini denetlemenizi ve de�i�tirmenizi sa�layan bir programd�r.


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
%attr(640,root,root) %config(noreplace) %verify(not size mtime md5) /etc/sysconfig/*

%{_mandir}/man8/*
%lang(pl) %{_mandir}/pl/man8/*
