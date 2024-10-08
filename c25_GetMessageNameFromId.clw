GetMessageNameFromId Procedure(ULong _id)


    Code

        Case _id
        Of 0
            Return 'WM_NULL'
        Of 1
            Return 'WM_CREATE'
        Of 2
            Return 'WM_DESTROY'
        Of 3
            Return 'WM_MOVE'
        Of 4
            Return 'WM_SIZEWAIT'
        Of 5
            Return 'WM_SIZE'
        Of 6
            Return 'WM_ACTIVATE'
        Of 7
            Return 'WM_SETFOCUS'
        Of 8
            Return 'WM_KILLFOCUS'
        Of 9
            Return 'WM_SETVISIBLE'
        Of 10
            Return 'WM_ENABLE'
        Of 11
            Return 'WM_SETREDRAW'
        Of 12
            Return 'WM_SETTEXT'
        Of 13
            Return 'WM_GETTEXT'
        Of 14
            Return 'WM_GETTEXTLENGTH'
        Of 15
            Return 'WM_PAINT'
        Of 16
            Return 'WM_CLOSE'
        Of 17
            Return 'WM_QUERYENDSESSION'
        Of 18
            Return 'WM_QUIT'
        Of 19
            Return 'WM_QUERYOPEN'
        Of 20
            Return 'WM_ERASEBKGND'
        Of 21
            Return 'WM_SYSCOLORCHANGE'
        Of 22
            Return 'WM_ENDSESSION'
        Of 23
            Return 'WM_SYSTEMERROR'
        Of 24
            Return 'WM_SHOWWINDOW'
        Of 25
            Return 'WM_CTLCOLOR'
        Of 26
            Return 'WM_WININICHANGE'
        Of 27
            Return 'WM_DEVMODECHANGE'
        Of 28
            Return 'WM_ACTIVATEAPP'
        Of 29
            Return 'WM_FONTCHANGE'
        Of 30
            Return 'WM_TIMECHANGE'
        Of 31
            Return 'WM_CANCELMODE'
        Of 32
            Return 'WM_SETCURSOR'
        Of 33
            Return 'WM_MOUSEACTIVATE'
        Of 34
            Return 'WM_CHILDACTIVATE'
        Of 35
            Return 'WM_QUEUESYNC'
        Of 36
            Return 'WM_GETMINMAXINFO'
        Of 37
            Return 'WM_LOGOFF'
        Of 38
            Return 'WM_PAINTICON'
        Of 39
            Return 'WM_ICONERASEBKGND'
        Of 40
            Return 'WM_NEXTDLGCTL'
        Of 41
            Return 'WM_ALTTABACTIVE'
        Of 42
            Return 'WM_SPOOLERSTATUS'
        Of 43
            Return 'WM_DRAWITEM'
        Of 44
            Return 'WM_MEASUREITEM'
        Of 45
            Return 'WM_DELETEITEM'
        Of 46
            Return 'WM_VKEYTOITEM'
        Of 47
            Return 'WM_CHARTOITEM'
        Of 48
            Return 'WM_SETFONT'
        Of 49
            Return 'WM_GETFONT'
        Of 50
            Return 'WM_SETHOTKEY'
        Of 51
            Return 'WM_GETHOTKEY'
        Of 52
            Return 'WM_SHELLNOTIFY'
        Of 53
            Return 'WM_ISACTIVEICON'
        Of 54
            Return 'WM_QUERYPARKICON'
        Of 55
            Return 'WM_QUERYDRAGICON'
        Of 56
            Return 'WM_WINHELP'
        Of 57
            Return 'WM_COMPAREITEM'
        Of 58
            Return 'WM_FULLSCREEN'
        Of 59
            Return 'WM_CLIENTSHUTDOWN'
        Of 60
            Return 'WM_DDEMLEVENT'
        Of 61
            Return 'WM_GETOBJECT'
        Of 64
            Return 'WM_TESTING'
        Of 65
            Return 'WM_COMPACTING'
        Of 66
            Return 'WM_OTHERWINDOWCREATED'
        Of 67
            Return 'WM_OTHERWINDOWDESTROYED'
        Of 68
            Return 'WM_COMMNOTIFY'
        Of 70
            Return 'WM_WINDOWPOSCHANGING'
        Of 71
            Return 'WM_WINDOWPOSCHANGED'
        Of 72
            Return 'WM_POWER'
        Of 73
            Return 'WM_COPYGLOBALDATA'
        Of 74
            Return 'WM_COPYDATA'
        Of 75
            Return 'WM_CANCELJOURNAL'
        Of 77
            Return 'WM_KEYF1'
        Of 78
            Return 'WM_NOTIFY'
        Of 79
            Return 'WM_ACCESS_WINDOW'
        Of 80
            Return 'WM_INPUTLANGCHANGEREQUEST'
        Of 81
            Return 'WM_INPUTLANGCHANGE'
        Of 82
            Return 'WM_TCARD'
        Of 83
            Return 'WM_HELP'
        Of 84
            Return 'WM_USERCHANGED'
        Of 85
            Return 'WM_NOTIFYFORMAT'
        Of 112
            Return 'WM_FINALDESTROY'
        Of 113
            Return 'WM_MEASUREITEM_CLIENTDATA'
        Of 123
            Return 'WM_CONTEXTMENU'
        Of 124
            Return 'WM_STYLECHANGING'
        Of 125
            Return 'WM_STYLECHANGED'
        Of 126
            Return 'WM_DISPLAYCHANGE'
        Of 127
            Return 'WM_GETICON'
        Of 128
            Return 'WM_SETICON'
        Of 129
            Return 'WM_NCCREATE'
        Of 130
            Return 'WM_NCDESTROY'
        Of 131
            Return 'WM_NCCALCSIZE'
        Of 132
            Return 'WM_NCHITTEST'
        Of 133
            Return 'WM_NCPAINT'
        Of 134
            Return 'WM_NCACTIVATE'
        Of 135
            Return 'WM_GETDLGCODE'
        Of 136
            Return 'WM_SYNCPAINT'
        Of 137
            Return 'WM_SYNCTASK'
        Of 139
            Return 'WM_KLUDGEMINRECT'
        Of 140
            Return 'WM_LPKDRAWSWITCHWND'
        Of 144
            Return 'WM_UAHDESTROYWINDOW'
        Of 145
            Return 'WM_UAHDRAWMENU'
        Of 146
            Return 'WM_UAHDRAWMENUITEM'
        Of 147
            Return 'WM_UAHINITMENU'
        Of 148
            Return 'WM_UAHMEASUREMENUITEM'
        Of 149
            Return 'WM_UAHNCPAINTMENUPOPUP'
        Of 150
            Return 'WM_UAHUPDATE'
        Of 160
            Return 'WM_NCMOUSEMOVE'
        Of 161
            Return 'WM_NCLBUTTONDOWN'
        Of 162
            Return 'WM_NCLBUTTONUP'
        Of 163
            Return 'WM_NCLBUTTONDBLCLK'
        Of 164
            Return 'WM_NCRBUTTONDOWN'
        Of 165
            Return 'WM_NCRBUTTONUP'
        Of 166
            Return 'WM_NCRBUTTONDBLCLK'
        Of 167
            Return 'WM_NCMBUTTONDOWN'
        Of 168
            Return 'WM_NCMBUTTONUP'
        Of 169
            Return 'WM_NCMBUTTONDBLCLK'
        Of 171
            Return 'WM_NCXBUTTONDOWN'
        Of 172
            Return 'WM_NCXBUTTONUP'
        Of 173
            Return 'WM_NCXBUTTONDBLCLK'
        Of 174
            Return 'WM_NCUAHDRAWCAPTION'
        Of 175
            Return 'WM_NCUAHDRAWFRAME'
        Of 254
            Return 'WM_INPUT_DEVICE_CHANGE'
        Of 255
            Return 'WM_INPUT'
        Of 256
            Return 'WM_KEYDOWN'
        Of 256
            Return 'WM_KEYFIRST'
        Of 257
            Return 'WM_KEYUP'
        Of 258
            Return 'WM_CHAR'
        Of 259
            Return 'WM_DEADCHAR'
        Of 260
            Return 'WM_SYSKEYDOWN'
        Of 261
            Return 'WM_SYSKEYUP'
        Of 262
            Return 'WM_SYSCHAR'
        Of 263
            Return 'WM_SYSDEADCHAR'
        Of 264
            Return 'WM_KEYLAST'
        Of 265
            Return 'WM_UNICHAR'
        Of 265
            Return 'WM_WNT_CONVERTREQUESTEX'
        Of 266
            Return 'WM_CONVERTREQUEST'
        Of 267
            Return 'WM_CONVERTRESULT'
        Of 268
            Return 'WM_INTERIM'
        Of 269
            Return 'WM_IME_STARTCOMPOSITION'
        Of 270
            Return 'WM_IME_ENDCOMPOSITION'
        Of 271
            Return 'WM_IME_COMPOSITION'
        Of 271
            Return 'WM_IME_KEYLAST'
        Of 272
            Return 'WM_INITDIALOG'
        Of 273
            Return 'WM_COMMAND'
        Of 274
            Return 'WM_SYSCOMMAND'
        Of 275
            Return 'WM_TIMER'
        Of 276
            Return 'WM_HSCROLL'
        Of 277
            Return 'WM_VSCROLL'
        Of 278
            Return 'WM_INITMENU'
        Of 279
            Return 'WM_INITMENUPOPUP'
        Of 280
            Return 'WM_SYSTIMER'
        Of 281
            Return 'WM_GESTURE'
        Of 282
            Return 'WM_GESTURENOTIFY'
        Of 283
            Return 'WM_GESTUREINPUT'
        Of 284
            Return 'WM_GESTURENOTIFIED'
        Of 287
            Return 'WM_MENUSELECT'
        Of 288
            Return 'WM_MENUCHAR'
        Of 289
            Return 'WM_ENTERIDLE'
        Of 290
            Return 'WM_MENURBUTTONUP'
        Of 291
            Return 'WM_MENUDRAG'
        Of 292
            Return 'WM_MENUGETOBJECT'
        Of 293
            Return 'WM_UNINITMENUPOPUP'
        Of 294
            Return 'WM_MENUCOMMAND'
        Of 295
            Return 'WM_CHANGEUISTATE'
        Of 296
            Return 'WM_UPDATEUISTATE'
        Of 297
            Return 'WM_QUERYUISTATE'
        Of 305
            Return 'WM_LBTRACKPOINT'
        Of 306
            Return 'WM_CTLCOLORMSGBOX'
        Of 307
            Return 'WM_CTLCOLOREDIT'
        Of 308
            Return 'WM_CTLCOLORLISTBOX'
        Of 309
            Return 'WM_CTLCOLORBTN'
        Of 310
            Return 'WM_CTLCOLORDLG'
        Of 311
            Return 'WM_CTLCOLORSCROLLBAR'
        Of 312
            Return 'WM_CTLCOLORSTATIC'
        Of 512
            Return 'WM_MOUSEFIRST'
        Of 512
            Return 'WM_MOUSEMOVE'
        Of 513
            Return 'WM_LBUTTONDOWN'
        Of 514
            Return 'WM_LBUTTONUP'
        Of 515
            Return 'WM_LBUTTONDBLCLK'
        Of 516
            Return 'WM_RBUTTONDOWN'
        Of 517
            Return 'WM_RBUTTONUP'
        Of 518
            Return 'WM_RBUTTONDBLCLK'
        Of 519
            Return 'WM_MBUTTONDOWN'
        Of 520
            Return 'WM_MBUTTONUP'
        Of 521
            Return 'WM_MBUTTONDBLCLK'
        Of 521
            Return 'WM_MOUSELAST'
        Of 522
            Return 'WM_MOUSEWHEEL'
        Of 523
            Return 'WM_XBUTTONDOWN'
        Of 524
            Return 'WM_XBUTTONUP'
        Of 525
            Return 'WM_XBUTTONDBLCLK'
        Of 526
            Return 'WM_MOUSEHWHEEL'
        Of 528
            Return 'WM_PARENTNOTIFY'
        Of 529
            Return 'WM_ENTERMENULOOP'
        Of 530
            Return 'WM_EXITMENULOOP'
        Of 531
            Return 'WM_NEXTMENU'
        Of 532
            Return 'WM_SIZING'
        Of 533
            Return 'WM_CAPTURECHANGED'
        Of 534
            Return 'WM_MOVING'
        Of 536
            Return 'WM_POWERBROADCAST'
        Of 537
            Return 'WM_DEVICECHANGE'
        Of 544
            Return 'WM_MDICREATE'
        Of 545
            Return 'WM_MDIDESTROY'
        Of 546
            Return 'WM_MDIACTIVATE'
        Of 547
            Return 'WM_MDIRESTORE'
        Of 548
            Return 'WM_MDINEXT'
        Of 549
            Return 'WM_MDIMAXIMIZE'
        Of 550
            Return 'WM_MDITILE'
        Of 551
            Return 'WM_MDICASCADE'
        Of 552
            Return 'WM_MDIICONARRANGE'
        Of 553
            Return 'WM_MDIGETACTIVE'
        Of 554
            Return 'WM_DROPOBJECT'
        Of 555
            Return 'WM_QUERYDROPOBJECT'
        Of 556
            Return 'WM_BEGINDRAG'
        Of 557
            Return 'WM_DRAGLOOP'
        Of 558
            Return 'WM_DRAGSELECT'
        Of 559
            Return 'WM_DRAGMOVE'
        Of 560
            Return 'WM_MDISETMENU'
        Of 561
            Return 'WM_ENTERSIZEMOVE'
        Of 562
            Return 'WM_EXITSIZEMOVE'
        Of 563
            Return 'WM_DROPFILES'
        Of 564
            Return 'WM_MDIREFRESHMENU'
        Of 568
            Return 'WM_POINTERDEVICECHANGE'
        Of 569
            Return 'WM_POINTERDEVICEINRANGE'
        Of 570
            Return 'WM_POINTERDEVICEOUTOFRANGE'
        Of 571
            Return 'WM_STOPINERTIA'
        Of 572
            Return 'WM_ENDINERTIA'
        Of 573
            Return 'WM_EDGYINERTIA'
        Of 576
            Return 'WM_TOUCH'
        Of 577
            Return 'WM_NCPOINTERUPDATE'
        Of 578
            Return 'WM_NCPOINTERDOWN'
        Of 579
            Return 'WM_NCPOINTERUP'
        Of 580
            Return 'WM_NCPOINTERLAST'
        Of 581
            Return 'WM_POINTERUPDATE'
        Of 582
            Return 'WM_POINTERDOWN'
        Of 583
            Return 'WM_POINTERUP'
        Of 584
            Return 'WM_POINTER_reserved_248'
        Of 585
            Return 'WM_POINTERENTER'
        Of 586
            Return 'WM_POINTERLEAVE'
        Of 587
            Return 'WM_POINTERACTIVATE'
        Of 588
            Return 'WM_POINTERCAPTURECHANGED'
        Of 589
            Return 'WM_TOUCHHITTESTING'
        Of 590
            Return 'WM_POINTERWHEEL'
        Of 591
            Return 'WM_POINTERHWHEEL'
        Of 592
            Return 'WM_POINTER_reserved_250'
        Of 593
            Return 'WM_POINTERROUTEDTO'
        Of 594
            Return 'WM_POINTERROUTEDAWAY'
        Of 595
            Return 'WM_POINTERROUTEDRELEASED'
        Of 596
            Return 'WM_POINTER_reserved_254'
        Of 597
            Return 'WM_POINTER_reserved_255'
        Of 598
            Return 'WM_POINTER_reserved_256'
        Of 599
            Return 'WM_POINTERLAST'
        Of 624
            Return 'WM_VISIBILITYCHANGED'
        Of 625
            Return 'WM_VIEWSTATECHANGED'
        Of 626
            Return 'WM_UNREGISTER_WINDOW_SERVICES'
        Of 627
            Return 'WM_CONSOLIDATED'
        Of 640
            Return 'WM_IME_REPORT'
        Of 641
            Return 'WM_IME_SETCONTEXT'
        Of 642
            Return 'WM_IME_NOTIFY'
        Of 643
            Return 'WM_IME_CONTROL'
        Of 644
            Return 'WM_IME_COMPOSITIONFULL'
        Of 645
            Return 'WM_IME_SELECT'
        Of 646
            Return 'WM_IME_CHAR'
        Of 647
            Return 'WM_IME_SYSTEM'
        Of 648
            Return 'WM_IME_REQUEST'
        Of 649
            Return 'WM_KANJI_reserved_289'
        Of 650
            Return 'WM_KANJI_reserved_28a'
        Of 651
            Return 'WM_KANJI_reserved_28b'
        Of 652
            Return 'WM_KANJI_reserved_28c'
        Of 653
            Return 'WM_KANJI_reserved_28d'
        Of 654
            Return 'WM_KANJI_reserved_28e'
        Of 655
            Return 'WM_KANJI_reserved_28f'
        Of 656
            Return 'WM_IMEKEYDOWN'
        Of 656
            Return 'WM_IME_KEYDOWN'
        Of 657
            Return 'WM_IMEKEYUP'
        Of 657
            Return 'WM_IME_KEYUP'
        Of 658
            Return 'WM_KANJI_reserved_292'
        Of 659
            Return 'WM_KANJI_reserved_293'
        Of 660
            Return 'WM_KANJI_reserved_294'
        Of 661
            Return 'WM_KANJI_reserved_295'
        Of 662
            Return 'WM_KANJI_reserved_296'
        Of 663
            Return 'WM_KANJI_reserved_297'
        Of 664
            Return 'WM_KANJI_reserved_298'
        Of 665
            Return 'WM_KANJI_reserved_299'
        Of 666
            Return 'WM_KANJI_reserved_29a'
        Of 667
            Return 'WM_KANJI_reserved_29b'
        Of 668
            Return 'WM_KANJI_reserved_29c'
        Of 669
            Return 'WM_KANJI_reserved_29d'
        Of 670
            Return 'WM_KANJI_reserved_29e'
        Of 671
            Return 'WM_KANJILAST'
        Of 672
            Return 'WM_NCMOUSEHOVER'
        Of 673
            Return 'WM_MOUSEHOVER'
        Of 674
            Return 'WM_NCMOUSELEAVE'
        Of 675
            Return 'WM_MOUSELEAVE'
        Of 676
            Return 'WM_TRACKMOUSEEVENT__reserved_2a4'
        Of 677
            Return 'WM_TRACKMOUSEEVENT__reserved_2a5'
        Of 678
            Return 'WM_TRACKMOUSEEVENT__reserved_2a6'
        Of 679
            Return 'WM_TRACKMOUSEEVENT__reserved_2a7'
        Of 680
            Return 'WM_TRACKMOUSEEVENT__reserved_2a8'
        Of 681
            Return 'WM_TRACKMOUSEEVENT__reserved_2a9'
        Of 682
            Return 'WM_TRACKMOUSEEVENT__reserved_2aa'
        Of 683
            Return 'WM_TRACKMOUSEEVENT__reserved_2ab'
        Of 684
            Return 'WM_TRACKMOUSEEVENT__reserved_2ac'
        Of 685
            Return 'WM_TRACKMOUSEEVENT__reserved_2ad'
        Of 686
            Return 'WM_TRACKMOUSEEVENT__reserved_2ae'
        Of 687
            Return 'WM_TRACKMOUSEEVENT_LAST'
        Of 689
            Return 'WM_WTSSESSION_CHANGE'
        Of 704
            Return 'WM_TABLET_FIRST'
        Of 705
            Return 'WM_TABLET__reserved_2c1'
        Of 706
            Return 'WM_TABLET__reserved_2c2'
        Of 707
            Return 'WM_TABLET__reserved_2c3'
        Of 708
            Return 'WM_TABLET__reserved_2c4'
        Of 709
            Return 'WM_TABLET__reserved_2c5'
        Of 710
            Return 'WM_TABLET__reserved_2c6'
        Of 711
            Return 'WM_TABLET__reserved_2c7'
        Of 712
            Return 'WM_POINTERDEVICEADDED'
        Of 713
            Return 'WM_POINTERDEVICEDELETED'
        Of 714
            Return 'WM_TABLET__reserved_2ca'
        Of 715
            Return 'WM_FLICK'
        Of 716
            Return 'WM_TABLET__reserved_2cc'
        Of 717
            Return 'WM_FLICKINTERNAL'
        Of 718
            Return 'WM_BRIGHTNESSCHANGED'
        Of 719
            Return 'WM_TABLET__reserved_2cf'
        Of 720
            Return 'WM_TABLET__reserved_2d0'
        Of 721
            Return 'WM_TABLET__reserved_2d1'
        Of 722
            Return 'WM_TABLET__reserved_2d2'
        Of 723
            Return 'WM_TABLET__reserved_2d3'
        Of 724
            Return 'WM_TABLET__reserved_2d4'
        Of 725
            Return 'WM_TABLET__reserved_2d5'
        Of 726
            Return 'WM_TABLET__reserved_2d6'
        Of 727
            Return 'WM_TABLET__reserved_2d7'
        Of 728
            Return 'WM_TABLET__reserved_2d8'
        Of 729
            Return 'WM_TABLET__reserved_2d9'
        Of 730
            Return 'WM_TABLET__reserved_2da'
        Of 731
            Return 'WM_TABLET__reserved_2db'
        Of 732
            Return 'WM_TABLET__reserved_2dc'
        Of 733
            Return 'WM_TABLET__reserved_2dd'
        Of 734
            Return 'WM_TABLET__reserved_2de'
        Of 735
            Return 'WM_TABLET_LAST'
        Of 736
            Return 'WM_DPICHANGED'
        Of 738
            Return 'WM_DPICHANGED_BEFOREPARENT'
        Of 739
            Return 'WM_DPICHANGED_AFTERPARENT'
        Of 740
            Return 'WM_GETDPISCALEDSIZE'
        Of 768
            Return 'WM_CUT'
        Of 769
            Return 'WM_COPY'
        Of 770
            Return 'WM_PASTE'
        Of 771
            Return 'WM_CLEAR'
        Of 772
            Return 'WM_UNDO'
        Of 773
            Return 'WM_RENDERFORMAT'
        Of 774
            Return 'WM_RENDERALLFORMATS'
        Of 775
            Return 'WM_DESTROYCLIPBOARD'
        Of 776
            Return 'WM_DRAWCLIPBOARD'
        Of 777
            Return 'WM_PAINTCLIPBOARD'
        Of 778
            Return 'WM_VSCROLLCLIPBOARD'
        Of 779
            Return 'WM_SIZECLIPBOARD'
        Of 780
            Return 'WM_ASKCBFORMATNAME'
        Of 781
            Return 'WM_CHANGECBCHAIN'
        Of 782
            Return 'WM_HSCROLLCLIPBOARD'
        Of 783
            Return 'WM_QUERYNEWPALETTE'
        Of 784
            Return 'WM_PALETTEISCHANGING'
        Of 785
            Return 'WM_PALETTECHANGED'
        Of 786
            Return 'WM_HOTKEY'
        Of 787
            Return 'WM_SYSMENU'
        Of 788
            Return 'WM_HOOKMSG'
        Of 789
            Return 'WM_EXITPROCESS'
        Of 790
            Return 'WM_WAKETHREAD'
        Of 791
            Return 'WM_PRINT'
        Of 792
            Return 'WM_PRINTCLIENT'
        Of 793
            Return 'WM_APPCOMMAND'
        Of 794
            Return 'WM_THEMECHANGED'
        Of 795
            Return 'WM_UAHINIT'
        Of 796
            Return 'WM_DESKTOPNOTIFY'
        Of 797
            Return 'WM_CLIPBOARDUPDATE'
        Of 798
            Return 'WM_DWMCOMPOSITIONCHANGED'
        Of 799
            Return 'WM_DWMNCRENDERINGCHANGED'
        Of 800
            Return 'WM_DWMCOLORIZATIONCOLORCHANGED'
        Of 801
            Return 'WM_DWMWINDOWMAXIMIZEDCHANGE'
        Of 802
            Return 'WM_DWMEXILEFRAME'
        Of 803
            Return 'WM_DWMSENDICONICTHUMBNAIL'
        Of 804
            Return 'WM_MAGNIFICATION_STARTED'
        Of 805
            Return 'WM_MAGNIFICATION_ENDED'
        Of 806
            Return 'WM_DWMSENDICONICLIVEPREVIEWBITMAP'
        Of 807
            Return 'WM_DWMTHUMBNAILSIZECHANGED'
        Of 808
            Return 'WM_MAGNIFICATION_OUTPUT'
        Of 809
            Return 'WM_BSDRDATA'
        Of 810
            Return 'WM_DWMTRANSITIONSTATECHANGED'
        Of 812
            Return 'WM_KEYBOARDCORRECTIONCALLOUT'
        Of 813
            Return 'WM_KEYBOARDCORRECTIONACTION'
        Of 814
            Return 'WM_UIACTION'
        Of 815
            Return 'WM_ROUTED_UI_EVENT'
        Of 816
            Return 'WM_MEASURECONTROL'
        Of 817
            Return 'WM_GETACTIONTEXT'
        Of 818
            Return 'WM_CE_ONLY__reserved_332'
        Of 819
            Return 'WM_FORWARDKEYDOWN'
        Of 820
            Return 'WM_FORWARDKEYUP'
        Of 821
            Return 'WM_CE_ONLY__reserved_335'
        Of 822
            Return 'WM_CE_ONLY__reserved_336'
        Of 823
            Return 'WM_CE_ONLY__reserved_337'
        Of 824
            Return 'WM_CE_ONLY__reserved_338'
        Of 825
            Return 'WM_CE_ONLY__reserved_339'
        Of 826
            Return 'WM_CE_ONLY__reserved_33a'
        Of 827
            Return 'WM_CE_ONLY__reserved_33b'
        Of 828
            Return 'WM_CE_ONLY__reserved_33c'
        Of 829
            Return 'WM_CE_ONLY__reserved_33d'
        Of 830
            Return 'WM_CE_ONLY_LAST'
        Of 831
            Return 'WM_GETTITLEBARINFOEX'
        Of 832
            Return 'WM_NOTIFYWOW'
        Of 856
            Return 'WM_HANDHELDFIRST'
        Of 857
            Return 'WM_HANDHELD_reserved_359'
        Of 858
            Return 'WM_HANDHELD_reserved_35a'
        Of 859
            Return 'WM_HANDHELD_reserved_35b'
        Of 860
            Return 'WM_HANDHELD_reserved_35c'
        Of 861
            Return 'WM_HANDHELD_reserved_35d'
        Of 862
            Return 'WM_HANDHELD_reserved_35e'
        Of 863
            Return 'WM_HANDHELDLAST'
        Of 864
            Return 'WM_AFXFIRST'
        Of 865
            Return 'WM_AFX_reserved_361'
        Of 866
            Return 'WM_AFX_reserved_362'
        Of 867
            Return 'WM_AFX_reserved_363'
        Of 868
            Return 'WM_AFX_reserved_364'
        Of 869
            Return 'WM_AFX_reserved_365'
        Of 870
            Return 'WM_AFX_reserved_366'
        Of 871
            Return 'WM_AFX_reserved_367'
        Of 872
            Return 'WM_AFX_reserved_368'
        Of 873
            Return 'WM_AFX_reserved_369'
        Of 874
            Return 'WM_AFX_reserved_36a'
        Of 875
            Return 'WM_AFX_reserved_36b'
        Of 876
            Return 'WM_AFX_reserved_36c'
        Of 877
            Return 'WM_AFX_reserved_36d'
        Of 878
            Return 'WM_AFX_reserved_36e'
        Of 879
            Return 'WM_AFX_reserved_36f'
        Of 880
            Return 'WM_AFX_reserved_370'
        Of 881
            Return 'WM_AFX_reserved_371'
        Of 882
            Return 'WM_AFX_reserved_372'
        Of 883
            Return 'WM_AFX_reserved_373'
        Of 884
            Return 'WM_AFX_reserved_374'
        Of 885
            Return 'WM_AFX_reserved_375'
        Of 886
            Return 'WM_AFX_reserved_376'
        Of 887
            Return 'WM_AFX_reserved_377'
        Of 888
            Return 'WM_AFX_reserved_378'
        Of 889
            Return 'WM_AFX_reserved_379'
        Of 890
            Return 'WM_AFX_reserved_37a'
        Of 891
            Return 'WM_AFX_reserved_37b'
        Of 892
            Return 'WM_AFX_reserved_37c'
        Of 893
            Return 'WM_AFX_reserved_37d'
        Of 894
            Return 'WM_AFX_reserved_37e'
        Of 895
            Return 'WM_AFXLAST'
        Of 896
            Return 'WM_PENWINFIRST'
        Of 897
            Return 'WM_RCRESULT'
        Of 898
            Return 'WM_HOOKRCRESULT'
        Of 899
            Return 'WM_GLOBALRCCHANGE'
        Of 899
            Return 'WM_PENMISCINFO'
        Of 900
            Return 'WM_SKB'
        Of 901
            Return 'WM_PENCTL'
        Of 901
            Return 'WM_HEDITCTL'
        Of 902
            Return 'WM_PENMISC'
        Of 903
            Return 'WM_CTLINIT'
        Of 904
            Return 'WM_PENEVENT'
        Of 905
            Return 'WM_PENWIN_reserved_389'
        Of 906
            Return 'WM_PENWIN_reserved_38a'
        Of 907
            Return 'WM_PENWIN_reserved_38b'
        Of 908
            Return 'WM_PENWIN_reserved_38c'
        Of 909
            Return 'WM_PENWIN_reserved_38d'
        Of 910
            Return 'WM_PENWIN_reserved_38e'
        Of 911
            Return 'WM_PENWINLAST'
        Of 912
            Return 'WM_COALESCE_FIRST'
        Of 913
            Return 'WM_COALESCE__reserved_391'
        Of 914
            Return 'WM_COALESCE__reserved_392'
        Of 915
            Return 'WM_COALESCE__reserved_393'
        Of 916
            Return 'WM_COALESCE__reserved_394'
        Of 917
            Return 'WM_COALESCE__reserved_395'
        Of 918
            Return 'WM_COALESCE__reserved_396'
        Of 919
            Return 'WM_COALESCE__reserved_397'
        Of 920
            Return 'WM_COALESCE__reserved_398'
        Of 921
            Return 'WM_COALESCE__reserved_399'
        Of 922
            Return 'WM_COALESCE__reserved_39a'
        Of 923
            Return 'WM_COALESCE__reserved_39b'
        Of 924
            Return 'WM_COALESCE__reserved_39c'
        Of 925
            Return 'WM_COALESCE__reserved_39d'
        Of 926
            Return 'WM_COALESCE__reserved_39e'
        Of 927
            Return 'WM_COALESCE_LAST'
        Of 928
            Return 'WM_MM_RESERVED_FIRST'
        Of 929
            Return 'WM_MM_RESERVED__reserved_3a1'
        Of 930
            Return 'WM_MM_RESERVED__reserved_3a2'
        Of 931
            Return 'WM_MM_RESERVED__reserved_3a3'
        Of 932
            Return 'WM_MM_RESERVED__reserved_3a4'
        Of 933
            Return 'WM_MM_RESERVED__reserved_3a5'
        Of 934
            Return 'WM_MM_RESERVED__reserved_3a6'
        Of 935
            Return 'WM_MM_RESERVED__reserved_3a7'
        Of 936
            Return 'WM_MM_RESERVED__reserved_3a8'
        Of 937
            Return 'WM_MM_RESERVED__reserved_3a9'
        Of 938
            Return 'WM_MM_RESERVED__reserved_3aa'
        Of 939
            Return 'WM_MM_RESERVED__reserved_3ab'
        Of 940
            Return 'WM_MM_RESERVED__reserved_3ac'
        Of 941
            Return 'WM_MM_RESERVED__reserved_3ad'
        Of 942
            Return 'WM_MM_RESERVED__reserved_3ae'
        Of 943
            Return 'WM_MM_RESERVED__reserved_3af'
        Of 944
            Return 'WM_MM_RESERVED__reserved_3b0'
        Of 945
            Return 'WM_MM_RESERVED__reserved_3b1'
        Of 946
            Return 'WM_MM_RESERVED__reserved_3b2'
        Of 947
            Return 'WM_MM_RESERVED__reserved_3b3'
        Of 948
            Return 'WM_MM_RESERVED__reserved_3b4'
        Of 949
            Return 'WM_MM_RESERVED__reserved_3b5'
        Of 950
            Return 'WM_MM_RESERVED__reserved_3b6'
        Of 951
            Return 'WM_MM_RESERVED__reserved_3b7'
        Of 952
            Return 'WM_MM_RESERVED__reserved_3b8'
        Of 953
            Return 'WM_MM_RESERVED__reserved_3b9'
        Of 954
            Return 'WM_MM_RESERVED__reserved_3ba'
        Of 955
            Return 'WM_MM_RESERVED__reserved_3bb'
        Of 956
            Return 'WM_MM_RESERVED__reserved_3bc'
        Of 957
            Return 'WM_MM_RESERVED__reserved_3bd'
        Of 958
            Return 'WM_MM_RESERVED__reserved_3be'
        Of 959
            Return 'WM_MM_RESERVED__reserved_3bf'
        Of 960
            Return 'WM_MM_RESERVED__reserved_3c0'
        Of 961
            Return 'WM_MM_RESERVED__reserved_3c1'
        Of 962
            Return 'WM_MM_RESERVED__reserved_3c2'
        Of 963
            Return 'WM_MM_RESERVED__reserved_3c3'
        Of 964
            Return 'WM_MM_RESERVED__reserved_3c4'
        Of 965
            Return 'WM_MM_RESERVED__reserved_3c5'
        Of 966
            Return 'WM_MM_RESERVED__reserved_3c6'
        Of 967
            Return 'WM_MM_RESERVED__reserved_3c7'
        Of 968
            Return 'WM_MM_RESERVED__reserved_3c8'
        Of 969
            Return 'WM_MM_RESERVED__reserved_3c9'
        Of 970
            Return 'WM_MM_RESERVED__reserved_3ca'
        Of 971
            Return 'WM_MM_RESERVED__reserved_3cb'
        Of 972
            Return 'WM_MM_RESERVED__reserved_3cc'
        Of 973
            Return 'WM_MM_RESERVED__reserved_3cd'
        Of 974
            Return 'WM_MM_RESERVED__reserved_3ce'
        Of 975
            Return 'WM_MM_RESERVED__reserved_3cf'
        Of 976
            Return 'WM_MM_RESERVED__reserved_3d0'
        Of 977
            Return 'WM_MM_RESERVED__reserved_3d1'
        Of 978
            Return 'WM_MM_RESERVED__reserved_3d2'
        Of 979
            Return 'WM_MM_RESERVED__reserved_3d3'
        Of 980
            Return 'WM_MM_RESERVED__reserved_3d4'
        Of 981
            Return 'WM_MM_RESERVED__reserved_3d5'
        Of 982
            Return 'WM_MM_RESERVED__reserved_3d6'
        Of 983
            Return 'WM_MM_RESERVED__reserved_3d7'
        Of 984
            Return 'WM_MM_RESERVED__reserved_3d8'
        Of 985
            Return 'WM_MM_RESERVED__reserved_3d9'
        Of 986
            Return 'WM_MM_RESERVED__reserved_3da'
        Of 987
            Return 'WM_MM_RESERVED__reserved_3db'
        Of 988
            Return 'WM_MM_RESERVED__reserved_3dc'
        Of 989
            Return 'WM_MM_RESERVED__reserved_3dd'
        Of 990
            Return 'WM_MM_RESERVED__reserved_3de'
        Of 991
            Return 'WM_MM_RESERVED_LAST'
        Of 992
            Return 'WM_INTERNAL_DDE_FIRST'
        Of 993
            Return 'WM_INTERNAL_DDE__reserved_3e1'
        Of 994
            Return 'WM_INTERNAL_DDE__reserved_3e2'
        Of 995
            Return 'WM_INTERNAL_DDE__reserved_3e3'
        Of 996
            Return 'WM_INTERNAL_DDE__reserved_3e4'
        Of 997
            Return 'WM_INTERNAL_DDE__reserved_3e5'
        Of 998
            Return 'WM_INTERNAL_DDE__reserved_3e6'
        Of 999
            Return 'WM_INTERNAL_DDE__reserved_3e7'
        Of 1000
            Return 'WM_INTERNAL_DDE__reserved_3e8'
        Of 1001
            Return 'WM_INTERNAL_DDE__reserved_3e9'
        Of 1002
            Return 'WM_INTERNAL_DDE__reserved_3ea'
        Of 1003
            Return 'WM_INTERNAL_DDE__reserved_3eb'
        Of 1004
            Return 'WM_INTERNAL_DDE__reserved_3ec'
        Of 1005
            Return 'WM_INTERNAL_DDE__reserved_3ed'
        Of 1006
            Return 'WM_INTERNAL_DDE__reserved_3ee'
        Of 1007
            Return 'WM_INTERNAL_DDE_LAST'
        Of 1008
            Return 'WM_CBT_RESERVED_FIRST'
        Of 1009
            Return 'WM_CBT_RESERVED__reserved_3f1'
        Of 1010
            Return 'WM_CBT_RESERVED__reserved_3f2'
        Of 1011
            Return 'WM_CBT_RESERVED__reserved_3f3'
        Of 1012
            Return 'WM_CBT_RESERVED__reserved_3f4'
        Of 1013
            Return 'WM_CBT_RESERVED__reserved_3f5'
        Of 1014
            Return 'WM_CBT_RESERVED__reserved_3f6'
        Of 1015
            Return 'WM_CBT_RESERVED__reserved_3f7'
        Of 1016
            Return 'WM_CBT_RESERVED__reserved_3f8'
        Of 1017
            Return 'WM_CBT_RESERVED__reserved_3f9'
        Of 1018
            Return 'WM_CBT_RESERVED__reserved_3fa'
        Of 1019
            Return 'WM_CBT_RESERVED__reserved_3fb'
        Of 1020
            Return 'WM_CBT_RESERVED__reserved_3fc'
        Of 1021
            Return 'WM_CBT_RESERVED__reserved_3fd'
        Of 1022
            Return 'WM_CBT_RESERVED__reserved_3fe'
        Of 1023
            Return 'WM_CBT_RESERVED_LAST'
        Of 1024
            Return 'WM_USER'

        Of 1024
            Return 'WM_PSD_PAGESETUPDLG'
        Of 1025
            Return 'WM_PSD_FULLPAGERECT'
        Of 1025
            Return 'WM_CHOOSEFONT_GETLOGFONT'
        Of 1026
            Return 'WM_PSD_MINMARGINRECT'
        Of 1027
            Return 'WM_PSD_MARGINRECT'
        Of 1028
            Return 'WM_PSD_GREEKTEXTRECT'
        Of 1029
            Return 'WM_PSD_ENVSTAMPRECT'
        Of 1030
            Return 'WM_PSD_YAFULLPAGERECT'
        Of 1124
            Return 'WM_CAP_UNICODE_START'
        Of 1125
            Return 'WM_CHOOSEFONT_SETLOGFONT'
        Of 1126
            Return 'WM_CHOOSEFONT_SETFLAGS'
        Of 1126
            Return 'WM_CAP_SET_CALLBACK_ERRORW'
        Of 1127
            Return 'WM_CAP_SET_CALLBACK_STATUSW'
        Of 1136
            Return 'WM_CAP_DRIVER_GET_NAMEW'
        Of 1137
            Return 'WM_CAP_DRIVER_GET_VERSIONW'
        Of 1144
            Return 'WM_CAP_FILE_SET_CAPTURE_FILEW'
        Of 1145
            Return 'WM_CAP_FILE_GET_CAPTURE_FILEW'
        Of 1147
            Return 'WM_CAP_FILE_SAVEASW'
        Of 1149
            Return 'WM_CAP_FILE_SAVEDIBW'
        Of 1190
            Return 'WM_CAP_SET_MCI_DEVICEW'
        Of 1191
            Return 'WM_CAP_GET_MCI_DEVICEW'
        Of 1204
            Return 'WM_CAP_PAL_OPENW'
        Of 1205
            Return 'WM_CAP_PAL_SAVEW'
        Of 2024
            Return 'WM_CPL_LAUNCH'
        Of 2025
            Return 'WM_CPL_LAUNCHED'
        Of 32768
            Return 'WM_APP'
        Of 52429
            Return 'WM_RASDIALEVENT'
        ELSE
            Return _id & ' (UNKNOWN)'
        End
        Return ''

