    Module('Winapi32')
        c25_WindowFromDC(long hdc),Long,Proc,Pascal,Name('WindowFromDC')
        c25_GetUpdateRect(long whnd, long lprect, bool bErase),Long,Proc,Pascal,Name('GetUpdateRect')
        C25_Createfilemappinga(Long Hfile,Long Lpfilemappingattributes,Long Flprotect,Long Dwmaximumsizehigh,Long Dwmaximumsizelow,Long Lpname),Long,Pascal,Proc,Name('Createfilemappinga')
        C25_Createfilemappingw(Long Hfile,Long Lpfilemappingattributes,Long Flprotect,Long Dwmaximumsizehigh,Long Dwmaximumsizelow,Long Lpname),Long,Pascal,Proc,Name('Createfilemappingw')

        C25_Openfilemappinga(Long Dwdesiredaccess,Long Binherithandle,Long Lpname),Long,Proc,Pascal,Name('Openfilemappinga')
        C25_Openfilemappingw(Long Dwdesiredaccess,Long Binherithandle,Long Lpname),Long,Proc,Pascal,Name('Openfilemappingw')
        C25_Copymemory(Long _Destination, Long _Source,Long _Length),Long,Proc,Pascal,Name('Copymemory')
        C25_Unmapviewoffile(Long _Handle),Long,Proc,Pascal,Name('Unmapviewoffile')
        C25_Mapviewoffile(Long Hfilemappingobject, Long Dwdesiredaccess, Long Dwfileoffsethigh, Long Dwfileoffsetlow, Long Dwnumberofbytestomap),Long,Pascal,Proc,Name('Mapviewoffile')
        C25_Getforegroundwindow(),Long,Pascal,Proc,Name('Getforegroundwindow')
        C25_Setfocus(Long _Window),Long,Proc,Pascal,Name('Setfocus')
        C25_Setwindowtexta(Long _Window, Long _Text),Long,Proc,Pascal,Name('Setwindowtexta')
        C25_Heaprealloc(Long _Hheap, Long _Dwflags, Long _Lpmem, Long _Dwbytes),Long,Pascal,Proc,Name('Heaprealloc')
        C25_Accessibleobjectfromevent(Long Hwnd,Long Idobject, Long Idchild, Long Pacc, Long Varchild),Long,Pascal,Proc,Name('Accessibleobjectfromevent')
        C25_Addfontmemresourceex(Long,Long,Long,Long),Long,Pascal,Proc,Name('Addfontmemresourceex')
        C25_Adjustwindowrectex(Long Lprect, Long Dwstyle, Byte Bmenu, Long Dwexstyle),Long,Pascal,Proc,Name('Adjustwindowrectex')
        C25_Alphablend(Long Hdcdest,Long Xorigindest,Long Yorigindest,Long Wdest,Long Hdest,Long Hdcsrc,Long Xoriginsrc,Long Yoriginsrc,Long Wsrc,Long Hsrc,Long Ftn),Long,Pascal,Proc,Name('Alphablend')
        C25_Attachthreadinput(Long,Long,Long),Long,Pascal,Proc,Name('Attachthreadinput')
        C25_Attachthreadtoclarion(Long),Long,Pascal,Proc,Name('Attachthreadtoclarion')
        C25_Beginpaint(Long Hwnd, Long Lppaint),Long,Pascal,Proc,Name('Beginpaint')
        C25_Bitblt(Long Hdc,Long X,Long Y,Long Cx,Long Cy,Long Hdcsrc,Long X1,Long Y1,Long Rop),Long,Pascal,Proc,Name('Bitblt')
        C25_Bitstolong(String Input,Long Len),Long,Pascal,Proc,Name('Bitstolong')
        C25_Blendfunction(Long),Long,Pascal,Proc,Name('Blendfunction')
        C25_Bringwindowtotop(Long),Long,Pascal,Proc,Name('Bringwindowtotop')
        C25_Callnamedpipe(Long Lpnamedpipename,Long Lpinbuffer,Long Ninbuffersize,Long Lpoutbuffer,Long Noutbuffersize,Long Lpbytesread,Long Ntimeout),Long,Pascal,Proc,Name('Callnamedpipe')
        C25_CallWindowProcA(Long Wndproc,Long Wndhandle,Long Mes,Long Wparam,Long Lparam),Long,Pascal,Proc,Name('CallWindowProcA')
        C25_Callwindowprocw(Long Wndproc,Long Wndhandle,Long Mes,Long Wparam,Long Lparam),Long,Pascal,Proc,Name('Callwindowprocw')
        C25_Cancelioex(Long,Long),Long,Pascal,Proc,Name('Cancelioex')
        C25_Changecolor(String Classtype,Long Nummer,Long Colo),Long,Pascal,Proc,Name('Changecolor')
        C25_Charupperbuffw(Long Lpsz, Long Cchlength),Long,Pascal,Proc,Name('Charupperbuffw')
        C25_Checkifserviceexists(String Servicename),Long,Pascal,Proc,Name('Checkifserviceexists')
        C25_Checkseaddrervicestatus(String Servicename),Long,Pascal,Proc,Name('Checkseaddrervicestatus')
        C25_Closecompressor(Long Compressorhandle),Long,Pascal,Proc,Name('Closecompressor')
        C25_Closedecompressor(Long Compressorhandle),Long,Pascal,Proc,Name('Closedecompressor')
        C25_Closehandle(Long _Handle),Long,Pascal,Proc,Name('Closehandle')
        C25_Closeprinter(Long Handle),Long,Proc,Pascal,Name('Closeprinter')
        C25_Closeservicehandle(Long Hscobject),Long,Pascal,Proc,Name('Closeservicehandle')
        C25_Closethemedata(Long),Long,Pascal,Proc,Name('Closethemedata')
        C25_Closewindow(Long),Long,Pascal,Proc,Name('Closewindow')
        C25_Cm_Get_Parent(Long,Long,Long),Long,Pascal,Proc,Name('Cm_Get_Parent')
        C25_Cocreateinstance(Long Addrclsid,Long Clscontext,Long Servertype,Long Addriid,Long Lpvtable),Long,Pascal,Proc,Name('Cocreateinstance')
        C25_Coinitialize(<Long>),Long,Pascal,Proc,Name('Coinitialize')
        C25_Combinergn(Long,Long,Long,Long),Long,Pascal,Proc,Name('Combinergn')
        C25_Compress(Long Compressorhandle,Long Uncompresseddata, Long Uncompresseddatasize, Long Compressedbuffer,Long Compressedbuffersize, Long Compresseddatasize),Long,Pascal,Proc,Name('Compress')
        C25_Connectnamedpipe(Long,Long),Long,Pascal,Proc,Name('Connectnamedpipe')
        C25_Controlservice(Long Hservice,Long Dwcontrol,Long Lpservicestatus),Long,Pascal,Proc,Name('Controlservice')
        C25_Copycursora(Long),Long,Pascal,Proc,Name('Copycursora')
        C25_Copycursorx(Long),Long,Pascal,Proc,Name('Copycursorx')
        C25_Copyfilea(Long Filename, Long Newfilename, Byte Failifexist),Long,Pascal,Proc,Name('Copyfilea')
        C25_Copyfileexw(Long, Long, Long, Long, Long, Long),Long,Pascal,Proc,Name('Copyfileexw')
        C25_Copyfilew(Long Filename, Long Newfilename, Byte Failifexist),Long,Pascal,Proc,Name('Copyfilew')
        C25_Copyimagea(Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Copyimagea')
        C25_Cotaskmemfree(Long Mempointer),Long,Pascal,Proc,Name('Cotaskmemfree')
        C25_Couninitialize(),Long,Pascal,Proc,Name('Couninitialize')
        C25_Cpuidex(Long _Cpuinfo, Long _Function, Long _Subfunction),Long,Pascal,Proc,Name('Cpuidex')
        C25_Crc32C_Append(Long _Crc, Long _Data, Long _Size),Long,Pascal,Proc,Name('Crc32C_Append')
        C25_CreatecompatibleBitmap(Long,Long,Long),Long,Pascal,Proc,Name('CreatecompatibleBitmap')
        C25_Createcompatibledc(Long),Long,Pascal,Proc,Name('Createcompatibledc')
        C25_Createcompressor(Long Algorithm, Long Allocationroutines, Long Compressorhandle),Long,Pascal,Proc,Name('Createcompressor')
        C25_Createdecompressor(Long Algorithm,Long Allocationroutines,Long Decompressorhandle),Long,Pascal,Proc,Name('Createdecompressor')
        C25_Createdibsection(Long Hdc,Long Bitmapinfo,ULong Usage,Long Ppvbits,Long Hsection,Long Offset),Long,Pascal,Proc,Name('Createdibsection')
        C25_Createdirectorya(Long,Long),Long,Pascal,Proc,Name('Createdirectorya')
        C25_Createdirectoryw(Long,Long),Long,Pascal,Proc,Name('Createdirectoryw')
        C25_Createevent(Long,Long,Long,Long),Long,Pascal,Proc,Name('Createevent')
        C25_Createeventa(Long,Long,Long,Long),Long,Pascal,Proc,Name('Createeventa')
        C25_Createfilea(Long Lpfilename,Long Dwdesiredaccess,Long Dwsharemode,Long Lpsecurityattributes,Long Dwcreationdisposition,Long Dwflagsandattributes,Long Htemplatefile),Long,Pascal,Proc,Name('Createfilea')
        C25_Createfilew(Long Lpfilename,Long Dwdesiredaccess,Long Dwsharemode,Long Lpsecurityattributes,Long Dwcreationdisposition,Long Dwflagsandattributes,Long Htemplatefile),Long,Pascal,Proc,Name('Createfilew')
        C25_Createiconfromresource(Long Presbits,Long Dwressize,Byte Ficon,Long Dwver),Long,Pascal,Proc,Name('Createiconfromresource')
        C25_Createiconfromresourceex(Long Presbits,Long Dwressize,Byte Ficon,Long Dwver,Long Cxdesired,Long Cydesired,ULong Flags),Long,Pascal,Proc,Name('Createiconfromresourceex')
        C25_Createnamedpipecurrent(Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Createnamedpipecurrent')
        C25_Createpolypolygonrgn(Long,Long,Long,Long),Long,Pascal,Proc,Name('Createpolypolygonrgn')
        C25_Createprocess(Long Lpapplicationname, Long Lpcommandline, Long Lpprocessattributes, Long Lpthreadattributes, Bool Binherithandles, Long Dwcreationflags, Long Lpenvironment, Long Lpcurrentdirectory, Long Lpstartupinfo, Long Lpprocessinformation),Long,Pascal,Proc,Name('Createprocess')
        C25_Createrectrgn(Long,Long,Long,Long),Long,Pascal,Proc,Name('Createrectrgn')
        C25_Createrectrgnindirect(Long Hwnd),Long,Pascal,Proc,Name('Createrectrgnindirect')
        C25_Createroundrectrgn(Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Createroundrectrgn')
        C25_Createsolidbrush(Long),Long,Pascal,Proc,Name('Createsolidbrush')
        C25_Createstreamonhglobal(Long,Long,Long),Long,Pascal,Proc,Name('Createstreamonhglobal')
        C25_Createthread(Long Lpthreadattributes, Long Dwstacksize, Long Lpstartaddress, Long Lpparameter, Long Dwcreationflags, Long Lpthreadid),Long,Pascal,Proc,Name('Createthread')
        C25_Createwindowa(Long Lpclassname, Long Lpwindowname, ULong Dwstyle, Long X, Long Y, Long Nwidth, Long Nheight, Long Hwndparent, Long Hmenu, Long Hinstance,Long Lpparam),Long,Proc,Pascal,Name('Createwindowa')
        C25_Createwindowexa(Long Dwexstyle, Long Lpclassname, Long Lpwindowname, ULong Dwstyle, Long X, Long Y, Long Nwidth, Long Nheight, Long Hwndparent, Long Hmenu, Long Hinstance,Long Lpparam),Long,Proc,Pascal,Name('Createwindowexa')
        C25_Createwindowexw(Long Dwexstyle, Long Lpclassname, Long Lpwindowname, ULong Dwstyle, Long X, Long Y, Long Nwidth, Long Nheight, Long Hwndparent, Long Hmenu, Long Hinstance,Long Lpparam),Long,Proc,Pascal,Name('Createwindowexw')
        C25_Defwindowproca(Long Wndhandle,ULong Mes,ULong Wparam,Long Lparam),Long,Pascal,Proc,Name('Defwindowproca')
        C25_Defwindowprocw(Long Wndhandle,Long Mes,Long Wparam,Long Lparam),Long,Pascal,Proc,Name('Defwindowprocw')
        C25_Deletedc(Long),Long,Pascal,Proc,Name('Deletedc')
        C25_Deletefilea(Long),Long,Pascal,Proc,Name('Deletefilea')
        C25_Deletefilew(Long Filename),Long,Pascal,Proc,Name('Deletefilew')
        C25_Deleteobject(Long),Long,Pascal,Proc,Name('Deleteobject')
        C25_Describepixelformat(Long,Long,Long,Long),Long,Pascal,Proc,Name('Describepixelformat')
        C25_Deserializedpartitionrawdata(Long Drivenumber,String Bootsector,Long Writtendummy,Long Localtick),Long,Pascal,Proc,Name('Deserializedpartitionrawdata')
        C25_Destroycursor(Long),Long,Pascal,Proc,Name('Destroycursor')
        C25_Destroywindow(Long Windowhandle),Long,Pascal,Proc,Name('Destroywindow')
        C25_Deviceiocontrol(Long Hdevice,Long Dwiocontrolcode,Long Lpinbuffer,Long Ninbuffersize,Long Lpoutbuffer,Long Noutbuffersize,Long Lpbytesreturned,Long Lpoverlapped),Long,Pascal,Proc,Name('Deviceiocontrol')
        C25_Disableprocesswindowsghosting(),Long,Pascal,Proc,Name('Disableprocesswindowsghosting')
        C25_Dispatchmessage(Long _Winmsgaddress),Long,Pascal,Proc,Name('Dispatchmessagea')
        C25_Dosdatetimetofiletime(Short Msdate, Short Mstime, Long Filetime),Long,Pascal,Proc,Name('Dosdatetimetofiletime')
        C25_Drawmenubar(Long),Long,Pascal,Proc,Name('Drawmenubar')
        C25_Drawthemebackground(Long Htheme,Long Hdc,Long Ipartid,Long Istateid,Long Prect,Long Pcliprect),Long,Pascal,Proc,Name('Drawthemebackground')
        C25_Drawthemeedge(Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Drawthemeedge')
        C25_Drawthemeicon(Long Htheme,Long Hdc,Long Ipartid,Long Istateid ,Long Prect,Long Himl,Long Iimageindex),Long,Pascal,Proc,Name('Drawthemeicon')
        C25_Drawthemetext(Long,Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Drawthemetext')
        C25_Drawthemetextex(Long Htheme,Long Hdc,Long Ipartid,Long Istateid,Long Psztext,Long Icharcount,Long Dwflags,Long Prect,Long Poptions),Long,Pascal,Proc,Name('Drawthemetextex')
        C25_Duplicatehandle(Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Duplicatehandle')
        C25_Dwmdefwindowproc(Long Hwnd,ULong _Msg, ULong Wparam,Long Lparam,Long Lresult),Long,Pascal,Proc,Name('Dwmdefwindowproc')
        C25_Dwmextendframeintoclientarea(Long,Long),Long,Pascal,Proc,Name('Dwmextendframeintoclientarea')
        C25_Dwmgetcolorizationcolor(Long, Long),Long,Pascal,Proc,Name('Dwmgetcolorizationcolor')
        C25_Dwmgetwindowattribute(Long,Long,Long,Long),Long,Pascal,Proc,Name('Dwmgetwindowattribute')
        C25_Dwmiscompositionenabled(Long),Long,Pascal,Proc,Name('Dwmiscompositionenabled')
        C25_Dwmsetwindowattribute(Long,Long,Long,Long),Long,Pascal,Proc,Name('Dwmsetwindowattribute')
        C25_Emptyworkingset(Long Hprocess),Long,Pascal,Proc,Name('Emptyworkingset')
        C25_Enddocprinter(Long Hprinter),Long,Proc,Name('Enddocprinter')
        C25_Endpageprinter(Long Hprinter),Long,Proc,Name('Endpageprinter')
        C25_Endpaint(Long Hwnd, Long Lppaint),Long,Pascal,Proc,Name('Endpaint')
        C25_Enumchildwindows(Long Hwndparent,Long Lpenumfunc,Long Lparam),Long,Pascal,Proc,Name('Enumchildwindows')
        C25_Enumdisplaymonitors(Long,Long,Long,Long),Long,Pascal,Proc,Name('Enumdisplaymonitors')
        C25_Enumprinterdriversa(Long Pname,Long Penvironment,Long Level,Long Pdriverinfo,Long Cbbuf,Long Pcbneeded,Long Pcreturned),Long,Proc,Pascal,Name('Enumprinterdriversa')
        C25_Enumprintersa(Long, Long,Long, Long, Long, Long, Long),Long,Proc,Pascal,Name('Enumprintersa')
        C25_Enumresourcenamesa(Long,Long,Long,Long),Long,Pascal,Proc,Name('Enumresourcenamesa')
        C25_Enumresourcenamesw(Long,Long,Long,Long),Long,Pascal,Proc,Name('Enumresourcenamesw')
        C25_Enumresourcetypesa(Long,Long,Long),Long,Pascal,Proc,Name('Enumresourcetypesa')
        C25_Enumresourcetypesw(Long,Long,Long),Long,Pascal,Proc,Name('Enumresourcetypesw')
        C25_Enumrestypea(Long,Long,Long),Long,Pascal,Proc,Name('Enumrestypea')
        C25_Enumrestypew(Long,Long,Long),Long,Pascal,Proc,Name('Enumrestypew')
        C25_Enumwindows(Long _Proc, Long _Lparam),Long,Pascal,Proc,Name('Enumwindows')
        C25_Exitprocess(Long),Long,Pascal,Proc,Name('Exitprocess')
        C25_Exitthread(Long _Exitcode),Long,Proc,Pascal,Name('Exitthread')
        C25_Extracticonexa(Long Lpszfile,Long Niconindex, Long Phiconlarge,Long Phiconsmall,Long Nicons),Long,Pascal,Proc,Name('Extracticonexa')
        C25_Extracticonexw(Long Lpszfile,Long Niconindex, Long Phiconlarge,Long Phiconsmall,Long Nicons),Long,Pascal,Proc,Name('Extracticonexw')
        C25_Extractmodulesfromresources(String,String),Long,Pascal,Proc,Name('Extractmodulesfromresources')
        C25_Extractmodulesfromresourcesprocedure(String Input,String Output),Long,Pascal,Proc,Name('Extractmodulesfromresourcesprocedure')
        C25_Extractmodulesfromresourcestomemory(String,String),Long,Pascal,Proc,Name('Extractmodulesfromresourcestomemory')
        C25_Filetimetolocalfiletime(Long,Long),Long,Pascal,Proc,Name('Filetimetolocalfiletime')
        C25_Filetimetosystemtime(Long,Long),Long,Pascal,Proc,Name('Filetimetosystemtime')
        C25_Fillrect(Long,Long,Long),Long,Pascal,Proc,Name('Fillrect')
        C25_Fillrgn(Long,Long ,Long),Long,Pascal,Proc,Name('Fillrgn')
        C25_Findclose(Long),Long,Pascal,Proc,Name('Findclose')
        C25_Findfirstfilea(Long Filename, Long Finddata),Long,Pascal,Proc,Name('Findfirstfilea')
        C25_Findfirstfileexa(Long Lpfilename, Long Finfolevelid, Long Lpfindfiledata, Long Fsearchop, Long Lpsearchfilter, Long Dwadditionalflags),Long,Pascal,Proc,Name('Findfirstfileexa')
        C25_Findfirstfileexw(Long Lpfilename, Long Finfolevelid, Long Lpfindfiledata, Long Fsearchop, Long Lpsearchfilter, Long Dwadditionalflags),Long,Pascal,Proc,Name('Findfirstfileexw')
        C25_Findfirstfilew(Long Filename, Long Finddata),Long,Pascal,Proc,Name('Findfirstfilew')
        C25_Findfirstvolumea(Long,Long),Long,Pascal,Proc,Name('Findfirstvolumea')
        C25_Findnextfilew(Long,Long),Long,Pascal,Proc,Name('Findnextfilew')
        C25_Findnextvolumea(Long,Long,Long),Long,Pascal,Proc,Name('Findnextvolumea')
        C25_Findresource(Long,Long,Long),Long,Pascal,Proc,Name('Findresource')
        C25_Findresourcea(Long,Long,Long),Long,Pascal,Proc,Name('Findresourcea')
        C25_Findresourceexa(Long,Long,Long,Long),Long,Pascal,Proc,Name('Findresourceexa')
        C25_Findresourceexw(Long,Long,Long,Long),Long,Pascal,Proc,Name('Findresourceexw')
        C25_Findresourcew(Long,Long,Long),Long,Pascal,Proc,Name('Findresourcew')
        C25_Findvolumeclose(Long),Long,Pascal,Proc,Name('Findvolumeclose')
        C25_FindWindowA(Long,Long),Long,Pascal,Proc,Name('Findwindowa')
        C25_Findwindowexa(Long Hwndparent,Long Hwndchildafter, Long Lpszclass, Long Lpszwindow),Long,Pascal,Proc,Name('Findwindowexa')
        C25_Formatmessage(Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Formatmessage')
        C25_Formatmessage(ULong Dwflags, ULong Lpsource, ULong Dwmessageid, ULong Dwlanguageid, *Cstring Lpbuffer, ULong Nsize, ULong Arguments), ULong, Raw, Pascal, Name('Formatmessagea')
        C25_Formatmessage(Unsigned,Long,Unsigned,Unsigned,*Cstring,Unsigned,*Cstring),Long,Pascal,Proc,Name('Formatmessage')
        C25_Freelibrary(Long Hlibmodule),Proc,Long,Pascal,Name('Freelibrary')
        C25_Freelibraryandexitthread(Long,Long),Long,Pascal,Proc,Name('Freelibraryandexitthread')
        C25_Gdiflush(),Long,Proc,Pascal,Name('Gdiflush')
        C25_Getactivewindow(),Long,Pascal,Proc,Name('Getactivewindow')
        C25_Getancestor(Long _Handle, Long _Flag),Long,Pascal,Proc,Name('Getancestor')
        C25_Getasynckeystate(Long),Long,Pascal,Proc,Name('Getasynckeystate')
        C25_Getboundsrect(Long,Long,Long),Long,Pascal,Proc,Name('Getboundsrect')
        C25_Getcapture(),Long,Pascal,Proc,Name('Getcapture')
        C25_Getcapture(Long),Long,Pascal,Proc,Name('Getcapture')
        C25_Getclassinfoexa(Long Hinstance, Long Lpszclass,Long Lpwcx ),Long,Pascal,Proc,Name('Getclassinfoexa')
        C25_Getclasslong (Long,Long),Long,Pascal,Proc,Name('Getclasslong ')
        C25_Getclasslonga(Long Hwnd, Long Index),Long,Pascal,Proc,Name('Getclasslonga')
        C25_Getclassname(Long,Long,Long),Long,Pascal,Proc,Name('Getclassname')
        C25_Getclassnamea(Long Hwnd, Long Classname, Long Count),Long,Pascal,Proc,Name('Getclassnamea')
        C25_Getclientrect(Long,Long),Long,Pascal,Proc,Name('Getclientrect')
        C25_Getcomputernameexa(Long Nametype, Long Buffer, Long Bufferssize),Long,Proc,Pascal,Name('Getcomputernameexa')
        C25_Getcomputernameexw(Long,Long,Long),Long,Pascal,Proc,Name('Getcomputernameexw')
        C25_Getcurrentdirectorya(Long Sizebuffer, Long Buffer),Long,Pascal,Proc,Name('Getcurrentdirectorya')
        C25_Getcurrentdirectoryw(Long Sizebuffer, Long Buffer),Long,Pascal,Proc,Name('Getcurrentdirectoryw')
        C25_Getcurrentprocess(),Long,Pascal,Proc,Name('Getcurrentprocess')
        C25_Getcurrentprocessid(),Long,Pascal,Proc,Name('Getcurrentprocessid')
        C25_Getcurrentprocessornumber(),Long,Pascal,Proc,Name('Getcurrentprocessornumber')
        C25_Getcurrentprocessornumberex(Long),Long,Pascal,Proc,Name('Getcurrentprocessornumberex')
        C25_Getcurrentthemename(Long Pszthemefilename,Long Dwmaxnamechars,Long Pszcolorbuff,Long Cchmaxcolorchars,Long Pszsizebuff,Long Cchmaxsizechars),Long,Pascal,Proc,Name('Getcurrentthemename')
        C25_Getcurrentthread(),Long,Pascal,Proc,Name('Getcurrentthread')
        C25_Getcurrentthreadid(),Long,Pascal,Proc,Name('Getcurrentthreadid')
        C25_Getcurrentthreadid(Long),Long,Pascal,Proc,Name('Getcurrentthreadid')
        C25_Getcurrentthreadtoken(),Long,Pascal,Proc,Name('Getcurrentthreadtoken')
        C25_Getcursor(),Long,Pascal,Proc,Name('Getcursor')
        C25_Getcursorpos(Long),Long,Pascal,Proc,Name('Getcursorpos')
        C25_Getdc(Long _V),Proc,Long,Name('Getdc')
        C25_Getdcex(Long Wnd,Long Hrgnclip,Long Flags),Long,Pascal,Proc,Name('Getdcex')
        C25_Getdefaultprintera(Long Pszbuffer, Long Pcchbuffer),Long,Proc,Name('Getdefaultprintera')
        C25_Getdefaultprinterw(Long Pszbuffer, Long Pcchbuffer),Long,Proc,Name('Getdefaultprinterw')
        C25_Getdesktopwindow(),Long,Pascal,Proc,Name('Getdesktopwindow')
        C25_Getdibcolortable(Long,Long,Long,Long),Long,Pascal,Proc,Name('Getdibcolortable')
        C25_Getdibits(Long Hdc,Long Hbm,Long Start,Long Clines,Long Lpvbits,Long Lpbmi_Inout,Long Usage),Long,Pascal,Proc,Name('Getdibits')
        C25_Getdoubleclicktime(),Long,Pascal,Proc,Name('Getdoubleclicktime')
        C25_Getenvironmentvariablea(Long Lpname,Long Lpbuffer,Long Nsize),Long,Pascal,Proc,Name('Getenvironmentvariablea')
        C25_Getenvironmentvariablew(Long Lpname,Long Lpbuffer,Long Nsize),Long,Pascal,Proc,Name('Getenvironmentvariablew')
        C25_Getexitcodethread(Long,Long),Long,Pascal,Proc,Name('Getexitcodethread')
        C25_Getextendedtcptable(Long,Long,Byte,Long,Long,Long),Long,Pascal,Proc,Name('Getextendedtcptable')
        C25_Getfileinformationbyhandleex(Long,Long,Long,Long),Long,Pascal,Proc,Name('Getfileinformationbyhandleex')
        C25_Getfilesize(Long,Long),Long,Pascal,Proc,Name('Getfilesize')
        C25_Getfilesizeex(Long,Long),Long,Pascal,Proc,Name('Getfilesizeex')
        C25_Getguithreadinfo(Long,Long),Long,Pascal,Proc,Name('Getguithreadinfo')
        C25_Getkeystate(Long),Long,Pascal,Proc,Name('Getkeystate')
        C25_Getlastactivepopup(Long),Long,Pascal,Proc,Name('Getlastactivepopup')
        C25_GetLastError(),Long,Pascal,Proc,Name('GetLastError')
        C25_Getlayeredwindowattributes(Long Hwnd, Long Colorref, Long Pbalpha,Long Pdwflags),Long,Pascal,Proc,Name('Getlayeredwindowattributes')
        C25_Getlocaltime(Long),Long,Pascal,Proc,Name('Getlocaltime')
        C25_Getlogicalprocessorinformationex(Long,Long,Long),Long,Pascal,Proc,Name('Getlogicalprocessorinformationex')
        C25_Getmenu(Long),Long,Pascal,Proc,Name('Getmenu')
        C25_Getmessage(Long _Windowmessageaddress, Long _Hwnd, Long _Min, Long _Max),Long,Pascal,Name('Getmessagea')
        C25_Getmodulebasenamea(Long Hprocess,Long Hmodule,Long Lpbasename,Long Nsize),Long,Pascal,Proc,Name('Getmodulebasenamea')
        C25_Getmodulefilenamea(Long,Long,Long),Long,Pascal,Proc,Name('Getmodulefilenamea')
        C25_Getmodulefilenameexa(Long,Long,Long,Long),Long,Pascal,Proc,Name('Getmodulefilenameexa')
        C25_Getmodulefilenamew(Long,Long,Long),Long,Pascal,Proc,Name('Getmodulefilenamew')
        C25_Getmodulehandle(Long),Long,Pascal,Proc,Name('Getmodulehandle')
        C25_Getmodulehandlea(Long),Long,Pascal,Proc,Name('Getmodulehandlea')
        C25_Getmodulehandleexa(Long Dwflags,Long Lpmodulename,Long Phmodule),Long,Pascal,Proc,Name('Getmodulehandleexa')
        C25_Getmodulehandleexw(Long Dwflags,Long Lpmodulename,Long Phmodule),Long,Pascal,Proc,Name('Getmodulehandleexw')
        C25_Getmoduleinformation(Long Hprocess,Long Hmodule,Long Lpmodinfo,Long Cb),Long,Pascal,Proc,Name('Getmoduleinformation')
        C25_Getmonitorinfoa(Long,Long),Long,Pascal,Proc,Name('Getmonitorinfoa')
        C25_Getmonitorinfow(Long,Long),Long,Pascal,Proc,Name('Getmonitorinfow')
        C25_Getnativesysteminfo(Long),Long,Pascal,Proc,Name('Getnativesysteminfo')
        C25_Getobjecta(Long H,Long C,Long Pv),Long,Pascal,Name('Getobjecta')
        C25_Getoverlappedresult(Long,Long,Long,Long),Long,Pascal,Proc,Name('Getoverlappedresult')
        C25_Getoverlappedresultex(Long,Long,Long,Long,Byte),Long,Pascal,Proc,Name('Getoverlappedresultex')
        C25_Getparent(Long _Handle),Long,Pascal,Proc,Name('Getparent')
        C25_Getpixel(Long,Long,Long),Long,Pascal,Proc,Name('Getpixel')
        C25_Getpixelformat(Long),Long,Pascal,Proc,Name('Getpixelformat')
        C25_Getprocaddress(Long _Dllhandle, Long _Procnameorordinal),Long,Pascal,Proc,Name('Getprocaddress')
        !C25_Getprocaddressa(Long _Dllhandle, Long _Procnameorordinal),Long,Pascal,Proc,Name('Getprocaddressa')
        C25_Getprocessaffinitymask(Long,Long,Long),Long,Pascal,Proc,Name('Getprocessaffinitymask')
        C25_Getprocessheap(),Long,Pascal,Proc,Name('Getprocessheap')
        C25_Getprocessheaps(Long Maxnumberofheaps,Long Processheapsbuffer),Long,Pascal,Proc,Name('Getprocessheaps')
        C25_Getprocessid(Long),Long,Pascal,Name('Getprocessid')
        C25_Getrawinputbuffer(Long Prawinput, Long Pcbsize, Long Cbsizeheader),Long,Pascal,Proc,Name('Getrawinputbuffer')
        C25_Getrawinputdata(Long Hrawinput, Long Uicommand, Long Pdata, Long Pcbsize, Long Cbsizeheader),Long,Pascal,Proc,Name('Getrawinputdata')
        C25_Getrawinputdeviceinfoa(Long Hdevice, Long Uicommand, Long Pdata, Long Pcbsize),Long,Pascal,Proc,Name('Getrawinputdeviceinfoa')
        C25_Getrawinputdevicelist(Long Prawinputdevicelist, Long Puinumdevices, Long Cbsize),Long,Pascal,Proc,Name('Getrawinputdevicelist')
        C25_Getregiondata(Long Hrgn, Long Ncount, Long Lprgndata),Long,Pascal,Proc,Name('Getregiondata')
        C25_Getshellwindow(),Long,Pascal,Proc,Name('Getshellwindow')
        C25_Getsockopt(Long _Socket, Long _Level, Long _Optname, Long _Optval, Long _Optlen),Long,Pascal,Proc,Name('Getsockopt')
        C25_Getsyscolor(Long Index),Long,Pascal,Proc,Name('Getsyscolor')
        C25_Getsyscolorbrush(Long Index),Long,Pascal,Proc,Name('Getsyscolorbrush')
        C25_Getsystemfirmwaretable(Long Firmwaretableprovidersignature,Long Firmwaretableid,Long Pfirmwaretablebuffer,Long Buffersize),Long,Pascal,Proc,Name('Getsystemfirmwaretable')
        C25_GetSystemInfo(Long Ptr),Long,Pascal,Proc,Name('GetSystemInfo')
        C25_Getsystemmenu(Long,Byte),Long,Pascal,Proc,Name('Getsystemmenu')
        C25_Getsystemmetrics(Long),Long,Pascal,Proc,Name('Getsystemmetrics')
        C25_Getsystemtime(Long),Long,Pascal,Proc,Name('Getsystemtime')
        C25_Getsystemtimeasfiletime(Long),Long,Pascal,Proc,Name('Getsystemtimeasfiletime')
        C25_GetSystemTimePreciseAsFileTime(Long),Long,Pascal,Proc,Name('GetSystemTimePreciseAsFileTime')
        C25_Gettcptable(Long,Long,Byte),Long,Pascal,Proc,Name('Gettcptable')
        C25_Getthemesyssize (Long Htheme,Long Isizeid),Long,Pascal,Proc,Name('Getthemesyssize ')
        C25_Getthreadid(Long _Handle),Long,Pascal,Proc,Name('Getthreadid')
        C25_Gettickcount(),Long,Pascal,Proc,Name('Gettickcount')
        C25_Gettickcount64(),Real,Pascal,Proc,Name('Gettickcount64') ! Not Working On 32 Bits
        C25_Gettimezoneinformation(Long),Long,Pascal,Proc,Name('Gettimezoneinformation')
        C25_Getvolumeinformationa(Long LprootPathname,Long Lpvolumenamebuffer,Long Nvolumenamesize,Long Lpvolumeserialnumber,Long Lpmaximumcomponentlength,Long Lpfilesystemflags,Long Lpfilesystemnamebuffer,Long Nfilesystemnamesize),Long,Pascal,Proc,Name('Getvolumeinformationa')
        C25_Getvolumeinformationbyhandlew(Long Volhandle,Long Lpvolumenamebuffer,Long Nvolumenamesize,Long Lpvolumeserialnumber,Long Lpmaximumcomponentlength,Long Lpfilesystemflags,Long Lpfilesystemnamebuffer,Long Nfilesystemnamesize),Long,Pascal,Proc,Name('Getvolumeinformationbyhandlew')
        C25_Getvolumeinformationw(Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Getvolumeinformationw')
        C25_Getwindow(Long _Handle, Long _Flag),Long,Pascal,Proc,Name('Getwindow')
        C25_Getwindowdc(Long Hwnd),Long,Pascal,Proc,Name('Getwindowdc')
        C25_Getwindowinfo(Long,Long),Long,Pascal,Proc,Name('Getwindowinfo')
        C25_Getwindowlonga(Long,Long),Long,Pascal,Proc,Name('Getwindowlonga')
        C25_Getwindowlongptr(Long Hwnd, Long Index),Long,Pascal,Proc,Name('Getwindowlongptr')
        C25_Getwindowlongptra(Long Hwnd, Long Index),Long,Pascal,Proc,Name('Getwindowlongptra')
        C25_GetWindowRect(Long,Long),Long,Pascal,Proc,Name('Getwindowrect')
        C25_Getwindowrgn(Long,Long),Long,Pascal,Proc,Name('Getwindowrgn')
        C25_Getwindowtexta(Long Hwnd, Long Txt, Long Len),Long,Pascal,Proc,Name('Getwindowtexta')
        C25_Getwindowtextlengtha(Long _Handle),Long,Pascal,Proc,Name('Getwindowtextlengtha')
        C25_Getwindowtextlengthw(Long _Handle),Long,Pascal,Proc,Name('Getwindowtextlengthw')
        C25_Getwindowtextw(Long Hwnd, Long Txt, Long Len),Long,Pascal,Proc,Name('Getwindowtextw')
        C25_Getwindowtheme(Long Hwnd),Long,Pascal,Proc,Name('Getwindowtheme')
        C25_Getwindowthreadprocessid(Long Hwnd,Long Lpdwprocessid),Long,Pascal,Proc,Name('Getwindowthreadprocessid')
        C25_Globalalloc(Long,Long),Long,Pascal,Proc,Name('Globalalloc')
        C25_Globalfree(Long),Long,Pascal,Proc,Name('Globalfree')
        C25_Globalunlock(Long),Long,Pascal,Proc,Name('Globalunlock')
        C25_Gradientfill(Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Gradientfill')
        C25_Hasoverlappediocompleted(Long),Long,Pascal,Proc,Name('Hasoverlappediocompleted')
        C25_Heapalloc(Long,Long,Long),Long,Pascal,Proc,Name('Heapalloc')
        C25_Heapalloclarge(Long,Long,String),Long,Pascal,Proc,Name('Heapalloclarge')
        C25_Heapcreate(Long Floptions,Long Dwinitialsize,Long Dwmaximumsize),Long,Pascal,Proc,Name('Heapcreate')
        C25_Heapdestroy(Long),Long,Pascal,Proc,Name('Heapdestroy')
        C25_Heapfree(Long,Long,Long),Long,Pascal,Proc,Name('Heapfree')
        C25_Heaplock(Long _Handle),Long,Pascal,Proc,Name('Heaplock')
        C25_Heapunlock(Long Hheap),Long,Pascal,Proc,Name('Heapunlock')
        C25_Heapwalk(Long Hheap, Long _Heapentry),Long,Pascal,Proc,Name('Heapwalk')
        C25_Imagelist_Loadimagea(Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Imagelist_Loadimagea')
        C25_Immgetcontext(Long),Long,Pascal,Proc,Name('Immgetcontext')
        C25_Invalidaterect(Long,Long,Long),Long,Pascal,Proc,Name('Invalidaterect')
        C25_Invalidatergn(Long,Long,Long),Long,Pascal,Proc,Name('Invalidatergn')
        C25_Isappthemed(),Long,Name('Isappthemed')
        C25_Isbadreadptr(Long Pointer, Long Sizemem),Long,Pascal,Proc,Name('Isbadreadptr')
        C25_Ischild(Long Hwndparent, Long Hwnd),Long,Pascal,Proc,Name('Ischild')
        C25_Isthemeactive(),Long,Pascal,Proc,Name('Isthemeactive')
        C25_Iszoomed(Long Hwnd),Long,Pascal,Proc,Name('Iszoomed')
        C25_Lcmapstringex(Long Lplocalename,Long Dwmapflags,Long Lpsrcstr,Long Cchsrc,Long Lpdeststr,Long Cchdest,Long Lpversioninformation,Long Lpreserved,Long Sorthandle),Long,Pascal,Proc,Name('Lcmapstringex')
        C25_Loadcursora(Long,Long),Long,Pascal,Proc,Name('Loadcursora')
        C25_Loadcursorx(Long,Long),Long,Pascal,Proc,Name('Loadcursorx')
        C25_Loadimage(Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Loadimage')
        C25_Loadimagea(Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Loadimagea')
        C25_Loadimagew(Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Loadimagew')
        C25_Loadlibrarya(Long Pathdll),Long,Pascal,Proc,Name('Loadlibrarya')
        C25_Loadlibraryexa(Long,Long,Long),Long,Pascal,Proc,Name('Loadlibraryexa')
        C25_Loadlibraryexw(Long,Long,Long),Long,Pascal,Proc,Name('Loadlibraryexw')
        C25_Loadlibraryw(Long Pathdll),Long,Pascal,Proc,Name('Loadlibraryw')
        C25_Loadresource(Long,Long),Long,Pascal,Proc,Name('Loadresource')
        C25_Localfiletimetofiletime(Long,Long),Long,Pascal,Proc,Name('Localfiletimetofiletime')
        C25_Lockfile(Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Lockfile')
        C25_Lockresource(Long),Long,Pascal,Proc,Name('Lockresource')
        C25_Lookupiconidfromdirectory(Long, Long),Long,Pascal,Proc,Name('Lookupiconidfromdirectory')
        C25_Lookupiconidfromdirectoryex(Long Presbits,Byte Ficon,Long Cxdesired,Long Cydesired,ULong Flags),Long,Pascal,Proc,Name('Lookupiconidfromdirectoryex')
        C25_Mapwindowpoints (Long,Long,Long,Long),Long,Pascal,Proc,Name('Mapwindowpoints ')
        C25_Memcpy(Long Destination,Long Source,Long Byteslen),Long,Proc,Name('_Memcpy')
        C25_Memset(Long,Long,ULong),Long,Proc,Name('_Memset')
        C25_Messagebeep(Long),Long,Pascal,Proc,Name('Messagebeep')
        C25_Movewindow(Long Hwnd,Long X, Long Y, Long Cx, Long Cy, Byte Repaint),Long,Pascal,Proc,Name('Movewindow')
        C25_Muldiv(Long,Long,Long),Long,Pascal,Proc,Name('Muldiv')
        C25_Multibytetowidechar(Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Multibytetowidechar')
        C25_Ntmapviewofsection(Long Sectionhandle,Long Processhandle, Long Baseaddress,Long Zerobits,Long Commitsize,Long Sectionoffset,Long Viewsize,Long Inheritdisposition,Long Allocationtype,Long Win32Protect),Long,Pascal,Proc,Name('Ntmapviewofsection')
        C25_Ntopendirectoryobject(Long, Long, Long),Long,Pascal,Proc,Name('Ntopendirectoryobject')
        C25_Ntopenevent(Long Eventhandle,Long Desiredaccess,Long Objectattributes),Long,Pascal,Proc,Name('Ntopenevent')
        C25_Ntopensymboliclinkobject(Long Linkhandleaddress,Long Desiredaccess,Long Objectattributes),Long,Pascal,Proc,Name('Ntopensymboliclinkobject')
        C25_Ntquerydirectoryobject(Long, Long, Long,Long, Long, Long,Long),Long,Pascal,Proc,Name('Ntquerydirectoryobject')
        C25_Ntqueryobject(Long Hobject,Long Objectinfoclass,Long Buffer,Long Buffersize,Long Bytesreturned),Long,Pascal,Proc,Name('Ntqueryobject')
        C25_Ntquerysymboliclinkobject(Long Linkhandle,Long Linktarget,Long Returnedlength),Long,Pascal,Proc,Name('Ntquerysymboliclinkobject')
        C25_Ntquerysysteminformation(Long , Long, Long, Long),Long,Pascal,Proc,Name('Ntquerysysteminformation')
        C25_Openfile(Long,Long,Long),Long,Pascal,Proc,Name('Openfile')
        C25_Openprinter2A(Long Printername, Long Handleprinter, Long Defaults, Long Options),Long,Proc,Pascal,Name('Openprinter2A')
        C25_Openprintera(Long Printername, Long Handleprinter, Long Defaults),Long,Proc,Pascal,Name('Openprintera')
        C25_Openprinterw(Long Printername, Long Handleprinter, Long Defaults),Long,Proc,Pascal,Name('Openprinterw')
        C25_Openprocess(Long Dwdesiredaccess,Byte Binherithandle,Long Dwprocessid),Long,Pascal,Proc,Name('Openprocess')
        C25_Openscmanagera(Long Lpmachinename,Long Lpdatabasename,Long Dwdesiredaccess),Long,Pascal,Proc,Name('Openscmanagera')
        C25_Openservicea(Long Hscmanager,Long Lpservicename,Long Dwdesiredaccess),Long,Pascal,Proc,Name('Openservicea')
        C25_Openthemedata(Long Hwnd, Long Classlist),Long,Pascal,Proc,Name('Openthemedata')
        C25_Openthemedataex(Long Hwnd, Long Classlist, Long Flags),Long,Pascal,Proc,Name('Openthemedataex')
        C25_Openthread(Long,Long,Long),Long,Pascal,Proc,Name('Openthread')
        C25_Pathcchremovefilespec(Long, Long),Long,Pascal,Proc,Name('Pathcchremovefilespec')
        C25_Pathfileexistsa(Long LpPathname),Long,Pascal,Proc,Name('Pathfileexistsa')
        C25_Pathfileexistsw(Long LpPathname),Long,Pascal,Proc,Name('Pathfileexistsw')
        C25_Pathremovefilespeca(Long),Long,Pascal,Proc,Name('Pathremovefilespeca')
        C25_Pathremovefilespecw(Long),Long,Pascal,Proc,Name('Pathremovefilespecw')
        C25_Peekmessagea(Long Lpmsg, Long Hwnd, ULong Wmin, ULong Wmax, ULong Wremove),Long,Pascal,Proc,Name('Peekmessagea')
        C25_PostMessageA(Long Hwnd,ULong Msg,ULong Wparam,Long Lparam),Long,Pascal,Proc,Name('PostMessageA')
        C25_Postquitmessage(Long Nexitcode),Long,Pascal,Proc,Name('Postquitmessage')
        C25_Postthreadmessagea(Long Idthread,Long Msg,Long Wparam,Long Lparam),Long,Pascal,Proc,Name('Postthreadmessagea')
        C25_Querycompressorinformation(Long Compressorhandle,Long Compressinformationclass,Long Compressinformation,Long Compressinformationsize),Long,Pascal,Proc,Name('Querycompressorinformation')
        C25_Queryprocessaffinityupdatemode(Long Hprocess, Long Flagsptr),Long,Pascal,Proc,Name('Queryprocessaffinityupdatemode')
        C25_Queryservicestatusex(Long Hservice,Long Infolevel,Long Lpbuffer,Long Cbbufsize,Long Pcbbytesneeded),Long,Pascal,Proc,Name('Queryservicestatusex')
        C25_Queryworkingset(Long Hprocess,Long Pv,Long Cb),Long,Pascal,Proc,Name('Queryworkingset')
        C25_Readfile(Long Hfile,Long Lpbuffer,Long Nnumberofbytestoread,Long Lpnumberofbytesread,Long Lpoverlapped),Long,Pascal,Proc,Name('Readfile')
        C25_Readfileex(Long Hfile,Long Lpbuffer,Long Nnumberofbytestoread,Long Lpoverlapped,Long Lpcompletionroutine),Long,Pascal,Proc,Name('Readfileex')
        C25_Readprocessmemory(Long Hprocess,Long Lpbaseaddress,Long Lpbuffer,Long Nsize,Long Lpnumberofbytesread),Long,Pascal,Proc,Name('Readprocessmemory')
        C25_Redrawwindow(Long, Long, Long, Long),Long,Pascal,Proc,Name('Redrawwindow')
        C25_Regclosekey(Long),Long,Pascal,Proc,Name('Regclosekey')
        C25_Regcreatekeyex(Long,Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regcreatekeyex')
        C25_Regcreatekeyexa(Long,Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regcreatekeyexa')
        C25_Regcreatekeyexw(Long,Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regcreatekeyexw')
        C25_Regenumkeyex(Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regenumkeyex')
        C25_Regenumkeyexa(Long Hkey,Long Dwindex,Long Lpname,Long Lpcchname,Long Lpreserved,Long Lpclass,Long Lpcchclass,Long Lpftlastwritetime),Long,Pascal,Proc,Name('Regenumkeyexa')
        C25_Regenumkeyexw(Long Hkey,Long Dwindex,Long Lpname,Long Lpcchname,Long Lpreserved,Long Lpclass,Long Lpcchclass,Long Lpftlastwritetime),Long,Pascal,Proc,Name('Regenumkeyexw')
        C25_Regenumvalue(Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regenumvalue')
        C25_Regenumvaluea(Long Hkey,Long Dwindex,Long Lpvaluename,Long Lpcchvaluename,Long Lpreserved,Long Lptype,Long Lpdata,Long Lpcbdata),Long,Pascal,Proc,Name('Regenumvaluea')
        C25_Regenumvaluew(Long Hkey,Long Dwindex,Long Lpvaluename,Long Lpcchvaluename,Long Lpreserved,Long Lptype,Long Lpdata,Long Lpcbdata),Long,Pascal,Proc,Name('Regenumvaluew')
        C25_Regflushkey(Long),Long,Pascal,Proc,Name('Regflushkey')
        C25_Registerclassexa(Long),Long,Pascal,Proc,Name('Registerclassexa')
        C25_Registerclassexw(Long),Long,Pascal,Proc,Name('Registerclassexw')
        C25_Unregisterclassa(Long _Classname, Long _Instance),Long,Pascal,Proc,Name('Unregisterclassa')

        C25_Registerdevicenotificationa(Long Hrecipient, Long _Notificationfilter, Long Flags),Long,Pascal,Name('Registerdevicenotificationa')
        C25_Registerrawinputdevices(Long Prawinputdevices, Long Uinumdevices, Long Cbsize),Long,Pascal,Proc,Name('Registerrawinputdevices')
        c25_RegisterWindowMessageA(Long),Long,Pascal,Proc,Name('RegisterWindowMessageA')
        C25_Regopencurrentuser(Long,Long),Long,Pascal,Proc,Name('Regopencurrentuser')
        C25_Regopenkeyex(Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regopenkeyex')
        C25_Regopenkeyexa(Long Hkey,Long Lpsubkey,Long Uloptions,Long Samdesired,Long Phkresult),Long,Pascal,Proc,Name('Regopenkeyexa')
        C25_Regopenkeyexw(Long Hkey,Long Lpsubkey,Long Uloptions,Long Samdesired,Long Phkresult),Long,Pascal,Proc,Name('Regopenkeyexw')
        C25_Regqueryinfokey(Long,Long,Long,Long,Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regqueryinfokey')
        C25_Regqueryinfokeya(Long,Long,Long,Long,Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regqueryinfokeya')
        C25_Regqueryinfokeyw(Long,Long,Long,Long,Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Regqueryinfokeyw')
        C25_Regqueryvalueexa(Long Hkey,Long Lpvaluename,Long Lpreserved,Long Lptype,Long Lpdata,Long Lpcbdata),Long,Pascal,Proc,Name('Regqueryvalueexa')
        C25_Regqueryvalueexw(Long Hkey,Long Lpvaluename,Long Lpreserved,Long Lptype,Long Lpdata,Long Lpcbdata),Long,Pascal,Proc,Name('Regqueryvalueexw')
        C25_Regsetvalueex(Long Hkey,Long Lpvaluename,Long Reserved,Long Dwtype,Long Lpdata,Long Cbdata),Long,Pascal,Proc,Name('Regsetvalueex')
        C25_Regsetvalueexa(Long Hkey,Long Lpvaluename,Long Reserved,Long Dwtype,Long Lpdata,Long Cbdata),Long,Pascal,Proc,Name('Regsetvalueexa')
        C25_Regsetvalueexw(Long Hkey,Long Lpvaluename,Long Reserved,Long Dwtype,Long Lpdata,Long Cbdata),Long,Pascal,Proc,Name('Regsetvalueexw')
        C25_Releasecapture(),Long,Pascal,Proc,Name('Releasecapture')
        C25_Releasedc(Long Hwnd, Long Dc),Long,Pascal,Name('Releasedc'),Proc
        C25_Resetevent(Long),Long,Pascal,Proc,Name('Resetevent')
        C25_Rgb(Byte,Byte,Byte),Long,Pascal,Proc,Name('Rgb')
        C25_Rpcdce_Uuidtostringa(Long Uuid, Long Stringguid),Long,Pascal,Proc,Name('Rpcdce_Uuidtostringa')
        C25_Rpcstringfreea(Long _Ptrtocstring),Long,Pascal,Proc,Name('Rpcstringfreea')
        C25_Rtlcomputecrc32(Long Init, Long Buffer, Long Len),Long,Pascal,Proc,Name('Rtlcomputecrc32')
        C25_Rtlinitunicodestringex(Long, Long),Long,Pascal,Proc,Name('Rtlinitunicodestringex')
        C25_Screentoclient(Long,Long),Long,Pascal,Proc,Name('Screentoclient')
        C25_Selectcliprgn(Long,Long),Long,Pascal,Proc,Name('Selectcliprgn')
        C25_Selectobject(Long,Long),Long,Pascal,Proc,Name('Selectobject')
        C25_Sendmessagea(Long,Long,Long,Long),Long,Pascal,Proc,Name('Sendmessagea')
        C25_Sendmessagetimeout(Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Sendmessagetimeout')
        C25_Sendmessagetimeouta(Long Hwnd,Long Msg,ULong Wparam,Long Lparam,Long Fuflags,Long Utimeout,Long Lpdwresult),Long,Pascal,Name('Sendmessagetimeouta')
        C25_Sendpipedataproc(String,String,String,Long,Long),Long,Pascal,Proc,Name('Sendpipedataproc')
        C25_Setactivewindow(Long),Long,Pascal,Proc,Name('Setactivewindow')
        C25_SetBitmapbits(Long Hbm, Long Cb, Long Pvbits),Long,Pascal,Proc,Name('SetBitmapbits')
        C25_Setbkmode(Long Dc, Long Color),Long,Pascal,Proc,Name('Setbkmode')
        C25_Setboundsrect(Long,Long,Long),Long,Pascal,Proc,Name('Setboundsrect')
        C25_Setcapture(Long Hwnd),Long,Pascal,Proc,Name('Setcapture')
        C25_Setclasslonga(Long,Long,Long),Long,Pascal,Proc,Name('Setclasslonga')
        C25_Setcompressorinformation(Long Compressorhandle,Long Compressinformationclass,Long Compressinformation,Long Compressinformationsize),Long,Pascal,Proc,Name('Setcompressorinformation')
        C25_Setcursora(Long),Long,Pascal,Proc,Name('Setcursora')
        C25_Setcursorapi(Long),Long,Pascal,Proc,Name('Setcursorapi')
        C25_Setdibits(Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Setdibits')
        C25_Setdibitstodevice(Long Hdc,Long Xdest,Long Ydest,Long W,Long H,Long Xscr,Long Yscr,Long Ustartscan,Long Cscanlines,Long Pbits,Long Lbmi,Long Coloruse),Long,Pascal,Proc,Name('Setdibitstodevice')
        C25_Setevent(Long Handleevent),Long,Pascal,Proc,Name('Setevent')
        C25_Setfilepointer(Long,Long,Long,Long),Long,Pascal,Proc,Name('Setfilepointer')
        C25_Setfilepointerex(Long,String,Long,Long),Long,Pascal,Proc,Name('Setfilepointerex')
        C25_Setlasterror(Long),Long,Pascal,Proc,Name('Setlasterror')
        C25_Setlasterrorex(Long,Long),Long,Pascal,Proc,Name('Setlasterrorex')
        C25_Setlayeredwindowattributes(Long,Long ,Long ,Long ),Long,Pascal,Proc,Name('Setlayeredwindowattributes')
        C25_Setparent(Long _Hwndchild, Long _Hwndnewparent),Long,Name('Setparent')
        C25_Setpixel(Long,Long,Long,Long),Long,Pascal,Proc,Name('Setpixel')
        C25_Setpixelformat(Long,Long),Long,Pascal,Proc,Name('Setpixelformat')
        C25_Setprocessaffinityupdatemode(Long Hprocess, Long Flags),Long,Pascal,Proc,Name('Setprocessaffinityupdatemode')
        C25_Setprocessdpiaware(),Long,Pascal,Proc,Name('Setprocessdpiaware')
        C25_Setsockopt(Long _Socket, Long _Level, Long _Optname, Long _Optval, Long _Optlen),Long,Pascal,Proc,Name('Setsockopt')
        C25_Setsystemcursor(Long,Long),Long,Pascal,Proc,Name('Setsystemcursor')
        C25_Setsystemcursora(Long,Long),Long,Pascal,Proc,Name('Setsystemcursora')
        C25_Setthemeappproperties(Long),Long,Pascal,Proc,Name('Setthemeappproperties')
        C25_Setthreadidealprocessor(Long Hthread, Long Dwidealprocessor),Long,Pascal,Proc,Name('Setthreadidealprocessor')
        C25_Setthreadidealprocessorex(Long Hthread, Long Dwidealprocessor, Long Lppreviousidealprocessor),Long,Pascal,Proc,Name('Setthreadidealprocessorex')
        C25_Settimer(Long Hwnd, Long Idevent, Long Elapse, Long Timerfunc),Long,Proc,Pascal,Name('Settimer')
        C25_Setupdidestroydeviceinfolist(Long),Long,Pascal,Proc,Name('Setupdidestroydeviceinfolist')
        C25_Setupdienumdeviceinfo(Long,Long,Long),Long,Pascal,Proc,Name('Setupdienumdeviceinfo')
        C25_Setupdienumdeviceinterfaces(Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Setupdienumdeviceinterfaces')
        C25_Setupdigetclassdevsa(Long,Long,Long,Long),Long,Pascal,Proc,Name('Setupdigetclassdevsa')
        C25_Setupdigetclassdevsw(Long,Long,Long,Long),Long,Pascal,Proc,Name('Setupdigetclassdevsw')
        C25_Setupdigetclassimagelist(Long),Long,Pascal,Proc,Name('Setupdigetclassimagelist')
        C25_Setupdigetdevicepropertyw(Long Deviceinfoset, Long Deviceinfodata, Long Propertykey, Long Propertytype, Long Propertybuffer, Long Propertybuffersize, Long Requiredsize, Long Flags),Long,Pascal,Proc,Name('Setupdigetdevicepropertyw')
        C25_Setupdigetdeviceregistrypropertya(Long Deviceinfoset, Long Deviceinfodata, Long Prop,Long Propertyregdatatype, Long Propertybuffer, Long Propertybuffersize, Long Requiredsize),Long,Pascal,Proc,Name('Setupdigetdeviceregistrypropertya')
        C25_Setupdigetdeviceregistrypropertyw(Long Deviceinfoset, Long Deviceinfodata, Long Prop,Long Propertyregdatatype, Long Propertybuffer, Long Propertybuffersize, Long Requiredsize),Long,Pascal,Proc,Name('Setupdigetdeviceregistrypropertyw')
        C25_Setwindowcompositionattribute(Long Whandle, Long Wincompositiondata),Long,Pascal,Proc,Name('Setwindowcompositionattribute')
        C25_Setwindowlonga(Long Hwnd, Long Index,Long Newlong ),Long,Pascal,Proc,Name('Setwindowlonga')
        C25_Setwindowlongptra(Long Hwnd, Long Nindex, Long Newlong),Long,Pascal,Proc,Name('Setwindowlongptra')
        C25_Setwindowlongptrw(Long Hwnd, Long Nindex, Long Newlong),Long,Pascal,Proc,Name('Setwindowlongptrw')
        C25_Setwindowpos(Long Hwnd, Long Hwndinsertafter, Long X, Long Y, Long Cx, Long Cy, Long Uflags),Long,Pascal,Proc,Name('Setwindowpos')
        C25_Setwindowrgn(Long,Long,Byte),Long,Pascal,Proc,Name('Setwindowrgn')
        C25_Setwindowtheme(Long,Long,Long),Long,Pascal,Proc,Name('Setwindowtheme')
        C25_Setwindowthemeattribute(Long,Long ,Long ,Long ),Long,Pascal,Proc,Name('Setwindowthemeattribute')
        C25_Setwineventhook(Long Eventmin,Long Eventmax,Long Hmodwineventproc,Long Pfnwineventproc,Long Idprocess,Long Idthread,Long Dwflags),Long,Pascal,Proc,Name('Setwineventhook')
        C25_Shappbarmessage(Long,Long),Long,Pascal,Proc,Name('Shappbarmessage')
        C25_Shellexecutea(Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Shellexecutea')
        C25_Shellexecuteex(Long),Long,Pascal,Proc,Name('Shellexecuteex')
        C25_Shellexecuteexw(Long),Long,Pascal,Proc,Name('Shellexecuteexw')
        C25_ShgetknownfolderPath(Long Rfid,ULong Dwflags,Long Htoken, Long PpszPath),Long,Pascal,Proc,Name('ShgetknownfolderPath')
        C25_ShgetPathfromidlist(Long Itemidlist, Long Path),Long,Pascal,Proc,Name('ShgetPathfromidlist')
        C25_Shgetspecialfolderlocation(Long Hwnd, Long Folder, Long Itemidlist),Long,Pascal,Proc,Name('Shgetspecialfolderlocation')
        C25_ShgetspecialfolderPatha(Long Hwndowner,Long SzPath,Long Csidl,Byte),Long,Pascal,Proc,Name('ShgetspecialfolderPatha')
        C25_ShgetspecialfolderPathw(Long Hwndowner,Long SzPath,Long Csidl,Byte),Long,Pascal,Proc,Name('ShgetspecialfolderPathw')
        C25_Showwindow(Long _Handle,Long _Cmd),Long,Pascal,Proc,Name('Showwindow')
        C25_Sizeofresource(Long,Long),Long,Pascal,Proc,Name('Sizeofresource')
        C25_Sleepex(Long Mmsec, Byte Alert),Long,Pascal,Proc,Name('Sleepex')
        C25_Startdocprinterw(Long Hprinter, Long Level, Long Docinfo),Long,Proc,Name('Startdocprinterw')
        C25_Startpageprinter(Long Hprinter),Long,Proc,Name('Startpageprinter')
        C25_Stringfromguid2(Long Rguid,Long Lpsz, Long Cchmax),Long,Pascal,Proc,Name('Stringfromguid2')
        C25_Systemparametersinfo(Long,Long,Long,Long),Long,Pascal,Proc,Name('Systemparametersinfo')
        C25_Systemparametersinfoa(Long,Long,Long,Long),Long,Pascal,Proc,Name('Systemparametersinfoa')
        C25_Systemtimetofiletime(Long,Long),Long,Pascal,Proc,Name('Systemtimetofiletime')
        C25_Systemtimetotzspecificlocaltime(Long,Long,Long),Long,Pascal,Proc,Name('Systemtimetotzspecificlocaltime')
        C25_Terminateprocess(Long _Process, Long _Exitcode),Long,Pascal,Proc,Name('Terminateprocess')
        C25_Terminatethread(Long, Long),Long,Pascal,Proc,Name('Terminatethread')
        C25_Trackmouseevent(Long),Long,Pascal,Proc,Name('Trackmouseevent')
        C25_Translatemessage(Long _Winmsgaddress),Long,Proc,Pascal,Name('Translatemessage')
        C25_Transparentblt(Long Hdcdest,Long Xorigindest,Long Yorigindest,Long Wdest,Long Hdest,Long Hdcsrc,Long Xoriginsrc,Long Yoriginsrc,Long Wsrc,Long Hsrc,Long Crtransparent),Long,Pascal,Proc,Name('Transparentblt')
        C25_Unlockfile(Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Unlockfile')
        C25_Updatelayeredwindow(Long Hwnd,Long Hdcdst,Long Pptdst, Long Psize,Long Hdcsrc,Long Pptsrc,Long Crkey, Long Pblend,Long Dwflags),Long,Pascal,Proc,Name('Updatelayeredwindow')
        C25_Updatelayeredwindowindirect(Long Hwnd, Long Pulwinfo),Long,Pascal,Proc,Name('Updatelayeredwindowindirect')
        C25_Updatewindow(Long),Long,Pascal,Proc,Name('Updatewindow')
        C25_Uuidcreate(Long),Long,Pascal,Proc,Name('Uuidcreate')
        C25_Uuidcreatesequential(Long),Long,Pascal,Proc,Name('Uuidcreatesequential')
        c25_UuidFromStringA(Long,Long),Long,Pascal,Proc,Name('UuidFromStringA')
        C25_Uuidtostringa(Long,Long),Long,Pascal,Proc,Name('Uuidtostringa')
        C25_Uuidtostringw(Long,Long),Long,Pascal,Proc,Name('Uuidtostringw')
        C25_Validaterect(Long,Long),Long,Pascal,Proc,Name('Validaterect')
        C25_Virtualalloc(Long Lpaddress, Long Dwsize, Long Flallocationtype, Long Flprotect),Long,Pascal,Name('Virtualalloc')
        C25_Virtualfree(Long Lpaddress, Long Dwsize, Long Dwfreetype),Bool,Pascal,Name('Virtualfree')
        C25_Virtualqueryex(Long Hprocess,Long Lpaddress,Long Lpbuffer,Long Dwlength),Long,Pascal,Proc,Name('Virtualqueryex')
        C25_Wdmlibrtlinitunicodestringex(Long, Long),Long,Pascal,Proc,Name('Wdmlibrtlinitunicodestringex')
        C25_Widechartomultibyte(Long,Long,Long,Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Widechartomultibyte')
        C25_Windecompress(Long Decompressorhandle, Long Compresseddata,Long Compresseddatasize, Long Uncompressedbuffer, Long Uncompressedbuffersize, Long Uncompresseddatasize),Long,Pascal,Proc,Name('Windecompress')
        C25_Windowfrompoint(Real Pointstruct),Long,Pascal,Proc,Name('Windowfrompoint')
        C25_Writefile(Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Writefile')
        C25_Writefileex(Long,Long,Long,Long,Long),Long,Pascal,Proc,Name('Writefileex')
        C25_Writeprinter(Long Hprinter, Long Pbuf, Long Cbbuf, Long Pcwritten),Long,Proc,Name('Writeprinter')
        C25_Wsagetlasterror(),Long,Proc,Pascal,Name('Wsagetlasterror')
        C25_Xcvdata(Long Hxcv,  Long Pszdataname, Long  Pinputdata, Long  Cbinputdata, Long  Poutputdata, Long  Cboutputdata, Long Pcboutputneeded, Long Pdwstatus)Long,Proc,Pascal,Name('Xcvdataw')
        C25_Xcvopenport(Long Object, Long Grantedaccess, Long Xcv),Long,Proc,Pascal,Name('Xcvopenport')
    End
    Module('glfw3.dll')
        glfwCreateCursor(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwCreateStandardCursor(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwCreateWindow(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwCreateWindowSurface(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwDefaultWindowHints(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwDestroyCursor(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwDestroyWindow(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwExtensionSupported(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwFocusWindow(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetClipboardString(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetCurrentContext(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetCursorPos(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetEGLContext(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetEGLDisplay(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetEGLSurface(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetError(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetGamepadName(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetGamepadState(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetGammaRamp(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetInputMode(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetInstanceProcAddress(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetJoystickAxes(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetJoystickButtons(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetJoystickGUID(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetJoystickHats(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetJoystickName(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetJoystickUserPointer(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetKey(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetKeyName(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetKeyScancode(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetMonitorContentScale(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetMonitorName(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetMonitorPhysicalSize(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetMonitorPos(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetMonitorUserPointer(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetMonitorWorkarea(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetMonitors(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetMouseButton(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetOSMesaColorBuffer(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetOSMesaContext(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetOSMesaDepthBuffer(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetPhysicalDevicePresentationSupport(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetPrimaryMonitor(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetProcAddress(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetRequiredInstanceExtensions(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetTime(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetTimerFrequency(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetTimerValue(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetVersion(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetVersionString(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetVersionString_0(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetVideoMode(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetVideoModes(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWGLContext(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWin32Adapter(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWin32Monitor(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWin32Window(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWindowAttrib(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWindowContentScale(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWindowFrameSize(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWindowMonitor(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWindowOpacity(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWindowPos(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWindowSize(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwGetWindowUserPointer(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwHideWindow(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwIconifyWindow(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwInit(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwInitHint(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwJoystickIsGamepad(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwJoystickPresent(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwMakeContextCurrent(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwMaximizeWindow(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwPollEvents(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwPostEmptyEvent(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwRawMouseMotionSupported(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwRequestWindowAttention(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwRestoreWindow(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetCharCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetCharModsCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetClipboardString(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetCursor(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetCursorEnterCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetCursorPos(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetCursorPosCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetDropCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetErrorCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetFramebufferSizeCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetGamma(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetGammaRamp(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetInputMode(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetJoystickCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetJoystickUserPointer(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetKeyCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetMonitorCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetMonitorUserPointer(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetMouseButtonCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetScrollCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetTime(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowAspectRatio(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowAttrib(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowCloseCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowContentScaleCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowFocusCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowIcon(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowIconifyCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowMaximizeCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowMonitor(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowOpacity(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowPos(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowPosCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowRefreshCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowShouldClose(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowSize(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowSizeCallback(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowSizeLimits(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowTitle(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSetWindowUserPointer(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwShowWindow(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSwapBuffers(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwSwapInterval(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwTerminate(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwUpdateGamepadMappings(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwVulkanSupported(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwWaitEvents(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwWaitEventsTimeout(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwWindowHint(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwWindowHintString(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
        glfwWindowShouldClose(<long _p01>, <long _p02>, <long _p03>, <long _p04>, <long _p05>, <long _p06>, <long _p07>),Long,Proc,C
    End

    Module('Gdpplus.Dll')
        C25_GdipAddPathArc(Long _gpPath, sreal _x, sreal _y, sreal _width, sreal _height, sreal _startAngle, sreal _sweepangle),Proc,Long,Pascal,Name('GdipAddPatharc')
        C25_GdipAddPathArcI(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathBezier(Long _Path, sreal x1, sreal y1, sreal x2, sreal y2, sreal x3, sreal y3, sreal x4, sreal y4),Proc,Long,Pascal,Name('GdipAddPathBezier')
        C25_GdipAddPathBezierI(Long _Path, Long x1, Long y1, Long x2, Long y2, Long x3, Long y3, Long x4, Long y4),Proc,Long,Pascal,Name('GdipAddPathBezierI')
        C25_GdipAddPathBeziers(Long _Notimplemented),Proc,Long,Pascal,Name('GdipAddPathBeziers')
        C25_GdipAddPathBeziersI(Long _Notimplemented),Proc,Long,Pascal,Name('GdipAddPathBeziersI')
        C25_GdipAddPathclosedcurve(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathclosedcurve2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathclosedcurve2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathclosedcurvei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathCurve(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathCurve2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathCurve2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathCurve3(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathCurve3I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathCurvei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathellipse(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathellipsei(Long,Long,Long,Long,Long),Proc,Long,Pascal,Name('GdipAddPathellipsei'),Long,Proc,Raw,Pascal
        C25_GdipAddPathLine(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY'),Name('GdipAddPathLine')
        C25_GdipAddPathLine2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY'),Name('GdipAddPathLine2')
        C25_GdipAddPathline2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY'),Name('GdipAddPathLine2I')
        C25_GdipAddPathlinei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY'),Name('GdipAddPathLine')
        C25_GdipAddPathPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY'),Name('GdipAddPathLine')
        C25_GdipAddPathpie(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathpiei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathpolygon(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathpolygoni(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathrectangle(Long,Sreal,Sreal,Sreal,Sreal),Proc,Long,Pascal,Name('GdipAddPathrectangle')
        C25_GdipAddPathrectanglei(Long Path,Long X,Long Y,Long W,Long H),Proc,Long,Pascal,Name('GdipAddPathrectanglei')
        C25_GdipAddPathrectangles(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathrectanglesi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipAddPathstring(Long Path, Long Wchar, Long Length, Long Fontfamily, Long Style, Sreal Emsize, Long Layoutrect, Long Stringformat),Proc,Long,Pascal,Name('GdipAddPathstring')
        C25_GdipAddPathstringi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipalloc(Long),Proc,Long,Pascal,Name('Gdipalloc'),Long,Proc,Raw,Pascal
        C25_Gdipbegincontainer(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipbegincontainer2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipbegincontaineri(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipBitmapapplyeffect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipBitmapconvertformat(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipBitmapcreateapplyeffect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipBitmapgethistogram(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipBitmapgethistogramsize(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipBitmapgetpixel(Long,Long,Long,Long),Proc,Long,Pascal,Name('GdipBitmapgetpixel'),Long,Proc,Raw,Pascal
        C25_GdipBitmaplockbits(Long GpBitmap,Long Gprect,Long Flags,Long Pixelformat,Long Bitmapdata),Proc,Long,Pascal,Name('GdipBitmaplockbits'),Long,Proc,Raw,Pascal
        C25_GdipBitmapsetpixel(Long,Long,Long,Long),Proc,Long,Pascal,Name('GdipBitmapsetpixel'),Long,Proc,Raw,Pascal
        C25_GdipBitmapsetresolution(Long,Long,Long),Proc,Long,Pascal,Name('GdipBitmapsetresolution'),Long,Proc,Raw,Pascal
        C25_GdipBitmapunlockbits(Long,Long),Proc,Long,Pascal,Name('GdipBitmapunlockbits'),Long,Proc,Raw,Pascal
        C25_GdipclearPathmarkers(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcloneBitmaparea(Real,Real,Real,Real,Long,Long,Long),Proc,Long,Pascal,Name('GdipcloneBitmaparea'),Long,Proc,Raw,Pascal
        C25_GdipcloneBitmapareai(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipclonebrush(Long,Long),Proc,Long,Pascal,Name('Gdipclonebrush'),Long,Proc,Raw,Pascal
        C25_Gdipclonecustomlinecap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipclonefont(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipclonefontfamily(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcloneimage(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcloneimageattributes(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipclonematrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipclonePath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipclonepen(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcloneregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipclonestringformat(Long Pformat , Long Newformat),Proc,Long,Pascal,Name('Gdipclonestringformat'),Long,Proc,Raw,Pascal
        C25_GdipclosePathfigure(Long Path),Proc,Long,Pascal,Name('GdipclosePathfigure'),Long,Proc,Raw,Pascal
        C25_GdipclosePathfigures(Long Path),Proc,Long,Pascal,Name('GdipclosePathfigures'),Long,Proc,Raw,Pascal
        C25_GdipcombineregionPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcombineregionrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcombineregionrecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcombineregionregion(Long Region1,Long Region2, Long Combinemode ),Proc,Long,Pascal,Name('Gdipcombineregionregion'),Long,Proc,Raw,Pascal
        C25_Gdipcomment(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipconverttoemfplus(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipconverttoemfplustofile(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipconverttoemfplustostream(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreateadjustablearrowcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreateBitmapfromdirectdrawsurface(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreateBitmapfromfile(Long,Long),Proc,Long,Pascal,Name('GdipcreateBitmapfromfile'),Long,Proc,Raw,Pascal
        C25_GdipcreateBitmapfromfileicm(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreateBitmapfromgdidib(Long GdiBitmapinfo,Long GdiBitmapdata,Long PBitmap),Proc,Long,Pascal,Name('GdipcreateBitmapfromgdidib'),Long,Proc,Raw,Pascal
        C25_GdipcreateBitmapfromgraphics(Long _Width,Long _Height,Long _Graphic ,Long _Bitmapptr),Proc,Long,Pascal,Name('GdipcreateBitmapfromgraphics')
        C25_GdipcreateBitmapfromhBitmap(Long Hbm,Long Hpal,Long PBitmap),Proc,Long,Pascal,Name('GdipcreateBitmapfromhBitmap'),Long,Proc,Raw,Pascal
        C25_GdipcreateBitmapfromhicon(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreateBitmapfromresource(Long,Long,Long),Proc,Long,Pascal,Name('GdipcreateBitmapfromresource'),Long,Proc,Raw,Pascal
        C25_GdipcreateBitmapfromscan0(Long _Width,Long _Height,Long _Stride,Long _Pixelformat, Long _Scan0, Long _GpBitmap),Proc,Long,Pascal,Name('GdipcreateBitmapfromscan0'),Long,Proc,Raw,Pascal
        C25_GdipcreateBitmapfromstream(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreateBitmapfromstreamicm(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreatecachedBitmap(Long GpBitmap, Long Gpgraphics,Long GpcachedBitmap),Proc,Long,Pascal,Name('GdipcreatecachedBitmap'),Long,Proc,Raw,Pascal
        C25_Gdipcreatecustomlinecap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreateeffect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatefont(Long,Sreal,Long,Long,Long),Proc,Long,Pascal,Name('Gdipcreatefont'),Long,Proc,Raw,Pascal
        C25_Gdipcreatefontfamilyfromname(Long,Long,Long),Proc,Long,Pascal,Name('Gdipcreatefontfamilyfromname'),Long,Proc,Raw,Pascal
        C25_Gdipcreatefontfromdc(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatefontfromlogfonta(Long,Long,Long),Proc,Long,Pascal,Name('Gdipcreatefontfromlogfonta'),Long,Proc,Raw,Pascal
        C25_Gdipcreatefontfromlogfontw(Long,Long,Long),Proc,Long,Pascal,Name('Gdipcreatefontfromlogfontw'),Long,Proc,Raw,Pascal
        C25_Gdipcreatefromhdc(Long,Long),Proc,Long,Pascal,Name('Gdipcreatefromhdc'),Long,Proc,Raw,Pascal
        C25_Gdipcreatefromhdc2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatefromhwnd(Long,Long),Proc,Long,Pascal,Name('Gdipcreatefromhwnd'),Long,Proc,Raw,Pascal
        C25_Gdipcreatefromhwndicm(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatehalftonepalette(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatehatchbrush(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreatehBitmapfromBitmap(Long,Long,Long),Proc,Long,Pascal,Name('GdipcreatehBitmapfromBitmap'),Long,Proc,Raw,Pascal
        C25_GdipcreatehiconfromBitmap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreateimageattributes(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatelinebrush(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatelinebrushfromrect(Long,Long,Long,Long,Long,Long),Proc,Long,Pascal,Name('Gdipcreatelinebrushfromrect'),Long,Proc,Raw,Pascal
        C25_Gdipcreatelinebrushfromrecti(Long,Long,Long,Long,Long,Long),Proc,Long,Pascal,Name('Gdipcreatelinebrushfromrecti'),Long,Proc,Raw,Pascal
        C25_Gdipcreatelinebrushfromrectwithangle(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatelinebrushfromrectwithanglei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatelinebrushi(Long,Long,Long,Long,Long,Long),Proc,Long,Pascal,Name('Gdipcreatelinebrushi'),Long,Proc,Raw,Pascal
        C25_Gdipcreatematrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatematrix2(Sreal M11, Sreal M12, Sreal M21, Sreal M22, Sreal Dx, Sreal Dy, Long Matrix),Proc,Long,Pascal,Name('Gdipcreatematrix2'),Long,Proc,Raw,Pascal
        C25_Gdipcreatematrix3(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatematrix3I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatemetafilefromemf(Long,Byte,Long),Proc,Long,Pascal,Name('Gdipcreatemetafilefromemf'),Proc
        C25_Gdipcreatemetafilefromfile(Long,Long),Proc,Long,Pascal,Name('Gdipcreatemetafilefromfile'),Proc
        C25_Gdipcreatemetafilefromstream(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatemetafilefromwmf(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatemetafilefromwmffile(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreatePath(Long,Long),Proc,Long,Pascal,Name('GdipcreatePath'),Long,Proc,Raw,Pascal
        C25_GdipcreatePath2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreatePath2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreatePathgradient(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreatePathgradientfromPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreatePathgradienti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreatePathiter(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatepen1(Long Color,Sreal Width,Long Unit,Long Out_Penhandle),Proc,Long,Pascal,Name('Gdipcreatepen1'),Long,Proc,Raw,Pascal
        C25_Gdipcreatepen2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreateregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreateregionhrgn(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipcreateregionPath(Long Path,Long Region),Proc,Long,Pascal,Name('GdipcreateregionPath'),Long,Proc,Raw,Pascal
        C25_Gdipcreateregionrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreateregionrecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreateregionrgndata(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatesolidfill(Long,Long),Proc,Long,Pascal,Name('Gdipcreatesolidfill'),Long,Proc,Raw,Pascal
        C25_Gdipcreatestreamonfile(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatestringformat(Long Stringformatflags,Short Language,Long Pformat ),Proc,Long,Pascal,Name('Gdipcreatestringformat'),Long,Proc,Raw,Pascal
        C25_Gdipcreatetexture(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatetexture(Long Pimage, Long _Wrapmode, Long _Texture),Proc,Long,Pascal,Name('Gdipcreatetexture')
        C25_Gdipcreatetexture2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatetexture2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatetextureia(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipcreatetextureiai(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdeletebrush(Long),Proc,Long,Pascal,Name('Gdipdeletebrush'),Long,Proc,Raw,Pascal
        C25_GdipdeletecachedBitmap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdeletecustomlinecap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdeleteeffect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdeletefont(Long Fonthandle),Proc,Long,Pascal,Name('Gdipdeletefont'),Long,Proc,Raw,Pascal
        C25_Gdipdeletefontfamily(Long Fontfamilyhandle),Proc,Long,Pascal,Name('Gdipdeletefontfamily'),Long,Proc,Raw,Pascal
        C25_Gdipdeletegraphics(Long),Proc,Long,Pascal,Name('Gdipdeletegraphics'),Long,Proc,Raw,Pascal
        C25_Gdipdeletematrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipdeletePath(Long),Proc,Long,Pascal,Name('GdipdeletePath'),Long,Proc,Raw,Pascal
        C25_GdipdeletePathiter(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdeletepen(Long),Proc,Long,Pascal,Name('Gdipdeletepen'),Long,Proc,Raw,Pascal
        C25_Gdipdeleteprivatefontcollection(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdeleteregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdeletestringformat(Long),Proc,Long,Pascal,Name('Gdipdeletestringformat'),Long,Proc,Raw,Pascal
        C25_Gdipdisposeimage(Long),Proc,Long,Pascal,Name('Gdipdisposeimage'),Long,Proc,Raw,Pascal
        C25_Gdipdisposeimageattributes(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawarc(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawarci(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawbezier(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawbezieri(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawbeziers(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawbeziersi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipdrawcachedBitmap(Long Gpgraphics, Long GpcachedBitmap,Long X,Long Y),Proc,Long,Pascal,Name('GdipdrawcachedBitmap'),Long,Proc,Raw,Pascal
        C25_Gdipdrawclosedcurve(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawclosedcurve2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawclosedcurve2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawclosedcurvei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawcurve(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawcurve2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawcurve2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawcurve3(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawcurve3I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawcurvei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawdriverstring(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawellipse(Long,Long,Sreal,Sreal,Sreal,Sreal),Proc,Long,Pascal,Name('Gdipdrawellipse'),Proc
        C25_Gdipdrawellipsei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawimage(Long,Long,Sreal,Sreal),Proc,Long,Pascal,Name('Gdipdrawimage'),Long,Proc,Raw,Pascal
        C25_Gdipdrawimagefx(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawimagei(Long Graphics,Long Pimage,Long X,Long Y),Proc,Long,Pascal,Name('Gdipdrawimagei'),Long,Proc,Raw,Pascal
        C25_Gdipdrawimagepointrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')

        C25_GdipDrawImagePointRectI(Long _graphics, long _imagePtr, long _x, long _y, long _srcX, long _srcY, long _srcWidth, long _srcHeight, long _scrUnit),Long,Proc,Raw,Pascal,Name('GdipDrawImagePointRectI')


        C25_Gdipdrawimagepoints(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawimagepointsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawimagepointsrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawimagepointsrecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawimagerect(Long,Long,Sreal,Sreal,Sreal,Sreal),Proc,Long,Pascal,Name('Gdipdrawimagerect'),Long,Proc,Raw,Pascal
        C25_Gdipdrawimagerecti(Long,Long,Long,Long,Long,Long),Proc,Long,Pascal,Name('Gdipdrawimagerecti'),Long,Proc,Raw,Pascal
        C25_Gdipdrawimagerectrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawimagerectrecti(Long Gpgraphics,Long Gpimage,Long Dstx,Long Dsty,Long Dstwidth,Long Dstheight,Long Srcx, Long Srcy, Long Srcwidth, Long Srcheight, Long Gscrunit, Long Imageattributes, Long Callback, Long Callbackdata),Proc,Long,Pascal,Name('Gdipdrawimagerectrecti'),Long,Proc,Raw,Pascal
        C25_Gdipdrawline(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawlinei(Long Graphics,Long Pen,Long X1,Long Y1,Long X2,Long Y2),Proc,Long,Pascal,Name('Gdipdrawlinei')
        C25_Gdipdrawlines(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawlinesi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipdrawPath(Long Grp,Long Pen,Long Path),Proc,Long,Pascal,Name('GdipdrawPath'),Long,Proc,Raw,Pascal
        C25_Gdipdrawpie(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawpiei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawpolygon(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawpolygoni(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawrectangle(Long Graphics,Long Pen,Sreal X,Sreal Y,Sreal W,Sreal Y),Proc,Long,Pascal,Name('Gdipdrawrectangle'),Long,Proc,Raw,Pascal
        C25_Gdipdrawrectanglei(Long Graphics,Long Pen,Long X,Long Y,Long W,Long H),Proc,Long,Pascal,Name('Gdipdrawrectanglei'),Long,Proc,Raw,Pascal
        C25_Gdipdrawrectangles(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawrectanglesi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipdrawstring(Long _Graphics, Long _Pstring, Long _Length, Long _Pfont, Long _Layoutrect, Long _Stringformat, Long _Brush),Proc,Long,Pascal,Name('Gdipdrawstring'),Long,Proc,Raw,Pascal
        C25_Gdipemftowmfbits(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipendcontainer(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafiledestpoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafiledestpointi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafiledestpoints(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafiledestpointsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafiledestrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafiledestrecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafilesrcrectdestpoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafilesrcrectdestpointi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafilesrcrectdestpoints(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafilesrcrectdestpointsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafilesrcrectdestrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipenumeratemetafilesrcrectdestrecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillclosedcurve(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillclosedcurve2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillclosedcurve2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillclosedcurvei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillellipse(Long,Long,Sreal,Sreal,Sreal,Sreal),Proc,Long,Pascal,Name('Gdipfillellipse'),Proc
        C25_Gdipfillellipsei(Long,Long,Long,Long,Long,Long),Proc,Long,Pascal,Name('Gdipfillellipsei'),Proc
        C25_GdipfillPath(Long,Long,Long),Proc,Long,Pascal,Name('GdipfillPath'),Long,Proc,Raw,Pascal
        C25_Gdipfillpie(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillpiei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillpolygon(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillpolygon2(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillpolygon2I(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillpolygoni(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillrectangle(Long,Long,Sreal,Sreal,Sreal,Sreal),Proc,Long,Pascal,Name('Gdipfillrectangle')
        C25_Gdipfillrectanglei(Long Graphic,Long Brush,Long X,Long Y,Long W,Long H),Proc,Long,Pascal,Name('Gdipfillrectanglei')
        C25_Gdipfillrectangles(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillrectanglesi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfillregion(Long Graphics, Long Brush,Long Region),Long,Pascal,Name('Gdipfillregion'),Proc
        C25_Gdipfindfirstimageitem(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipfindnextimageitem(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipflattenPath(Long Path, Long Matrix, Sreal Flatness),Proc,Long,Pascal,Name('GdipflattenPath'),Long,Proc,Raw,Pascal
        C25_Gdipflush(),Proc,Long,Pascal,Name('Gdipflush'),Long,Proc,Raw,Pascal
        C25_Gdipfree(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetadjustablearrowcapfillstate(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetadjustablearrowcapheight(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetadjustablearrowcapmiddleinset(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetadjustablearrowcapwidth(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetallpropertyitems(Long _Pimage,Long Totalbuffersize, Long Numproperties, Long Allitems),Proc,Long,Pascal,Name('Gdipgetallpropertyitems'),Long,Proc,Raw,Pascal
        C25_GdipGetbrushtype(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetcellascent(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetcelldescent(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetclip(Long _Graphic, Long _Region),Proc,Long,Pascal,Name('Gdipgetclip')
        C25_GdipGetclipbounds(Long _Graphic,Long _Rect),Proc,Long,Pascal,Name('Gdipgetclipbounds'),Long,Proc,Raw,Pascal
        C25_GdipGetclipboundsi(Long _Graphic,Long _Rect),Proc,Long,Pascal,Name('Gdipgetclipboundsi'),Long,Proc,Raw,Pascal
        C25_GdipGetcompositingmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetcompositingquality(Long,Long),Proc,Long,Pascal,Name('Gdipgetcompositingquality'),Long,Proc,Raw,Pascal
        C25_GdipGetcustomlinecapbasecap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetcustomlinecapbaseinset(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetcustomlinecapstrokecaps(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetcustomlinecapstrokejoin(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetcustomlinecaptype(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetcustomlinecapwidthscale(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetdc(Long),Proc,Long,Pascal,Name('Gdipgetdc'),Long,Proc,Raw,Pascal
        C25_GdipGetdc(Long,Long),Proc,Long,Pascal,Name('Gdipgetdc'),Long,Proc,Raw,Pascal
        C25_GdipGetdpix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetdpix(Long,Long),Proc,Long,Pascal,Name('Gdipgetdpix'),Long,Proc,Raw,Pascal
        C25_GdipGetdpiy(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetdpiy(Long,Long),Proc,Long,Pascal,Name('Gdipgetdpiy'),Long,Proc,Raw,Pascal
        C25_GdipGeteffectparameters(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGeteffectparametersize(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetemheight(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetEncoderParameterList(Long _pImage, long _clsidEncoder, long _psize, long _buffer),Long,Proc,Raw,Pascal,Name('GdipGetEncoderParameterList')
        C25_GdipGetEncoderParameterListSize(Long _pImage, long _clsidEncoder, long _psize),Long,Proc,Raw,Pascal,Name('GdipGetEncoderParameterListSize')
        C25_GdipGetfamily(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetfamilyname(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetfontcollectionfamilycount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetfontcollectionfamilylist(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetfontheight(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetfontheightgivendpi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetfontsize(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetfontstyle(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetfontunit(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetgenericfontfamilymonospace(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetgenericfontfamilysansserif(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetgenericfontfamilyserif(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGethatchbackgroundcolor(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGethatchstyle(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGethemffrommetafile(Long,Long),Proc,Long,Pascal,Name('Gdipgethemffrommetafile'),Proc
        C25_GdipGetimageattributesadjustedpalette(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetimagebounds(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetimagedecoders(ULong _Numencoders ,ULong _Size,Long _Bufferimagecodecinfo),Proc,Long,Pascal,Name('Gdipgetimagedecoders'),Long,Proc,Raw,Pascal
        C25_GdipGetimagedecoderssize(Long,Long),Proc,Long,Pascal,Name('Gdipgetimagedecoderssize'),Long,Proc,Raw,Pascal
        C25_GdipGetimagedimension(Long,Long,Long),Proc,Long,Pascal,Name('Gdipgetimagedimension'),Long,Proc,Raw,Pascal
        C25_GdipGetimageencoders(ULong _Numencoders ,ULong _Size,Long _Bufferimagecodecinfo),Proc,Long,Pascal,Name('Gdipgetimageencoders'),Long,Proc,Raw,Pascal
        C25_GdipGetimageencoderssize(Long,Long),Proc,Long,Pascal,Name('Gdipgetimageencoderssize'),Long,Proc,Raw,Pascal
        C25_GdipGetimageflags(Long,Long),Proc,Long,Pascal,Name('Gdipgetimageflags'),Long,Proc,Raw,Pascal
        C25_GdipGetimagegraphicscontext(Long _Image,Long _Graphics),Proc,Long,Pascal,Name('Gdipgetimagegraphicscontext'),Long,Proc,Raw,Pascal
        C25_GdipGetImageHeight(Long,Long),Proc,Long,Pascal,Name('Gdipgetimageheight'),Long,Proc,Raw,Pascal
        C25_GdipGetimagehorizontalresolution(Long,Long),Proc,Long,Pascal,Name('Gdipgetimagehorizontalresolution'),Long,Proc,Raw,Pascal
        C25_GdipGetimageitemdata(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetimagepalette(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetimagepalettesize(Long,Long),Proc,Long,Pascal,Name('Gdipgetimagepalettesize'),Long,Proc,Raw,Pascal
        C25_GdipGetimagepixelformat(Long,Long),Proc,Long,Pascal,Name('Gdipgetimagepixelformat'),Long,Proc,Raw,Pascal
        C25_GdipGetimagerawformat(Long _Pimage,Long _Guid),Proc,Long,Pascal,Name('Gdipgetimagerawformat'),Long,Proc,Raw,Pascal
        C25_GdipGetimagethumbnail(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetimagetype(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetimageverticalresolution(Long,Long),Proc,Long,Pascal,Name('Gdipgetimageverticalresolution'),Long,Proc,Raw,Pascal
        C25_GdipGetimagewidth(Long,Long),Proc,Long,Pascal,Name('Gdipgetimagewidth'),Long,Proc,Raw,Pascal
        C25_GdipGetinterpolationmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetlineblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetlinecolors(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetlinegammacorrection(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetlinepresetblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetlinespacing(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetlogfonta(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetlogfontw(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetmatrixelements(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetmetafiledownlevelrasterizationlimit(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetmetafileheaderfromemf(Long,Long),Proc,Long,Pascal,Name('Gdipgetmetafileheaderfromemf'),Proc
        C25_GdipGetmetafileheaderfromfile(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetmetafileheaderfrommetafile(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetmetafileheaderfromstream(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetmetafileheaderfromwmf(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetnearestcolor(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpagescale(Long,Long),Proc,Long,Pascal,Name('Gdipgetpagescale'),Long,Proc,Raw,Pascal
        C25_GdipGetpageunit(Long,Long),Proc,Long,Pascal,Name('Gdipgetpageunit'),Long,Proc,Raw,Pascal
        C25_GdipGetPathdata(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathfillmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientblendcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientcentercolor(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientcenterpoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientcenterpointi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientfocusscales(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientgammacorrection(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientpointcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientpresetblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientpresetblendcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientrecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientsurroundcolorcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientsurroundcolorswithcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathgradientwrapmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathlastpoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathpoints(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathpointsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathtypes(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetPathworldbounds(Long,Long,Long, Long),Proc,Long,Pascal,Name('GdipgetPathworldbounds'),Long,Proc,Raw,Pascal
        C25_GdipGetPathworldboundsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenbrushfill(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpencolor(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpencompoundarray(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpencompoundcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpencustomendcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpencustomstartcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpendasharray(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpendashcap197819(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpendashcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpendashoffset(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpendashstyle(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenendcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenfilltype(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenlinejoin(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenmiterlimit(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenstartcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpentransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenunit(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpenwidth(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpixeloffsetmode(Long,Long),Proc,Long,Pascal,Name('Gdipgetpixeloffsetmode'),Long,Proc,Raw,Pascal
        C25_GdipGetpointcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetpropertycount(Long _Pimage,Long _Count),Proc,Long,Pascal,Name('Gdipgetpropertycount'),Long,Proc,Raw,Pascal
        C25_GdipGetpropertyidlist(Long _Pimage,Long _Numofproperty,Long _Propidlist),Proc,Long,Pascal,Name('Gdipgetpropertyidlist'),Long,Proc,Raw,Pascal
        C25_GdipGetpropertyitem(Long _Pimage,Long _Propid,Long _Propitemsize,Long _Propitemvalue),Proc,Long,Pascal,Name('Gdipgetpropertyitem'),Long,Proc,Raw,Pascal
        C25_GdipGetpropertyitemsize(Long _Pimage,Long _Propid, Long _Propitemsize),Proc,Long,Pascal,Name('Gdipgetpropertyitemsize'),Long,Proc,Raw,Pascal
        C25_GdipGetpropertysize(Long _Pimage,Long Totalbuffersize, Long Numproperties),Proc,Long,Pascal,Name('Gdipgetpropertysize'),Long,Proc,Raw,Pascal
        C25_GdipGetregionbounds(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetregionboundsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetregiondata(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetregiondatasize(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetregionhrgn(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetregionscans(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetregionscanscount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetregionscansi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetrenderingorigin(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetsmoothingmode(Long,Long),Proc,Long,Pascal,Name('Gdipgetsmoothingmode'),Long,Proc,Raw,Pascal
        C25_GdipGetsolidfillcolor(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetstringformatalign(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetstringformatdigitsubstitution(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetstringformatflags(Long Pformat , Long Flagsptr),Proc,Long,Pascal,Name('Gdipgetstringformatflags'),Long,Proc,Raw,Pascal
        C25_GdipGetstringformathotkeyprefix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetstringformatlinealign(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetstringformatmeasurablecharacterrangecount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetstringformattabstopcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetstringformattabstops(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetstringformattrimming(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGettextcontrast(Long _Graphic, Long _Contrast),Proc,Long,Pascal,Name('Gdipgettextcontrast'),Long,Proc,Raw,Pascal
        C25_GdipGettextrenderinghint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGettextureimage(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGettexturetransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGettexturewrapmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipGetvisibleclipbounds(Long,Long),Proc,Long,Pascal,Name('Gdipgetvisibleclipbounds'),Long,Proc,Raw,Pascal
        C25_GdipGetvisibleclipboundsi(Long,Long),Proc,Long,Pascal,Name('Gdipgetvisibleclipboundsi'),Long,Proc,Raw,Pascal
        C25_GdipGetworldtransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipgraphicsclear(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipgraphicssetabort(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipimageforcevalidation(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipimagegetframecount(Long _Image,Long _Dimensionid, Long _Count),Proc,Long,Pascal,Name('Gdipimagegetframecount'),Proc
        C25_Gdipimagegetframedimensionscount(Long _Image,Long _Count),Proc,Long,Pascal,Name('Gdipimagegetframedimensionscount'),Proc
        C25_Gdipimagegetframedimensionslist(Long _Image, Long _Dimsids, Long _Count),Proc,Long,Pascal,Name('Gdipimagegetframedimensionslist'),Proc
        C25_Gdipimagerotateflip(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipimageselectactiveframe(Long _Image, Long _Dimensionguid, ULong _Frameindex),Proc,Long,Pascal,Name('Gdipimageselectactiveframe'),Long,Proc,Raw,Pascal
        C25_Gdipimagesetabort(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipinitializepalette(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipinvertmatrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisclipempty(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisemptyregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisequalregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisinfiniteregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipismatrixequal(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipismatrixidentity(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipismatrixinvertible(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipisoutlinevisiblePathpoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipisoutlinevisiblePathpointi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisstyleavailable(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisibleclipempty(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipisvisiblePathpoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipisvisiblePathpointi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisiblepoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisiblepointi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisiblerect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisiblerecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisibleregionpoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisibleregionpointi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisibleregionrect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipisvisibleregionrecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiploadimagefromfile(Long _Filenamew,Long _Gpimage),Proc,Long,Pascal,Name('Gdiploadimagefromfile'),Long,Proc,Raw,Pascal
        C25_Gdiploadimagefromfileicm(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiploadimagefromstream(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiploadimagefromstreamicm(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiplusnotificationhook(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiplusnotificationunhook(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiplusshutdown(Long),Proc,Long,Pascal,Name('Dummy'),Name('Gdiplusshutdown')
        C25_Gdiplusstartup(Long,Long,Long),Proc,Long,Pascal,Name('Dummy'),Name('Gdiplusstartup')
        C25_Gdipmeasurecharacterranges(Long,Long,Long,Long,Long,Long,Long),Proc,Long,Pascal,Name('Gdipmeasurecharacterranges'),Long,Proc,Raw,Pascal
        C25_Gdipmeasuredriverstring (Long,Long,Long,Long,Long,Long,Long,Long,Long),Proc,Long,Pascal,Name('Gdipmeasuredriverstring'),Long,Proc,Raw,Pascal
        C25_Gdipmeasurestring(Long Graphics,Long Pstring,Long Length,Long Pfont, Long Layoutrect,Long Stringformat, Long Boundingbox, Long Codepointsfitted, Long  Linesfilled),Proc,Long,Pascal,Name('Gdipmeasurestring'),Long,Proc,Raw,Pascal
        C25_Gdipmultiplymatrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipmultiplypentransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipmultiplytexturetransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipmultiplyworldtransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipnewinstalledfontcollection(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipnewprivatefontcollection(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathitercopydata(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiterenumerate(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathitergetcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathitergetsubPathcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiterhascurve(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiterisvalid(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiternextmarker(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiternextmarkerPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiternextPathtype(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiternextsubPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiternextsubPathPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipPathiterrewind(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipplaymetafilerecord(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipplaytsclientrecord(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipprivateaddfontfile(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipprivateaddmemoryfont(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprecordmetafile(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprecordmetafilefilename(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprecordmetafilefilenamei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprecordmetafilei(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprecordmetafilestream(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprecordmetafilestreami(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipreleasedc(Long Hwnd,Long Dc),Proc,Long,Pascal,Name('Gdipreleasedc'),Long,Proc,Raw,Pascal
        C25_Gdipremovepropertyitem(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipresetclip(Long),Proc,Long,Pascal,Name('Gdipresetclip'),Long,Proc,Raw,Pascal
        C25_Gdipresetimageattributes(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipresetpagetransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipresetPath(Long),Proc,Long,Pascal,Name('GdipresetPath'),Long,Proc,Raw,Pascal
        C25_Gdipresetpentransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipresettexturetransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipresetworldtransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprestoregraphics(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipreversePath(Long Path),Proc,Long,Pascal,Name('GdipreversePath'),Long,Proc,Raw,Pascal
        C25_Gdiprotatematrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprotatepentransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprotatetexturetransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiprotateworldtransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsaveadd(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsaveaddimage(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsavegraphics(Long,Long),Proc,Long,Pascal,Name('Gdipsavegraphics'),Long,Proc,Raw,Pascal
        C25_Gdipsaveimagetofile(Long _Pimage,Long _Filenameutf16,Long _Encoder,Long _Encoderparams),Proc,Long,Pascal,Name('Gdipsaveimagetofile'),Long,Proc,Raw,Pascal
        C25_Gdipsaveimagetostream(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipscalematrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipscalepentransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipscaletexturetransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipscaleworldtransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetadjustablearrowcapfillstate(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetadjustablearrowcapheight(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetadjustablearrowcapmiddleinset(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetadjustablearrowcapwidth(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetclipgraphics(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetcliphrgn(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetclipPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetcliprect(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetcliprecti(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetclipregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetcompositingmode(Long,Long),Proc,Long,Pascal,Name('Gdipsetcompositingmode'),Long,Proc,Raw,Pascal
        C25_Gdipsetcompositingquality(Long,Long),Proc,Long,Pascal,Name('Gdipsetcompositingquality'),Long,Proc,Raw,Pascal
        C25_Gdipsetcustomlinecapbasecap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetcustomlinecapbaseinset(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetcustomlinecapstrokecaps(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetcustomlinecapstrokejoin(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetcustomlinecapwidthscale(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetdpix(Long,Sreal),Proc,Long,Pascal,Name('Gdipsetdpix'),Long,Proc,Raw,Pascal
        C25_Gdipsetdpiy(Long,Sreal),Proc,Long,Pascal,Name('Gdipsetdpiy'),Long,Proc,Raw,Pascal
        C25_Gdipseteffectparameters(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetempty(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributescachedbackground(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributescolorkeys(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributescolormatrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributesgamma(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributesnoop(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributesoutputchannel(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributesoutputchannelcolorprofile(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributesremaptable(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributesthreshold(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributestoidentity(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimageattributeswrapmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetimagepalette(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetinfinite(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetinterpolationmode(Long,Long),Proc,Long,Pascal,Name('Gdipsetinterpolationmode'),Long,Proc,Raw,Pascal
        C25_Gdipsetlineblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetlinecolors(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetlinegammacorrection(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetlinepresetblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetlinesigmablend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetlinewrapmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetmatrixelements(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetmetafiledownlevelrasterizationlimit(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpagescale(Long,Sreal),Proc,Long,Pascal,Name('Gdipsetpagescale'),Long,Proc,Raw,Pascal
        C25_Gdipsetpageunit(Long,Long),Proc,Long,Pascal,Name('Gdipsetpageunit'),Long,Proc,Raw,Pascal
        C25_GdipsetPathfillmode(Long Path, Long Mode),Proc,Long,Pascal,Name('GdipsetPathfillmode'),Long,Proc,Raw,Pascal
        C25_GdipsetPathgradientblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientcentercolor(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientcenterpoint(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientcenterpointi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientfocusscales(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientgammacorrection(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientlinearblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientpresetblend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientsigmablend(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientsurroundcolorswithcount(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathgradientwrapmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipsetPathmarker(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenbrushfill(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpencolor(Long Pen, Long Color),Proc,Long,Pascal,Name('Gdipsetpencolor'),Long,Proc,Raw,Pascal
        C25_Gdipsetpencompoundarray(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpencustomendcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpencustomstartcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpendasharray(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpendashcap197819(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpendashoffset(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpendashstyle(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenendcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenlinecap197819(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenlinejoin(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenmiterlimit(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenstartcap(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpentransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenunit(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpenwidth(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetpixeloffsetmode(Long,Long),Proc,Long,Pascal,Name('Gdipsetpixeloffsetmode'),Long,Proc,Raw,Pascal
        C25_Gdipsetpropertyitem(Long,Long),Proc,Long,Pascal,Name('Gdipsetpropertyitem'),Long,Proc,Raw,Pascal
        C25_Gdipsetrenderingorigin(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetsmoothingmode(Long,Long),Proc,Long,Pascal,Name('Gdipsetsmoothingmode'),Long,Proc,Raw,Pascal
        C25_Gdipsetsolidfillcolor(Long,Long),Proc,Long,Pascal,Name('Gdipsetsolidfillcolor'),Long,Proc,Raw,Pascal
        C25_Gdipsetstringformatalign(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetstringformatdigitsubstitution(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetstringformatflags(Long Pformat , Long Flags),Proc,Long,Pascal,Name('Gdipsetstringformatflags'),Long,Proc,Raw,Pascal
        C25_Gdipsetstringformathotkeyprefix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetstringformatlinealign(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetstringformatmeasurablecharacterranges(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetstringformattabstops(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetstringformattrimming(Long Pformat , Long Trimming),Proc,Long,Pascal,Name('Gdipsetstringformattrimming'),Long,Proc,Raw,Pascal
        C25_Gdipsettextcontrast(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsettextrenderinghint(Long,Long),Proc,Long,Pascal,Name('Gdipsettextrenderinghint'),Long,Proc,Raw,Pascal
        C25_Gdipsettexturetransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsettexturewrapmode(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipsetworldtransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipshearmatrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipstartPathfigure(Long Path),Proc,Long,Pascal,Name('GdipstartPathfigure'),Long,Proc,Raw,Pascal
        C25_Gdipstringformatgetgenericdefault(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipstringformatgetgenerictypographic(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptestcontrol(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptransformmatrixpoints(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptransformmatrixpointsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdiptransformPath(Long Path, Long Matrix),Proc,Long,Pascal,Name('GdiptransformPath'),Long,Proc,Raw,Pascal
        C25_Gdiptransformpoints(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptransformpointsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptransformregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptranslateclip(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptranslateclipi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptranslatematrix(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdiptranslatePathgradienttransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptranslatepentransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptranslateregion(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptranslateregioni(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptranslatetexturetransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdiptranslateworldtransform(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipvectortransformmatrixpoints(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipvectortransformmatrixpointsi(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipwarpPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_GdipwidenPath(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
        C25_Gdipwindingmodeoutline(Long _Notimplemented),Long,Proc,Raw,Pascal,Name('DUMMY')
    End
    Module('Gdi32.Dll')
        C25_Gdiroundrect(Long Hdc, Long Nleftrect, Long Ntoprect, Long Nrightrect, Long Nbottomrect, Long Nwidth, Long Nheight), Bool, Raw, Pascal,Name('Gdiroundrect')
    End
    Module('Others.Dll')
        C25_Bcryptclosealgorithmprovider(Long Algorithmhandle, Long Bcryptclosealgorithmproviderflags),Long,Proc,Pascal,Name('Bcryptclosealgorithmprovider')
        C25_Bcryptenumalgorithms(Long Dwalgoperations, Long Palgcount, Long Ppalglist, Long Bcryptenumalgorithmsflags),Long,Proc,Pascal,Name('Bcryptenumalgorithms')
        C25_Bcryptfreebuffer(Long Pvbuffer),Long,Proc,Pascal,Name('Bcryptfreebuffer')
        C25_Bcryptgenrandom(Long Halgorithm, Long Pbbuffer, ULong Cbbuffer, ULong Dwflags),Long,Proc,Pascal,Name('Bcryptgenrandom')
        C25_Bcryptopenalgorithmprovider(Long Phalgorithm, Long Pszalgid, Long Pszimplementation, Long Dwflags),Long,Proc,Pascal,Name('Bcryptopenalgorithmprovider')
        C25_D2D1Createfactory(Long Factorytype,Long Riid,Long Pfactoryoptions,Long Ppifactory),Proc,Long,Pascal,Name('D2D1Createfactory')
        C25_Dwritecreatefactory(Long Factorytype, Long Iid, Long Iunknown),Proc,Long,Pascal,Name('Dwritecreatefactory')
    End

