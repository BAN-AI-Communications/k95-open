# CKOKER.MAK, Version 6.00
# See CKOMAK.HLP for further information.
# Authors: 
#   Jeffrey Altman, Frank da Cruz, Columbia University, New York City, USA
#
# Last update: 
#
# -- Makefile to build C-Kermit 5A(192) for OS/2 and Windows NT --
#
# The result is a runnable program called CKOKER32.EXE (OS/2) or CKNKER.EXE
# (NT) in the current directory.  Or if you "make winsetup", SETUP.EXE.
#
# To override the following definitions without having to edit this file,
# define them as environment variables and then run NMAKE with the /E switch.

# which operating system
PLATFORM= NT

# IBM VisualAge Libs
VISUALAGE = C:\IBMCXX0

# for IBM TCP/IP 1.2.1
IBM12DIR  = C:\TCPIP
IBM12LIBS = $(IBM12DIR)\lib\tcpipdll.lib
IBM12INC  = $(IBM12DIR)\include

# for IBM TCP/IP 2.0
IBM20DIR  = C:\TCPIP
IBM20LIBS = $(IBM20DIR)\lib\tcp32dll.lib $(IBM20DIR)\lib\so32dll.lib
IBM20INC  = $(IBM20DIR)\include

# for FTP PC/TCP 1.3
FTP13DIR  = C:\DEVKIT
FTP13LIBS32 = $(FTP13DIR)\lib\socket32.lib
FTP13LIBS16 = $(FTP13DIR)\lib\socket16.lib
FTP13INC  = $(FTP13DIR)\include

# for Novell LAN Workplace 3.0
LWP30DIR  = C:\LANWP\TOOLKIT
LWP30LIBS32 = $(LWP30DIR)\os2lib20\socklib.lib 
LWP30INC    = $(LWP30DIR)\inc20


#---------- Compiler targets:
#
# To build: "[dn]make <target>"

unknown:
	@echo Please specify target: "ibmc", "msvc" or "clean"

#    IMPORTANT: When building with TCP/IP support, edit the IBM-supplied
#    TCPIP\INCLUDE\NETLIB.H to remove the spurious #define for SIGALRM!
#    Similarly, the FTP Software PC/TCP devkit header files will need some
#    editing to correct far vs _far confusion.

# IBM C Set++ 2.x (32-bit) with static linking -- no DLL's required.
# Which is good, because otherwise users would need to have the IBM
# OS/2 development system C libraries on their PCs.
# - Current CSDs are CTC0011 and CTU0003
# - Current LINK386 is 2.01.016
#
# -G4 optimizes for the i486 pipeline.  It might make the program run a bit
# faster on 486 and above, but it also increases the size of .EXE by about
# 30K.  The result still runs OK on i386 processors.
# Add -G4 to the CC= line below if you want i486 optimization.
#
# msgbind does not use any environment variables to find DDE4.MSG.  Therefore,
# its path (on the system where you are building C-Kermit) must be edited into
# CKOKER.MSB, or the DDE4.MSG file must be copied into the current directory.
# It is normally found in IBMCPP\HELP.

telnet:
	$(MAKE) -f ckoker.mak wtelnet \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/Ot /Og /Oi /G4" \
    DEBUG="-DNDEBUG" \
    DLL="" \
    CFLAGS=" /MD /Ze /GX- /YX /J /DWIN32 /D_WIN32 /D_CONSOLE /D__32BIT__ /W2" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="-c" \
    LINKFLAGS="/nologo /align:0x1000 /SUBSYSTEM:console" \
	DEF="wtelnet.def"


rlogin:
	$(MAKE) -f ckoker.mak wrlogin \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/Ot /Og /Oi /G4" \
    DEBUG="-DNDEBUG" \
    DLL="" \
    CFLAGS=" /MD /Ze /GX- /YX /J /DWIN32 /D_WIN32 /D_CONSOLE /D__32BIT__ /W2" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="-c" \
    LINKFLAGS="/nologo /align:0x1000 /SUBSYSTEM:console" \
	DEF="wrlogin.def"

# release version
test:
	$(MAKE) -f ckoker.mak wtest \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/Ot /Og /Oi /G4" \
    DEBUG="-DNDEBUG" \
    DLL="" \
    CFLAGS=" /MD /Ze /GX- /YX /J /DWIN32 /D_CONSOLE /D__32BIT__ /W2" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="-c" \
    LINKFLAGS="/nologo /align:0x1000 /SUBSYSTEM:console" \
	DEF="wtest.def"

winsetup:
	$(MAKE) -f ckoker.mak wsetup \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/Ot /Og /Oi /G4" \
    DEBUG="-DNDEBUG" \
    DLL="" \
    CFLAGS=" /MD /Ze /GX- /YX /J /D_WIN32 /DOS2 /DNT /D_CONSOLE /D__32BIT__ /W2 /D_WIN32_WINNT=0x0400" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="-c" \
    LINKFLAGS="/nologo /align:0x1000 /SUBSYSTEM:console /OPT:REF" \
	DEF="wsetup.def"

# release version
msvc:
	$(MAKE) -f ckoker.mak win32 \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/G5 /Ox /GA" \
    DEBUG="-DNDEBUG" \
    DLL="" \
    CFLAGS=" /MD /Ze /GX- /GF /YX /J /D_WIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /Fm /F65536" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="/c" \
    LINKFLAGS="/nologo /SUBSYSTEM:console /MAP /OPT:REF" DEF="cknker.def"

# release version
msvc-iksd:
     $(MAKE) -f ckoker.mak iksdnt \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/G5 /Ox /GA" \
    DEBUG="-DNDEBUG" \
    DLL="" \
    CFLAGS=" /MD /Ze /GX- /GF /YX /J /DWIN32 /D_WIN32_WINNT=0x0400  /D_CONSOLE /D__32BIT__ /W2 /Fm /F65536" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="/c" \
    LINKFLAGS="/nologo /SUBSYSTEM:console /MAP /OPT:REF" DEF="cknker.def"

# debug version
msvcd:
        $(MAKE) -f ckoker.mak win32 \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
	OPT="" \
    DEBUG="/Zi /Odi /Ge " \
    DLL="" \
	CFLAGS="/MD /Ze /GX- /GF /GZ /YX /J /DWIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /F65536" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="/c" \
    LINKFLAGS="/nologo /SUBSYSTEM:console /MAP /DEBUG:full /WARN:3 /FIXED:NO /PROFILE /OPT:REF" \
	DEF="cknker.def"

# debug version
msvcd-iksd:
        $(MAKE) -f ckoker.mak iksdnt \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
	OPT="" \
    DEBUG="/Zi /Odi /Ge " \
    DLL="" \
	CFLAGS="/MD /Ze /GX- /GF /GZ /YX /J /DWIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /F65536" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="/c" \
    LINKFLAGS="/nologo /SUBSYSTEM:console /MAP /DEBUG:full /WARN:3 /FIXED:NO /PROFILE /OPT:REF" \
	DEF="cknker.def"

# memory debug version
msvcmd:
        $(MAKE) -f ckoker.mak win32md \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
	OPT="" \
    DEBUG="/Zi /Odi /Ge -Dmalloc=dmalloc -Dfree=dfree -DMDEBUG" \
    DLL="" \
	CFLAGS=" /MD /Ze /GX- /YX /J /DWIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /F65536" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="/c" \
    LINKFLAGS="/nologo /SUBSYSTEM:console /MAP /DEBUG:full /WARN:3 /FIXED:NO /PROFILE" \
	DEF="cknker.def"

# profile version
msvcp:
        $(MAKE) -f ckoker.mak win32 \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/G5 /Ob1 /Oi /GA" \
    DEBUG="-DNDEBUG" \
    DLL="" \
    CFLAGS=" /MD /Ze /GX- /YX /J /DWIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /Fm /F65536" \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="/c" \
    LINKFLAGS="/nologo /align:0x1000 /SUBSYSTEM:console /MAP /FIXED:NO /PROFILE" \
	DEF="cknker.def"

# kui debug version
kuid:
	$(MAKE) -f ckoker.mak win32kui \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
	OPT="" \
    DEBUG="/Zi /Odi" \
    DLL="" \
	CFLAGS=" /MD /Ze /GX- /YX /GF /J /DKUI /DCK_WIN /DWIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /Zp4 -I." \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="-c" \
    LINKFLAGS="/nologo /align:0x1000 /DEBUG:full /SUBSYSTEM:windows" \
	DEF="cknker.def"

kui:
	$(MAKE) -f ckoker.mak win32kui \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/G5 /Ox /GA" \
    DEBUG="-DNDEBUG" \
    DLL="" \
	CFLAGS=" /MD /Ze /GX- /YX /J /DKUI /DCK_WIN /DWIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /I." \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="-c" \
    LINKFLAGS="/nologo /align:0x1000 /SUBSYSTEM:windows" \
	DEF="cknker.def"

# k95g debug version
k95gd:
	$(MAKE) -f ckoker.mak win32k95g \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
	OPT="" \
    DEBUG="/Zi /Odi" \
    DLL="" \
	CFLAGS=" /MD /Ze /GX- /YX /J /DKUI /DK95G /DCK_WIN /DWIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /Zp4 -I." \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="-c" \
    LINKFLAGS="/nologo /align:0x1000 /MAP /DEBUG:full /SUBSYSTEM:windows" \
	DEF="cknker.def"

k95g:
	$(MAKE) -f ckoker.mak win32k95g \
	CC="cl /nologo" \
    CC2="" \
    OUT="-Fe" O=".obj" \
    OPT="/G5 /Ox /GA" \
    DEBUG="-DNDEBUG" \
    DLL="" \
	CFLAGS="/MD /Ze /GX- /YX /J /DKUI /DK95G /DCK_WIN /DWIN32 /D_WIN32_WINNT=0x0400 /D_CONSOLE /D__32BIT__ /W2 /I." \
    LDFLAGS="" \
    PLATFORM="NT" \
    NOLINK="-c" \
    LINKFLAGS="/nologo /align:0x1000 /SUBSYSTEM:windows" \
	DEF="cknker.def"


# release version
#         CC2="-Fi+ -Si+ -Gi+ -Gl+" \
#         add /Gn+ back to hide the default library info after I figure out how to build the runtime library dll

ibmc:
	$(MAKE) -f ckoker.mak os232 \
	CC="icc -q" \
        CC2="-Fi+ -Si+ -Gi+" \
        OUT="-Fe" O=".obj" \
	OPT="-O -Oi25" \
        DEBUG="-Gs -DNDEBUG" \
        DLL="-Gt- /Ge-" \
	CFLAGS="-Sp1 -Sm -Gm -G5 -Gt -Gd -J" \
        LDFLAGS="" \
        PLATFORM="OS2" \
        NOLINK="-c" \
!ifdef WARP
        WARP="YES" \
        LINKFLAGS="/nologo /noi /align:16 /base:0x10000" \
!else
        LINKFLAGS="/nologo /noi /align:16 /base:0x10000" \
!endif
	DEF="ckoker32.def"

# source browser
ibmsb:
	$(MAKE) -f ckoker.mak os232 \
	CC="sb" \
        CC2="" \
        OUT="-Fo" O="._sb" \
	OPT="" \
        DEBUG="" \
        DLL="" \
	CFLAGS="" \
        LDFLAGS="" \
        PLATFORM="OS2" \
        NOLINK="" \
!ifdef WARP
        WARP="YES" \
!endif
        LINKFLAGS="" \
	DEF=""

# profiling version
ibmcp:
	$(MAKE) -f ckoker.mak os232 \
	CC="icc -q" \
        CC2="-Fi+ -Si+ -Gi+ /Gl+"\
        OUT="-Fe" O=".obj" \
	OPT="-O -Oi25" \
        DEBUG="-Gh -Ti -DNDEBUG" \
        DLL="-Gt- /Ge-" \
	CFLAGS="-Sp1 -Sm -Gm -G5 -Gt -Gd -J" \
        LDFLAGS="dde4xtra.obj" \
        PLATFORM="OS2" \
        NOLINK="-c" \
        LINKFLAGS="/nologo /noi /align:16 /base:0x10000" \
	DEF="ckoker32.def"

# debugging version
ibmcd:
	$(MAKE) -f ckoker.mak os232 \
	CC="icc -q" \
        CC2=""\
        OUT="-Fe" O=".obj" \
	OPT="" \
        DEBUG="-Ti+ -Tx+ -Tm+ -D__DEBUG" \
        DEBUG2="/Wcmp /Wcnd /Wcns /Wdcl \
            /Weff /Wenu /Wext /Wgnr /Word /Wpar /Wppc /Wpro /Wrea \
            /Wret /Wtrd /Wund /Wuni /Wuse" \
        DLL="-Gt- /Ge-" \
	CFLAGS="-Sp1 -Sm -Gm -G5 -Gt -Gd -J" \
        PLATFORM="OS2" \
        LDFLAGS="" \
        NOLINK="-c" \
        LINKFLAGS="/nologo /noi /align:16 /base:0x10000 /debug /dbgpack" \
	DEF="ckoker32.def"

#---------- Macros:

# To build without NETWORK support, uncomment the following line and
# then comment out the next: (save 60K)
!if "$(PLATFORM)" == "OS2"
#DEFINES = -DOS2 -DDYNAMIC -DKANJI -DOS2MOUSE -DPCFONTS\
#          -DONETERMUPD 
!else if "$(PLATFORM)" == "NT"
#DEFINES = -DNT -DOS2 -DDYNAMIC -DKANJI -DOS2MOUSE \
#          -DONETERMUPD
!endif /* PLATFORM */

# To build with NETWORK support, uncomment the following three 
# lines and comment out the previous set:
!ifdef PLATFORM
!if "$(PLATFORM)" == "OS2"
DEFINES = -DOS2 -DDYNAMIC -DKANJI -DNETCONN -DDECNET -DTCPSOCKET \
          -DNPIPE -DOS2MOUSE -DCK_NETBIOS -DHADDRLIST -DPCFONTS \
          -DRLOGCODE -DNETFILE -DONETERMUPD -DZLIB \
           -DLIBDES -DCRYPT_DLL -DPRE_SRP_1_7_3 -DBETATEST 
           
!else if "$(PLATFORM)" == "NT"
!ifndef K95BUILD
K95BUILD = K95
!endif
!if "$(K95BUILD)" == "TLSONLY"
DEFINES = -DNT -D__STDC__ -DWINVER=0x0400 -DOS2 -DNOSSH \
          -DDYNAMIC -DNETCONN -DHADDRLIST -DOS2MOUSE -DTCPSOCKET -DRLOGCODE \
          -DNETFILE -DONETERMUPD -DNO_ENCRYPTION -DZLIB \
          -DNO_SRP -DNO_KERBEROS -DBETATEST
!else if "$(K95BUILD)" == "UIUC"
DEFINES = -DNT -D__STDC__ -DWINVER=0x0400 -DOS2 -DNOSSH \
          -DDYNAMIC -DNETCONN -DHADDRLIST -DOS2MOUSE -DTCPSOCKET -DRLOGCODE \
          -DNETFILE -DONETERMUPD -DLIBDES -DCRYPT_DLL -DZLIB \
          -DNOXFER -DNODIAL -DNOHTTP -DNOFORWARDX -DNOBROWSER -DNOLOGIN \
          -DNOCYRIL -DNOKANJI -DNOHEBREW -DNOGREEK -DNOLOGIN -DNOIKSD -DNOHELP \
          -DNOSOCKS -DNONETCMD -DNO_SRP -DNO_SSL -DNOFTP -DBETATEST \
          -DNODEBUG -DCK_TAPI -DNOPUSH -DNO_COMPORT -DNOXMIT -DNOSCRIPT
!else if "$(K95BUILD)" == "IKSD"
DEFINES = -DNT -D__STDC__ -DWINVER=0x0400 -DOS2 -DNOSSH -DONETERMUPD \
          -DDYNAMIC -DKANJI -DNETCONN -DIKSDONLY -DZLIB \
          -DHADDRLIST -DCK_LOGIN -DLIBDES -DCRYPT_DLL \
          #-DBETATEST # -DPRE_SRP_1_7_3
!else
DEFINES = -DNT -D__STDC__ -DWINVER=0x0400 -DOS2 \
          -DDYNAMIC -DKANJI -DNETCONN -DDECNET -DSUPERLAT \
          -DHADDRLIST -DNPIPE -DOS2MOUSE -DTCPSOCKET -DRLOGCODE -DZLIB \
          -DNETFILE -DONETERMUPD -DLIBDES -DCRYPT_DLL \
          -DNEWFTP #-DBETATEST -DSFTP_BUILTIN # -DPRE_SRP_1_7_3 -DCK_NETBIOS -DNEW_URL_HIGHLIGHT 
!endif
!endif  /* PLATFORM */
!else
! ERROR Macro named PLATFORM undefined
!endif

!ifdef PLATFORM
!if "$(PLATFORM)" == "OS2"
LIBS = os2386.lib rexx.lib libsrp.lib bigmath.lib 
!else if "$(PLATFORM)" == "NT"
!if "$(K95BUILD)" == "UIUC"
LIBS = kernel32.lib user32.lib gdi32.lib wsock32.lib \
       winmm.lib mpr.lib advapi32.lib winspool.lib \
       wshload.lib
!else
KUILIBS = kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib \
        advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib \
        rpcrt4.lib rpcns4.lib wsock32.lib \
        winmm.lib vdmdbg.lib comctl32.lib mpr.lib commode.obj \
        wshload.lib srpstatic.lib  ssh\libssh.lib ssh\openbsd.lib #msvcrt.lib
        #libsrp.lib bigmath.lib
LIBS = kernel32.lib user32.lib gdi32.lib wsock32.lib shell32.lib\
       winmm.lib mpr.lib advapi32.lib winspool.lib commode.obj \
       srpstatic.lib  wshload.lib ssh\libssh.lib ssh\openbsd.lib #msvcrt.lib  
       # libsrp.lib bigmath.lib
!endif
!endif /* PLATFORM */
!endif

#---------- Inference rules:

.SUFFIXES: .w .c $(O)

.c$(O):
	$(CC) $(CC2) $(CFLAGS) $(DEBUG) $(OPT) $(DEFINES) $(NOLINK) $*.c

#---------- Targets:

OBJS =  ckcmai$(O) ckcfns$(O) ckcfn2$(O) ckcfn3$(O) ckcnet$(O) ckcpro$(O) \
        ckucmd$(O) ckudia$(O) ckofio$(O) ckuscr$(O) ckuusr$(O) ckuus2$(O) \
        ckuus3$(O) ckuus4$(O) ckuus5$(O) ckuus6$(O) ckuus7$(O) ckuusx$(O) \
        ckuusy$(O) ckuxla$(O) ckclib$(O) ckctel$(O) ckcuni$(O) ckcftp$(O) \
!if "$(PLATFORM)" == "NT"
        cknsig$(O) cknalm$(O) ckntap$(O) cknwin$(O) cknprt$(O)\
!else
        ckusig$(O) \
!endif /* PLATFORM */
        ckuath$(O) ckoath$(O) ck_ssl$(O) ckossl$(O) ckosslc$(O) ckossh$(O) \
        ckosftp$(O) ckozli$(O) \
!if 0
        ck_crp$(O) ck_des$(O) \
!endif
        ckocon$(O) ckoco2$(O) ckoco3$(O) ckoco4$(O) ckoco5$(O) \
        ckoetc$(O) ckoetc2$(O) ckokey$(O) ckomou$(O) ckoreg$(O) \
        ckonet$(O) \
        ckoslp$(O) ckosyn$(O) ckothr$(O) ckotek$(O) ckotio$(O) ckowys$(O) \
        ckodg$(O)  ckoava$(O) ckoi31$(O) ckotvi$(O) ckovc$(O) \
        ckoadm$(O) ckohzl$(O) ckohp$(O) ckoqnx$(O)\
!if "$(PLATFORM)" == "NT"
        cknnbi$(O) \
!else
        ckonbi$(O) \
!endif /* PLATFORM */
        ckop$(O) p_callbk$(O) p_global$(O) p_omalloc$(O) p_error$(O) \
        p_common$(O) p_tl$(O) p_dir$(O)

#OUTDIR = \kui\win95
KUIOBJS = \
    $(OUTDIR)\kregedit.obj $(OUTDIR)\ksysmets.obj     \
    $(OUTDIR)\ksplash.obj  $(OUTDIR)\ikui.obj     $(OUTDIR)\kprogres.obj \
    $(OUTDIR)\ikterm.obj   $(OUTDIR)\ikcmd.obj    $(OUTDIR)\kuidef.obj   \
    $(OUTDIR)\karray.obj   $(OUTDIR)\khwndset.obj $(OUTDIR)\kwin.obj     \
    $(OUTDIR)\kszpopup.obj $(OUTDIR)\kflstat.obj  $(OUTDIR)\kcustdlg.obj \
    $(OUTDIR)\kmenu.obj    $(OUTDIR)\kstatus.obj  $(OUTDIR)\ktoolbar.obj \
    $(OUTDIR)\kscroll.obj  $(OUTDIR)\kcmdproc.obj $(OUTDIR)\kcmdterm.obj \
    $(OUTDIR)\kcmdprot.obj $(OUTDIR)\kcmdmous.obj $(OUTDIR)\kcmdscri.obj \
    $(OUTDIR)\kcmdup.obj   $(OUTDIR)\kcmddown.obj $(OUTDIR)\kcmdlog.obj  \
    $(OUTDIR)\kcmdcom.obj  $(OUTDIR)\kprop.obj    $(OUTDIR)\kfont.obj    \
    $(OUTDIR)\kfontdlg.obj $(OUTDIR)\kcolor.obj   $(OUTDIR)\kabout.obj   \
    $(OUTDIR)\kflname.obj  $(OUTDIR)\kdwnload.obj $(OUTDIR)\kupload.obj  \
    $(OUTDIR)\kuikey.obj   $(OUTDIR)\kclient.obj  \
    $(OUTDIR)\kcliserv.obj $(OUTDIR)\kappwin.obj  $(OUTDIR)\kcserver.obj \
    $(OUTDIR)\kcommand.obj $(OUTDIR)\ktermin.obj  $(OUTDIR)\kui.obj

PDLLDIR = pdll
PDLLOBJS = \
$(PDLLDIR)\pdll_common.obj \
$(PDLLDIR)\pdll_crc.obj \
$(PDLLDIR)\pdll_dev.obj \
$(PDLLDIR)\pdll_error.obj \
$(PDLLDIR)\pdll_exeio.obj \
$(PDLLDIR)\pdll_global.obj \
$(PDLLDIR)\pdll_main.obj \
$(PDLLDIR)\pdll_omalloc.obj \
$(PDLLDIR)\pdll_r.obj \
$(PDLLDIR)\pdll_ryx.obj \
$(PDLLDIR)\pdll_rz.obj \
$(PDLLDIR)\pdll_s.obj \
$(PDLLDIR)\pdll_syx.obj \
$(PDLLDIR)\pdll_sz.obj \
$(PDLLDIR)\pdll_tcpipapi.obj \
$(PDLLDIR)\pdll_x_global.obj \
$(PDLLDIR)\pdll_z.obj \
$(PDLLDIR)\pdll_z_global.obj \

os232: cko32rtl.dll ckoker32.exe tcp32 otelnet.exe ckoclip.exe orlogin.exe osetup.exe k2crypt.dll  srp-tconf.exe srp-passwd.exe otextps.exe 
# docs pcfonts.dll cksnval.dll 

win32: cknker.exe wtelnet wrlogin k95d textps k95crypt.dll ctl3dins.exe srp-tconf.exe srp-passwd.exe iksdsvc.exe iksd.exe #wreg

win32md: mdnker.exe

win32kui: cknkui.exe

win32k95g: k95g.exe

iksdnt: iksdnt.exe

wsetup: setup.exe

wtest: test.exe

wtelnet: telnet.exe

wrlogin: rlogin.exe

k95d: k95d.exe

wreg: reg.exe

textps: textps.exe

# Remove the DLLs you don't have the Development Kits for:
# IBM TCP/IP 2.0          - cko32i20.dll
# IBM TCP/IP 1.2          - cko32i12.dll 
# FTP Software PC/TCP 1.3 - cko32i13.dll 
# Novell LWP OS/2 3.0     - cko32n30.dll 

tcp32: cko32i20.dll cko32i12.dll cko32f13.dll 
# cko32n30.dll

cknker.exe: $(OBJS) cknker.res $(DEF) ckoker.mak 
#        $(CC) $(CC2) /link "$(LINKFLAGS)" $(DEBUG) $(OBJS) $(DEF) $(OUT) $@ $(LIBS) $(LDFLAGS)
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ $(OBJS) cknker.res $(LIBS) 
<<

iksdnt.exe: $(OBJS) cknker.res $(DEF) ckoker.mak 
#        $(CC) $(CC2) /link "$(LINKFLAGS)" $(DEBUG) $(OBJS) $(DEF) $(OUT) $@ $(LIBS) $(LDFLAGS)
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ $(OBJS) cknker.res $(LIBS) 
<<

mdnker.exe: $(OBJS) ckcmdb$(O) cknker.res $(DEF) ckoker.mak 
#        $(CC) $(CC2) /link "$(LINKFLAGS)" $(DEBUG) ckcmdb$(O) $(OBJS) $(DEF) $(OUT) $@ $(LIBS) $(LDFLAGS)
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ ckcmdb$(O) $(OBJS) cknker.res $(LIBS) 
<<

k95g.exe: $(OBJS) $(KUIOBJS) cknker.res $(DEF) ckoker.mak 
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ $(OBJS) $(KUIOBJS) $(OUTDIR)\kui.res $(KUILIBS) 
<<

cknkui.exe: $(OBJS) $(KUIOBJS) cknker.res $(DEF) ckoker.mak 
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ $(OBJS) $(KUIOBJS) $(OUTDIR)\kui.res $(KUILIBS) 
<<

setup.exe: setup.obj settapi.obj $(DEF) ckoker.mak 
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ setup.obj settapi.obj cknker.res $(LIBS) 
<<

test.exe: test.obj $(DEF) ckoker.mak
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ test.obj cknker.res $(LIBS) 
<<

reg.exe: reg.obj ckoetc.obj ckcuni.obj ckofio.obj ckuxla.obj $(DEF) ckoker.mak
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ reg.obj ckoetc.obj ckoetc2.obj ckuxla.obj ckcuni.obj ckofio.obj cknker.res $(LIBS) 
<<

telnet.exe: telnet.obj $(DEF) ckoker.mak
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ telnet.obj $(LIBS) 
<<

rlogin.exe: rlogin.obj $(DEF) ckoker.mak
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ rlogin.obj $(LIBS) 
<<

orlogin.exe: rlogin.obj $(DEF) ckoker.mak
      	$(CC) $(CC2) /B"$(LINKFLAGS)" rlogin.obj $(OUT) $@ $(LDFLAGS) $(LIBS)

otextps.exe: textps.obj $(DEF) ckoker.mak
      	$(CC) $(CC2) /B"$(LINKFLAGS)" textps.obj $(OUT) $@ $(LDFLAGS) $(LIBS)

k95d.exe: k95d.obj $(DEF) ckoker.mak
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ k95d.obj $(LIBS) 
<<

ctl3dins.exe: ctl3dins.obj $(DEF) ckoker.mak
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ ctl3dins.obj $(LIBS) VERSION.LIB
<<

textps.exe: textps.obj $(DEF) ckoker.mak
       link.exe @<< 
       $(LINKFLAGS) /OUT:$@ textps.obj $(LIBS) 
<<

ckoker32.exe: $(OBJS) $(DEF) ckoker.msb ckoker.res ckoker.mak 
        $(CC) $(CC2) /B"$(LINKFLAGS)" $(DEBUG) $(OBJS) $(DEF) $(OUT) $@ $(LIBS) $(LDFLAGS)
!ifdef WARP
       rc -p -x2 ckoker.res $@
!else
       rc -p -x1 ckoker.res $@
!endif
       dllrname $@ CPPRMI36=CKO32RTL       

cko32rtl.dll: 
        copy $(VISUALAGE)\RUNTIME\CPPRMI36.DLL cko32rtl.dll
        dllrname $@ CPPRMI36=CKO32RTL       

cko32rtl.lib: cko32rtl.dll cko32rt.def cko32rt.c
        ILIB /GI cko32rt.dll
        ILIB /NOBR /OUT:cko32rt.lib $(VISUALAGE)\LIB\CPPRNO36.LIB

cko32i20.dll: ckoi20.obj cko32i20.def ckoker.mak
	$(CC) $(CC2) $(DEBUG) $(DLL) ckoi20.obj cko32i20.def $(OUT) $@ \
	/B"/noe /noi" $(IBM20LIBS) $(LIBS)
        dllrname $@ CPPRMI36=CKO32RTL       

cko32i12.dll: ckoi12.obj cko32i12.def ckoker.mak
	$(CC) $(CC2) $(DEBUG) $(DLL) ckoi12.obj cko32i12.def $(OUT) $@ \
	/B"/noe /noi" $(IBM12LIBS) $(LIBS)
        dllrname $@ CPPRMI36=CKO32RTL       

cko32f13.dll: ckof13.obj cko32f13.def ckoker.mak
	$(CC) $(CC2) $(DEBUG) $(DLL) ckof13.obj cko32f13.def $(OUT) $@ \
	/B"/noe /noi" $(FTP13LIBS32) $(LIBS)
        dllrname $@ CPPRMI36=CKO32RTL       

cko32n30.dll: ckon30.obj cko32n30.def ckoker.mak
	$(CC) $(CC2) $(DEBUG) $(DLL) ckon30.obj cko32n30.def $(OUT) $@ \
	/B"/noe /noi" $(LWP30LIBS32) $(LIBS)
        dllrname $@ CPPRMI36=CKO32RTL       

pcfonts.dll: ckopcf.obj cko32pcf.def ckopcf.res ckoker.mak
	$(CC) $(CC2) $(DEBUG) $(DLL) ckopcf.obj \
        cko32pcf.def $(OUT) $@ $(LIBS)
!ifdef WARP
        rc -p -x2 ckopcf.res pcfonts.dll
!else
        rc -p -x1 ckopcf.res pcfonts.dll
!endif

cksnval.dll: cksnval.obj cksnval.def ckoker.mak
	$(CC) $(CC2) $(DEBUG) $(DLL) cksnval.obj \
        cksnval.def $(OUT) $@ $(LIBS)

k95crypt.dll: ck_crp.obj ck_des.obj ckclib.obj ck_crp.def ckoker.mak
	link /dll /debug /def:ck_crp.def /out:$@ ck_crp.obj ckclib.obj ck_des.obj libdes.lib
       
k2crypt.dll: ck_crp.obj ck_des.obj ckclib.obj k2crypt.def ckoker.mak
	ilink /nologo /noi /exepack:1 /align:16 /base:0x10000 k2crypt.def \
            /out:$@ ck_crp.obj ck_des.obj ckclib.obj libdes.lib 
        dllrname $@ CPPRMI36=CKO32RTL       
       
ckwart.exe: ckwart.obj $(DEF)
	$(CC) ckwart.obj 

docs:   ckermit.inf

otelnet.exe: ckotel.obj ckotel.def ckoker.mak 
        $(CC) $(CC2) $(DEBUG) ckotel.obj ckotel.def $(OUT) $@ $(LIBS)
        dllrname $@ CPPRMI36=CKO32RTL       

osetup.exe: setup.obj osetup.def ckoker.mak 
        $(CC) $(DEBUG) setup.obj osetup.def $(OUT) $@ 

ckoclip.exe: ckoclip.obj ckoclip.def ckoker.mak ckoclip.res 
        $(CC) $(CC2) $(DEBUG) ckoclip.obj ckoclip.def $(OUT) $@ $(LIBS)
!ifdef WARP
       rc -p -x2 ckoclip.res $@
!else
       rc -p -x1 ckoclip.res $@
!endif
        dllrname $@ CPPRMI36=CKO32RTL       

srp-tconf.exe: srp-tconf.obj getopt.obj ssh\ckosslc.obj ckoker.mak
!if "$(PLATFORM)" == "OS2"
        $(CC) $(CC2) $(DEBUG) srp-tconf.obj getopt.obj ssh\ckosslc.obj ckotel.def $(OUT) $@ $(LIBS)
        dllrname $@ CPPRMI36=CKO32RTL       
!else if "$(PLATFORM)" == "NT"
	link /debug /out:$@ srp-tconf.obj getopt.obj ssh\ckosslc.obj $(LIBS)
!endif
        
srp-passwd.exe: srp-passwd.obj getopt.obj ssh\ckosslc.obj ckoker.mak
!if "$(PLATFORM)" == "OS2"
        $(CC) $(CC2) $(DEBUG) srp-passwd.obj getopt.obj ssh\ckosslc.obj ckotel.def $(OUT) $@ $(LIBS)
        dllrname $@ CPPRMI36=CKO32RTL       
!else if "$(PLATFORM)" == "NT"
	link /debug /out:$@ srp-passwd.obj getopt.obj ssh\ckosslc.obj $(LIBS)
!endif
        
iksdsvc.exe: iksdsvc.obj ckoker.mak
!if "$(PLATFORM)" == "OS2"
!else if "$(PLATFORM)" == "NT"
	link /debug /out:$@ iksdsvc.obj $(LIBS)
!endif
        
iksd.exe: iksd.obj ckoker.mak
!if "$(PLATFORM)" == "OS2"
!else if "$(PLATFORM)" == "NT"
	link /debug /out:$@ iksd.obj $(LIBS)
!endif
        

#---------- Dependencies:

reg$(O):    reg.c ckoetc.h 

!if "$(PLATFORM)" == "OS2"
setup$(O):	setup.c
	$(CC) $(CC2) $(CFLAGS) /Gd- /Gn- $(DEBUG) $(DEFINES) $(NOLINK) setup.c
!else
setup$(O):	setup.c ckcdeb.h ckoker.h ckcker.h ckucmd.h ckuusr.h ckowin.h ckntap.h
	$(CC) $(CC2) $(CFLAGS) $(DEFINES) $(DEBUG) $(OPT) /Gn- -c setup.c

settapi$(O):  settapi.c 
	$(CC) $(CC2) $(CFLAGS) $(DEFINES) $(DEBUG) $(OPT) /Gn- -c settapi.c

!endif

test$(O):	test.c

telnet$(O):	telnet.c

rlogin$(O):	rlogin.c

textps$(O):     textps.c

ckcmai$(O):	ckcmai.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckcsym.h ckcnet.h ckctel.h \
                ckuusr.h ckonet.h ckcsig.h ckocon.h ckntap.h ckocon.h ck_ssl.h ckossl.h
ckcmdb$(O):     ckcmdb.c ckcsym.h ckcdeb.h ckoker.h
ckclib$(O):     ckclib.c ckcsym.h ckcdeb.h ckoker.h ckclib.h ckcasc.h
ckcfns$(O):	ckcfns.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckcsym.h ckcxla.h ckuxla.h \
                ckcnet.h
ckcfn2$(O):	ckcfn2.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckcsym.h ckcxla.h ckuxla.h \
                ckcnet.h ckctel.h
ckcfn3$(O):	ckcfn3.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckcsym.h ckcxla.h ckuxla.h
ckcpro$(O):	ckcpro.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckcnet.h ckctel.h
ckcuni$(O):     ckcuni.c ckcsym.h ckcdeb.h ckoker.h ckcker.h ckucmd.h ckcxla.h ckuxla.h 
ckuxla$(O):	ckuxla.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcxla.h ckuxla.h
ckucmd$(O):	ckucmd.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckucmd.h ckuusr.h ckcnet.h \
                ckctel.h
ckudia$(O):	ckudia.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckucmd.h ckuusr.h \
            ckcsig.h ckocon.h cknwin.h ckowin.h ckntap.h ckcnet.h ckctel.h
ckuscr$(O):	ckuscr.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckcsig.h ckcnet.h \
                ckctel.h
ckuusr$(O):	ckuusr.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckucmd.h \
		  ckcxla.h ckuxla.h ckcnet.h ckctel.h ckonet.h ckocon.h cknwin.h \
	          ckowin.h ckntap.h kui\ikui.h
ckuus2$(O):	ckuus2.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckucmd.h \
		  ckcxla.h ckuxla.h ckokvb.h ckocon.h ckokey.h ckcnet.h ckctel.h
ckuus3$(O):	ckuus3.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckucmd.h \
		  ckcxla.h ckuxla.h ckcnet.h ckctel.h ckonet.h ckonbi.h ckntap.h \
                  ckocon.h ckokey.h ckokvb.h ckcuni.h ck_ssl.h ckossl.h ckuath.h kui\ikui.h
ckuus4$(O):	ckuus4.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckucmd.h \
		  ckcxla.h ckuxla.h ckuver.h ckcnet.h ckctel.h ckonet.h ckocon.h \
	          ckoetc.h ckntap.h ckuath.h ck_ssl.h
ckuus5$(O):	ckuus5.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckucmd.h \
                ckocon.h ckokey.h ckokvb.h ckcuni.h ckcnet.h ckctel.h ck_ssl.h ckossl.h kui\ikui.h
ckuus6$(O):	ckuus6.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckucmd.h ckntap.h \
                ckcnet.h ckctel.h
!if "$(PLATFORM)" == "OS2"
	$(CC) $(CC2) $(CFLAGS) $(DEBUG) $(DEFINES) $(NOLINK) ckuus6.c

!endif
ckuus7$(O):	ckuus7.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckucmd.h \
		  ckcxla.h ckuxla.h ckcnet.h ckctel.h ckonet.h ckocon.h ckodir.h \
                  ckokey.h ckokvb.h cknwin.h ckowin.h ckntap.h ckcuni.h \
                  ckntap.h ckuath.h ck_ssl.h kui\ikui.h
ckuusx$(O):	ckuusx.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckonbi.h \
                ckocon.h cknwin.h ckowin.h ckntap.h ckcnet.h ckctel.h kui\ikui.h
ckuusy$(O):	ckuusy.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckuusr.h ckucmd.h ckcnet.h ckctel.h \
	        ck_ssl.h kui\ikui.h
ckofio$(O):	ckofio.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckuver.h ckodir.h ckoker.h \
                ckuusr.h ckcxla.h ck_ssl.h
ckoava$(O):     ckoava.c ckoava.h ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h
ckocon$(O):	ckocon.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckoker.h ckocon.h ckcnet.h ckctel.h \
                ckonbi.h ckokey.h ckokvb.h ckuusr.h cknwin.h ckowin.h ckcuni.h kui\ikui.h
ckoco2$(O):     ckoco2.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckoker.h ckocon.h \
                ckonbi.h ckopcf.h ckuusr.h ckokey.h ckokvb.h ckcuni.h kui\ikui.h
ckoco3$(O):     ckoco3.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckoker.h ckocon.h \
                ckokey.h ckokvb.h ckuusr.h ckowys.h ckodg.h  ckoava.h ckoi31.h \
                ckohp.h  ckoadm.h ckohzl.h ckoqnx.h ckotvi.h ckovc.h  ckcuni.h \
                ckcnet.h ckctel.h kui\ikui.h
ckoco4$(O):     ckoco4.c ckcdeb.h ckoker.h ckclib.h ckocon.h ckokey.h ckokvb.h ckuusr.h ckcasc.h \
                ckokey.h ckokvb.h
ckoco5$(O):     ckoco5.c ckcdeb.h ckoker.h ckclib.h ckocon.h 
ckodg$(O):      ckodg.c  ckodg.h  ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h \
                ckcnet.h ckctel.h
ckoetc$(O):     ckoetc.c ckcdeb.h ckoker.h ckclib.h ckoetc.h
ckoetc2$(O):    ckoetc2.c ckcdeb.h ckoker.h ckclib.h ckoetc.h
ckohp$(O):      ckohp.c  ckohp.h  ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h \
                ckokey.h ckokvb.h
ckohzl$(O):     ckohzl.c ckohzl.h ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h \
                ckcnet.h ckctel.h ckcuni.h
ckoadm$(O):     ckoadm.c ckoadm.h ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h \
                ckcnet.h ckctel.h ckcuni.h
ckoi31$(O):     ckoi31.c ckoi31.h ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h
ckokey$(O):     ckokey.c ckcdeb.h ckoker.h ckclib.h ckcasc.h ckcker.h ckuusr.h ckctel.h \
                ckocon.h ckokey.h ckokvb.h ckcxla.h ckuxla.h ckcuni.h kui\ikui.h
ckoqnx$(O):     ckoqnx.c ckoqnx.h ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h
ckotek$(O): ckotek.c ckotek.h ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckoker.h ckocon.h \
                ckokey.h ckokvb.h ckuusr.h ckcnet.h ckctel.h
ckotio$(O):	ckotio.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckuver.h ckodir.h ckoker.h \
                ckocon.h ckokey.h ckokvb.h ckuusr.h ckoslp.h ckcsig.h ckop.h \
                ckcuni.h ckowin.h p.h ckcnet.h ckctel.h \
!if "$(PLATFORM)" == "NT"
                ckntap.h cknwin.h  kui\ikui.h
!else

!endif
ckotvi$(O):     ckotvi.c ckotvi.h ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h \
                ckctel.h ckokvb.h
ckovc$(O):      ckovc.c  ckovc.h  ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h
ckowys$(O):     ckowys.c ckowys.h ckcdeb.h ckoker.h ckclib.h ckcker.h ckcasc.h ckocon.h ckuusr.h \
                ckcuni.h ckokey.h ckokvb.h ckctel.h
ckcnet$(O):	ckcnet.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcnet.h ckctel.h ckonet.h ckotcp.h \
                ckuusr.h ckcsig.h ckocon.h ckuath.h ck_ssl.h ckossl.h ckosslc.h
ckcftp$(O):     ckcftp.c ckcdeb.h ckoker.h ckcasc.h ckcker.h ckucmd.h ckuusr.h ckcnet.h ckctel.h \
                ckcxla.h ckuath.h ck_ssl.h ckoath.h
ckctel$(O):	ckctel.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckctel.h ckcnet.h ckocon.h ck_ssl.h \
                ckossl.h ckosslc.h
ckonet$(O):	ckonet.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckoker.h ckcnet.h ckctel.h ckonet.h \
                ckotcp.h ckonbi.h ckuusr.h ckcsig.h cknwin.h ckowin.h ckuath.h \
                ck_ssl.h ckossl.h ckosslc.h
!if "$(PLATFORM)" == "NT"
cknnbi$(O):     cknnbi.c ckonbi.h ckcdeb.h ckoker.h ckclib.h 
!else
ckonbi$(O):     ckonbi.c ckonbi.h ckcdeb.h ckoker.h ckclib.h 
!endif
ckoslp$(O):     ckoslp.c ckoslp.h ckcdeb.h ckoker.h ckclib.h 
ckomou$(O):     ckomou.c ckocon.h ckcdeb.h ckoker.h ckclib.h ckokey.h ckokvb.h ckuusr.h
ckop$(O):       ckop.c ckop.h ckcdeb.h ckoker.h ckclib.h ckcker.h p_global.h p_callbk.h \
                ckuusr.h ckcnet.h ckctel.h ckonet.h ckocon.h
cknsig$(O):	cknsig.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckcsym.h ckcnet.h ckctel.h ckonet.h\
                ckuusr.h ckonet.h ckcsig.h ckocon.h
ckusig$(O):	ckusig.c ckcker.h ckcdeb.h ckoker.h ckclib.h ckcasc.h ckcsym.h ckcnet.h ckctel.h ckonet.h\
                ckuusr.h ckonet.h ckcsig.h ckocon.h
ckosyn$(O):     ckosyn.c ckcdeb.h ckoker.h ckclib.h ckcker.h ckocon.h ckuusr.h ckntap.h
ckothr$(O): ckothr.c ckocon.h ckcsym.h ckcasc.h ckcdeb.h ckoker.h ckclib.h ckcker.h ckcsig.h
ckntap$(O): ckntap.c ckcdeb.h ckoker.h ckclib.h ckcker.h ckntap.h cknwin.h ckowin.h ckuusr.h ckucmd.h ckowin.h
ckoreg$(O): ckoreg.c ckcdeb.h ckoker.h ckclib.h ckcker.h
cknalm$(O): cknalm.c cknalm.h
cknwin$(O): cknwin.c cknwin.h ckowin.h ckcdeb.h ckoker.h ckclib.h ckntap.h ckocon.h
cknprt$(O): cknprt.c ckcdeb.h ckoker.h ckcker.h ckucmd.h

ckuath$(O):     ckcdeb.h ckoker.h ckclib.h ckcnet.h ckctel.h ckuath.h ckuat2.h ck_ssl.h ckossl.h \
                ckosslc.h ckuath.c ckoath.h
ckoath$(O):     ckoath.c ckcdeb.h ckoker.h ckclib.h ckcnet.h ckctel.h ckuath.h ckuat2.h ckoath.h
ck_ssl$(O):     ck_ssl.c ckcdeb.h ckoker.h ckclib.h ckctel.h ck_ssl.h ckosslc.h ckossl.h
ckossl$(O):     ckossl.c ckcdeb.h ckoker.h ck_ssl.h ckossl.h
ckosslc$(O):    ckosslc.c ckcdeb.h ckoker.h ck_ssl.h ckosslc.h
ckozli$(O):     ckozli.c ckcdeb.h ckoker.h ckozli.h
ckosftp$(O):    ckcdeb.h ckoker.h ckclib.h ckosftp.h ckosftp.c
	$(CC) $(CC2) -Issh -Issh/openbsd-compat $(CFLAGS) $(DLL) $(DEBUG) $(DEFINES) $(NOLINK) ckosftp.c
ckossh$(O):     ckcdeb.h ckoker.h ckclib.h ckossl.h ckoath.h ckosslc.h ckossh.c ckossh.h
	$(CC) $(CC2) -Issh -Issh/openbsd-compat $(CFLAGS) $(DLL) $(DEBUG) $(DEFINES) $(NOLINK) ckossh.c

ck_crp$(O):     ckcdeb.h ckoker.h ckclib.h ckcnet.h ckctel.h ckuath.h ckuat2.h ck_crp.c
!if "$(PLATFORM)" == "OS2"
	$(CC) $(CC2) $(CFLAGS) $(DLL) $(DEBUG) $(DEFINES) $(NOLINK) ck_crp.c

!endif
ck_des$(O):     ck_des.c
!if "$(PLATFORM)" == "OS2"
	$(CC) $(CC2) $(CFLAGS) $(DLL) $(DEBUG) $(DEFINES) $(NOLINK) ck_des.c

!endif

p_brw$(O):     ckcdeb.h ckoker.h ckclib.h ckocon.h p_brw.c p_type.h p_brw.h
p_callbk$(O):  ckcdeb.h ckoker.h ckclib.h ckocon.h p_callbk.c p_type.h p.h p_callbk.h p_common.h p_brw.h \
               p_error.h  p_global.h p_module.h p_omalloc.h
p_common$(O):  ckcdeb.h ckoker.h ckclib.h ckocon.h p_common.c p_type.h p_common.h p_error.h p_module.h p_global.h
p_dir$(O):     ckcdeb.h ckoker.h ckclib.h ckocon.h p_dir.c    p_type.h p_dir.h
p_error$(O):   ckcdeb.h ckoker.h ckclib.h ckocon.h p_error.c  p_type.h p_errmsg.h ckcnet.h ckctel.h ckonet.h
p_global$(O):  ckcdeb.h ckoker.h ckclib.h ckocon.h p_global.c p_type.h p_tl.h p_brw.h p.h
p_tl$(O):      ckcdeb.h ckoker.h ckclib.h ckocon.h p_tl.c     p_type.h p_tl.h p_brw.h p.h
p_omalloc$(O): ckcdeb.h ckoker.h ckclib.h p_omalloc.c p_type.h p_error.h p.h

ckcpro.c:	ckcpro.w ckwart.exe
#		$(MAKE) -f ckoker.mak ckwart.exe \
#		  CC="$(CC) $(CC2)" OUT="$(OUT)" O="$(O)" OPT="$(OPT)" \
#		  DEBUG="$(DEBUG)" CFLAGS="-DCK_ANSIC $(CFLAGS)" LDFLAGS="$(LDFLAGS)"
		ckwart ckcpro.w ckcpro.c

ckopcf$(O):     ckopcf.c ckopcf.h
	$(CC) $(CC2) $(CFLAGS) $(DEBUG) $(OPT) $(DLL) -c ckopcf.c

ckotel$(O):     ckotel.c
	$(CC) $(CC2) $(CFLAGS) $(DEBUG) $(OPT) /Gn- -c ckotel.c

ckoclip$(O):     ckoclip.c
	$(CC) $(CC2) $(CFLAGS) $(DEBUG) $(OPT) /Gn- -c ckoclip.c

ckwart$(O):     ckwart.c
	$(CC) -c ckwart.c

#cko32rt$(O):     cko32rt.c
#        /Gd+ /Ge- $(DLL) -c cko32rt.c

k95d$(O):  k95d.c

getopt$(O):     getopt.c getopt.h
srp-tconf$(O):  srp-tconf.c getopt.h 
srp-passwd$(O): srp-passwd.c getopt.h

iksdsvc$(O):    iksdsvc.c 

iksd$(O):    iksd.c 

ckof13.obj: ckoftp.c ckotcp.h
        @echo > ckof13.obj
        del ckof13.obj
	$(CC) $(CC2) $(CFLAGS) -DTCPERRNO -I$(FTP13INC) \
           $(DEBUG) $(OPT) $(DEFINES) $(DLL) -c ckoftp.c
        ren ckoftp.obj ckof13.obj

ckoi20.obj: ckoibm.c ckotcp.h
        @echo > ckoi20.obj
        del ckoi20.obj
	$(CC) $(CC2) $(CFLAGS) -I$(IBM20INC) \
           $(DEBUG) $(OPT) $(DEFINES) -DSOCKS_ENABLED $(DLL) -c ckoibm.c
        ren ckoibm.obj ckoi20.obj

ckoi12.obj: ckoibm.c ckotcp.h
        @echo > ckoi12.obj
        del ckoi12.obj
	$(CC) $(CC2) $(CFLAGS) -I$(IBM12INC) \
           $(DEBUG) $(OPT) $(DEFINES) $(DLL) -c ckoibm.c
        ren ckoibm.obj ckoi12.obj

ckon30.obj: ckonov.c ckotcp.h
        @echo > ckon30.obj
        del ckon30.obj
	$(CC) $(CC2) $(CFLAGS) -DTCPERRNO -I$(LWP30INC) \
           $(DEBUG) $(OPT) $(DLL) -c ckonov.c
        ren ckonov.obj ckon30.obj

cksnval$(O):  ckoetc.c
    @echo > cksnval.obj
    del cksnval.obj
    ren ckoetc.obj ckoetc.o
	$(CC) $(CC2) $(CFLAGS) $(DEBUG) $(OPT) -DREXXDLL /Gn- -c ckoetc.c 
    ren ckoetc.obj cksnval.obj
    ren ckoetc.o ckoetc.obj

ckoker.res: ckoker.rc
        rc -r ckoker.rc 

cknker.res: cknker.rc cknker.ico
        rc /fo cknker.res cknker.rc

ckopcf.res: ckopcf.rc ckopcf.h
        rc -r ckopcf.rc

ckoclip.res: ckoclip.rc ckoclip.h ckoclip.ico
        rc -r ckoclip.rc

ckermit.inf:    ckermit.ipf cker01.ipf cker02.ipf cker03.ipf cker04.ipf \
                cker05.ipf cker06.ipf ckermit.bmp
                ipfc ckermit.ipf /inf

clean:
       -del *.obj
       -del *.res
