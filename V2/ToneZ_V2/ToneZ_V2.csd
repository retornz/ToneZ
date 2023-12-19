;****************************************************************************
;****************************************************************************
;****************************************************************************
;****************************************************************************
;                             ToneZ V2
;                          Retornz - 2023
;                         wwww.retornz.com
;                          Made in France
; 
;  Some parts of the code, especially the effects,
;  were inspired by Iain McCurdy example
;  http://iainmccurdy.org/csound.html
;
;  Designed in Cabbage.
;  Many thanks to @Rorywalsh for all the help & for designing this great
;  framework
;****************************************************************************
;****************************************************************************
;****************************************************************************
;****************************************************************************


<Cabbage>
;*****************************************************************************************************************
;**********************************************GUI****************************************************************
;*****************************************************************************************************************

;******************STYLES

;DEFAULT TONEZ STYLE
#define nsliderstyle colour(11,21,31), fontColour("silver"), fontSize(11)
#define buttonstyle imgFile("on", "img/theme_DEFAULT/buttonon.svg"), imgFile("off", "img/theme_DEFAULT/buttonoff.svg"), fontColour:1("white"), fontColour:0(220,220,220), colour("lightblue")
#define buttonstyleon imgFile("on", "img/theme_DEFAULT/buttonon.svg"), imgFile("off", "img/theme_DEFAULT/buttonon.svg"), fontColour:1("white"), fontColour:1("white"), colour:0("lightblue"), colour:1("lightblue")
#define buttontabstyle fontColour:1("white"), fontColour:0(220,220,220,200), colour("lightblue"), imgFile("on", "img/theme_DEFAULT/tabon.svg"), imgFile("off", "img/theme_DEFAULT/taboff.svg")
#define checkboxstyle fontColour:1("white"), fontColour:0(220,220,220), colour("lightblue"), imgFile("on", "img/theme_DEFAULT/buttonon.svg"), imgFile("off", "img/theme_DEFAULT/buttonoff.svg")
#define bgstyle colour(20, 30, 40)
#define hsliderstyle trackerColour(0, 0, 0, 0) colour("lightblue")   textColour(0, 0, 0, 0) fontColour(0, 0, 0, 0), imgFile("Slider", "img/theme_DEFAULT/RD8.png") imgFile("Background", "img/theme_DEFAULT/SQ_BG.png")
#define rsliderhiddenstyle alpha(1), popupText(0), colour(20,30,40,255), fontColour("silver"), trackerColour("lightblue"), outlineColour(70,70,70,100), trackerInsideRadius(.8), style("normal")
#define gentablestyle tableColour("lightblue"), tableBackgroundColour(11,21,31,255), tableGridColour(0,0,0,0), fill(0), outlineThickness(1.5)
#define comboboxstyle fontColour("silver"), colour(20,30,40), align("centre")
#define groupboxstyle linethickess(0), outlineThickness(0), colour(0,0,0,0)
#define rsliderstyle colour(20,30,40,0), fontColour("silver"), trackerColour("lightblue"), outlineColour(71,74,77,50), markerThickness(1) markerStart(1.1), markerEnd(1.2), markerColour(255,255,255,70) trackerInsideRadius(.82), style("flat"), trackerBackgroundColour(71,74,77,100), trackerBgColour(71,74,77,100)
#define rsliderstylesmall colour(20,30,40,0), fontColour("silver"), trackerColour(180,230,250,220), outlineColour(71,74,77,50), markerThickness(1) markerStart(1.1), markerEnd(1.2), markerColour(255,255,255,70) trackerInsideRadius(.82), style("legacy"), trackerBackgroundColour(71,74,77,100)
#define formstyle colour(0,10,20)
#define imagestyle colour(20, 30, 40, 255)
#define hiddenscreen colour(11,21,31,255)
#define visbgstyle colour(11, 21, 31, 255), corners(0), outlineColour(30,40,50), outlineThickness(3)
#define hsliderbgstyle colour(40,50,60)
#define visfontstyle fontColour(255,255,255,70)
#define ledstyle colour("lightblue"), corners(2), alpha(0.1)
;;############################################################################################


;Background light squares
image        bounds(319, 26, 232, 193) colour(78, 101, 113, 200)
image        bounds(4, 26, 303, 193) colour(78, 101, 113, 200)
image        bounds(4, 249, 307, 105) colour(78, 101, 113, 200)
image        bounds(319, 249, 232, 105) colour(78, 101, 113, 200)
image        bounds(4, 381, 547, 95) colour(78, 101, 113, 200)
image        bounds(559, 0, 10, 500) colour(78, 101, 113, 200)

;******************KEYBOARD
form caption("ToneZ V2") size(720, 545), pluginId("Rz01"), guiRefresh(10), $formstyle
//form caption("ToneZ V2") size(720, 700), pluginId("RZ01"), guiRefresh(10), $formstyle
//csoundoutput bounds(0, 555, 500, 130)
;*******************HEADER
groupbox bounds(560, 0, 172, 507), plant("GUI_HEADER") $groupboxstyle {
    image bounds(0, 0, 175, 507), $imagestyle
    image        bounds(1, -5, 158, 419) $imagestyle 
    image        bounds(10, 72, 138, 1), colour("lightblue")
    image        bounds(10, 120, 138, 1), colour("lightblue")
    image        bounds(10, 270, 138, 1), colour("lightblue")
    image        bounds(10, 300, 138, 1), colour("lightblue")
    image        bounds(10, 410, 138, 1), colour("lightblue")
    label bounds(5,20,150,10), text("BROKEN GUI"), fontColour("red")
    label bounds(5,30,150,10), text("Click on the 'About' button"), fontColour("red")
    label bounds(5,40,150,10), text("& Ask for help on Discord"), fontColour("red")
    
    image bounds(5, 7, 145, 65), file("img/LogoToneZ2.svg"), colour(0,0,0,255)
    label bounds(72, 58, 90, 10), text("by Retornz"), fontColour(255,255,255,200)
    
    vmeter bounds(80, 80, 3, 35), channel("vMeterL") value(0) overlayColour(20,20,20,255) corners(0) meterColour:0("white") outlineThickness(0)
    vmeter bounds(85, 80, 3, 35), channel("vMeterR") value(0) overlayColour(20,20,20,255) corners(0) meterColour:0("white") outlineThickness(0)
   
    listbox visible(1) bounds(2, 190, 156, 80), populate("*.tzp*","factorypresets") channel("box") channelType("string") identChannel("boxI") presetIgnore(1) numberOfClicks(2) fontColour(220,220,220) value(-1), highlightColour(123,154,164), colour(20,30,40), align("centre")
    filebutton bounds(15, 145, 60, 19), channel("saveFile"), text("Save"), populate("*.tzp2"), mode("save"), presetIgnore(1), identChannel("saveFileI") $buttonstyle
    filebutton bounds(84, 145, 60, 19), channel("openFile") text("Open"), populate("*.tzp2;*.tzp"), mode("file"), presetIgnore(1) $buttonstyle
    filebutton bounds(15, 165, 60, 19), channel("opendir") text("Folder"), populate("*.tzp2;*.tzp"), mode("directory"), $buttonstyle
    button bounds(84, 165, 60, 19), channel("reload") text("Reload") identChannel("reloadI") latched(0), active(0) $buttonstyle

    rslider bounds(75, 75, 75, 43), text("Volume"),    channel("MasterVol"), range(0, 500, 100, 0.43, 0.01), popupPostfix(" %"), $rsliderstylesmall
    nslider bounds(17, 77, 55, 23),       channel("pbrange"), range(1, 24, 12, 1, 1) , $nsliderstyle
    label bounds(0, 102, 90, 11), text("PB. Range")

    button bounds(0, 0, 160, 70), channel("BUTTON_PANIC"),latched(0), alpha(0)
    button bounds(100, 2, 58, 20), channel("BUTTON_ABOUT") text("About..."),latched(0), $buttonstyle
    
    label bounds(47,127,150,13), text("PRESETS")
    label bounds(3, 130, 80, 10) text("<No Preset>") identChannel("PresetName")
    texteditor bounds(0, 0, 80, 20), wrap(0), colour(20,30,40), fontColour(160,160,160), channel("PathText"), identChannel("PathTextI"), text("factorypresets"), active(0), alpha(0)
    label bounds(0, 0, 80, 20) text(" "), alpha(0)
    combobox bounds(2, 2, 60, 18), mode("resize"), value(3), channel("resizebox"), identChannel("resizeboxI") $comboboxstyle 
    groupbox bounds(0, 270, 170, 30), visible(1), plant("GUI_PART4") $groupboxstyle { ;WF MANAGER
        label bounds(15,4,150,13), text("WF MANAG."), align("left")
        label bounds(20,18,150,8), text("1"), align("left")
        image    bounds(30, 21, 10, 2),     identChannel("idCUSTOM1_LED"), $ledstyle
        label bounds(50,18,150,8), text("2"), align("left")
        image    bounds(60, 21, 10, 2),     identChannel("idCUSTOM2_LED"), $ledstyle
        button  bounds(100, 6, 50, 17), channel("BUTTON_WFMANAG"), text("Open"), latched(0), $buttonstyle
    }
    groupbox bounds(0, 305, 170, 105), visible(1), plant("GUI_PART2") $groupboxstyle { ;EXPERT DETUNE
        label bounds(50,5,150,13), text("EXPERT")
        label bounds(50,20,150,13), text("DETUNE")
        image        bounds(10, 83, 138, 15), colour(10,20,30)

        rslider bounds(0, 5, 35, 35), text("A"),    channel("detsh1"), range(-.5, .5, 0, 1, 0.0001), popupPostfix(" "), $rsliderstylesmall
        rslider bounds(20, 5, 35, 35), text("B"),    channel("detsh2"), range(-.5, .5, 0, 1, 0.0001), popupPostfix(" "), $rsliderstylesmall
        rslider bounds(40, 5, 35, 35), text("C"),    channel("detsh3"), range(-.5, .5, 0, 1, 0.0001), popupPostfix(" "), $rsliderstylesmall
        rslider bounds(60, 5, 35, 35), text("D"),    channel("detsh4"), range(-.5, .5, 0, 1, 0.0001), popupPostfix(" "), $rsliderstylesmall
        image bounds(40, 72, 80, 1), $hsliderbgstyle
        label bounds(10, 67, 20, 10), text("Mix"), $visfontstyle
        hslider bounds(40, 65, 80, 16)    channel("detmix")     range(0, 100, 50, 1, 0.01), popupPostfix(" %"),  $hsliderstyle
        button bounds(10, 40, 48, 17),     channel("detstyle0"), text("Original"), radioGroup(200), value(1), $buttonstyle 
        button bounds(58, 40, 48, 17),     channel("detstyle1"), text("Basic"), radioGroup(200), $buttonstyle 
        button bounds(101, 40, 48, 17),     channel("detstyle2"), text("Ultra"), radioGroup(200), $buttonstyle  
    }
    groupbox bounds(0, 410, 170, 75), visible(1), plant("GUI_PART1") $groupboxstyle { ;PORTAMENTO
        label bounds(15,8,150,13), text("PORTAMENTO"), align("left")
        button  bounds(120, 6, 30, 17), text("OFF", "ON"), channel("monopoly"), $checkboxstyle
        rslider bounds(15, 27, 47, 43), text("Leg.Time"),    channel("LegTim"), range(1, 5000, 100, 0.25, 1), popupPostfix(" ms"), $rsliderstylesmall
        label bounds(77, 35, 40, 11), text("Retrig")
        checkbox   bounds(120, 35, 10, 10), channel("SARetrig"), , identChannel("SARetrigID"), $checkboxstyle
        label bounds(79, 52, 40, 11), text("Glide")
        checkbox   bounds(120, 52, 10, 10), channel("SAGlide"), $checkboxstyle
    }
}

keyboard bounds(0, 485, 730, 60), middleC(5), keyDownColour("lightblue"), mouseOverKeyColour(218,205,255,200), arrowbackgroundColour(20,30,40,100), arrowColour("white"), blackNoteColour(20,30,40), whiteNoteColour(240,240,255)


;*******************OSC
groupbox bounds(5, 5, 305, 230), , identChannel("GROUP_OSCALL"), plant("GUI_OSCALL"), $groupboxstyle {
    groupbox bounds(0, 20, 305, 195), visible(1), identChannel("GROUP_OSC1"), plant("GUI_OSC1"), $groupboxstyle { ; OSC1 TAB
        image bounds(0, 2, 301, 191) $imagestyle ;tab bg
        image bounds(50, 95, 200, 95), $visbgstyle
        gentable bounds(80, 110, 140, 45), tableNumber(10011), ampRange(-1, 1, 10011, 0.0100), active(1), identChannel("genTabOSC1"), sampleRange(0,128), $gentablestyle
        combobox bounds(51, 65, 98, 20),    channel("osc1wave1_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Custom1","Custom2"), value(1), $comboboxstyle
        combobox bounds(151, 65, 98, 20),   channel("osc1wave2_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Custom1","Custom2"), value(1), $comboboxstyle
        rslider bounds(130, 65, 20, 20),    channel("osc1wave1_K"), range(1, 13, 1, 1, 1), $rsliderhiddenstyle
        rslider bounds(222, 65, 35, 20),    channel("osc1wave2_K"), range(1, 13, 1, 1, 1), $rsliderhiddenstyle
        image bounds(80, 177, 148, 1), $hsliderbgstyle
        label bounds(100, 160, 100, 10), text("Morph"), $visfontstyle
        hslider bounds(80, 170, 149, 16)    channel("osc1morph")     range(0, 100, 0, 1, 0.01), popupPostfix(" %"),  $hsliderstyle
        rslider bounds(50, 10, 50, 50),     channel("osc1vol"),      range(0, 100, 100, 1, 0.01),   text("Volume"), popupPostfix(" %"),      $rsliderstyle 
        rslider bounds(100, 10, 50, 50),    channel("osc1det"),      range(0, 100, 0, 0.25, 0.01),   text("Detune"), popupPostfix(" %"),    $rsliderstyle
        rslider bounds(150, 10, 50, 50),    channel("osc1wid"),      range(0, 100, 100, 1, 0.01),   text("Width"), popupPostfix(" %"),    $rsliderstyle
        label bounds(0, 45, 50, 11), text("Voices")
        label bounds(250, 45, 50, 11), text("Octave")
        label bounds(205, 45, 50, 11), text("Semi")
        nslider bounds(5, 14, 40, 25),      channel("osc1voice"),    range(1, 8, 1, 1, 1),     $nsliderstyle
        nslider bounds(255, 14, 40, 25),    channel("osc1octave"),   range(-3, 3, 0, 1, 1),     $nsliderstyle
        nslider bounds(210, 14, 40, 25),    channel("osc1semi"),     range(-12, 12, 0, 0.5, 1),     $nsliderstyle
        rslider bounds(4, 90, 45, 40),      channel("osc1cent"),     range(-100, 100, 0, 1, 1) text("Cent"), popupPostfix(" "),  $rsliderstylesmall
        rslider bounds(4, 140, 45, 40),     channel("osc1pan"),      range(0, 100, 50, 1, 0.01) text("Pan"), popupPostfix(" %"),  $rsliderstylesmall
        rslider bounds(252, 90, 45, 40),    channel("osc1phase"),    range(0, 360, 0, 1, 0.01),   text("Phase"), popupPostfix(" °"),     $rsliderstylesmall
        button  bounds(253, 140, 45, 18),   channel("osc1retrig"), text("RETRIG"), $checkboxstyle
        button  bounds(253, 170, 45, 18),   channel("osc1noise"), text("NOISE"), $checkboxstyle 
    }
        groupbox bounds(0, 20, 305, 195), visible(0), identChannel("GROUP_OSC2"), plant("GUI_OSC2"), $groupboxstyle { ; OSC2 TAB
        image bounds(0, 2, 301, 191) $imagestyle ;tab bg
        image bounds(50, 95, 200, 95), $visbgstyle
        gentable bounds(80, 110, 140, 45), tableNumber(10012), ampRange(-1, 1, 10012, 0.0100), active(1), identChannel("genTabOSC2"), sampleRange(0,128), $gentablestyle
        combobox bounds(51, 65, 98, 20),    channel("osc2wave1_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Custom1","Custom2"), value(1), $comboboxstyle
        combobox bounds(151, 65, 98, 20),   channel("osc2wave2_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Custom1","Custom2"), value(1), $comboboxstyle
        rslider bounds(130, 65, 20, 20),    channel("osc2wave1_K"), range(1, 13, 1, 1, 1), $rsliderhiddenstyle
        rslider bounds(222, 65, 35, 20),    channel("osc2wave2_K"), range(1, 13, 1, 1, 1), $rsliderhiddenstyle
        image bounds(80, 177, 148, 1), $hsliderbgstyle
        label bounds(100, 160, 100, 10), text("Morph"), $visfontstyle
        hslider bounds(80, 170, 149, 16)    channel("osc2morph")     range(0, 100, 0, 1, 0.01), popupPostfix(" %"),  $hsliderstyle
        rslider bounds(50, 10, 50, 50),     channel("osc2vol"),      range(0, 100, 0, 1, 0.01),   text("Volume"), popupPostfix(" %"),      $rsliderstyle 
        rslider bounds(100, 10, 50, 50),    channel("osc2det"),      range(0, 100, 0, 0.25, 0.01),   text("Detune"), popupPostfix(" %"),    $rsliderstyle
        rslider bounds(150, 10, 50, 50),    channel("osc2wid"),      range(0, 100, 100, 1, 0.01),   text("Width"), popupPostfix(" %"),    $rsliderstyle
        label bounds(0, 45, 50, 11), text("Voices")
        label bounds(250, 45, 50, 11), text("Octave")
        label bounds(205, 45, 50, 11), text("Semi")
        nslider bounds(5, 14, 40, 25),      channel("osc2voice"),    range(1, 8, 1, 1, 1),     $nsliderstyle
        nslider bounds(255, 14, 40, 25),    channel("osc2octave"),   range(-3, 3, 0, 1, 1),     $nsliderstyle
        nslider bounds(210, 14, 40, 25),    channel("osc2semi"),     range(-12, 12, 0, 0.25, 1),     $nsliderstyle
        rslider bounds(4, 90, 45, 40),      channel("osc2cent"),     range(-100, 100, 0, 1, 1) text("Cent"), popupPostfix(" "),  $rsliderstylesmall
        rslider bounds(4, 140, 45, 40),     channel("osc2pan"),      range(0, 100, 50, 1, 0.01) text("Pan"), popupPostfix(" %"),  $rsliderstylesmall
        rslider bounds(252, 90, 45, 40),    channel("osc2phase"),    range(0, 360, 0, 1, 0.01),   text("Phase"), popupPostfix(" °"),     $rsliderstylesmall
        button  bounds(253, 140, 45, 18),   channel("osc2retrig"), text("RETRIG"), $checkboxstyle
        button  bounds(253, 170, 45, 18),   channel("osc2noise"), text("NOISE"), $checkboxstyle 
    }
    groupbox bounds(0, 20, 305, 195), visible(0), identChannel("GROUP_OSC3"), plant("GUI_OSC3"), $groupboxstyle { ; OSC3 TAB
        image bounds(0, 2, 301, 191) $imagestyle ;tab bg
        image bounds(50, 95, 200, 95), $visbgstyle
        gentable bounds(80, 110, 140, 45), tableNumber(10013), ampRange(-1, 1, 10013, 0.0100), active(1), identChannel("genTabOSC3"), sampleRange(0,128), $gentablestyle
        combobox bounds(51, 65, 98, 20),    channel("osc3wave1_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Custom1","Custom2"), value(1), $comboboxstyle
        combobox bounds(151, 65, 98, 20),   channel("osc3wave2_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Custom1","Custom2"), value(1), $comboboxstyle
        rslider bounds(130, 65, 20, 20),    channel("osc3wave1_K"), range(1, 13, 1, 1, 1), $rsliderhiddenstyle
        rslider bounds(222, 65, 35, 20),    channel("osc3wave2_K"), range(1, 13, 1, 1, 1), $rsliderhiddenstyle
        image bounds(80, 177, 148, 1), $hsliderbgstyle
        label bounds(100, 160, 100, 10), text("Morph"), $visfontstyle
        hslider bounds(80, 170, 149, 16)    channel("osc3morph")     range(0, 100, 0, 1, 0.01), popupPostfix(" %"),  $hsliderstyle
        rslider bounds(50, 10, 50, 50),     channel("osc3vol"),      range(0, 100, 0, 1, 0.01),   text("Volume"), popupPostfix(" %"),      $rsliderstyle 
        rslider bounds(100, 10, 50, 50),    channel("osc3det"),      range(0, 100, 0, 0.25, 0.01),   text("Detune"), popupPostfix(" %"),    $rsliderstyle
        rslider bounds(150, 10, 50, 50),    channel("osc3wid"),      range(0, 100, 100, 1, 0.01),   text("Width"), popupPostfix(" %"),    $rsliderstyle
        label bounds(0, 45, 50, 11), text("Voices")
        label bounds(250, 45, 50, 11), text("Octave")
        label bounds(205, 45, 50, 11), text("Semi")
        nslider bounds(5, 14, 40, 25),      channel("osc3voice"),    range(1, 8, 1, 1, 1),     $nsliderstyle
        nslider bounds(255, 14, 40, 25),    channel("osc3octave"),   range(-3, 3, 0, 1, 1),     $nsliderstyle
        nslider bounds(210, 14, 40, 25),    channel("osc3semi"),     range(-12, 12, 0, 0.5, 1),     $nsliderstyle
        rslider bounds(4, 90, 45, 40),      channel("osc3cent"),     range(-100, 100, 0, 1, 1) text("Cent"), popupPostfix(" "),  $rsliderstylesmall
        rslider bounds(4, 140, 45, 40),     channel("osc3pan"),      range(0, 100, 50, 1, 0.01) text("Pan"), popupPostfix(" %"),  $rsliderstylesmall
        rslider bounds(252, 90, 45, 40),    channel("osc3phase"),    range(0, 360, 0, 1, 0.01),   text("Phase"), popupPostfix(" °"),     $rsliderstylesmall
        button  bounds(253, 140, 45, 18),   channel("osc3retrig"), text("RETRIG"), $checkboxstyle
        button  bounds(253, 170, 45, 18),   channel("osc3noise"), text("NOISE"), $checkboxstyle 
    }
    groupbox bounds(0, 20, 305, 195), visible(1), identChannel("GROUP_OSC4"), plant("GUI_OSC4"), $groupboxstyle { ; OSC4 TAB
        image bounds(0, 2, 301, 191) $imagestyle ;tab bg
        image bounds(50, 95, 200, 95), $visbgstyle
        gentable bounds(80, 110, 140, 45), tableNumber(10014), ampRange(-1, 1, 10014, 0.0100), active(1), identChannel("genTabOSC4"), sampleRange(0,128), $gentablestyle
        combobox bounds(51, 65, 98, 20),    channel("osc4wave1_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Custom1","Custom2"), value(1), $comboboxstyle
        combobox bounds(151, 65, 98, 20),   channel("osc4wave2_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Custom1","Custom2"), value(1), $comboboxstyle
        rslider bounds(130, 65, 20, 20),    channel("osc4wave1_K"), range(1, 13, 1, 1, 1), $rsliderhiddenstyle
        rslider bounds(222, 65, 35, 20),    channel("osc4wave2_K"), range(1, 13, 1, 1, 1), $rsliderhiddenstyle
        image bounds(80, 177, 148, 1), $hsliderbgstyle
        label bounds(100, 160, 100, 10), text("Morph"), $visfontstyle
        hslider bounds(80, 170, 149, 16)    channel("osc4morph")     range(0, 100, 0, 1, 0.01), popupPostfix(" %"),  $hsliderstyle
        rslider bounds(50, 10, 50, 50),     channel("osc4vol"),      range(0, 100, 0, 1, 0.01),   text("Volume"), popupPostfix(" %"),      $rsliderstyle 
        rslider bounds(100, 10, 50, 50),    channel("osc4det"),      range(0, 100, 0, 0.25, 0.01),   text("Detune"), popupPostfix(" %"),    $rsliderstyle
        rslider bounds(150, 10, 50, 50),    channel("osc4wid"),      range(0, 100, 100, 1, 0.01),   text("Width"), popupPostfix(" %"),    $rsliderstyle
        label bounds(0, 45, 50, 11), text("Voices")
        label bounds(250, 45, 50, 11), text("Octave")
        label bounds(205, 45, 50, 11), text("Semi")
        nslider bounds(5, 14, 40, 25),      channel("osc4voice"),    range(1, 8, 1, 1, 1),     $nsliderstyle
        nslider bounds(255, 14, 40, 25),    channel("osc4octave"),   range(-3, 3, 0, 1, 1),     $nsliderstyle
        nslider bounds(210, 14, 40, 25),    channel("osc4semi"),     range(-12, 12, 0, 0.5, 1),     $nsliderstyle
        rslider bounds(4, 90, 45, 40),      channel("osc4cent"),     range(-100, 100, 0, 1, 1) text("Cent"), popupPostfix(" "),  $rsliderstylesmall
        rslider bounds(4, 140, 45, 40),     channel("osc4pan"),      range(0, 100, 50, 1, 0.01) text("Pan"), popupPostfix(" %"),  $rsliderstylesmall
        rslider bounds(252, 90, 45, 40),    channel("osc4phase"),    range(0, 360, 0, 1, 0.01),   text("Phase"), popupPostfix(" °"),     $rsliderstylesmall
        button  bounds(253, 140, 45, 18),   channel("osc4retrig"), text("RETRIG"), $checkboxstyle
        button  bounds(253, 170, 45, 18),   channel("osc4noise"), text("NOISE"), $checkboxstyle 
    }
    button bounds(0, 3, 54, 19),    text("OSC1"),channel("OSC1_BUTTON"), $buttontabstyle, identChannel("idOSC1_BUTTON") radioGroup(101), value(1)
    button bounds(54, 3, 54, 19),   text("OSC2"),channel("OSC2_BUTTON"), $buttontabstyle, identChannel("idOSC2_BUTTON") radioGroup(101)
    button bounds(108, 3, 54, 19),  text("OSC3"),channel("OSC3_BUTTON"), $buttontabstyle, identChannel("idOSC3_BUTTON") radioGroup(101)
    button bounds(162, 3, 54, 19),  text("OSC4"),channel("OSC4_BUTTON"), $buttontabstyle, identChannel("idOSC4_BUTTON") radioGroup(101) 
    image    bounds(22, 18, 10, 2),     identChannel("idOSC1_LED"), $ledstyle
    image    bounds(76, 18, 10, 2),     identChannel("idOSC2_LED"), $ledstyle
    image    bounds(131, 18, 10, 2),    identChannel("idOSC3_LED"), $ledstyle
    image    bounds(184, 18, 10, 2),    identChannel("idOSC4_LED"), $ledstyle
}


;*******************ENVELOPPES
;1
groupbox bounds(320, 5, 230, 230), , identChannel("GROUP_ENVALL"), plant("GUI_ENVALL"), $groupboxstyle visible(1){
    groupbox bounds(0, 20, 230, 195), visible(1) , identChannel("GROUP_ENV1"), plant("GUI_ENV1") $groupboxstyle { ; ENV1 TAB
        image        bounds(0, 2, 230, 191) $imagestyle ;tab bg
        image        bounds(5, 95, 215, 95) $visbgstyle ;vis bg
        gentable bounds(45, 110, 130, 45), tableNumber(10021), ampRange(0, 1, 10021, 0.0100), active(1), identChannel("genTableEnv1"), sampleRange(0,2048), $gentablestyle      
        rslider  bounds(3, 50, 45, 45),    channel("env1a"),        range(0, 10, 0.001, 0.5, 0.001),   text("A"), popupPostfix(" s"),   $rsliderstyle
        rslider  bounds(43, 50, 45, 45),   channel("env1d"),        range(0, 10, 0, 0.5, 0.001),   text("D"), popupPostfix(" s"),  $rsliderstyle
        rslider  bounds(83, 50, 45, 45),   channel("env1s"),        range(0, 1, 1, 1, 0.001),   text("S"), popupPostfix(" "),     $rsliderstyle
        rslider  bounds(123, 50, 45, 45),   channel("env1r"),       range(0, 10, 0, 0.5, 0.001),   text("R"), popupPostfix(" s"), $rsliderstyle
        rslider  bounds(173, 50, 45, 45),  channel("env1amt"), identChannel("ENV1AMT_BUTTON"),   range(-100, 100, 100, 1, 0.01),   text("Amt"), popupPostfix(" %"), $rsliderstyle
        button bounds(180, 105, 30, 13),     channel("env1curve_exp"), text("EXP"), value(1),  radioGroup(201), $buttonstyle
        button bounds(180, 125, 30, 13),     channel("env1curve_lin"), text("LIN"), radioGroup(201), $buttonstyle
        button bounds(180, 145, 30, 13),     channel("env1curve_custom"), text("CUSTOM"), radioGroup(201), $buttonstyle
        image bounds(21, 178, 50, 1), $hsliderbgstyle
        image bounds(87, 178, 50, 1), $hsliderbgstyle
        image bounds(152, 178, 50, 1), $hsliderbgstyle
        label bounds(20, 161, 50, 10), text("A curve"), $visfontstyle
        label bounds(87, 161, 50, 10), text("D curve"), $visfontstyle
        label bounds(150, 161, 50, 10), text("R curve"), $visfontstyle
        hslider bounds(21, 167, 50, 25),      channel("env1acurve"),        range(-10, 10, 2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        hslider bounds(87, 167, 50, 25),      channel("env1dcurve"),        range(-10, 10, -2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        hslider bounds(152, 167, 50, 25),      channel("env1rcurve"),        range(-10, 10, -2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        image bounds(10, 160, 200, 25), $hiddenscreen, identChannel("ENV1_HIDCUST")
        button bounds(5, 27, 40, 17),   channel("env1osc1"), identChannel("ENV1OSC1_BUTTON"), text("OSC1"), value(1), $checkboxstyle
        button bounds(45, 27, 40, 17),   channel("env1osc2"), identChannel("ENV1OSC2_BUTTON"), text("OSC2"), value(1), $checkboxstyle
        button bounds(85, 27, 40, 17),  channel("env1osc3"), identChannel("ENV1OSC3_BUTTON"), text("OSC3"), value(1), $checkboxstyle
        button bounds(125, 27, 40, 17),  channel("env1osc4"), identChannel("ENV1OSC4_BUTTON"), text("OSC4"), value(1), $checkboxstyle
        button bounds(5, 7, 40, 17),     channel("env1amp"), text("Amp"), radioGroup(101), value(1), $buttonstyle 
        button bounds(45, 7, 40, 17),     channel("env1pitch"), text("Pitch"), radioGroup(101), $buttonstyle 
        button bounds(85, 7, 40, 17),     channel("env1morph"), text("Morph"), radioGroup(101), $buttonstyle  
        button bounds(125, 7, 40, 17),     channel("env1filter"), text("Filter"), radioGroup(101), $buttonstyle
        button bounds(165, 7, 40, 17),     channel("env1lfo"), text("LFO"), radioGroup(101), $buttonstyle
    }
    groupbox bounds(0, 20, 230, 195), visible(0) , identChannel("GROUP_ENV2"), plant("GUI_ENV2") $groupboxstyle { ; ENV2 TAB
        image        bounds(0, 2, 230, 191) $imagestyle ;tab bg
        image        bounds(5, 95, 215, 95) $visbgstyle ;vis bg
        gentable bounds(45, 110, 130, 45), tableNumber(10022), ampRange(0, 1, 10022, 0.0100), active(1), identChannel("genTableEnv2"), sampleRange(0,2048), $gentablestyle      
        rslider  bounds(3, 50, 45, 45),    channel("env2a"),        range(0, 10, 0.001, 0.5, 0.001),   text("A"), popupPostfix(" s"),   $rsliderstyle
        rslider  bounds(43, 50, 45, 45),   channel("env2d"),        range(0, 10, 0, 0.5, 0.001),   text("D"), popupPostfix(" s"),  $rsliderstyle
        rslider  bounds(83, 50, 45, 45),   channel("env2s"),        range(0, 1, 0, 1, 0.001),   text("S"), popupPostfix(" "),     $rsliderstyle
        rslider  bounds(123, 50, 45, 45),   channel("env2r"),       range(0, 10, 0, 0.5, 0.001),   text("R"), popupPostfix(" s"), $rsliderstyle
        rslider  bounds(173, 50, 45, 45),  channel("env2amt"), identChannel("ENV2AMT_BUTTON"),   range(-100, 100, 100, 1, 0.01),   text("Amt"), popupPostfix(" %"), $rsliderstyle
        button bounds(180, 105, 30, 13),     channel("env2curve_exp"), text("EXP"), value(1),  radioGroup(202), $buttonstyle
        button bounds(180, 125, 30, 13),     channel("env2curve_lin"), text("LIN"), radioGroup(202), $buttonstyle
        button bounds(180, 145, 30, 13),     channel("env2curve_custom"), text("CUSTOM"), radioGroup(202), $buttonstyle
        image bounds(21, 178, 50, 1), $hsliderbgstyle
        image bounds(87, 178, 50, 1), $hsliderbgstyle
        image bounds(152, 178, 50, 1), $hsliderbgstyle
        label bounds(20, 161, 50, 10), text("A curve"), $visfontstyle
        label bounds(87, 161, 50, 10), text("D curve"), $visfontstyle
        label bounds(150, 161, 50, 10), text("R curve"), $visfontstyle
        hslider bounds(21, 167, 50, 25),      channel("env2acurve"),        range(-10, 10, 2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        hslider bounds(87, 167, 50, 25),      channel("env2dcurve"),        range(-10, 10, -2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        hslider bounds(152, 167, 50, 25),      channel("env2rcurve"),        range(-10, 10, -2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        image bounds(10, 160, 200, 25), $hiddenscreen, identChannel("ENV2_HIDCUST")
        button bounds(5, 27, 40, 17),   channel("env2osc1"), identChannel("ENV2OSC1_BUTTON"), text("OSC1"), value(0), $checkboxstyle
        button bounds(45, 27, 40, 17),   channel("env2osc2"), identChannel("ENV2OSC2_BUTTON"), text("OSC2"), value(0), $checkboxstyle
        button bounds(85, 27, 40, 17),  channel("env2osc3"), identChannel("ENV2OSC3_BUTTON"), text("OSC3"), value(0), $checkboxstyle
        button bounds(125, 27, 40, 17),  channel("env2osc4"), identChannel("ENV2OSC4_BUTTON"), text("OSC4"), value(0), $checkboxstyle
        button bounds(5, 7, 40, 17),     channel("env2amp"), text("Amp"), radioGroup(102), value(1), $buttonstyle 
        button bounds(45, 7, 40, 17),     channel("env2pitch"), text("Pitch"), radioGroup(102), $buttonstyle 
        button bounds(85, 7, 40, 17),     channel("env2morph"), text("Morph"), radioGroup(102), $buttonstyle  
        button bounds(125, 7, 40, 17),     channel("env2filter"), text("Filter"), radioGroup(102), $buttonstyle
        button bounds(165, 7, 40, 17),     channel("env2lfo"), text("LFO"), radioGroup(102), $buttonstyle
    }
    groupbox bounds(0, 20, 230, 195), visible(0) , identChannel("GROUP_ENV3"), plant("GUI_ENV3") $groupboxstyle { ; ENV3 TAB
        image        bounds(0, 2, 230, 191) $imagestyle ;tab bg
        image        bounds(5, 95, 215, 95) $visbgstyle ;vis bg
        gentable bounds(45, 110, 130, 45), tableNumber(10023), ampRange(0, 1, 10023, 0.0100), active(1), identChannel("genTableEnv3"), sampleRange(0,2048), $gentablestyle      
        rslider  bounds(3, 50, 45, 45),    channel("env3a"),        range(0, 10, 0.001, 0.5, 0.001),   text("A"), popupPostfix(" s"),   $rsliderstyle
        rslider  bounds(43, 50, 45, 45),   channel("env3d"),        range(0, 10, 0, 0.5, 0.001),   text("D"), popupPostfix(" s"),  $rsliderstyle
        rslider  bounds(83, 50, 45, 45),   channel("env3s"),        range(0, 1, 0, 1, 0.001),   text("S"), popupPostfix(" "),     $rsliderstyle
        rslider  bounds(123, 50, 45, 45),   channel("env3r"),       range(0, 10, 0, 0.5, 0.001),   text("R"), popupPostfix(" s"), $rsliderstyle
        rslider  bounds(173, 50, 45, 45),  channel("env3amt"), identChannel("ENV3AMT_BUTTON"),   range(-100, 100, 100, 1, 0.01),   text("Amt"), popupPostfix(" %"), $rsliderstyle
        button bounds(180, 105, 30, 13),     channel("env3curve_exp"), text("EXP"), value(1),  radioGroup(203), $buttonstyle
        button bounds(180, 125, 30, 13),     channel("env3curve_lin"), text("LIN"), radioGroup(203), $buttonstyle
        button bounds(180, 145, 30, 13),     channel("env3curve_custom"), text("CUSTOM"), radioGroup(203), $buttonstyle
        image bounds(21, 178, 50, 1), $hsliderbgstyle
        image bounds(87, 178, 50, 1), $hsliderbgstyle
        image bounds(152, 178, 50, 1), $hsliderbgstyle
        label bounds(20, 161, 50, 10), text("A curve"), $visfontstyle
        label bounds(87, 161, 50, 10), text("D curve"), $visfontstyle
        label bounds(150, 161, 50, 10), text("R curve"), $visfontstyle
        hslider bounds(21, 167, 50, 25),      channel("env3acurve"),        range(-10, 10, 2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        hslider bounds(87, 167, 50, 25),      channel("env3dcurve"),        range(-10, 10, -2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        hslider bounds(152, 167, 50, 25),      channel("env3rcurve"),        range(-10, 10, -2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        image bounds(10, 160, 200, 25), $hiddenscreen, identChannel("ENV3_HIDCUST")
        button bounds(5, 27, 40, 17),   channel("env3osc1"), identChannel("ENV3OSC1_BUTTON"), text("OSC1"), value(0), $checkboxstyle
        button bounds(45, 27, 40, 17),   channel("env3osc2"), identChannel("ENV3OSC2_BUTTON"), text("OSC2"), value(0), $checkboxstyle
        button bounds(85, 27, 40, 17),  channel("env3osc3"), identChannel("ENV3OSC3_BUTTON"), text("OSC3"), value(0), $checkboxstyle
        button bounds(125, 27, 40, 17),  channel("env3osc4"), identChannel("ENV3OSC4_BUTTON"), text("OSC4"), value(0), $checkboxstyle
        button bounds(5, 7, 40, 17),     channel("env3amp"), text("Amp"), radioGroup(103), value(1), $buttonstyle 
        button bounds(45, 7, 40, 17),     channel("env3pitch"), text("Pitch"), radioGroup(103), $buttonstyle 
        button bounds(85, 7, 40, 17),     channel("env3morph"), text("Morph"), radioGroup(103), $buttonstyle  
        button bounds(125, 7, 40, 17),     channel("env3filter"), text("Filter"), radioGroup(103), $buttonstyle
        button bounds(165, 7, 40, 17),     channel("env3lfo"), text("LFO"), radioGroup(103), $buttonstyle
    }
    groupbox bounds(0, 20, 230, 195), visible(0) , identChannel("GROUP_ENV4"), plant("GUI_ENV4") $groupboxstyle { ; ENV4 TAB
        image        bounds(0, 2, 230, 191) $imagestyle ;tab bg
        image        bounds(5, 95, 215, 95) $visbgstyle ;vis bg
        gentable bounds(45, 110, 130, 45), tableNumber(10024), ampRange(0, 1, 10024, 0.0100), active(1), identChannel("genTableEnv4"), sampleRange(0,2048), $gentablestyle      
        rslider  bounds(3, 50, 45, 45),    channel("env4a"),        range(0, 10, 0.001, 0.5, 0.001),   text("A"), popupPostfix(" s"),   $rsliderstyle
        rslider  bounds(43, 50, 45, 45),   channel("env4d"),        range(0, 10, 0, 0.5, 0.001),   text("D"), popupPostfix(" s"),  $rsliderstyle
        rslider  bounds(83, 50, 45, 45),   channel("env4s"),        range(0, 1, 0, 1, 0.001),   text("S"), popupPostfix(" "),     $rsliderstyle
        rslider  bounds(123, 50, 45, 45),   channel("env4r"),       range(0, 10, 0, 0.5, 0.001),   text("R"), popupPostfix(" s"), $rsliderstyle
        rslider  bounds(173, 50, 45, 45),  channel("env4amt"), identChannel("ENV4AMT_BUTTON"),   range(-100, 100, 100, 1, 0.01),   text("Amt"), popupPostfix(" %"), $rsliderstyle
        button bounds(180, 105, 30, 13),     channel("env4curve_exp"), text("EXP"), value(1),  radioGroup(204), $buttonstyle
        button bounds(180, 125, 30, 13),     channel("env4curve_lin"), text("LIN"), radioGroup(204), $buttonstyle
        button bounds(180, 145, 30, 13),     channel("env4curve_custom"), text("CUSTOM"), radioGroup(204), $buttonstyle
        image bounds(21, 178, 50, 1), $hsliderbgstyle
        image bounds(87, 178, 50, 1), $hsliderbgstyle
        image bounds(152, 178, 50, 1), $hsliderbgstyle
        label bounds(20, 161, 50, 10), text("A curve"), $visfontstyle
        label bounds(87, 161, 50, 10), text("D curve"), $visfontstyle
        label bounds(150, 161, 50, 10), text("R curve"), $visfontstyle
        hslider bounds(21, 167, 50, 25),      channel("env4acurve"),        range(-10, 10, 2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        hslider bounds(87, 167, 50, 25),      channel("env4dcurve"),        range(-10, 10, -2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        hslider bounds(152, 167, 50, 25),      channel("env4rcurve"),        range(-10, 10, -2, 1, 0.01) text(""), popupPostfix(" "), $hsliderstyle
        image bounds(10, 160, 200, 25), $hiddenscreen, identChannel("ENV4_HIDCUST")
        button bounds(5, 27, 40, 17),   channel("env4osc1"), identChannel("ENV4OSC1_BUTTON"), text("OSC1"), value(0), $checkboxstyle
        button bounds(45, 27, 40, 17),   channel("env4osc2"), identChannel("ENV4OSC2_BUTTON"), text("OSC2"), value(0), $checkboxstyle
        button bounds(85, 27, 40, 17),  channel("env4osc3"), identChannel("ENV4OSC3_BUTTON"), text("OSC3"), value(0), $checkboxstyle
        button bounds(125, 27, 40, 17),  channel("env4osc4"), identChannel("ENV4OSC4_BUTTON"), text("OSC4"), value(0), $checkboxstyle
        button bounds(5, 7, 40, 17),     channel("env4amp"), text("Amp"), radioGroup(103), value(1), $buttonstyle 
        button bounds(45, 7, 40, 17),     channel("env4pitch"), text("Pitch"), radioGroup(103), $buttonstyle 
        button bounds(85, 7, 40, 17),     channel("env4morph"), text("Morph"), radioGroup(103), $buttonstyle  
        button bounds(125, 7, 40, 17),     channel("env4filter"), text("Filter"), radioGroup(103), $buttonstyle
        button bounds(165, 7, 40, 17),     channel("env4lfo"), text("LFO"), radioGroup(103), $buttonstyle
    }
    image        bounds(205, 2, 18, 18), file("img/warning.png"), identChannel("WARN_ENVSIGN"), visible(0)
    rslider  bounds(188,3,50,20), popupText("You are using 2 envelopes of the same type on the same oscillator. Unexpected behaviour may occur. Click on the 'About...' button (top right) & read the user manual for more infos."), identChannel("WARN_ENVMSG"), visible(0), alpha(0)
    
    button bounds(0, 3, 50, 19),text("ENV1"),channel("ENV1_BUTTON"), radioGroup(106), $buttontabstyle, identChannel("idENV1_BUTTON"), value(1)
    button bounds(50, 3, 50, 19),text("ENV2"),channel("ENV2_BUTTON"), radioGroup(106), $buttontabstyle, identChannel("idENV2_BUTTON")
    button bounds(100, 3, 50, 19),text("ENV3"),channel("ENV3_BUTTON"), radioGroup(106), $buttontabstyle, identChannel("idENV3_BUTTON")
    button bounds(150, 3, 50, 19),text("ENV4"),channel("ENV4_BUTTON"), radioGroup(106), $buttontabstyle, identChannel("idENV4_BUTTON")
    image    bounds(19, 18, 10, 2),     identChannel("idENV1_LED"), $ledstyle
    image    bounds(70, 18, 10, 2),     identChannel("idENV2_LED"), $ledstyle
    image    bounds(120, 18, 10, 2),    identChannel("idENV3_LED"), $ledstyle
    image    bounds(170, 18, 10, 2),    identChannel("idENV4_LED"), $ledstyle
}


;*******************LFO
;1
groupbox bounds(320, 228, 230, 125), , identChannel("GROUP_LFOALL"), plant("GUI_LFOALL") visible(1) $groupboxstyle {
    groupbox bounds(0, 20, 230, 110), visible(1) , identChannel("GROUP_LFO1"), plant("GUI_LFO1") $groupboxstyle {
        image    bounds(0, 2, 230, 110) $imagestyle
        combobox bounds(5, 64, 70, 20), fontColour("silver") channel("lfo1shape_B"), items("-","Sine","Triangle","Square","Saw Dn","Saw Up","Random"), value(1), colour(20,30,40), align("centre")
        rslider  bounds(55, 64, 20, 20),    channel("lfo1shape_K"),       range(1, 7, 1, 1, 1), $rsliderhiddenstyle
        label    bounds(13,88,50,11), text("Shape")
        rslider  bounds(80, 58, 45, 45),   channel("lfo1gain"),        range(0, 20, 0.5, 0.25, 0.01),   text("Gain"), popupPostfix(" "),  $rsliderstyle
        rslider  bounds(126, 58, 45, 45),   channel("lfo1rate"),        range(0, 1000, 4, 0.25, 0.01),   text("Rate"), popupPostfix(" Hz"), identChannel("lfo1rate_i")     $rsliderstyle
        image        bounds(126, 58, 45, 45), channel("lfo1hide") identChannel("lfo1hide_i"), $imagestyle
        rslider  bounds(126, 58, 45, 45),   channel("lfo1mult"), value(0),     range(1, 256, 1, 1, 1),   text("Rate"), popupPrefix("1/"), popupPostfix(" Beat"), identChannel("lfo1mult_i")     $rsliderstyle
        rslider  bounds(170, 58, 45, 45),  channel("lfo1amt"),         range(-100, 100, 100, 1, 0.01),   text("Amt"), popupPostfix(" %"), $rsliderstyle
        
        button bounds(5, 30, 38, 17),      channel("lfo1osc1"), identChannel("LFO1OSC1_BUTTON"), text("OSC1"),value(1), $checkboxstyle
        button bounds(43, 30, 38, 17),     channel("lfo1osc2"), identChannel("LFO1OSC2_BUTTON"), text("OSC2"),value(1), $checkboxstyle
        button bounds(81, 30, 38, 17),     channel("lfo1osc3"), identChannel("LFO1OSC3_BUTTON"), text("OSC3"),value(1), $checkboxstyle
        button bounds(119, 30, 38, 17),    channel("lfo1osc4"), identChannel("LFO1OSC4_BUTTON"), text("OSC4"),value(1), $checkboxstyle
        label bounds(150, 40, 70, 10), text("Musical")  
        checkbox bounds(210, 40, 10, 10), channel("lfo1musical"), text("Musical"), value(1) $checkboxstyle
        label bounds(150, 10, 70, 10), text("BPM Sync")  
        checkbox bounds(210 ,10, 10, 10), channel("lfo1bpm"), text("BPM Sync"), $checkboxstyle
        label bounds(150, 25, 70, 10), text("Fast LFO")  
        checkbox bounds(210, 25, 10, 10), channel("lfo1audiorate"), value(1) $checkboxstyle
         
        button bounds(5, 7, 38, 17),     channel("lfo1amp"), text("Amp"), radioGroup(107), value(1), $buttonstyle 
        button bounds(43, 7, 38, 17),     channel("lfo1pitch"), text("Pitch"), radioGroup(107), $buttonstyle 
        button bounds(81, 7, 38, 17),     channel("lfo1morph"), text("Morph"), radioGroup(107), $buttonstyle  
        button bounds(119, 7, 38, 17),     channel("lfo1filter"), text("Filter"), radioGroup(107), $buttonstyle 
    }
     groupbox bounds(0, 20, 230, 110), visible(0) , identChannel("GROUP_LFO2"), plant("GUI_LFO2") $groupboxstyle {
        image    bounds(0, 2, 230, 110), $imagestyle
        combobox bounds(5, 64, 70, 20), fontColour("silver") channel("lfo2shape_B"), items("-","Sine","Triangle","Square","Saw Dn","Saw Up","Random"), value(1), colour(20,30,40), align("centre")
        rslider  bounds(55, 64, 20, 20),    channel("lfo2shape_K"),       range(1, 7, 1, 1, 1), $rsliderhiddenstyle
        label    bounds(13,88,50,11), text("Shape")
        rslider  bounds(80, 58, 45, 45),   channel("lfo2gain"),        range(0, 20, 0.5, 0.25, 0.01),   text("Gain"), popupPostfix(" "),  $rsliderstyle
        rslider  bounds(126, 58, 45, 45),   channel("lfo2rate"),        range(0, 1000, 4, 0.25, 0.01),   text("Rate"), popupPostfix(" Hz"), identChannel("lfo2rate_i")     $rsliderstyle
        image        bounds(126, 58, 45, 45), channel("lfo2hide") identChannel("lfo2hide_i"), $imagestyle
        rslider  bounds(126, 58, 45, 45),   channel("lfo2mult"), value(0),     range(1, 32, 1, 1, 1),   text("Rate"), popupPrefix("1/"), popupPostfix(" Beat"), identChannel("lfo2mult_i")     $rsliderstyle
        rslider  bounds(170, 58, 45, 45),  channel("lfo2amt"),         range(-100, 100, 100, 1, 0.01),   text("Amt"), popupPostfix(" %"), $rsliderstyle

        button bounds(5, 30, 38, 17),      channel("lfo2osc1"), identChannel("LFO2OSC1_BUTTON"), text("OSC1"), $checkboxstyle
        button bounds(43, 30, 38, 17),     channel("lfo2osc2"), identChannel("LFO2OSC2_BUTTON"), text("OSC2"), $checkboxstyle
        button bounds(81, 30, 38, 17),     channel("lfo2osc3"), identChannel("LFO2OSC3_BUTTON"), text("OSC3"), $checkboxstyle
        button bounds(119, 30, 38, 17),    channel("lfo2osc4"), identChannel("LFO2OSC4_BUTTON"), text("OSC4"), $checkboxstyle
        label bounds(150, 40, 70, 10), text("Musical")  
        checkbox bounds(210, 40, 10, 10), channel("lfo2musical"), text("Musical"), value(1) $checkboxstyle
        label bounds(150, 10, 70, 10), text("BPM Sync")  
        checkbox bounds(210 ,10, 10, 10), channel("lfo2bpm"), text("BPM Sync"), $checkboxstyle
        label bounds(150, 25, 70, 10), text("Fast LFO")  
        checkbox bounds(210, 25, 10, 10), channel("lfo2audiorate"), value(1) $checkboxstyle
        
        button bounds(5, 7, 38, 17),       channel("lfo2amp"), text("Amp"), radioGroup(108), value(1), $buttonstyle 
        button bounds(43, 7, 38, 17),      channel("lfo2pitch"), text("Pitch"), radioGroup(108), $buttonstyle 
        button bounds(81, 7, 38, 17),      channel("lfo2morph"), text("Morph"), radioGroup(108), $buttonstyle  
        button bounds(119, 7, 38, 17),     channel("lfo2filter"), text("Filter"), radioGroup(108), $buttonstyle 
    }
   
    button bounds(0, 3, 50, 19), text("LFO1"),channel("LFO1_BUTTON"), radioGroup(109), identChannel("idLFO1_BUTTON"), $buttontabstyle, value(1)
    button bounds(50, 3, 50, 19),text("LFO2"),channel("LFO2_BUTTON"), radioGroup(109), identChannel("idLFO2_BUTTON"), $buttontabstyle
    image    bounds(19, 18, 10, 2),     identChannel("idLFO1_LED"), $ledstyle
    image    bounds(70, 18, 10, 2),     identChannel("idLFO2_LED"), $ledstyle
}


;*******************FILTER
;1
groupbox bounds(5, 228, 305, 125), , identChannel("GROUP_FILTERALL"), plant("GUI_FILTERALL"), visible(1) $groupboxstyle {
    groupbox bounds(0, 20, 305, 125), visible(0) , identChannel("GROUP_FILTER1"), plant("GUI_FILTER1") $groupboxstyle {
        image    bounds(0, 2, 305, 110) $imagestyle       
        combobox bounds(55, 15, 55, 20), fontColour("silver") channel("filter1mode1_B"), items("-","LP3","LP2","HP","BP"), value(1), colour(20,30,40), align("centre")
        rslider bounds(83, 15, 35, 20), range(1, 5, 1, 1, 1),              channel("filter1mode1_K"), $rsliderhiddenstyle
        rslider bounds(115, 8, 45, 45) range(0, 20000, 1300, 0.25, 0.01),     channel("filter1cut1"), text("Cut 1.1"), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(165, 14, 45, 40) range(0.01, 10, 0.1, 1, 0.01),    channel("filter1res1"), text("Res 1.1"), popupPostfix(" "), $rsliderstylesmall
        rslider bounds(210, 14, 60, 40) range(-100, 100, 0, 1, 0.01),       channel("filter1keytrack1"),  text("Keytrack 1.1"), popupPostfix(" %"), $rsliderstylesmall
        label    bounds(57,38,50,11), text("Filter 1.1")
        combobox bounds(55, 65, 55, 20), fontColour("silver") channel("filter1mode2_B"), items("-","LP3","LP2","HP","BP"), value(1), colour(20,30,40), align("centre") 
        rslider bounds(83, 65, 35, 20), range(1, 5, 1, 1, 1),             channel("filter1mode2_K"), $rsliderhiddenstyle
        rslider bounds(115, 58, 45, 45) range(0, 20000, 1300, 0.25, 0.01), channel("filter1cut2"), text("Cut 1.2"), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(165, 63, 45, 40) range(0.01, 10, 0.1, 1, 0.01),   channel("filter1res2"), text("Res 1.2"), popupPostfix(" "), $rsliderstylesmall
        rslider bounds(210, 63, 60, 40) range(-100, 100, 0, 1, 0.01),       channel("filter1keytrack2"),  text("Keytrack 1.2"), popupPostfix(" %"), $rsliderstylesmall
        label    bounds(57,88,50,11), text("Filter 1.2")
        vslider bounds(270, 8, 35, 90) range(1, 20, 1, 0.5, 0.01),    channel("filter1drive"), text("Drive"), popupPostfix(" "), $rsliderstyle

        button bounds(7, 25, 38, 17), channel("filter1osc1"), text("OSC1"), identChannel("FILTER1BUT1"), value(1) $checkboxstyle
        button bounds(7, 45, 38, 17),channel("filter1osc2"), text("OSC2"), identChannel("FILTER1BUT2"), value(1) $checkboxstyle
        button bounds(7, 65, 38, 17), channel("filter1osc3"), text("OSC3"), identChannel("FILTER1BUT3"), value(1) $checkboxstyle
        button bounds(7, 85, 38, 17),channel("filter1osc4"), text("OSC4"), identChannel("FILTER1BUT4"), value(1) $checkboxstyle
        button  bounds(2, 5, 50, 15), text("F1 > F2", "F1 // F2"), channel("filterP"), $buttonstyleon
    }
    groupbox bounds(0, 20, 305, 125), visible(0) , identChannel("GROUP_FILTER2"), plant("GUI_FILTER2") $groupboxstyle {
        image    bounds(0, 2, 305, 110) $imagestyle     
        combobox bounds(55, 15, 55, 20), fontColour("silver") channel("filter2mode1_B"), items("-","LP3","LP2","HP","BP"), value(1), colour(20,30,40), align("centre")
        rslider bounds(83, 15, 35, 20), range(1, 5, 1, 1, 1),              channel("filter2mode1_K"), $rsliderhiddenstyle
        rslider bounds(115, 8, 45, 45) range(0, 20000, 1300, 0.25, 0.01),     channel("filter2cut1"), text("Cut 2.1"), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(165, 14, 45, 40) range(0.01, 10, 0.1, 1, 0.01),    channel("filter2res1"), text("Res 2.1"), popupPostfix(" "), $rsliderstylesmall
        rslider bounds(210, 14, 60, 40) range(-100, 100, 0, 1, 0.01),       channel("filter2keytrack1"),  text("Keytrack 2.1"), popupPostfix(" %"), $rsliderstylesmall
        label    bounds(57,38,50,11), text("Filter 2.1")
        combobox bounds(55, 65, 55, 20), fontColour("silver") channel("filter2mode2_B"), items("-","LP3","LP2","HP","BP"), value(1), colour(20,30,40), align("centre") 
        rslider bounds(83, 65, 35, 20), range(1, 5, 1, 1, 1),             channel("filter2mode2_K"), $rsliderhiddenstyle
        rslider bounds(115, 58, 45, 45) range(0, 20000, 1300, 0.25, 0.01), channel("filter2cut2"), text("Cut 2.2"), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(165, 63, 45, 40) range(0.01, 10, 0.1, 1, 0.01),   channel("filter2res2"), text("Res 2.2"), popupPostfix(" "), $rsliderstylesmall
        rslider bounds(210, 63, 60, 40) range(-100, 100, 0, 1, 0.01),       channel("filter2keytrack2"),  text("Keytrack 2.2"), popupPostfix(" %"), $rsliderstylesmall
        label    bounds(57,88,50,11), text("Filter 2.2")
        vslider bounds(270, 8, 35, 90) range(1, 20, 1, 0.5, 0.01),    channel("filter2drive"), text("Drive"), popupPostfix(" "), $rsliderstyle
        
        button bounds(7, 25, 38, 17), channel("filter2osc1"), text("OSC1"), identChannel("FILTER2BUT1"), $checkboxstyle
        button bounds(7, 45, 38, 17),channel("filter2osc2"), text("OSC2"), identChannel("FILTER2BUT2"), $checkboxstyle
        button bounds(7, 65, 38, 17), channel("filter2osc3"), text("OSC3"), identChannel("FILTER2BUT3"), $checkboxstyle
        button bounds(7, 85, 38, 17),channel("filter2osc4"), text("OSC4"), identChannel("FILTER2BUT4"), $checkboxstyle
        button  bounds(2, 5, 50, 15), text("F1 > F2", "F1 // F2"), channel("filterP"), $buttonstyleon
    }
    image        bounds(105, 2, 18, 18), file("img/warning.png"), identChannel("WARN_FILSIGN"), visible(0)
    rslider  bounds(90,3,50,20), popupText("The OSC in RED are used but not routed to any filter unit. When filters are used in parallel mode every OSC used must be routed to at least one filter unit. Click on the 'About...' button (top right) & read the user manual for more infos."), identChannel("WARN_FILMSG"), visible(0), alpha(0)
    
    button bounds(0, 3, 50, 19),text("FILTER1"), channel("FILTER1_BUTTON"), identChannel("idFILTER1_BUTTON"), radioGroup(110), $buttontabstyle, value(1)
    button bounds(50, 3, 50, 19),text("FILTER2"), channel("FILTER2_BUTTON"), identChannel("idFILTER2_BUTTON"), radioGroup(110), $buttontabstyle
    image    bounds(19, 18, 10, 2),     identChannel("idFILTER1_LED"), $ledstyle
    image    bounds(70, 18, 10, 2),     identChannel("idFILTER2_LED"), $ledstyle
}


;**************EFFECTS
groupbox bounds(5, 360, 545, 115), , identChannel("GROUP_EFFECTALL"), plant("GUI_EFFECTALL")visible(1) $groupboxstyle {
    groupbox bounds(0, 20, 545, 190), visible(1) , identChannel("GROUP_EFFECT1"), plant("GUI_EFFECT1") $groupboxstyle {
        image    bounds(-1, 2, 548, 99) $imagestyle
        label    bounds(350,8,140,15), align("right"), text("DISTORTION")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("distswitch"), $checkboxstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 100, 1, 0.01), channel("drywetdist"), popupPostfix(" %"), text("Dry/Wet"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("distlevel"), text("Volume"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(395, 40, 45, 45), range(0, 100.0, 0), channel("distcarac"), text("Carac."), popupPostfix(" %"), $rsliderstyle
        rslider bounds(5, 20, 65, 65), range(0, 100, 0, 1, 0.01), channel("distclip"), text("Clip"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(80, 20, 65, 65), range(0, 100, 63, 1, 0.01), channel("distpowershape"), text("Power"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(160, 20, 65, 65), range(0, 100, 0, 1, 0.01), channel("distsaturator"), text("Saturator"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(240, 20, 65, 65), range(0, 100, 0, 1, 0.01), channel("distbitcrusher"), text("Bit Crusher"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(320, 20, 65, 65), range(0, 100, 0, 0.25, 0.01), channel("distfoldover"), text("Foldover"), popupPostfix(" %"), $rsliderstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identChannel("GROUP_EFFECT3"), plant("GUI_EFFECT3") $groupboxstyle {
        image    bounds(-1, 2, 548, 99) $imagestyle
        label    bounds(350,8,140,15), align("right"), text("EQ")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("eqswitch"), $checkboxstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 100, 1, 0.01), channel("dryweteq"), text("Dry/Wet"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("eqlevel"), text("Volume"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(60, 20, 65, 65), range(1, 20000, 300, 0.5, 0.01), channel("eqlowfreq"), text("Low"), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(20, 40, 45, 45), range(0, 5, 0.75, 1, 0.01), channel("eqlowamp"), text("Gain"), popupPostfix(" "), $rsliderstyle
        rslider bounds(280, 20, 65, 65), range(1, 20000, 8000, 0.5, 0.01), channel("eqhighfreq"), text("High"), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(340, 40, 45, 45), range(0, 5, 1.5, 1, 0.01), channel("eqhighamp"), text("Gain"), popupPostfix(" "), $rsliderstyle
        rslider bounds(190, 20, 65, 65), range(1, 20000, 300, 0.5, 0.01), channel("eqmidfreq"), text("Mid"), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(150, 40, 45, 45), range(0, 5, 1, 1, 0.01), channel("eqmidamp"), text("Gain"), popupPostfix(" "), $rsliderstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identChannel("GROUP_EFFECT2"), plant("GUI_EFFECT2") $groupboxstyle {
        image    bounds(-1, 2, 548, 99) $imagestyle
        label    bounds(350,8,140,15), align("right"), text("CHORUS")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("chorusswitch"), $checkboxstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 50, 1, 0.01), channel("drywetchorus"), text("Dry/Wet"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("choruslevel"), text("Volume"), popupPostfix(" %"), $rsliderstyle
        rslider  bounds(70, 20, 65, 65), text("Rate"), channel("chorusrate"), range(0.001, 40, 0.35,0.2), popupPostfix(" Hz"), $rsliderstyle
        rslider  bounds(130, 20, 65, 65), text("Depth"), channel("chorusdepth"), range(0, 100.00, 40), popupPostfix(" %"), $rsliderstyle
        rslider  bounds(330, 20, 65, 65), text("Offset"), channel("chorusoffset"), range(0.0001,0.1,0.001,0.5,0.0001), popupPostfix(" s"), $rsliderstyle
        rslider  bounds(190, 20, 65, 65), text("Delay"), channel("choruswidth"), range(0, 100.00, 100), popupPostfix(" %"), $rsliderstyle
        rslider  bounds(270, 20, 65, 65), text("Width"), channel("chorusstereowidth"), range(0, 100.00, 100), popupPostfix(" %"), $rsliderstyle
        label bounds(0, 70, 70, 11), text("Mode") 
        button bounds(10, 10, 50, 17), text("Classic"), channel("chorusmode1"),radioGroup(120), value(1), $checkboxstyle
        button bounds(10, 30, 50, 17), text("Super"), channel("chorusmode2"), radioGroup(120), $checkboxstyle
        button bounds(10, 50, 50, 17), text("Hyper"), channel("chorusmode3"), radioGroup(120), $checkboxstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identChannel("GROUP_EFFECT5"), plant("GUI_EFFECT5") $groupboxstyle {
        image    bounds(-1, 2, 548, 99) $imagestyle
        label    bounds(350,8,140,15), align("right"), text("DELAY")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("delswitch"), $checkboxstyle
        rslider bounds(20, 30, 50, 50), text("Tempo"), 	 		channel("deltempo"), 	range(40, 500, 128, 1, 1), popupPostfix(" BPM"), $rsliderstyle
        label bounds(5, 13, 70, 13), text("BPM Sync")  
        checkbox bounds(75, 15, 10, 10), channel("delClockSource"), text("BPM Sync"), value(1), $checkboxstyle
        rslider bounds(85, 30, 50, 50), text("Rhy.Mult."),		channel("delRhyMlt"), 	range(1, 16, 4, 1, 1), popupPostfix(" "), $rsliderstyle     
        rslider bounds(150, 30, 50, 50), text("Damping"),  		channel("deldamp"), 	range(0,20000, 3800,0.5), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(215, 30, 50, 50), text("Feedback"), 		channel("delfback"), 	range(0, 100.00, 60), popupPostfix(" %"), $rsliderstyle  
        rslider bounds(280, 30, 50, 50), text("Width"),			channel("delwidth"), 	range(0,  100.00, 100), popupPostfix(" %"), $rsliderstyle
        button  bounds(340, 35, 70, 20), text("REV->DEL", "DEL->REV"), channel("delrevorder"), $buttonstyleon
        label    bounds(350,65,50,11), text("Order")   
        rslider bounds(485, 40, 45, 45), range(0, 100, 25, 1, 0.01), channel("drywetdel"), text("Dry/Wet"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("dellevel"), text("Volume"), popupPostfix(" %"), $rsliderstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identChannel("GROUP_EFFECT4"), plant("GUI_EFFECT4") $groupboxstyle {
        image    bounds(-1, 2, 548, 99) $imagestyle
        image    bounds(330, 15, 1, 70), colour(255,255,255,50)
        label    bounds(350,8,140,15), align("right"), text("REVERB")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("revswitch"), $checkboxstyle
        button bounds(12, 33, 30, 30), text("L","H"), channel("revtype"), popupPostfix(" "), $checkboxstyle
        label    bounds(2,65,50,11), text("Type")
        rslider bounds(45, 30, 50, 50), text("Size"), channel("revsize"), 	range(0, 100.00,85), popupPostfix(" %"), $rsliderstyle
        rslider bounds(95, 30, 50, 50), text("Pre-del."), channel("revdel"), 	range(0, 1000, 0, 0.25, 1), popupPostfix(" ms"), $rsliderstyle
        rslider bounds(145, 30, 50, 50), text("Damping"), channel("revdamp"), 	range(0, 20000, 10000, 0.5, 0.01), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(195, 30, 50, 50), text("Pitch Mod."), channel("revpitchmod"), range(0, 20.0, 1), identchannel("REVPITCHMOD_BUTTON"), popupPostfix(" "), $rsliderstyle
        rslider bounds(245, 30, 50, 50), text("Width"), channel("revwred"), range(0, 100.0, 100), popupPostfix(" %"), $rsliderstyle
        rslider bounds(287, 55, 50, 35), text("LPF"), channel("revCutLPF"), range(0, 20000, 20000, 0.5), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(287, 16, 50, 35), text("HPF"), channel("revCutHPF"), range(0, 20000, 200, 0.5), popupPostfix(" Hz"), $rsliderstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 15, 1, 0.01), channel("drywetrev"), text("Dry/Wet"), popupPostfix(" %"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("revlevel"), text("Volume"), popupPostfix(" %"), $rsliderstyle
        label bounds(332, 30, 70, 12), text("Sidechain")
        button  bounds(400, 28, 30, 16), text("OFF", "ON"), channel("revSCswitch"), $checkboxstyle
        rslider bounds(335, 50, 50, 35), text("Level"), channel("revSCthresh"), range(-120,0,-30), popupPostfix(" dB"), $rsliderstylesmall
        rslider bounds(375, 50, 50, 35), text("Rel."), channel("revSCrel"), range(0,0.1,0.03,0.5,0.001), popupPostfix(" s"), $rsliderstylesmall
        image    bounds(435, 30, 1, 50), colour(255,255,255,50)
        image    bounds(295, 15, 1, 70), colour(255,255,255,50)
        
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identChannel("GROUP_EFFECT6"), plant("GUI_EFFECT6") $groupboxstyle {
        image    bounds(-1, 2, 548, 99) $imagestyle
        label    bounds(350,8,140,15), align("right"), text("COMPRESSOR")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("compswitch"), $checkboxstyle
        rslider bounds(70, 20, 65, 65), channel("compatt"), text("Attack"),  range(0,1,0.2,0.5,0.001), popuppostfix(" s"), $rsliderstyle
        rslider bounds(130, 20, 65, 65), channel("comprel"), text("Release"), range(0,2,0.01,0.5,0.001), popuppostfix(" s"), $rsliderstyle
        rslider bounds(190, 20, 65, 65), channel("compratio"), text("Ratio"), range(1,300,2,0.25), popuppostfix(" "), $rsliderstyle
        rslider bounds(270, 20, 65, 65), channel("compLowKnee"), text("Low Knee"), range(0,120,48), popuppostfix(" dB"), $rsliderstyle
        rslider bounds(330, 20, 65, 65), channel("compHighKnee"), text("High Knee"), range(0,120,60), popuppostfix(" dB"), $rsliderstyle

        rslider bounds(440, 40, 45, 45), range(-40,40,5), channel("compgain"), text("Gain"), popupPostfix(" "), $rsliderstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 100, 1, 0.01), channel("drywetcomp"), text("Dry/Wet"), popupPostfix(" %"), $rsliderstyle  
    }
    button bounds(0, 3, 50, 19),text("DIST"), channel("EFFECT1_BUTTON"), identChannel("idFX1_BUTTON"), radioGroup(111), $buttontabstyle, value(1)
    button bounds(50, 3, 50, 19),text("EQ"), channel("EFFECT3_BUTTON"), identChannel("idFX2_BUTTON"), radioGroup(111), $buttontabstyle
    button bounds(100, 3, 50, 19),text("CHORUS"), channel("EFFECT2_BUTTON"), identChannel("idFX3_BUTTON"), radioGroup(111), $buttontabstyle
    button bounds(150, 3, 50, 19),text("DELAY"), channel("EFFECT5_BUTTON"), identChannel("idFX4_BUTTON"), radioGroup(111), $buttontabstyle
    button bounds(200, 3, 50, 19),text("REVERB"), channel("EFFECT4_BUTTON"), identChannel("idFX5_BUTTON"), radioGroup(111), $buttontabstyle
    button bounds(250, 3, 50, 19),text("COMP"), channel("EFFECT6_BUTTON"), identChannel("idFX6_BUTTON"), radioGroup(111), $buttontabstyle
    image    bounds(20, 18, 10, 2),     identChannel("idFX1_LED"), $ledstyle
    image    bounds(70, 18, 10, 2),     identChannel("idFX2_LED"), $ledstyle
    image    bounds(119, 18, 10, 2),    identChannel("idFX3_LED"), $ledstyle
    image    bounds(169, 18, 10, 2),    identChannel("idFX4_LED"), $ledstyle
    image    bounds(218, 18, 10, 2),     identChannel("idFX5_LED"), $ledstyle
    image    bounds(270, 18, 10, 2),     identChannel("idFX6_LED"), $ledstyle
}


; DETUNE VIS - x,y updated by Csound
image bounds(650, 500, 1, 10), identChannel("img_bar10"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar11"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar12"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar13"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar14"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar15"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar16"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar17"), colour("lightblue"), visible(0)

image bounds(650, 500, 1, 10), identChannel("img_bar20"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar21"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar22"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar23"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar24"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar25"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar26"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar27"), colour("lightblue"), visible(0)

image bounds(650, 500, 1, 10), identChannel("img_bar30"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar31"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar32"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar33"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar34"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar35"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar36"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar37"), colour("lightblue"), visible(0)

image bounds(650, 500, 1, 10), identChannel("img_bar40"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar41"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar42"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar43"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar44"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar45"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar46"), colour("lightblue"), visible(0)
image bounds(650, 500, 1, 10), identChannel("img_bar47"), colour("lightblue"), visible(0)



image    bounds(0, 0, 719, 485), visible(0), colour(0, 0, 0), alpha(0.8), identChannel("GROUP_BGABOUT")
button bounds(0, 0, 719, 485), visible(0), colour(0,0,0), alpha(0), identChannel("GROUP_BGCLOSE"), channel("BGCLOSE")

image    bounds(0, 0, 719, 485), visible(0), colour(0, 0, 0), alpha(0.8), identChannel("GROUP_BGWFMANAG")
button bounds(0, 0, 719, 485), visible(0), colour(0,0,0), alpha(0), identChannel("GROUP_BGCLOSE_1"), channel("BGCLOSE_1")

;ABOUT TAB
groupbox bounds(100, 100, 500, 300), visible(0) , identChannel("GROUP_ABOUT"), plant("GUI_ABOUT"){
    image    bounds(0, 0, 500, 300) $imagestyle
    label    bounds(0,20,500,20), text("ToneZ by Retornz - v2.0.0")
    button bounds(300, 20, 70, 20) channel("button_debug") alpha(0) text("") value(0) latched(0) $buttonstyle
    infobutton bounds(400, 18, 100, 23), text("Check for updates"), file("https://www.retornz.com/utils/tonez_uc?v=2.0.0"), latched(0), $buttonstyle
    label    bounds(130,100,100,10), text("[[USER MANUAL]]")
    image        bounds(100, 70, 150, 72), file("img/AboutMan.png"), colour(0,0,0,0.5)
    infobutton bounds(100, 70, 150, 72), file("https://www.retornz.com/redir/ToneZAboutM.html"), colour(0,0,0), alpha(0)
    label    bounds(290,100,100,10), text("[[DISCORD CHAT]]")
    image        bounds(260, 70, 150, 72), file("img/AboutDisc.png"), colour(0,0,0,0.5)
    infobutton bounds(260, 70, 150, 72), file("https://www.retornz.com/redir/ToneZAboutD.html"), colour(0,0,0), alpha(0)
    label    bounds(100,180,150,10), text("[[DOWNLAOD PRESET PACKS]]")
    image        bounds(100, 152, 150, 72), file("img/AboutPP.png"), colour(0,0,0,0.5)
    infobutton bounds(100, 152, 150, 72), file("https://www.retornz.com/redir/ToneZAboutPP.html"), colour(0,0,0), alpha(0)
    label    bounds(260,180,150,10), text("[[DONATE ON PAYPAL]]")
    image        bounds(260, 152, 150, 72), file("img/AboutDon.png"), colour(0,0,0,0.5)
    infobutton bounds(260, 152, 150, 72), file("https://www.retornz.com/redir/ToneZAboutP.html"), colour(0,0,0), alpha(0)

    groupbox bounds(10, 250, 200, 50) alpha(0.6){
        image    bounds(0, 0, 200, 50) $imagestyle
        label    bounds(40,10,100,10), text("Made in Cabbage"), align("left")
        label    bounds(40,25,130,10), text("www.cabbageaudio.com"), align("left")
        image        bounds(5, 10, 25, 40), file("img/CabbageLogo.svg")
        infobutton bounds(0, 0, 200, 50), file("http://cabbageaudio.com/"), colour(0,0,0), alpha(0)
    }
    groupbox bounds(180, 230, 200, 70) alpha(0.6){
        image    bounds(0, 0, 200, 70) $imagestyle
        label    bounds(0,40,100,10), text("Retornz - 2023"), align("center")
        label    bounds(0,50,110,10), text("www.retornz.com"), align("center")
        image        bounds(0, 10, 150, 28), file("img/logov6.svg")
        infobutton bounds(0, 0, 200, 50), file("https://www.retornz.com/"), colour(0,0,0), alpha(0)
    }
    groupbox bounds(350, 250, 200, 50) alpha(0.6){
        image    bounds(0, 0, 200, 50) $imagestyle
        label    bounds(40,10,100,10), text("Developed in Csound"), align("left")
        label    bounds(40,25,100,10), text("www.csound.com"), align("left")
        image        bounds(5, 10, 25, 25), file("img/CsoundLogo.svg")
        infobutton bounds(0, 0, 200, 50), file("https://csound.com"), colour(0,0,0), alpha(0)
    }
}

groupbox bounds(100, 100, 500, 300), visible(0) , identChannel("GROUP_CONSOLE"), plant("GUI_CONSOLE"){
    image    bounds(0, 0, 500, 300) $imagestyle
    csoundoutput bounds(0, 0, 500, 300)
}
;WF MANAGER TAB
groupbox bounds(50, 50, 600, 400), visible(0) , identChannel("GROUP_WFMANAG"), plant("GUI_WFMANAG"), $groupboxstyle {
    image    bounds(0, 0, 600, 400) $imagestyle
    label    bounds(50,13,500,20), text("ToneZ Custom Waveform Manager")
    texteditor    bounds(40,40,530,50), wrap(1), readOnly(1), colour(0,0,0,0), fontColour("grey"), fontSize(12) text("Up to 2 custom waveforms can be loaded in a single instance of ToneZ.\nThey are accessible through the waveform oscilators waveforms selectors as 'Custom1' & 'Custom2'\n'Custom1' & 'Custom2' are automatically saved into presets")
    image bounds(35,40,1,45), alpha(0.5)
    image bounds(300,105,1,150), alpha(0.5)
    image bounds(0,255,600,1), alpha(0.5)
    
    groupbox bounds(0, 265, 600, 130), visible(1) plant("GUI_WFMANAG_WAV"), $groupboxstyle {
       label    bounds(20,0,200,17), text("ToneZ Waveform Creator"), align("left")
       texteditor    bounds(220,0,530,50), wrap(1), readOnly(1), align("left"), colour(0,0,0,0), fontColour("grey"), fontSize(12) text("Convert a part of a .wav file into a ToneZ custom Waveform")
       texteditor    bounds(20,20,530,50), wrap(1), readOnly(1), align("left"), colour(0,0,0,0), fontColour("grey"), fontSize(12) text("1) Open a .wav file")
       texteditor    bounds(20,38,530,50), wrap(1), readOnly(1), align("left"), colour(0,0,0,0), fontColour("grey"), fontSize(12) text("2) Adjust the size & starting point")
       texteditor    bounds(420,30,530,50), wrap(1), readOnly(1), align("left"), colour(0,0,0,0), fontColour("grey"), fontSize(12) text("3) Convert to ToneZ waveform")
       
       gentable bounds(210, 32, 200, 100), tableNumber(20000), ampRange(-1, 1, 20000, 0.0100), identChannel("genTableWFWAV"), sampleRange(0,8192), $gentablestyle tableColour("grey")
       texteditor    bounds(230,110,530,50), wrap(1), readOnly(1), align("left"), colour(0,0,0,0), fontColour("grey"), fontSize(10) text("(.wav will not be saved into presets)")
       
       filebutton bounds(30, 60, 100, 19), channel("WFM_Open_WAV") text("Open (.wav)") populate("*.wav") latched(0) $buttonstyle
       
       rslider bounds(10, 91, 75, 42), text("Size"),    channel("WFM_WAV_Size"), range(7, 13, 13,1,1), popupText(0) $rsliderstyle
       button bounds(430, 58, 100, 19), channel("WFM_WAVtoWF1") text("--> Custom 1") latched(0), $buttonstyle
       button bounds(430, 92, 100, 19), channel("WFM_WAVtoWF2") text("--> Custom 2") latched(0), $buttonstyle
       label bounds(95, 118, 50, 11), text("Start")
       image bounds(80, 108, 75, 1), $hsliderbgstyle
       hslider bounds(80, 100, 76, 16)    channel("WFM_WAV_Start")     range(0, 16384, 0, 1, 1), popupPostfix(" "),  $hsliderstyle 
    }
    
    groupbox bounds(0, 90, 300, 160), plant("GUI_WFMANAG_1"), $groupboxstyle {
        label    bounds(12,8,150,17), text("Custom 1"), align("left")
        gentable bounds(10, 30, 190, 100), tableNumber(21000), ampRange(-1, 1, 21000, 0.0100), identChannel("genTableWF1"), sampleRange(0,8192), $gentablestyle
        listbox bounds(210,30,80,100), populate("*.tzf","factorywaveforms") channel("WFM_List_1") presetIgnore(1) identChannel("WFM_List_1I") channelType("string") numberOfClicks(1) fontColour(220,220,220) value(-1), highlightColour(123,154,164), colour(20,30,40), align("centre")
        filebutton bounds(7, 135, 100, 19), channel("WFM_Open_1") populate("*.tzf") text("Open (.tzf)") latched(0), presetIgnore(1) $buttonstyle
        filebutton bounds(103, 135, 100, 19), channel("WFM_Save_1") text("Export (.tzf)") latched(0), populate("*.tzf"), mode("save"), presetIgnore(1) $buttonstyle
        button bounds(122, 8, 80, 19), channel("WFM_Reset_1") text("Clear") latched(0), $buttonstyle
    }
    
    groupbox bounds(300, 90, 300, 160), plant("GUI_WFMANAG_2"), $groupboxstyle {
        label    bounds(12,8,150,17), text("Custom 2"), align("left")
        gentable bounds(10, 30, 190, 100), tableNumber(22000), ampRange(-1, 1, 22000, 0.0100), identChannel("genTableWF2"), sampleRange(0,8192), $gentablestyle
        listbox bounds(210,30,80,100), populate("*.tzf","factorywaveforms") channel("WFM_List_2") presetIgnore(1) identChannel("WFM_List_2I") channelType("string") numberOfClicks(1) fontColour(220,220,220) value(-1), highlightColour(123,154,164), colour(20,30,40), align("centre")
        filebutton bounds(7, 135, 100, 19), channel("WFM_Open_2") populate("*.tzf") text("Open (.tzf)") latched(0), presetIgnore(1) $buttonstyle
        filebutton bounds(103, 135, 100, 19), channel("WFM_Save_2") text("Export (.tzf)") latched(0), populate("*.tzf"), mode("save"), presetIgnore(1) $buttonstyle
        button bounds(122, 8, 80, 19), channel("WFM_Reset_2") text("Clear") latched(0), $buttonstyle
    }
}
</Cabbage>

<CsoundSynthesizer>

<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d --midi-key-cps=4 --midi-velocity-amp=5
</CsOptions>

<CsInstruments>

ksmps 		= 	256
nchnls 		= 	2
0dbfs		=	1	;MAXIMUM AMPLITUDE
seed	0
massign	0,2

ginitMode = 0
gkoldnum init 0
gknum init 0
gkactive	init	0


;SAW
gitable ftgen 0, 101, 8193, 7, 0, 4096, 1, 0, -1, 4096, 0

; bandlimited versions
gi_nextfree vco2init-gitable, gitable+1, 1.05, 128, 2^16, gitable
gitable_bl = -gitable

;SINE				
gitable1 ftgen 0, 102, 8193, 10, 1			
gi_nextfree1 vco2init-gitable1, gitable1+1, 1.05, 128, 2^16, gitable1
gitable_bl1 = -gitable1

;SQUARE
gitable2 ftgen 0, 103, 8193, 7, 0, 0, 1, 4096, 1, 0, -1, 4096, -1, 0, 0
gi_nextfree2 vco2init-gitable2, gitable2+1, 1.05, 128, 2^16, gitable2
gitable_bl2 = -gitable2

;PULSE
gitable3 ftgen 0, 0, 8193, 7, 0, 0, 1, 6144, 1, 0, -1, 2048, -1, 0, 0
gi_nextfree3 vco2init-gitable3, gitable3+1, 1.05, 128, 2^16, gitable3
gitable_bl3 = -gitable3

;TRIANGLE
gitable4 ftgen 0, 105, 8193, 7, 0, 2048, 1, 4096, -1, 2048, 0			
gi_nextfree4 vco2init-gitable4, gitable4+1, 1.05, 128, 2^16, gitable4
gitable_bl4 = -gitable4

;SPECTRAL1
gitable5 ftgen 0, 106, 8193, 6, 1, 1024, -1, 1024, 1, 512, -.5, 512, .5, 128, -.5, 64, 1, 128, -.5, 64, 1, 128, -.5, 672, 1, 128, -.5, 64, .1, 128, -.1, 136, 0
gi_nextfree5 vco2init-gitable5, gitable5+1, 1.05, 128, 2^16, gitable5
gitable_bl5 = -gitable5

;SPECTRAL2
gitable6 ftgen 0, 107, 513, 13, 1, 1, 0, 0, 0, -.1, 0, .3, 0, -.5, 0, .7, 0, -.9, 0, 1, 0, -1, 0 
gi_nextfree6 vco2init-gitable6, gitable6+1, 1.05, 128, 2^16, gitable6
gitable_bl6 = -gitable6

;SPECTRAL3
gitable7 ftgen 0, 108, 513, 13, 1, 1, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, -.1, 0, .1, 0, -.2, .3, 0, -.7, 0, .2, 0, -.1
gi_nextfree7 vco2init-gitable7, gitable7+1, 1.05, 128, 2^16, gitable7
gitable_bl7 = -gitable7

;SPECTRAL4
gitable8 ftgen 0, 109, 513, 13, 1, 1, 0, 1, -.8, 0, .6, 0, 0, 0, .4, 0, 0, 0, 0, .1, -.2, -.3, .5
gi_nextfree8 vco2init-gitable8, gitable8+1, 1.05, 128, 2^16, gitable8
gitable_bl8 = -gitable8

;SPECTRAL5
gitable10 ftgen 0, 110, 1025, 13, 1, 1, 0, 5, 0, 5, 0 ,10
gi_nextfree10 vco2init-gitable10, gitable10+1, 1.05, 128, 2^16, gitable10
gitable_bl10 = -gitable10

;SPECTRAL6
gitable11 ftgen 0, 111, 2^10,9, 1,2,0, 3,2,0, 9,0.333,180
; bandlimited versions
gi_nextfree11 vco2init-gitable11, gitable11+1, 1.05, 128, 2^16, gitable11
gitable_bl11 = -gitable11

;DIST
gidist ftgen 0, 201, 512, "tanh", -10, 10, 0

;LFO
gitable9 ftgen 0, 202, 513, 21, 6, 5.74
gi_nextfree9 vco2init-gitable9, gitable9+1, 1.05, 128, 2^16, gitable9
gitable_bl9 = -gitable9


gi_customwf_size ftgen 23000, 0, 4, 7, 0, 4, 0
tablew 4, 1, gi_customwf_size
tablew 4, 2, gi_customwf_size
gi_paramarray ftgen 30000, 0, 300, 7, 0, 300, 0

;CUSTOM WAVE DEFAULT
gitable21000 ftgen 0, 21000, 8192, 7, 0, 21000, 0			
gi_nextfree21000 vco2init-gitable21000, gitable21000+1, 1.05, 128, 2^16, gitable21000
gitable_bl21000 = -gitable21000

gitable22000 ftgen 0, 22000, 8192, 7, 0, 22000, 0			
gi_nextfree22000 vco2init-gitable22000, gitable22000+1, 1.05, 128, 2^16, gitable22000
gitable_bl22000 = -gitable22000

opcode	StChorus,aa,aakkakkk
;Modified for ToneZ
;Original by Iain McCurdy, 2012
;http://iainmccurdy.org/csound.html
	ainL,ainR,krate,kdepth,aoffset,kwidth,kfatmode, kultrafatmode	xin			;READ IN INPUT ARGUMENTS
	kmix=0.5
	if kultrafatmode == 1 then
	    kfatmode = 1
	endif
	ilfoshape	ftgentmp	0, 0, 131072, 19, 1, 0.5, 0,  0.5	;POSITIVE DOMAIN ONLY SINE WAVE
	kporttime	linseg	0,0.001,0.02					;RAMPING UP PORTAMENTO VARIABLE
	kChoDepth	portk	kdepth*0.01, kporttime				;SMOOTH VARIABLE CHANGES WITH PORTK
	aChoDepth	interp	kChoDepth					;INTERPOLATE TO CREATE A-RATE VERSION OF K-RATE VARIABLE
	amodL1 		osciliktp 	krate, ilfoshape, 0			;LEFT CHANNEL LFO
    amodL2 		osciliktp 	krate, ilfoshape, kwidth*0.75			;LEFT CHANNEL LFO
    amodL3 		osciliktp 	krate, ilfoshape, kwidth*1.00			;LEFT CHANNEL LFO
    amodL4 		osciliktp 	krate, ilfoshape, kwidth*1.75			;LEFT CHANNEL LFO
	amodR1 		osciliktp 	krate, ilfoshape, kwidth*0.5		;THE PHASE OF THE RIGHT CHANNEL LFO IS ADJUSTABLE
	amodR2 		osciliktp 	krate, ilfoshape, kwidth*0.25		;THE PHASE OF THE RIGHT CHANNEL LFO IS ADJUSTABLE
	amodR3 		osciliktp 	krate, ilfoshape, kwidth*1.50		;THE PHASE OF THE RIGHT CHANNEL LFO IS ADJUSTABLE
	amodR4 		osciliktp 	krate, ilfoshape, kwidth*1.25		;THE PHASE OF THE RIGHT CHANNEL LFO IS ADJUSTABLE
	
	amodL1		=		(amodL1*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (LEFT CHANNEL)
	amodR1		=		(amodR1*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (RIGHT CHANNEL)
	amodL2		=		(amodL2*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (LEFT CHANNEL)
	amodR2		=		(amodR2*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (RIGHT CHANNEL)
	amodL3		=		(amodL3*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (LEFT CHANNEL)
	amodR3		=		(amodR3*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (RIGHT CHANNEL)
	amodL4		=		(amodL4*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (LEFT CHANNEL)
	amodR4		=		(amodR4*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (RIGHT CHANNEL)	
	
	
	
	aChoL1		vdelay	ainL, amodL1*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (LEFT CHANNEL) 
	aChoR1		vdelay	ainR, amodR1*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (RIGHT CHANNEL)
	aChoL2		vdelay	ainL, amodL2*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (LEFT CHANNEL) 
	aChoR2		vdelay	ainR, amodR2*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (RIGHT CHANNEL)
	aChoL3		vdelay	ainL, amodL3*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (LEFT CHANNEL) 
	aChoR3		vdelay	ainR, amodR3*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (RIGHT CHANNEL)
	aChoL4		vdelay	ainL, amodL4*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (LEFT CHANNEL) 
	aChoR4		vdelay	ainR, amodR4*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (RIGHT CHANNEL)
	
	
	
	aoutL		ntrpol 	ainL*0.6, aChoL1*0.6+(aChoL2*0.6*kfatmode)+(aChoL3*0.6*kultrafatmode)+(aChoL4*0.6*kultrafatmode), kmix			;MIX DRY AND WET SIGNAL (LEFT CHANNEL)
	aoutR		ntrpol 	ainR*0.6, aChoR1*0.6+(aChoR2*0.6*kfatmode)+(aChoR3*0.6*kultrafatmode)+(aChoR4*0.6*kultrafatmode), kmix			;MIX DRY AND WET SIGNAL (RIGHT CHANNEL)
			xout	aoutL,aoutR					;SEND AUDIO BACK TO CALLER INSTRUMENT
endop


giPow3  ftgen 1,0,2048,10,1			; table for storage of functions
iftlen =       ftlen(giPow3)			; length of the function table
icount	=	0				; reset counter. (Moves for each index of the function table)
loop3:						; loop beginning                                            
ix	=	((icount/iftlen) * 2) -1        ; shift x range to -1 to 1                                  
iy	=	ix ^ 3                          ; apply formula to derive y                                 
	tableiw iy,icount,giPow3                ; write y value to table                                    
loop_lt,icount,1,iftlen,loop3                   ; loop back and increment counter if we are not yet finished


opcode	SsplinePort,k,KkkO
;Iain McCurdy, 2012
;http://iainmccurdy.org/csound.html												;DEFINE OPCODE
    knum,kporttime,kcurve,iopt	xin										;READ IN INPUT ARGUMENTS
    kout	init	i(knum)												;INITIALISE TO OUTPUT VALUE (PORTAMENTO APPLIED VALUE)
    ktrig	changed	knum												;...GENERATE A TRIGGER IS A NEW NOTE NUMBER IS GENERATED (FROM INSTR. 1)
    if ktrig=1 then												;IF A NEW (LEGATO) NOTE HAS BEEN PRESSED 
        reinit	S_CURVE												;BEGIN A REINITIALISATION PASS FROM LABEL
    endif														;END OF CONDITIONAL BRANCH
    S_CURVE:													;A LABEL. REINITIALISATION BEGINS FROM HERE.
    if iopt!=0 then													;IF ABSOLUTE/PROPORTIONAL SWITCH IS ON... (I.E. PROPORTIONAL)
        idiff	=	1+abs(i(knum)-i(kout))									;ABSOLUTE DIFFERENCE BETWEEN OLD NOTE AND NEW NOTE IN STEPS (+ 1)
        kporttime	=	kporttime*idiff										;SCALE PORTAMENTO TIME ACCORDING TO THE NOTE GAP
    endif														;END OF CONDITIONAL BRANCH
    imid	=	i(kout)+((i(knum)-i(kout))/2)								;SPLINE MID POINT VALUE
    isspline	ftgentmp	0,0,4096,-16,i(kout),4096*0.5,i(kcurve),imid,(4096/2)-1,-i(kcurve),i(knum)	;GENERATE 'S' SPLINE
    kspd	=	i(kporttime)/kporttime										;POINTER SPEED AS A RATIO (WITH REFERENCE TO THE ORIGINAL DURATION)
    kptr	init	0												;POINTER INITIAL VALUE	
    kout	tablei	kptr,isspline											;READ VALUE FROM TABLE
    kptr	limit	kptr+((ftlen(isspline)/(i(kporttime)*kr))*kspd), 0, ftlen(isspline)-1				;INCREMENT THE POINTER BY THE REQUIRED NUMBER OF TABLE POINTS IN ONE CONTROL CYCLE AND LIMIT IT BETWEEN FIRST AND LAST TABLE POINT - FINAL VALUE WILL BE HELD IF POINTER ATTEMPTS TO EXCEED TABLE DURATION
    rireturn													;RETURN FROM REINITIALISATION PASS
    xout	kout                                                                                    ;SEND PORTAMENTOED VALUES BACK TO CALLER INSTRUMENT
endop


/** Check if a number is a power of 2 or not.
*  IF n is power of 2, return 1, else return 0.
*/
opcode powerOfTwo, i,i
    inn xin
    ires init 0
    if inn == 0 goto powto0
    while inn != 1 do
        inn = inn/2
        if (inn%2 != 0 && inn != 1) goto powto0
    od
    ires = 1
    goto powto1

    powto0:
    ires = 0
    powto1:
    xout ires
endop

opcode my_tabmorphak, a,akkkiiiiiiiiiiiii
aindex, kMorph, kWave1, kWave2, ifn0, ifn1, ifn4, ifn2, ifn3, ifn5, ifn6, ifn7, ifn8, ifn10, ifn11, ifn21000, ifn22000 xin
kMorph/=100
asig     tabmorphak aindex, kMorph, kWave1, kWave2, ifn0, ifn1, ifn4, ifn2, ifn3, ifn5, ifn6, ifn7, ifn8, ifn10, ifn11, ifn21000, ifn22000
xout asig
endop

opcode SuperOsc2, aa, aaikkkkkkikkkkkk
    aVol, aFreq, iPhase, kWave1, kWave2, kMorph, kDet, kWid, kVoice, iRetrig, kOct, kSemi, kCent, kpb, kNoteTrig, kNoise xin
    amixL = 0
    amixR = 0 
    aVol/=100
    if k(aVol)!=0 then
        aVol limit aVol, 0, 1
        kWave1-=1
        kWave2-=1
        kdiff1 chnget "detsh1"
        kdiff2 chnget "detsh2"
        kdiff3 chnget "detsh3"
        kdiff4 chnget "detsh4"
        kdtmix chnget "detmix"
        kdtstyle0 chnget "detstyle0"
        kdtstyle1 chnget "detstyle1"
        kdtstyle2 chnget "detstyle2"
        kdtstyle3 chnget "detstyle3"
        kdetlokL chnget "detlockL"
        kdetlokR chnget "detlockR"
        if kdetlokL == 0 then
            kdetlokL = 1
        else
            kdetlokL = 0
        endif
        if kdetlokR == 0 then
            kdetlokR = 1
        else
            kdetlokR = 0
        endif
        kvar init 0 ;mandatory to refresh the 3 first fillaray ?        
        
        if kdtstyle0 == 1 then ; Original ToneZ detune style	
            kD[] fillarray -.30/8-kdiff4*kdetlokL, .30/8+kdiff4*kdetlokR, -.30/5-kdiff3*kdetlokL, .30/5+kdiff3*kdetlokR, -.30/3-kdiff2*kdetlokL, .30/3+kdiff2*kdetlokR, -.30/2-kdiff1*kdetlokL, .30/2+kdiff1*kdetlokR		
            kW[] fillarray -.5+kvar, .5+kvar, .5+kvar, -.5+kvar, -.5+kvar, .5+kvar, .5+kvar, -.5+kvar
        
        elseif kdtstyle1 == 1 then ; Basic detune style            
            kW[] fillarray -.5+kvar, +.5+kvar, +.5+kvar, -.5+kvar, +.5+kvar, -.5+kvar, -.5+kvar, +.5+kvar
            if (kVoice%2) != 0 then ;odd - if voice number is odd, make sure center voice is mono
                kW[int(kVoice/2)] = 0
            endif
            ; special cases when voice = 3,4,6,7 to "break" the symetry and balance voices across channels
            if kVoice == 3 then
	            kW[] fillarray -.5+kvar, kvar, .5+kvar, kvar, kvar, kvar, kvar, kvar
			endif
			if kVoice == 4 then
	            kW[] fillarray -.5+kvar, +.5+kvar, -.5+kvar, +.5+kvar, kvar, kvar, kvar, kvar
			endif
			if kVoice == 6 then
	            kW[] fillarray -.5+kvar, +.5+kvar, -.5+kvar, +.5+kvar, -.5+kvar, +.5+kvar, kvar, kvar
			endif
			if kVoice == 7 then
	            kW[] fillarray -.5+kvar, +.5+kvar, -.5+kvar, kvar, +.5+kvar, -.5+kvar, +.5+kvar, kvar
			endif	

			kD[] fillarray 1,1,1,1,1,1,1,1
            if kVoice != 1 then   
            kD[] fillarray -0.1*kVoice+0*(kVoice/((kVoice-1)/2))*0.1-kdiff1*kdetlokL+0.0146, -0.1*kVoice+1*(kVoice/((kVoice-1)/2))*0.1-kdiff2*kdetlokL+0.0183, -0.1*kVoice+2*(kVoice/((kVoice-1)/2))*0.1-kdiff3*kdetlokL+0.0179, -0.1*kVoice+3*(kVoice/((kVoice-1)/2))*0.1-kdiff4*kdetlokL+0.0222, -0.1*kVoice+4*(kVoice/((kVoice-1)/2))*0.1+kdiff4*kdetlokR, -0.1*kVoice+5*(kVoice/((kVoice-1)/2))*0.1+kdiff3*kdetlokR, -0.1*kVoice+6*(kVoice/((kVoice-1)/2))*0.1+kdiff2*kdetlokR, -0.1*kVoice+7*(kVoice/((kVoice-1)/2))*0.1+kdiff1*kdetlokR
               kD[] = kD/6
            endif
            
        elseif kdtstyle2 == 1 then
			kD[] fillarray -.30/8-kdiff4*kdetlokL, .30/8+kdiff4*kdetlokR, -.30/3-kdiff3*kdetlokL, .30/3+kdiff3*kdetlokR, -.30/2-kdiff2*kdetlokL, .35/2+kdiff2*kdetlokR, -.40/2-kdiff1*kdetlokL, .50/2+kdiff1*kdetlokR
			kW[] fillarray +.5+kvar, -.5+kvar, -.5+kvar, +.5+kvar, -.5+kvar, +.5+kvar, +.5+kvar, -.5+kvar
            if kVoice == 8 then
	            kW[] fillarray -.5+kvar, -.5+kvar, .5+kvar, .5+kvar, .5+kvar, .5+kvar, -.5+kvar, -.5+kvar
			endif	
			

        elseif kdtstyle3 == 1 then
           kD[] fillarray -.1/32-kdiff4, .1/32+kdiff4, -.1/16-kdiff3, .1/16+kdiff3, -.1/8-kdiff2, .1/8+kdiff2, -.1/2-kdiff1, .1/2+kdiff1		
           kW[] fillarray -.5, .5, .5, -.5, -.5, .5, .5, -.5
        endif
        
        kDT[] = kD*kDet/100 + 1	
        kWD[] = kW*kWid/100 + 0.5	
        kWDi[] = 1 - kWD	
        icnt = i(kVoice)
        kindex = 0 
        kchange changed k(aFreq),kOct,kSemi,kpb
        afactor = aFreq*octave(kOct)*semitone(kSemi)*cent(kCent)*cent(kpb)
        kfactor = downsamp(aFreq)*octave(kOct)*semitone(kSemi)*cent(kCent)*cent(kpb)
        
        if iRetrig=1 then
            iPhaseOsc = iPhase/360
        else
            iPhaseOsc = 2
        endif
     
          loop:   
            if kdtstyle2 == 1 && kVoice%2!= 0 && kindex == kVoice-1 then
                kfine = 1
            elseif kVoice==1 then
                kfine = 1
            else
                kfine = kDT[kindex]	
            endif
            aindex phasorbnk afactor*kfine, kindex, icnt, iPhaseOsc
            cngoto kNoteTrig==1||kchange==1, SHAPE_ENV2
            reinit SHAPE_ENV2
            SHAPE_ENV2:
            iNote = i(kfactor)*i(kfine)
            ifn0 vco2ift iNote, gitable_bl
            ifn1 vco2ift iNote, gitable_bl1
            ifn2 vco2ift iNote, gitable_bl2
            ifn3 vco2ift iNote, gitable_bl3
            ifn4 vco2ift iNote, gitable_bl4
            ifn5 vco2ift iNote, gitable_bl5
            ifn6 vco2ift iNote, gitable_bl6
            ifn7 vco2ift iNote, gitable_bl7
            ifn8 vco2ift iNote, gitable_bl8
            ifn10 vco2ift iNote, gitable_bl10
            ifn11 vco2ift iNote, gitable_bl11
            ifn21000 vco2ift iNote, gitable_bl21000
            ifn22000 vco2ift iNote, gitable_bl22000
            itab[] fillarray ifn0, ifn1, ifn4, ifn2, ifn3, ifn5, ifn6, ifn7, ifn8, ifn8
    
            if kMorph > 99.99 then
                kMorph = 99.99
            endif
            asig     my_tabmorphak aindex, kMorph, kWave1, kWave2, ifn0, ifn1, ifn4, ifn2, ifn3, ifn5, ifn6, ifn7, ifn8, ifn10, ifn11, ifn21000, ifn22000
                      if kNoise == 1 then
                    asig rand 100,2,i(kindex)
                    asig limit asig, 0, 1          
                endif
            rireturn
            
           
            if (kVoice == 1) then ;special case 1 voice
                    amixL = amixL+asig
                    amixR = amixR+asig
            else ;more than 1 voice - different detune styles :
            if kdtstyle0 == 1 || kdtstyle3 == 1 then ;Original ToneZ
                if kdtmix == 50 then ;Original ToneZ - Ensure ToneZ v2 sounds exactly the same as ToneZ v1 with default settings 
                    amixL = amixL+asig*kWD[kindex]
                    amixR = amixR+asig*kWDi[kindex]
                else
                    if kindex = 0 || kindex = 1 then
                        amixL = amixL+asig*kWD[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                        amixR = amixR+asig*kWDi[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                    else
                        amixL = amixL+asig*kWD[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                        amixR = amixR+asig*kWDi[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                    endif    
                endif
            endif
            
            
            if kdtstyle1 == 1 then ;Style = classic
                    if (kVoice%2) != 0 then ;odd
                        if kdtmix != 50 then
                            kWD[int(kVoice/2)] = 1
                            kWDi[int(kVoice/2)] = 1
                        endif
                        if kindex = int(kVoice/2) then ;center
                            amixL = amixL+asig*kWD[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                            amixR = amixR+asig*kWDi[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                        else ;sides
                            amixL = amixL+asig*kWD[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                            amixR = amixR+asig*kWDi[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                        endif
                    else ;even
                        if kindex = kVoice/2 || kindex = (kVoice/2)-1 then ;center
                            amixL = amixL+asig*kWD[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                            amixR = amixR+asig*kWDi[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                        else ;sides
                            amixL = amixL+asig*kWD[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                            amixR = amixR+asig*kWDi[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                        endif
                    endif
            
              endif
              
           if kdtstyle2 == 1 then ;Style = ultra
                if (kVoice%2) != 0 then ;odd
                    if kdtmix != 50 then
                        kWD[kVoice-1] = 1
                        kWDi[kVoice-1] = 1
                    endif
                    if kindex = kVoice-1 then ;center
                        amixL = amixL+asig*kWD[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                        amixR = amixR+asig*kWDi[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                    else ;sides
                        amixL = amixL+asig*kWD[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                        amixR = amixR+asig*kWDi[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                    endif
                else ;even
                    if kindex = 0 || kindex = 1 then ;center
                        amixL = amixL+asig*kWD[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                        amixR = amixR+asig*kWDi[kindex]*(-0.55366*kdtmix/100 + 0.99785)*1.5
                    else ;sides
                        amixL = amixL+asig*kWD[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                        amixR = amixR+asig*kWDi[kindex]*(-0.73764*kdtmix/100^2 + 1.2841*kdtmix/100 + 0.044372)*1.5
                    endif
                endif
           endif 
            
                
           endif
            kindex = kindex + 1
        if (kindex < i(kVoice)) kgoto loop 

        amixL *= (16-kVoice)/16
        amixR *= (16-kVoice)/16
    endif
    denorm amixL, amixR    
    xout amixL*aVol,amixR*aVol
endop

opcode cps2midi, k, k        
    kcps    xin
    xout    logbtwo(kcps / 440) * 12 + 69
endop 

opcode midi2cps, a, a
    amidi xin
    acps = (440/32)*(2^((rms(amidi)-9)/12))
    xout acps
endop


opcode keytrack, a,kak    
    kcps, acutoff, kkeytrack xin 
    kmidi    cps2midi    kcps
    kmidi    =            kmidi-64
    akey    =            2^(kmidi/12)*acutoff
    ascaled    =            ((akey-acutoff)*kkeytrack+acutoff)            
    xout        ascaled 
endop


opcode MultiFilter, aa, aaakkkkkkkkkk
    al, ar, aenvfilter1, kmodefilter1, kcut1, kres1, ktrack1, kmodefilter2, kcut2, kres2, ktrack2, kpitch, kdrive xin 
	ascaled1 keytrack kpitch, a(kcut1)*156.25+(aenvfilter1), ktrack1/100
    ascaled2 keytrack kpitch, a(kcut2), ktrack2/100
    
    kscaled2 rms ascaled2
    if kdrive > 1 then  
        al += kdrive*tanh(al)
        ar += kdrive*tanh(ar)
        al *= 0.3
        ar *= 0.3
    endif
    if kmodefilter1 == 2 then
        ascaled1 limit ascaled1, 0, 12500         
        al lpf18 al, ascaled1, kres1,0
        ar lpf18 ar, ascaled1, kres1,0 
    endif
    if kmodefilter1 == 3 then
        ascaled1 limit ascaled1*2, 0, 21000
        al zdf_2pole al, ascaled1, kres1,0
        ar zdf_2pole ar, ascaled1, kres1,0
    endif
    if kmodefilter1 == 4 then
        ascaled1 limit ascaled1, 0, 21000
        al zdf_2pole al, ascaled1, kres1,1
        ar zdf_2pole ar, ascaled1, kres1,1
    endif
    if kmodefilter1 == 5 then
        ascaled1 limit ascaled1, 0, 21000
        al zdf_2pole al, ascaled1, kres1,2
        ar zdf_2pole ar, ascaled1, kres1,2
    endif
        
    if kmodefilter2 == 2 then
        ascaled2 limit ascaled2, 0, 12500 
        al lpf18 al, ascaled2, kres2,0
        ar lpf18 ar, ascaled2, kres2,0
    endif
    if kmodefilter2 == 3 then
        kscaled2 limit kscaled2*2, 0, 21000
        al zdf_2pole al, ascaled2, kres2,0
        ar zdf_2pole ar, ascaled2, kres2,0
    endif
    if kmodefilter2 == 4 then
        kscaled2 limit kscaled2, 0, 21000
        al zdf_2pole al, ascaled2, kres2,1
        ar zdf_2pole ar, ascaled2, kres2,1
    endif
    if kmodefilter2 == 5 then
        kscaled2 limit kscaled2, 0, 21000
        al zdf_2pole al, ascaled2, kres2,2
        ar zdf_2pole ar, ascaled2, kres2,2
    endif 
    if kdrive > 1 then  
        al += kdrive*tanh(al)
        ar += kdrive*tanh(ar)
        al /= (kdrive)
        ar /= (kdrive)
    endif    
    denorm al,ar
    xout al,ar
endop


opcode	fastLFO,a,kkkkk
    kshape, kgain, krate, kmult, ksync xin
    setksmps 16
    if kshape>1 then    
        if ksync == 1 then
            krate	chnget	"HOST_BPM"
            krate = (krate/60)*kmult
        endif
        
        if kshape==2 then
            alfo lfo kgain, krate, 0
        elseif kshape==3 then
            alfo lfo kgain, krate, 1
        elseif kshape==4 then
            alfo lfo kgain, krate, 2
        elseif kshape==5 then
            alfo lfo kgain, krate, 4
            alfo = alfo - (kgain/2)
            alfo = -alfo
        elseif kshape==6 then
            alfo lfo kgain, krate, 5
            alfo = alfo - (kgain/2)
            alfo = -alfo
        elseif kshape==7 then
            alfo randi kgain, krate, 2
        endif
    else
        alfo = 0
    endif
    xout alfo
endop

opcode	fastLFO,k,kkkkk ;ToneZ v1 backward compatibility
    kshape, kgain, krate, kmult, ksync xin
    setksmps 16
    if kshape>1 then    
        if ksync == 1 then
            krate	chnget	"HOST_BPM"
            krate = (krate/60)*kmult
        endif
        
        if kshape==2 then
            klfo lfo kgain, krate, 0
        elseif kshape==3 then
            klfo lfo kgain, krate, 1
        elseif kshape==4 then
            klfo lfo kgain, krate, 2
        elseif kshape==5 then
            klfo lfo kgain, krate, 4
            klfo = klfo - (kgain/2)
            klfo = -klfo
        elseif kshape==6 then
            klfo lfo kgain, krate, 5
            klfo = klfo - (kgain/2)
            klfo = -klfo
        elseif kshape==7 then
            klfo randi kgain, krate;, 2
        endif
    else
        klfo = 0
    endif
    xout klfo
endop


opcode	LoFi,a,akk
;Iain McCurdy, 2012
;http://iainmccurdy.org/csound.html
	ain,kbits,kfold	xin									;READ IN INPUT ARGUMENTS
	kvalues		pow		2, kbits					;RAISES 2 TO THE POWER OF kbitdepth. THE OUTPUT VALUE REPRESENTS THE NUMBER OF POSSIBLE VALUES AT THAT PARTICULAR BIT DEPTH
	aout		=	(int((ain/0dbfs)*kvalues))/kvalues	;BIT DEPTH REDUCE AUDIO SIGNAL
	aout		fold 	aout, kfold							;APPLY SAMPLING RATE FOLDOVER
		xout	aout									;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

opcode myclip, a, ak        
    ax, kthresh    xin
    xout    max(a(-kthresh),min(a(kthresh),ax))
endop 


;CUSTOM WF TABLES OPCODE
opcode SaveStateWF, 0, ii
    iTabnum, i_customwftemp xin
    kTable[] init table(iTabnum, gi_customwf_size)
    copyf2array kTable, i_customwftemp
    StabSize sprintfk "CusTabSize%d", iTabnum
    Stab sprintfk "CusTab%d", iTabnum
    StabName sprintfk "CusTabName%d", iTabnum
    cabbageSetStateValue StabSize, table(iTabnum, gi_customwf_size)
    cabbageSetStateValue Stab, kTable
    printks "\n>>State saved for Tab%d (%d samples) \n",1,iTabnum, table(iTabnum, gi_customwf_size)
endop

opcode clearStateWF, 0, i
    iTabnum xin
    StabSize sprintfk "CusTabSize%d", iTabnum
    Stab sprintfk "CusTab%d", iTabnum
    kTable[] init 4
    cabbageSetStateValue StabSize, table(iTabnum, gi_customwf_size)
    cabbageSetStateValue Stab, kTable
    printks "\n>>State cleared for Tab%d \n",1,iTabnum
endop

;FX
opcode ToneZ_FX_DIST,aa,aa
    ainL, ainR xin
    
    adistinputL = ainL
    adistinputR = ainR
    
    kdistswitch chnget "distswitch"
    if kdistswitch == 1 then
    
        kdistcarac chnget "distcarac"
        if kdistcarac != 0 then
            kdistcarac /= 100
            adistinputL pareq adistinputL, 700, 1+1.5*kdistcarac, 0.71,0
            adistinputR pareq adistinputR, 700, 1+1.5*kdistcarac, 0.71,0
            adistinputL pareq adistinputL, 5000, 1+1*kdistcarac, 0.71,0
            adistinputR pareq adistinputR, 5000, 1+1*kdistcarac, 0.71,0
            adistinputL pareq adistinputL, 12000, 1+1.2*kdistcarac, 0.71,0
            adistinputR pareq adistinputR, 12000, 1+1.2*kdistcarac, 0.71,0
            adistinputL pareq adistinputL, 15000, 1+0.7*kdistcarac, 0.71,0
            adistinputR pareq adistinputR, 15000, 1+0.7*kdistcarac, 0.71,0
            adistinputL pareq adistinputL, 400, 1+0.5*kdistcarac, 0.71,0
            adistinputR pareq adistinputR, 400, 1+0.5*kdistcarac, 0.71,0
        endif
        
        kdrywetdist chnget "drywetdist"
        kpowershape chnget "distpowershape"
        ksaturator chnget "distsaturator"
        kbitcrusher chnget "distbitcrusher"
        kbitcrusher scale kbitcrusher/100,1,16
        kfoldover chnget "distfoldover"
        kclip chnget "distclip"
        kdistlevel chnget "distlevel"
        ifullscale=0dbfs    
        asumldist = adistinputL
        asumrdist = adistinputR
        if kpowershape > 0 then
            if kpowershape > 94 then
                kpowershape = 94
            endif
            asumldist 	powershape 	adistinputL, 1.001-kpowershape/100, ifullscale
            asumrdist	powershape 	adistinputR, 1.001-kpowershape/100, ifullscale
        endif
        if ksaturator > 0 then
            asumldist distort1 asumldist, ksaturator/100+0.1, 1, 0, 0, 1
            asumrdist distort1 asumrdist, ksaturator/100+0.1, 1, 0, 0, 1
        endif
        
        if kclip > 0 then
            asumldist myclip asumldist, 1-kclip/100
            asumldist *= exp(kclip/100)
            asumrdist myclip asumrdist, 1-kclip/100
            asumrdist *= exp(kclip/100)
        endif
        
        if kbitcrusher < 16 || kfoldover > 1 then
            
            asumldist	LoFi	asumldist,kbitcrusher*0.6,kfoldover*256/100
            asumrdist	LoFi	asumrdist,kbitcrusher*0.6,kfoldover*256/100
        endif
    else
        kdrywetdist = 0
    endif
        
    amixdistL ntrpol adistinputL, asumldist*kdistlevel/100, kdrywetdist/100
    amixdistR ntrpol adistinputR, asumrdist*kdistlevel/100, kdrywetdist/100
    denorm amixdistL,amixdistR
    
    xout amixdistL,amixdistR
endop

opcode ToneZ_FX_CHORUS,aa,aa
    ainL, ainR xin
    
    achorusinputL = ainL
    achorusinputR = ainR
    
    kchorusswitch chnget "chorusswitch"  
    if kchorusswitch == 1 then
        kdrywetchorus chnget "drywetchorus"  
        kchorusporttime	linseg	0,0.001,0.05                                                     
        kchorusrate chnget "chorusrate"
        kchorusdepth chnget "chorusdepth"
        kchorusoffset chnget "chorusoffset"
        kchoruswidth chnget "choruswidth"
        kchoruslevel chnget "choruslevel"
        kchorusmode2 chnget "chorusmode2"
        kchorusmode3 chnget "chorusmode3"
        kchorusstereowidth chnget "chorusstereowidth"
        kchoruslevel	portk	kchoruslevel,kchorusporttime
        kchorusoffset	portk	kchorusoffset,kchorusporttime*0.5
        aoffset	interp	kchorusoffset
 
        kchorustrem	rspline	0,-1,0.1,0.5
        kchorustrem	pow	2,kchorustrem
        achorusL,achorusR	StChorus	achorusinputL,achorusinputR,kchorusrate,kchorusdepth/100*kchorustrem,aoffset,kchoruswidth/100, kchorusmode2, kchorusmode3
    else
        kdrywetchorus = 0
    endif    
    achorusL = achorusL + (achorusR*(1-(kchorusstereowidth/100)))
    achorusR = achorusR + (achorusL*(1-(kchorusstereowidth/100)))
    
    amixchorusL ntrpol		achorusinputL, achorusL*kchoruslevel/100, kdrywetchorus/100	
    amixchorusR ntrpol		achorusinputR, achorusR*kchoruslevel/100, kdrywetchorus/100
    denorm amixchorusL,amixchorusR
    
    xout amixchorusL,amixchorusR
endop

opcode ToneZ_FX_EQ,aa,aa
    ainL, ainR xin
    
    aeqinputL = ainL
    aeqinputR = ainR
    
    keqswitch chnget "eqswitch"
    if keqswitch == 1 then
        kdryweteq chnget "dryweteq"
        keqlowfreq chnget "eqlowfreq"
        keqhighfreq chnget "eqhighfreq"
        keqlowamp chnget "eqlowamp"
        keqhighamp chnget "eqhighamp"
        keqlevel chnget "eqlevel"
        keqmidfreq chnget "eqmidfreq"   
        keqmidamp chnget "eqmidamp"
        if keqlowamp != 1 then
           asumleqlow pareq aeqinputL, keqlowfreq, keqlowamp, 0.71,1
           asumreqlow pareq aeqinputR, keqlowfreq, keqlowamp, 0.71,1
        else
           asumleqlow=aeqinputL
           asumreqlow=aeqinputR
        endif
        
        if keqhighamp != 1 then
            asumleqhigh pareq asumleqlow, keqhighfreq, keqhighamp, 0.71,2
            asumreqhigh pareq asumreqlow, keqhighfreq, keqhighamp, 0.71,2
        else
            asumleqhigh=asumleqlow
            asumreqhigh=asumreqlow
        endif
        
        if keqmidamp != 1 then
            asumleqmid pareq asumleqhigh, keqmidfreq, keqmidamp, 3,0
            asumreqmid pareq asumreqhigh, keqmidfreq, keqmidamp, 3,0
        else
            asumleqmid=asumleqhigh
            asumreqmid=asumreqhigh
        endif
    else
        kdryweteq = 0
    endif
    
    amixeqL ntrpol aeqinputL, asumleqmid*keqlevel/100, kdryweteq/100
    amixeqR ntrpol aeqinputR, asumreqmid*keqlevel/100, kdryweteq/100
    denorm amixeqL,amixeqR
    
    xout amixeqL,amixeqR
endop

opcode ToneZ_FX_REV,aa,aaaa
    ainL, ainR, ascL, ascR xin
    
    arevinputL = ainL
    arevinputR = ainR
    
    krevswitch		chnget	"revswitch"
    if krevswitch == 1 then
        kdrywetrev		chnget	"drywetrev"
        krevtype		chnget  "revtype"
        krevsize		chnget	"revsize"
        krevdamp		chnget	"revdamp"
        krevpitchmod   chnget	"revpitchmod"
	    krevwred chnget "revwred" ;stereo width (no more width reduction)
	
        krevCutLPF     chnget  "revCutLPF"
        krevCutHPF     chnget  "revCutHPF"
        
        krevlevel     chnget  "revlevel"
        krevdel chnget "revdel"
        arevdel = krevdel
        
       
        
        denorm		arevinputL, arevinputR
        if krevtype==0 then
           
            kSwitch		changed		krevpitchmod	
            if	kSwitch=1	then
                reinit	UPDATE		
            endif				
            UPDATE:				
            arvbL, arvbR reverbsc 	arevinputL, arevinputR, krevsize/100, krevdamp, sr, i(krevpitchmod)
            rireturn			
        else
            arvbL, arvbR 	freeverb 	arevinputL, arevinputR, krevsize/100, 1-krevdamp/20000
        endif

        arvbL vdelay arvbL, arevdel, 1001
        arvbR vdelay arvbR, arevdel, 1001
         
        ;rev filters
        if krevCutLPF!=2000 then
            arvbL zdf_2pole arvbL, krevCutLPF, 0.707,0
            arvbR zdf_2pole arvbR, krevCutLPF, 0.707,0
        endif
        if krevCutHPF!=0 then
            arvbL zdf_2pole arvbL, krevCutHPF, 0.707,1
            arvbR zdf_2pole arvbR, krevCutHPF, 0.707,1
        endif
        
        
         arvbL = arvbL + (arvbR*(1-krevwred/100))
         arvbR = arvbR + (arvbL*(1-krevwred/100))
    
    
        ;sidechain
        kdrywetcomp		chnget	"drywetcomp"
        kcompthresh	= -1000000000					
        krevSCthresh chnget "revSCthresh"
        krevSCrel chnget "revSCrel"
        krevSCknee init 30
        kcompratio init 5
        kcompatt init 0
        klook init 0.01	
        
        if chnget:k("revSCswitch") == 1 then						
            arvbL 	compress arvbL, ascL, kcompthresh, (krevSCthresh+120)-krevSCknee, (krevSCthresh+120)+krevSCknee, kcompratio, kcompatt, krevSCrel, i(klook)	
            arvbR 	compress arvbR, ascR, kcompthresh, (krevSCthresh+120)-krevSCknee, (krevSCthresh+120)+krevSCknee, kcompratio, kcompatt, krevSCrel, i(klook)	
        endif
    else
        kdrywetrev = 0
    endif
    	
	amixrevL ntrpol		arevinputL, arvbL*krevlevel/100, kdrywetrev/100	
	amixrevR ntrpol		arevinputR, arvbR*krevlevel/100, kdrywetrev/100 
    denorm amixrevL,amixrevR
    
    xout amixrevL,amixrevR
endop

opcode ToneZ_FX_DEL,aa,aa
    ainL, ainR xin
   
    adelinputL = ainL
    adelinputR = ainR
    
    kdelswitch chnget "delswitch"
    if kdelswitch == 1 then
        kdrywetdel chnget "drywetdel"
        kdelfback		chnget	"delfback"				;read in widgets
        kdeldamp		chnget	"deldamp"				;
        kdelmix		chnget	"delmix"				;
        kdellevel		chnget	"dellevel"				;
        kdelRhyMlt		chnget	"delRhyMlt"			;
        kdelClockSource	chnget	"delClockSource"			;
        kdelType	chnget	"delType"			;
        kdelwidth		chnget	"delwidth"				;
        if kdelClockSource==0 then				;if internal clock source has been chosen...
         kdeltempo	chnget	"deltempo"				;tempo taken from GUI knob control
        else
         kdeltempo	chnget	"HOST_BPM"				;tempo taken from host BPM
         kdeltempo	limit	kdeltempo,40,500			;limit range of possible tempo values. i.e. a tempo of zero would result in a delay time of infinity.
        endif
        kdeltime	divz	(60*kdelRhyMlt),(kdeltempo*8),0.1		;derive delay time. 8 in the denominator indicates that kRhyMult will be in demisemiquaver divisions
        atime	interp	kdeltime				;interpolate k-rate delay time to create an a-rate version which will give smoother results when tempo is modulated
	
         ;offset delay (no feedback)
         abuf	delayr	5
         afirst	deltap3	atime
         afirst	tone	afirst,kdeldamp
            delayw	adelinputL

         ;left channel delay (note that 'atime' is doubled) 
         abuf	delayr	10			;
         atapL	deltap3	atime*2
         atapL	tone	atapL,kdeldamp
            delayw	afirst+(atapL*kdelfback/100)

         ;right channel delay (note that 'atime' is doubled) 
         abuf	delayr	10
         atapR	deltap3	atime*2
         atapR	tone	atapR,kdeldamp
            delayw	adelinputR+(atapR*kdelfback/100)
	
         ;create width control. note that if width is zero the result is the same as 'simple' mode
         atapL	=	afirst+atapL+(atapR*(1-kdelwidth/100))
         atapR	=	atapR+(atapL*(1-kdelwidth/100))
    else
        kdrywetdel = 0
    endif
	
	amixdelL		ntrpol		adelinputL, atapL*kdellevel/100, kdrywetdel/100	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE EFFECT SIGNAL
	amixdelR		ntrpol		adelinputR, atapR*kdellevel/100, kdrywetdel/100 ;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE EFFECT SIGNAL
    denorm amixdelL,amixdelR
    
    xout amixdelL,amixdelR
endop

opcode ToneZ_FX_COMP,aa,aa
    ainL, ainR xin
    
    acompinputL = ainL
    acompinputR = ainR
    
    kcompswitch		chnget	"compswitch"
    if kcompswitch == 1 then
       kdrywetcomp		chnget	"drywetcomp"
        kcompthresh	chnget		"compthresh"					
        kcompLowKnee	chnget		"compLowKnee"
        kcompHighKnee	chnget		"compHighKnee"
        kcompatt		chnget		"compatt"
        kcomprel		chnget		"comprel"
        kcompratio 	chnget		"compratio"
        kcompgain	 	chnget		"compgain"

        klook		init		0.01										
        aC_L 	compress acompinputL, acompinputL, kcompthresh, kcompLowKnee, kcompHighKnee, kcompratio, kcompatt, kcomprel, i(klook)	
        aC_R 	compress acompinputR, acompinputR, kcompthresh, kcompLowKnee, kcompHighKnee, kcompratio, kcompatt, kcomprel, i(klook)	
        aC_L	*=	ampdb(kcompgain)							
        aC_R	*=	ampdb(kcompgain)

    else
        kdrywetcomp = 0
    endif
    
    amixcompL ntrpol		acompinputL, aC_L, kdrywetcomp/100	
	amixcompR ntrpol		acompinputR, aC_R, kdrywetcomp/100 
    denorm amixcompL,amixcompR
    
    xout amixcompL,amixcompR
endop







opcode ToneZ,aa,kkkk
    knum,kvel,gkpb, gkNoteTrig xin
    
    iosc1retrig chnget "osc1retrig"	
    iosc1phase chnget "osc1phase"
    iosc2retrig chnget "osc2retrig"	
    iosc2phase chnget "osc2phase"
    iosc3retrig chnget "osc3retrig"	
    iosc3phase chnget "osc3phase"
    iosc4retrig chnget "osc4retrig"	
    iosc4phase chnget "osc4phase"
       
    gienv1osc1 chnget "env1osc1"
    gienv1osc2 chnget "env1osc2"
    gienv1osc3 chnget "env1osc3"
    gienv1osc4 chnget "env1osc4"
        
    gkenv1amt chnget "env1amt"
    gkenv1amt/=100
    gkenv1curve_exp chnget "env1curve_exp"
    gkenv1curve_lin chnget "env1curve_lin"
    gkenv1curve_custom chnget "env1curve_custom"
     
    gienv1amp chnget "env1amp"
    gienv1filter chnget "env1filter"
    gienv1pitch chnget "env1pitch"
    gienv1morph chnget "env1morph"
    gienv1lfo chnget "env1lfo"
            
    gienv2osc1 chnget "env2osc1"
    gienv2osc2 chnget "env2osc2"
    gienv2osc3 chnget "env2osc3"
    gienv2osc4 chnget "env2osc4"
        
    gkenv2amt chnget "env2amt"
    gkenv2amt/=100
    gkenv2curve_exp chnget "env2curve_exp"
    gkenv2curve_lin chnget "env2curve_lin"
    gkenv2curve_custom chnget "env2curve_custom"
    
    gienv2amp chnget "env2amp"
    gienv2filter chnget "env2filter"
    gienv2pitch chnget "env2pitch"
    gienv2morph chnget "env2morph"
    gienv2lfo chnget "env2lfo"
            
    gienv3osc1 chnget "env3osc1"
    gienv3osc2 chnget "env3osc2"
    gienv3osc3 chnget "env3osc3"
    gienv3osc4 chnget "env3osc4"
        
    gkenv3amt chnget "env3amt"
    gkenv3amt/=100
    gkenv3curve_exp chnget "env3curve_exp"
    gkenv3curve_lin chnget "env3curve_lin"
    gkenv3curve_custom chnget "env3curve_custom"
    
    gienv3amp chnget "env3amp"
    gienv3filter chnget "env3filter"
    gienv3pitch chnget "env3pitch"
    gienv3morph chnget "env3morph"
    gienv3lfo chnget "env3lfo"
    
    gienv4osc1 chnget "env4osc1"
    gienv4osc2 chnget "env4osc2"
    gienv4osc3 chnget "env4osc3"
    gienv4osc4 chnget "envosc4"
        
    gkenv4amt chnget "env4amt"
    gkenv4amt/=100 
    gkenv4curve_exp chnget "env4curve_exp"
    gkenv4curve_lin chnget "env4curve_lin"
    gkenv4curve_custom chnget "env4curve_custom"
    
    gienv4amp chnget "env4amp"
    gienv4filter chnget "env4filter"
    gienv4pitch chnget "env4pitch"
    gienv4morph chnget "env4morph"
    gienv4lfo chnget "env4lfo"
     
    gilfo1amp chnget "lfo1amp"
    gilfo1filter chnget "lfo1filter"
    gilfo1pitch chnget "lfo1pitch"
    gilfo1morph chnget "lfo1morph"
        
    gilfo2amp chnget "lfo2amp"
    gilfo2filter chnget "lfo2filter"
    gilfo2pitch chnget "lfo2pitch"
    gilfo2morph chnget "lfo2morph"
    
    gkmonopoly	chnget	"monopoly"
	gkLegTim	chnget	"LegTim"
	gkLegTim	/=1000
    gkSARetrig	chnget	"SARetrig"
    gkMasterVolume chnget "MasterVol"
    
	gkosc1wave1 chnget "osc1wave1_B"
    gkosc1wave2 chnget "osc1wave2_B"
    gkosc1morph chnget "osc1morph" 
    gkosc1vol chnget "osc1vol"
    gkosc1vol /= 2
    gkosc1det chnget "osc1det"
    gkosc1wid chnget "osc1wid"
    gkosc1voice chnget "osc1voice"
    gkosc1octave chnget "osc1octave"
    gkosc1semi chnget "osc1semi"
    gkosc1cent chnget "osc1cent"
    gkosc1pan chnget "osc1pan"
    gkosc1noise chnget "osc1noise"
    
    gkosc2wave1 chnget "osc2wave1_B"
    gkosc2wave2 chnget "osc2wave2_B"
    gkosc2morph chnget "osc2morph" 
    gkosc2vol chnget "osc2vol"
    gkosc2vol /= 2
    gkosc2det chnget "osc2det"
    gkosc2wid chnget "osc2wid"
    gkosc2voice chnget "osc2voice"
    gkosc2octave chnget "osc2octave"
    gkosc2semi chnget "osc2semi"
    gkosc2cent chnget "osc2cent"
    gkosc2pan chnget "osc2pan"
    gkosc2noise chnget "osc2noise"
    
    gkosc3wave1 chnget "osc3wave1_B"
    gkosc3wave2 chnget "osc3wave2_B"
    gkosc3morph chnget "osc3morph" 
    gkosc3vol chnget "osc3vol"
    gkosc3vol /= 2
    gkosc3det chnget "osc3det"
    gkosc3wid chnget "osc3wid"
    gkosc3voice chnget "osc3voice"
    gkosc3octave chnget "osc3octave"
    gkosc3semi chnget "osc3semi"
    gkosc3cent chnget "osc3cent"
    gkosc3pan chnget "osc3pan"
    gkosc3noise chnget "osc3noise"
            
    gkosc4wave1 chnget "osc4wave1_B"
    gkosc4wave2 chnget "osc4wave2_B"
    gkosc4morph chnget "osc4morph" 
    gkosc4vol chnget "osc4vol"
    gkosc4vol /= 2
    gkosc4det chnget "osc4det"
    gkosc4wid chnget "osc4wid"
    gkosc4voice chnget "osc4voice"
    gkosc4octave chnget "osc4octave"
    gkosc4semi chnget "osc4semi"
    gkosc4cent chnget "osc4cent"
    gkosc4pan chnget "osc4pan"    
    gkosc4noise chnget "osc4noise"
    
    gkosc1lfoamp chnget "osc1lfoamp"
    gkosc1lfofreq chnget "osc1lfofreq"
    gkosc1lfoamnt chnget "osc1lfoamnt"
    
    gkpitchamnt chnget "pitchamnt"
    gkenvamt    chnget "envamt"
    
    gkfilter1mode1 chnget "filter1mode1_B"
    gkfilter1cut1 chnget "filter1cut1"
    gkfilter1cut1 /=156.25
    gkfilter1res1 chnget "filter1res1"
    gkfilter1keytrack1 chnget "filter1keytrack1"
    gkfilter1mode2 chnget "filter1mode2_B"
    gkfilter1cut2 chnget "filter1cut2"
    gkfilter1res2 chnget "filter1res2"
    gkfilter1keytrack2 chnget "filter1keytrack2"
    gkfilter1drive chnget "filter1drive"
                    
    gkfilter1osc1 chnget "filter1osc1"
    gkfilter1osc2 chnget "filter1osc2"
    gkfilter1osc3 chnget "filter1osc3"
    gkfilter1osc4 chnget "filter1osc4"
    
    gkfilter2mode1 chnget "filter2mode1_B"
    gkfilter2cut1 chnget "filter2cut1"
    gkfilter2cut1 /=156.25
    gkfilter2res1 chnget "filter2res1"
    gkfilter2keytrack1 chnget "filter2keytrack1"
    gkfilter2mode2 chnget "filter2mode2_B"
    gkfilter2cut2 chnget "filter2cut2"
    gkfilter2res2 chnget "filter2res2"
    gkfilter2keytrack2 chnget "filter2keytrack2"
    gkfilter2drive chnget "filter2drive"
    
    gkfilter2osc1 chnget "filter2osc1"
    gkfilter2osc2 chnget "filter2osc2"
    gkfilter2osc3 chnget "filter2osc3"
    gkfilter2osc4 chnget "filter2osc4"
   
    gklfo1shape chnget "lfo1shape_B"
    gklfo1gain chnget "lfo1gain"
    gklfo1rate chnget "lfo1rate"
    gklfo1mult chnget "lfo1mult"
    gklfo1bpm chnget "lfo1bpm"
    gklfo1musical chnget "lfo1musical"
    gklfo1amt chnget "lfo1amt"
    gklfo1amt/=100
    gklfo1audiorate chnget "lfo1audiorate"
    
    gklfo2shape chnget "lfo2shape_B"
    gklfo2gain chnget "lfo2gain"
    gklfo2rate chnget "lfo2rate"
    gklfo2mult chnget "lfo2mult"
    gklfo2bpm chnget "lfo2bpm"
    gklfo2musical chnget "lfo2musical"
    gklfo2amt chnget "lfo2amt"
    gklfo2amt/=100
    gklfo2audiorate chnget "lfo2audiorate" 
      
    gklfo1osc1 chnget "lfo1osc1"
    gklfo1osc2 chnget "lfo1osc2"
    gklfo1osc3 chnget "lfo1osc3"
    gklfo1osc4 chnget "lfo1osc4"
    
    gklfo2osc1 chnget "lfo2osc1"
    gklfo2osc2 chnget "lfo2osc2"
    gklfo2osc3 chnget "lfo2osc3"
    gklfo2osc4 chnget "lfo2osc4"
    
    gienv1a chnget "env1a"
    gienv1d chnget "env1d"
    gienv1s chnget "env1s"
    gienv1r chnget "env1r"
    gienv1acurve chnget "env1acurve"
    gienv1dcurve chnget "env1dcurve"
    gienv1rcurve chnget "env1rcurve"
    
    gienv2a chnget "env2a"
    gienv2d chnget "env2d"
    gienv2s chnget "env2s"
    gienv2r chnget "env2r"
    gienv2acurve chnget "env2acurve"
    gienv2dcurve chnget "env2dcurve"
    gienv2rcurve chnget "env2rcurve"
    
    gienv3a chnget "env3a"
    gienv3d chnget "env3d"
    gienv3s chnget "env3s"
    gienv3r chnget "env3r"
    gienv3acurve chnget "env3acurve"
    gienv3dcurve chnget "env3dcurve"
    gienv3rcurve chnget "env3rcurve"
    
    gienv4a chnget "env4a"
    gienv4d chnget "env4d"
    gienv4s chnget "env4s"
    gienv4r chnget "env4r"
    gienv4acurve chnget "env4acurve"
    gienv4dcurve chnget "env4dcurve"
    gienv4rcurve chnget "env4rcurve"
    
    cngoto gkNoteTrig==1&&gkSARetrig==1, SHAPE_ENV
    reinit SHAPE_ENV
    SHAPE_ENV:
    if gienv1a < 0.001 then
       gienv1a = 0.001
    endif
    if gienv2a < 0.001 then
       gienv2a = 0.001
    endif
    if gienv3a < 0.001 then
       gienv3a = 0.001
    endif
    if gienv4a < 0.001 then
       gienv4a = 0.001
    endif
    if gienv1s < 0.001 then
       gienv1s = 0.001
    endif
    if gienv2s < 0.001 then
       gienv2s = 0.001
    endif
    if gienv3s < 0.001 then
       gienv3s = 0.001
    endif
    if gienv4s < 0.001 then
       gienv4s = 0.001
    endif

   
  
   if gienv1osc1+gienv1osc2+gienv1osc3+gienv1osc4!=0 then
       if gkenv1curve_exp == 1 then
            aenv_1 mxadsr gienv1a, gienv1d, gienv1s, gienv1r, 0, 1
       elseif gkenv1curve_lin == 1 then
            aenv_1 madsr gienv1a, gienv1d, gienv1s, gienv1r, 0, 1
       else
            aenv_1 transegr 0, gienv1a, gienv1acurve, 1, gienv1d, gienv1dcurve, gienv1s, gienv1r, gienv1rcurve, 0
       endif
       aenv_1 limit aenv_1,0,1
   else
       aenv_1 = 0
   endif
   
   if gienv2osc1+gienv2osc2+gienv2osc3+gienv2osc4!=0 then
       if gkenv2curve_exp == 1 then
            aenv_2 mxadsr gienv2a, gienv2d, gienv2s, gienv2r, 0, 1
       elseif gkenv2curve_lin == 1 then
            aenv_2 madsr gienv2a, gienv2d, gienv2s, gienv2r, 0, 1
       else
            aenv_2 transegr 0, gienv2a, gienv2acurve, 1, gienv2d, gienv2dcurve, gienv2s, gienv2r, gienv2rcurve, 0
       endif
       aenv_2 limit aenv_2,0,1
   else
       aenv_2 = 0
   endif

   if gienv3osc1+gienv3osc2+gienv3osc3+gienv3osc4!=0 then
       if gkenv3curve_exp == 1 then
            aenv_3 mxadsr gienv3a, gienv3d, gienv3s, gienv3r, 0, 1
       elseif gkenv3curve_lin == 1 then
            aenv_3 madsr gienv3a, gienv3d, gienv3s, gienv3r, 0, 1
       else
            aenv_3 transegr 0, gienv3a, gienv3acurve, 1, gienv3d, gienv3dcurve, gienv3s, gienv3r, gienv3rcurve, 0
       endif
       aenv_3 limit aenv_3,0,1
   else
       aenv_3 = 0
   endif
   
   if gienv4osc1+gienv4osc2+gienv4osc3+gienv4osc4!=0 then
       if gkenv4curve_exp == 1 then
            aenv_4 mxadsr gienv4a, gienv4d, gienv4s, gienv4r, 0, 1
       elseif gkenv4curve_lin == 1 then
            aenv_4 madsr gienv4a, gienv4d, gienv4s, gienv4r, 0, 1
       else
            aenv_4 transegr 0, gienv4a, gienv4acurve, 1, gienv4d, gienv4dcurve, gienv4s, gienv4r, gienv4rcurve, 0
       endif
       aenv_4 limit aenv_4,0,1
   else
       aenv_4 = 0
   endif
     
    rireturn

	
		
			
					
	if gklfo1shape != 1 then
	    if gklfo1audiorate == 1 then
	        if gklfo1musical == 1 then
	            gklfo1gain /= 500
	            alfo1 fastLFO gklfo1shape, gklfo1gain+(gklfo1gain*knum*gklfo1audiorate), gklfo1rate, gklfo1mult, gklfo1bpm
	        else
	            alfo1 fastLFO gklfo1shape, gklfo1gain, gklfo1rate, gklfo1mult, gklfo1bpm
	        endif
	    else
	        klfo1 fastLFO gklfo1shape, gklfo1gain, gklfo1rate, gklfo1mult, gklfo1bpm
            alfo1 = klfo1
	    endif
    else
	    alfo1 = 1
	endif
	
	if gklfo2shape != 1 then
	    if gklfo2audiorate == 1 then
	        if gklfo2musical == 1 then
	            gklfo2gain /= 500
	            alfo2 fastLFO gklfo2shape, gklfo2gain+(gklfo2gain*knum*gklfo2audiorate), gklfo2rate, gklfo2mult, gklfo2bpm
	        else
	            alfo2 fastLFO gklfo2shape, gklfo2gain, gklfo2rate, gklfo2mult, gklfo2bpm
	        endif
	    else
	        klfo2 fastLFO gklfo2shape, gklfo2gain, gklfo2rate, gklfo2mult, gklfo2bpm
            alfo2 = klfo2
	    endif
    else
	    alfo2 = 1
	endif

    
    
    ;ENV : AMP
    aosc1envamp init 0
    aosc2envamp init 0
    aosc3envamp init 0
    aosc4envamp init 0
    
    if (gienv1amp==1) then
        if (gienv1osc1==1) then
            aosc1envamp = aenv_1+(1*(1-gkenv1amt))
        endif
        if (gienv1osc2==1) then
            aosc2envamp = aenv_1+(1*(1-gkenv1amt))
        endif
        if (gienv1osc3==1) then
            aosc3envamp = aenv_1+(1*(1-gkenv1amt))  
        endif
        if (gienv1osc4==1) then
            aosc4envamp = aenv_1+(1*(1-gkenv1amt))
        endif
    endif
        
    if (gienv2amp==1) then
        if (gienv2osc1==1) then
            aosc1envamp = aenv_2+(1*(1-gkenv2amt))
        endif
        if (gienv2osc2==1) then
            aosc2envamp = aenv_2+(1*(1-gkenv2amt))
        endif
        if (gienv2osc3==1) then
            aosc3envamp = aenv_2+(1*(1-gkenv2amt))
        endif
        if (gienv2osc4==1) then
            aosc4envamp = aenv_2+(1*(1-gkenv2amt))
        endif
    endif
        
    if (gienv3amp==1) then
        if (gienv3osc1==1) then
            aosc1envamp = aenv_3+(1*(1-gkenv3amt))
        endif
        if (gienv3osc2==1) then
            aosc2envamp = aenv_3+(1*(1-gkenv3amt))
        endif
        if (gienv3osc3==1) then
            aosc3envamp = aenv_3+(1*(1-gkenv3amt))
        endif
        if (gienv3osc4==1) then
            aosc4envamp = aenv_3+(1*(1-gkenv3amt))
        endif
    endif
        
    if (gienv4amp==1) then
        if (gienv4osc1==1) then
            aosc1envamp = aenv_4+(1*(1-gkenv4amt))
        endif
        if (gienv4osc2==1) then
            aosc2envamp = aenv_4+(1*(1-gkenv4amt))
        endif
        if (gienv4osc3==1) then
            aosc3envamp = aenv_4+(1*(1-gkenv4amt))
        endif
        if (gienv4osc4==1) then
            aosc4envamp = aenv_4+(1*(1-gkenv4amt))
        endif
    endif
    
    
    ;ENV : PITCH  
    kosc1pitch = knum
    kosc2pitch = knum
    kosc3pitch = knum
    kosc4pitch = knum

    
    if (gienv1pitch==1) then
        if (gienv1osc1==1) then
            kosc1pitch = knum+3.035*gkenv1amt*knum*downsamp(aenv_1)
        endif
        if (gienv1osc2==1) then
            kosc2pitch = knum+3.035*gkenv1amt*knum*downsamp(aenv_1)
        endif
        if (gienv1osc3==1) then
            kosc3pitch = knum+3.035*gkenv1amt*knum*downsamp(aenv_1)
        endif
        if (gienv1osc4==1) then
            kosc4pitch = knum+3.035*gkenv1amt*knum*downsamp(aenv_1)
        endif
    endif  
    
    if (gienv2pitch==1) then
        if (gienv2osc1==1) then
            kosc1pitch = knum+3.035*gkenv2amt*knum*downsamp(aenv_2)
        endif
        if (gienv2osc2==1) then
            kosc2pitch = knum+3.035*gkenv2amt*knum*downsamp(aenv_2)
        endif
        if (gienv2osc3==1) then
            kosc3pitch = knum+3.035*gkenv2amt*knum*downsamp(aenv_2)
        endif
        if (gienv2osc4==1) then
            kosc4pitch = knum+3.035*gkenv2amt*knum*downsamp(aenv_2)
        endif
    endif
        
    if (gienv3pitch==1) then
        if (gienv3osc1==1) then
            kosc1pitch = knum+3.035*gkenv3amt*knum*downsamp(aenv_3)
        endif
        if (gienv3osc2==1) then
            kosc2pitch = knum+3.035*gkenv3amt*knum*downsamp(aenv_3)
        endif
        if (gienv3osc3==1) then
            kosc3pitch = knum+3.035*gkenv3amt*knum*downsamp(aenv_3)
        endif
        if (gienv3osc4==1) then
            kosc4pitch = knum+3.035*gkenv3amt*knum*downsamp(aenv_3)
        endif
    endif
        
    if (gienv4pitch==1) then
        if (gienv4osc1==1) then
            kosc1pitch = knum+3.035*gkenv4amt*knum*downsamp(aenv_4)
        endif
        if (gienv4osc2==1) then
            kosc2pitch = knum+3.035*gkenv4amt*knum*downsamp(aenv_4)
        endif
        if (gienv4osc3==1) then
            kosc3pitch = knum+3.035*gkenv4amt*knum*downsamp(aenv_4)
        endif
        if (gienv4osc4==1) then
            kosc4pitch = knum+3.035*gkenv4amt*knum*downsamp(aenv_4)
        endif
    endif
    
    aosc1pitch upsamp kosc1pitch  
    aosc2pitch upsamp kosc2pitch  
    aosc3pitch upsamp kosc3pitch  
    aosc4pitch upsamp kosc4pitch  
    
    ;ENV : MORPH
    gkosc1morph init 0
    gkosc2morph init 0
    gkosc3morph init 0
    gkosc4morph init 0
            
    if (gienv1morph==1) then
        if (gienv1osc1==1) then
            gkosc1morph = gkosc1morph + gkenv1amt*100*(aenv_1)
        endif
        if (gienv1osc2==1) then
            gkosc2morph = gkosc2morph + gkenv1amt*100*(aenv_1)
        endif
        if (gienv1osc3==1) then
            gkosc3morph = gkosc3morph + gkenv1amt*100*(aenv_1)
        endif
        if (gienv1osc4==1) then
            gkosc4morph = gkosc4morph + gkenv1amt*100*(aenv_1)
        endif
    endif
    if (gienv2morph==1) then
        if (gienv2osc1==1) then
            gkosc1morph = gkosc1morph + gkenv2amt*100*(aenv_2)
        endif
        if (gienv2osc2==1) then
            gkosc2morph = gkosc2morph + gkenv2amt*100*(aenv_2)
        endif
        if (gienv2osc3==1) then
            gkosc3morph = gkosc3morph + gkenv2amt*100*(aenv_2)
        endif
        if (gienv2osc4==1) then
            gkosc4morph = gkosc4morph + gkenv2amt*100*(aenv_2)
        endif
    endif
    if (gienv3morph==1) then
        if (gienv3osc1==1) then
            gkosc1morph = gkosc1morph + gkenv3amt*100*(aenv_3)
        endif
        if (gienv3osc2==1) then
            gkosc2morph = gkosc2morph + gkenv3amt*100*(aenv_3)
        endif
        if (gienv3osc3==1) then
            gkosc3morph = gkosc3morph + gkenv3amt*100*(aenv_3)
        endif
        if (gienv3osc4==1) then
            gkosc4morph = gkosc4morph + gkenv3amt*100*(aenv_3)
        endif
    endif
    if (gienv4morph==1) then
        if (gienv4osc1==1) then
            gkosc1morph = gkosc1morph + gkenv4amt*100*(aenv_4)
        endif
        if (gienv4osc2==1) then
            gkosc2morph = gkosc2morph + gkenv4amt*100*(aenv_4)
        endif
        if (gienv4osc3==1) then
            gkosc3morph = gkosc3morph + gkenv4amt*100*(aenv_4)
        endif
        if (gienv4osc4==1) then
            gkosc4morph = gkosc4morph + gkenv4amt*100*(aenv_4)
        endif
    endif
       
    ;ENV : LFOAMT
    if (gienv1lfo==1) then
        if (gienv1osc1==1) then
            gklfo1amt = gklfo1amt * aenv_1
        endif
        if (gienv1osc2==1) then
            gklfo2amt = gklfo2amt * aenv_1
        endif
    endif
    if (gienv2lfo==1) then
        if (gienv2osc1==1) then
            gklfo1amt = gklfo1amt * aenv_2
        endif
        if (gienv2osc2==1) then
            gklfo2amt = gklfo2amt * aenv_2
        endif
    endif
    if (gienv3lfo==1) then
        if (gienv3osc1==1) then
            gklfo1amt = gklfo1amt * aenv_3
        endif
        if (gienv3osc2==1) then
            gklfo2amt = gklfo2amt * aenv_3
        endif
    endif  
    if (gienv4lfo==1) then
        if (gienv4osc1==1) then
            gklfo1amt = gklfo1amt * aenv_4
        endif
        if (gienv4osc2==1) then
            gklfo2amt = gklfo2amt * aenv_4
        endif
    endif
        
    
    
    ;FILTER ROUTING + LFO : FILTER
    if (gilfo1filter==1) && (gklfo1shape != 1) then
        if (gklfo1osc1==1) then
            gkfilter1cut1=gkfilter1cut1+(alfo1*gklfo1amt*10)
        endif
        if (gklfo1osc2==1) then
            gkfilter2cut1=gkfilter2cut1+(alfo1*gklfo1amt*10)
        endif
    endif
        
    if (gilfo2filter==1) && (gklfo2shape != 1) then
        if (gklfo2osc1==1) then
            gkfilter1cut1=gkfilter1cut1+(alfo2*gklfo2amt*10)
        endif
        if (gklfo2osc2==1) then
            gkfilter2cut1=gkfilter2cut1+(alfo2*gklfo2amt*10)
        endif
    endif
        
        
    if (gkfilter1osc1==1) then
        kenvfilter1 = 1
        kenvfilter1 = gkfilter1cut1
        klimitcut limit kenvfilter1, 0, 127
        kenvfilter1 cpsmidinn klimitcut
    endif
        
    if (gkfilter1osc2==1) then
        kenvfilter1 = 1
        kenvfilter1 = gkfilter1cut1
        klimitcut limit kenvfilter1, 0, 127
        kenvfilter1 cpsmidinn klimitcut
    endif
        
    if (gkfilter1osc3==1) then
        kenvfilter1 = 1
        kenvfilter1 = gkfilter1cut1
        klimitcut limit kenvfilter1, 0, 127
        kenvfilter1 cpsmidinn klimitcut
    endif
        
    if (gkfilter1osc4==1) then
        kenvfilter1 = 1
        kenvfilter1 = gkfilter1cut1
        klimitcut limit kenvfilter1, 0, 127
        kenvfilter1 cpsmidinn klimitcut
    endif
        
        
 
    if (gkfilter2osc1==1) then
        kenvfilter2 = 1
        kenvfilter2 = gkfilter2cut1
        klimitcut limit kenvfilter2, 0, 127
        kenvfilter2 cpsmidinn klimitcut
    endif
        
    if (gkfilter2osc2==1) then
        kenvfilter2 = 1
        kenvfilter2 = gkfilter2cut1
        klimitcut limit kenvfilter2, 0, 127
        kenvfilter2 cpsmidinn klimitcut
    endif
        
    if (gkfilter2osc3==1) then
        kenvfilter2 = 1
        kenvfilter2 = gkfilter2cut1
        klimitcut limit kenvfilter2, 0, 127
        kenvfilter2 cpsmidinn klimitcut
    endif
        
    if (gkfilter2osc4==1) then
        kenvfilter2 = 1
        kenvfilter2 = gkfilter2cut1
        klimitcut limit kenvfilter2, 0, 127
        kenvfilter2 cpsmidinn klimitcut
    endif
    
        
    ;ENV : FILTER
     if (gienv1filter==1) then
        if gkenv1amt < 0 then
            gkenv1amt=-gkenv1amt
            k1inv=-1
        else
            k1inv=1
        endif
        if (gienv1osc1==1) then
            kenvfilter1 downsamp aenv_1
            if k1inv == -1 then
                kenvfilter1=1-kenvfilter1
            endif 
            kenvfilter1 = ((kenvfilter1 * 128) * gkenv1amt) + gkfilter1cut1
            klimitcut limit kenvfilter1, 0, 127
            kenvfilter1 cpsmidinn klimitcut
        endif
        if (gienv1osc2==1) then
            kenvfilter2 downsamp aenv_1
            if k1inv == -1 then
                kenvfilter2=1-kenvfilter2
            endif
            kenvfilter2 = ((kenvfilter2 * 128) * gkenv1amt) + gkfilter2cut1
            klimitcut limit kenvfilter2, 0, 127
            kenvfilter2 cpsmidinn klimitcut
        endif
    endif
        
    if (gienv2filter==1) then
        if gkenv2amt < 0 then
            gkenv2amt=-gkenv2amt
            k2inv=-1
        else
            k2inv=1
        endif
        if (gienv2osc1==1) then
            kenvfilter1 downsamp aenv_2
            if k2inv == -1 then
                kenvfilter1=1-kenvfilter1
            endif
            kenvfilter1 = ((kenvfilter1 * 128) * gkenv2amt) + gkfilter1cut1
            klimitcut limit kenvfilter1, 0, 127
            kenvfilter1 cpsmidinn klimitcut
        endif
        if (gienv2osc2==1) then
            kenvfilter2 downsamp aenv_2
            if k2inv == -1 then
                kenvfilter2=1-kenvfilter2
            endif
            kenvfilter2 = ((kenvfilter2 * 128) * gkenv2amt) + gkfilter2cut1
            klimitcut limit kenvfilter2, 0, 127
            kenvfilter2 cpsmidinn klimitcut
        endif
    endif
        
        
        
    if (gienv3filter==1) then
        if gkenv3amt < 0 then
            gkenv3amt=-gkenv3amt
            k3inv=-1
        else
            k3inv=1
        endif
        if (gienv3osc1==1) then
            kenvfilter1 downsamp aenv_3
            if k3inv == -1 then
                kenvfilter1=1-kenvfilter1
            endif
            kenvfilter1 = ((kenvfilter1 * 128) * gkenv3amt) + gkfilter1cut1
            klimitcut limit kenvfilter1, 0, 127
            kenvfilter1 cpsmidinn klimitcut
        endif
        if (gienv3osc2==1) then
            kenvfilter2 downsamp aenv_3
            if k3inv == -1 then
                kenvfilter2=1-kenvfilter2
            endif
            kenvfilter2 = ((kenvfilter2 * 128) * gkenv3amt) + gkfilter2cut1
            klimitcut limit kenvfilter2, 0, 127
            kenvfilter2 cpsmidinn klimitcut
        endif
    endif
        
        
    if (gienv4filter==1) then
        if gkenv4amt < 0 then
            gkenv4amt=-gkenv4amt
            k4inv=-1
        else
            k4inv=1
        endif
        if (gienv4osc1==1) then
            kenvfilter1 downsamp aenv_4
            if k4inv == -1 then
                kenvfilter1=1-kenvfilter1
            endif
            kenvfilter1 = ((kenvfilter1 * 128) * gkenv4amt) + gkfilter1cut1
            klimitcut limit kenvfilter1, 0, 127
            kenvfilter1 cpsmidinn klimitcut
        endif
        if (gienv4osc2==1) then
            kenvfilter2 downsamp aenv_4
            if k4inv == -1 then
                kenvfilter2=1-kenvfilter2
            endif
            kenvfilter2 = ((kenvfilter2 * 128) * gkenv4amt) + gkfilter2cut1
            klimitcut limit kenvfilter2, 0, 127
            kenvfilter2 cpsmidinn klimitcut
        endif
    endif
        
          
   ;LFO : AMP
    if (gilfo1amp==1) && (gklfo1shape > 1) then
        if (gklfo1osc1==1) then        
            gkosc1vol=gkosc1vol+(klfo1*gklfo1amt*gkosc1vol)
        endif
        if (gklfo1osc2==1) then
            gkosc2vol=gkosc2vol+(klfo1*gklfo1amt*gkosc2vol)
        endif
        if (gklfo1osc3==1) then
            gkosc3vol=gkosc3vol+(klfo1*gklfo1amt*gkosc3vol)
        endif
        if (gklfo1osc4==1) then
            gkosc4vol=gkosc4vol+(klfo1*gklfo1amt*gkosc4vol)
        endif
    endif
        
	if (gilfo2amp==1) && (gklfo2shape > 1) then
        if (gklfo2osc1==1) then
            gkosc1vol=gkosc1vol+(klfo2*gklfo2amt*gkosc1vol)
        endif
        if (gklfo2osc2==1) then
            gkosc2vol=gkosc2vol+(klfo2*gklfo2amt*gkosc2vol)
        endif
        if (gklfo2osc3==1) then
            gkosc3vol=gkosc3vol+(klfo2*gklfo2amt*gkosc3vol)
        endif
        if (gklfo2osc4==1) then
            gkosc4vol=gkosc4vol+(klfo2*gklfo2amt*gkosc4vol)
        endif
    endif   
   
    klfoamtrange = 20 ;LFO amount multiplicator 
    ;LFO : PITCH
    if (gilfo1pitch == 1) && (gklfo1shape != 1) then
        if (gklfo1osc1==1) then
            aosc1pitch=aosc1pitch+(alfo1*gklfo1amt) * klfoamtrange
        endif
        if (gklfo1osc2==1) then
            aosc2pitch=aosc2pitch+(alfo1*gklfo1amt) * klfoamtrange
        endif
        if (gklfo1osc3==1) then
            aosc3pitch=aosc3pitch+(alfo1*gklfo1amt) * klfoamtrange
        endif
        if (gklfo1osc4==1) then
            aosc4pitch=aosc4pitch+(alfo1*gklfo1amt) * klfoamtrange
        endif
    endif
        
    if (gilfo2pitch==1) && (gklfo2shape !=1 ) then
        if (gklfo2osc1==1) then
            aosc1pitch=aosc1pitch+(alfo2*gklfo2amt) * klfoamtrange
        endif
        if (gklfo2osc2==1) then
            aosc2pitch=aosc2pitch+(alfo2*gklfo2amt) * klfoamtrange
        endif
        if (gklfo2osc3==1) then
            aosc3pitch=aosc3pitch+(alfo2*gklfo2amt) * klfoamtrange
        endif
        if (gklfo2osc4==1) then
            aosc4pitch=aosc4pitch+(alfo2*gklfo2amt) * klfoamtrange
        endif
    endif
        
    
    ;LFO : MORPH    
    if (gilfo1morph == 1) && (gklfo1shape != 1) then
        if (gklfo1osc1==1) then
            gkosc1morph =gkosc1morph +(alfo1*gklfo1amt*10)
        endif
        if (gklfo1osc2==1) then
            gkosc2morph =gkosc2morph +(alfo1*gklfo1amt*10)
        endif
        if (gklfo1osc3==1) then
            gkosc3morph =gkosc3morph +(alfo1*gklfo1amt*10)
        endif
        if (gklfo1osc4==1) then
            gkosc4morph =gkosc4morph +(alfo1*gklfo1amt*10)
        endif
    endif
    
    if (gilfo2morph==1) && (gklfo2shape != 1) then
        if (gklfo2osc1==1) then
            gkosc1morph =gkosc1morph +(alfo2*gklfo2amt*10)
        endif
        if (gklfo2osc2==1) then
            gkosc2morph =gkosc2morph +(alfo2*gklfo2amt*10)
        endif
        if (gklfo2osc3==1) then
            gkosc3morph =gkosc3morph +(alfo2*gklfo2amt*10)
        endif
        if (gklfo2osc4==1) then
            gkosc4morph =gkosc4morph +(alfo2*gklfo2amt*10)
        endif
    endif    
        

    kvoicechange changed chnget:k("osc1voice"), chnget:k("osc2voice"), chnget:k("osc3voice"), chnget:k("osc4voice")
    if kvoicechange ==1 then
        reinit VOICECHANGE
    endif

    VOICECHANGE:                      
    a1l ,a1r SuperOsc2 gkosc1vol*aosc1envamp*kvel, aosc1pitch, iosc1phase, gkosc1wave1, gkosc1wave2, gkosc1morph, gkosc1det, gkosc1wid, gkosc1voice, iosc1retrig, gkosc1octave, gkosc1semi, gkosc1cent, gkpb, gkNoteTrig, gkosc1noise
    a1l ntrpol a1l*2,a(0),gkosc1pan/100
    a1r ntrpol a(0),a1r*2,gkosc1pan/100
    a2l ,a2r SuperOsc2 gkosc2vol*aosc2envamp*kvel, aosc2pitch, iosc2phase, gkosc2wave1, gkosc2wave2, gkosc2morph, gkosc2det, gkosc2wid, gkosc2voice, iosc2retrig, gkosc2octave, gkosc2semi, gkosc2cent, gkpb, gkNoteTrig, gkosc2noise
    a2l ntrpol a2l*2,a(0),gkosc2pan/100
    a2r ntrpol a(0),a2r*2,gkosc2pan/100
    a3l ,a3r SuperOsc2 gkosc3vol*aosc3envamp*kvel, aosc3pitch, iosc3phase, gkosc3wave1, gkosc3wave2, gkosc3morph, gkosc3det, gkosc3wid, gkosc3voice, iosc3retrig, gkosc3octave, gkosc3semi, gkosc3cent, gkpb, gkNoteTrig, gkosc3noise
    a3l ntrpol a3l*2,a(0),gkosc3pan/100
    a3r ntrpol a(0),a3r*2,gkosc3pan/100
    a4l ,a4r SuperOsc2 gkosc4vol*aosc4envamp*kvel, aosc4pitch, iosc4phase, gkosc4wave1, gkosc4wave2, gkosc4morph, gkosc4det, gkosc4wid, gkosc4voice, iosc4retrig, gkosc4octave, gkosc4semi, gkosc4cent, gkpb, gkNoteTrig, gkosc4noise  
    a4l ntrpol a4l*2,a(0),gkosc4pan/100
    a4r ntrpol a(0),a4r*2,gkosc4pan/100
    rireturn

    aenvfilter1 interp kenvfilter1
    aenvfilter2 interp kenvfilter2 
    kpitch=knum
                                                                                   
     ; FILTER
 
    kfilterP chnget "filterP"
    
    a1l *= 2
    a1r *= 2
    a2l *= 2
    a2r *= 2
    a3l *= 2
    a3r *= 2
    a4l *= 2
    a4r *= 2
    
    if kfilterP == 0 then  ; 0= --, 1= //
                       
        if (gkfilter1osc1==1 && (gkfilter1mode1 != 1 || gkfilter1mode2 != 1)) then
            a1l, a1r MultiFilter a1l, a1r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch, gkfilter1drive
        endif
        if (gkfilter1osc2==1 && (gkfilter1mode1 != 1 || gkfilter1mode2 != 1)) then
            a2l, a2r MultiFilter a2l, a2r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch, gkfilter1drive
        endif
        if (gkfilter1osc3==1 && (gkfilter1mode1 != 1 || gkfilter1mode2 != 1)) then
            a3l, a3r MultiFilter a3l, a3r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch, gkfilter1drive
        endif
        if (gkfilter1osc4==1 && (gkfilter1mode1 != 1 || gkfilter1mode2 != 1)) then
            a4l, a4r MultiFilter a4l, a4r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch, gkfilter1drive
        endif
        
        if (gkfilter2osc1==1 && (gkfilter2mode1 != 1 || gkfilter2mode2 != 1)) then
            a1l, a1r MultiFilter a1l, a1r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch, gkfilter2drive
        endif
        if (gkfilter2osc2==1 && (gkfilter2mode1 != 1 || gkfilter2mode2 != 1)) then
            a2l, a2r MultiFilter a2l, a2r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch, gkfilter2drive
        endif
        if (gkfilter2osc3==1 && (gkfilter2mode1 != 1 || gkfilter2mode2 != 1)) then
            a3l, a3r MultiFilter a3l, a3r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch, gkfilter2drive
        endif
        if (gkfilter2osc4==1 && (gkfilter2mode1 != 1 || gkfilter2mode2 != 1)) then
            a4l, a4r MultiFilter a4l, a4r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch, gkfilter2drive
        endif
            
        asuml = (a1l+a2l+a3l+a4l)
        asumr = (a1r+a2r+a3r+a4r)
    else
        a1lf1 = 0
        a1rf1 = 0
        a2lf1 = 0
        a2rf1 = 0
        a3lf1 = 0
        a3rf1 = 0
        a4lf1 = 0
        a4rf1 = 0
        a1lf2 = 0
        a1rf2 = 0
        a2lf2 = 0
        a2rf2 = 0
        a3lf2 = 0
        a3rf2 = 0
        a4lf2 = 0
        a4rf2 = 0
        
        if (gkfilter1osc1==1) then
            a1lf1, a1rf1 MultiFilter a1l, a1r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch, gkfilter1drive
        endif
        if (gkfilter1osc2==1) then
            a2lf1, a2rf1 MultiFilter a2l, a2r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch, gkfilter1drive
        endif
        if (gkfilter1osc3==1) then
            a3lf1, a3rf1 MultiFilter a3l, a3r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch, gkfilter1drive
        endif
        if (gkfilter1osc4==1) then
            a4lf1, a4rf1 MultiFilter a4l, a4r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch, gkfilter1drive
        endif
    
        if (gkfilter2osc1==1) then
            a1lf2, a1rf2 MultiFilter a1l, a1r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch, gkfilter2drive
        endif
        if (gkfilter2osc2==1) then
            a2lf2, a2rf2 MultiFilter a2l, a2r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch, gkfilter2drive
        endif
        if (gkfilter2osc3==1) then
            a3lf2, a3rf2 MultiFilter a3l, a3r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch, gkfilter2drive
        endif
        if (gkfilter2osc4==1) then
            a4lf2, a4rf2 MultiFilter a4l, a4r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch, gkfilter2drive
        endif
    
    
        asuml = (a1lf1+a2lf1+a3lf1+a4lf1+a1lf2+a2lf2+a3lf2+a4lf2)
        asumr = (a1rf1+a2rf1+a3rf1+a4rf1+a1rf2+a2rf2+a3rf2+a4rf2)
    
    endif 
    
    
    gkNoteTrig	=	0
    xout asuml,asumr
endop



opcode detunedisplay, 0, iii 
ioscnum, ix, iy xin 
kdiff1 chnget "detsh1"
kdiff2 chnget "detsh2"
kdiff3 chnget "detsh3"
kdiff4 chnget "detsh4"
kdtstyle0 chnget "detstyle0"
kdtstyle1 chnget "detstyle1"
kdtstyle2 chnget "detstyle2"
kdtstyle3 chnget "detstyle3"
Skoscvoice sprintfk "osc%dvoice",ioscnum
koscvoice chnget Skoscvoice
Skoscdet sprintfk "osc%ddet",ioscnum
koscdet chnget Skoscdet
koscdetmix chnget "detmix"
Skoscvol sprintfk "osc%dvol",ioscnum
koscvol chnget Skoscvol
kdetlokL chnget "detlockL"
kdetlokR chnget "detlockR"
if kdetlokL == 0 then
    kdetlokL = 1
else
    kdetlokL = 0
endif
if kdetlokR == 0 then
    kdetlokR = 1
else
    kdetlokR = 0
endif
if kdtstyle0 == 1 then
    kD[] fillarray -.30/8-kdiff4*kdetlokL, .30/8+kdiff4*kdetlokR, -.30/5-kdiff3*kdetlokL, .30/5+kdiff3*kdetlokR, -.30/3-kdiff2*kdetlokL, .30/3+kdiff2*kdetlokR, -.30/2-kdiff1*kdetlokL, .30/2+kdiff1*kdetlokR
elseif kdtstyle1 == 1 then
    kD[] fillarray -0.1*koscvoice+0*(koscvoice/((koscvoice-1)/2))*0.1+0.02-kdiff1*kdetlokL, -0.1*koscvoice+1*(koscvoice/((koscvoice-1)/2))*0.1+0.01-kdiff2*kdetlokL, -0.1*koscvoice+2*(koscvoice/((koscvoice-1)/2))*0.1-kdiff3*kdetlokL, -0.1*koscvoice+3*(koscvoice/((koscvoice-1)/2))*0.1-kdiff4*kdetlokL, -0.1*koscvoice+4*(koscvoice/((koscvoice-1)/2))*0.1+kdiff4*kdetlokR, -0.1*koscvoice+5*(koscvoice/((koscvoice-1)/2))*0.1+kdiff3*kdetlokR, -0.1*koscvoice+6*(koscvoice/((koscvoice-1)/2))*0.1+kdiff2*kdetlokR, -0.1*koscvoice+7*(koscvoice/((koscvoice-1)/2))*0.1+kdiff1*kdetlokR 
elseif kdtstyle2 == 1 then
	kD[] fillarray -.30/8-kdiff4*kdetlokL, .30/8+kdiff4*kdetlokR, -.30/3-kdiff3*kdetlokL, .30/3+kdiff3*kdetlokR, -.30/2-kdiff2*kdetlokL, .35/2+kdiff2*kdetlokR, -.40/2-kdiff1*kdetlokL, .50/2+kdiff1*kdetlokR
elseif kdtstyle3 ==1 then
    kD[] fillarray -.1/32-kdiff4, .1/32+kdiff4, -.1/16-kdiff3, .1/16+kdiff3, -.1/8-kdiff2, .1/8+kdiff2, -.1/2-kdiff1, .1/2+kdiff1
endif

if koscdet != 0 && koscvoice != 1 then
        koscdet = 128*log10(koscdet*64)
        kDmax = max(abs(kD[0]),abs(kD[1]),abs(kD[2]),abs(kD[3]),abs(kD[4]),abs(kD[5]),abs(kD[6]),abs(kD[7]))
        else
        kosc1det = 0
        kDmax = 1
        endif
        kindex = 0
        loop: 
        
        if kdtstyle1 == 1 then
            if (koscvoice == 1) then ;special case 1 voice
                    kmixres = 0.5
            elseif (koscvoice%2) != 0 then ;odd
                    if kindex = int(koscvoice/2) then ;center
                        kmixres = (-0.55366*koscdetmix/100 + 0.99785)
                    
                    else ;sides
                        kmixres = (-0.73764*koscdetmix/100^2 + 1.2841*koscdetmix/100 + 0.044372)
                    
                    endif
            else ;even
                    if kindex = koscvoice/2 || kindex = (koscvoice/2)-1 then ;center
                        kmixres = (-0.55366*koscdetmix/100 + 0.99785)
                    
                    else ;sides
                        kmixres = (-0.73764*koscdetmix/100^2 + 1.2841*koscdetmix/100 + 0.044372)
                    
                    endif
            endif
         elseif kdtstyle0 == 1 || kdtstyle3 == 1 then
         
            if kindex = 0 || kindex = 1 then
               kmixres = (-0.55366*koscdetmix/100 + 0.99785)
            else
               kmixres = (-0.73764*koscdetmix/100^2 + 1.2841*koscdetmix/100 + 0.044372)
            endif
         else ;ktdstyle2 = 1
            if (koscvoice%2) != 0 then ;odd
                if kindex = koscvoice-1 then
                    kmixres = (-0.55366*koscdetmix/100 + 0.99785)
                else
                    kmixres = (-0.73764*koscdetmix/100^2 + 1.2841*koscdetmix/100 + 0.044372)
                endif
            else ;even
                if kindex = 0 || kindex = 1 then
                    kmixres = (-0.55366*koscdetmix/100 + 0.99785)
                else
                   kmixres = (-0.73764*koscdetmix/100^2 + 1.2841*koscdetmix/100 + 0.044372)
                endif
            endif
         endif   
               
        Svar sprintfk "img_bar%d%d", ioscnum, kindex
        
        if koscvoice==1 then
            kfine = 0
        else
            kfine = kD[kindex]		
        endif
        if koscdet==0 then
            koscdet = 1
            kDmax = 1
        endif
        if kdtstyle2 == 1 && koscvoice%2!= 0 && kindex == koscvoice-1 then
            kfine = 0
        endif
        Smessage sprintfk "bounds(%f, %d, 1, 10), visible(%d), alpha(%f)", ix+kfine/kDmax*koscdet/7.5,iy, kindex<koscvoice ? 1 : 0, kmixres*koscvol/100
        chnset Smessage, Svar
        
        kindex += 1
        if (kindex <= 7) kgoto loop
endop 



;##########################################################################################################################################

instr	UpdateGUI                                 
    kplay chnget "IS_PLAYING"

    if changed:k(kplay)==1 then 
        gkoldnum = 0
        gknum = 0
    endif 

    kTrigOSC changed chnget:k("OSC1_BUTTON"), chnget:k("OSC2_BUTTON"), chnget:k("OSC3_BUTTON"), chnget:k("OSC4_BUTTON") 
    kTrigENV changed chnget:k("ENV1_BUTTON"), chnget:k("ENV2_BUTTON"), chnget:k("ENV3_BUTTON"), chnget:k("ENV4_BUTTON")
    kTrigLFO changed chnget:k("LFO1_BUTTON"), chnget:k("LFO2_BUTTON")
    kTrigLFOsync changed chnget:k("lfo1bpm"), chnget:k("lfo2bpm")
    kTrigOSCMODEENV changed chnget:k("env1amp"), chnget:k("env1pitch"), chnget:k("env1morph"), chnget:k("env1filter"), chnget:k("env1lfo"), chnget:k("env2amp"), chnget:k("env2pitch"), chnget:k("env2morph"), chnget:k("env2filter"), chnget:k("env2lfo"), chnget:k("env3amp"), chnget:k("env3pitch"), chnget:k("env3morph"), chnget:k("env3filter"), chnget:k("env3lfo"), chnget:k("env4amp"), chnget:k("env4pitch"), chnget:k("env4morph"), chnget:k("env4filter"), chnget:k("env4lfo")
    kTrigOSCMODELFO changed chnget:k("lfo1amp"), chnget:k("lfo1pitch"), chnget:k("lfo1filter"), chnget:k("lfo2amp"), chnget:k("lfo2pitch"), chnget:k("lfo2filter")
    kTrigFILTER changed chnget:k("FILTER1_BUTTON"), chnget:k("FILTER2_BUTTON")
    kTrigEFFECT changed chnget:k("EFFECT1_BUTTON"), chnget:k("EFFECT2_BUTTON"), chnget:k("EFFECT3_BUTTON"), chnget:k("EFFECT4_BUTTON"), chnget:k("EFFECT5_BUTTON"), chnget:k("EFFECT6_BUTTON")
    kTrigOSCFILTER changed chnget:k("filter1osc1"), chnget:k("filter1osc2"), chnget:k("filter1osc3"), chnget:k("filter1osc4"), chnget:k("filter2osc1"), chnget:k("filter2osc2"), chnget:k("filter2osc3"), chnget:k("filter1osc4")    
    kTrigENVOSC changed chnget:k("env1osc1"), chnget:k("env1osc2"), chnget:k("env1osc3"), chnget:k("env1osc4"), chnget:k("env2osc1"), chnget:k("env2osc2"), chnget:k("env2osc3"), chnget:k("env2osc4"), chnget:k("env3osc1"), chnget:k("env3osc2"), chnget:k("env3osc3"), chnget:k("env3osc4"), chnget:k("env4osc1"),chnget:k("env4osc2"), chnget:k("env4osc3"), chnget:k("env4osc4") 
    
    kOscUse changed chnget:k("osc1vol"), chnget:k("osc2vol"), chnget:k("osc3vol"), chnget:k("osc4vol")
    iFxUse init 1 ;button doesn't send signal on init, this could be a solution to upgrade to changed2 opcode
    kFxUse changed chnget:k("distswitch"), chnget:k("eqswitch"), chnget:k("chorusswitch"), chnget:k("delswitch"), chnget:k("revswitch"), chnget:k("compswitch"), iFxUse
    kFilterUse changed chnget:k("filterP"), chnget:k("filter1osc1"), chnget:k("filter1osc2"), chnget:k("filter1osc3"), chnget:k("filter1osc4"), chnget:k("filter1mode1_K"), chnget:k("filter1mode2_K"), chnget:k("filter2osc1"), chnget:k("filter2osc2"), chnget:k("filter2osc3"), chnget:k("filter2osc4"), chnget:k("filter2mode1_K"), chnget:k("filter2mode2_K")
    kLFOUse changed chnget:k("lfo1osc1"), chnget:k("lfo1osc2"), chnget:k("lfo1osc3"), chnget:k("lfo1osc4"), chnget:k("lfo1shape_K"), chnget:k("lfo2osc1"), chnget:k("lfo2osc2"), chnget:k("lfo2osc3"), chnget:k("lfo2osc4"), chnget:k("lfo2shape_K")  
    
    kTrigENVmode changed chnget:k("env1curve_exp"), chnget:k("env1curve_lin"), chnget:k("env1curve_custom"), chnget:k("env2curve_exp"), chnget:k("env2curve_lin"), chnget:k("env2curve_custom"), chnget:k("env3curve_exp"), chnget:k("env3curve_lin"), chnget:k("env3curve_custom"), chnget:k("env4curve_exp"), chnget:k("env4curve_lin"), chnget:k("env4curve_custom") 
    

    
    ;TABS SELECTION DISPLAY & UNIT USED DISPLAY
    if kOscUse == 1 then 
        Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("osc1vol")>0 ? 230 : 140, chnget:k("osc1vol")>0 ? 255 : 220
		chnset Smessage, "idOSC1_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("osc2vol")>0 ? 230 : 140, chnget:k("osc2vol")>0 ? 255 : 220
		chnset Smessage, "idOSC2_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("osc3vol")>0 ? 230 : 140, chnget:k("osc3vol")>0 ? 255 : 220
		chnset Smessage, "idOSC3_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("osc4vol")>0 ? 230 : 140, chnget:k("osc4vol")>0 ? 255 : 220
		chnset Smessage, "idOSC4_BUTTON"	
		
	    Smessage sprintfk "alpha(%f)", chnget:k("osc1vol")>0 ? 1: 0.15
		chnset Smessage, "idOSC1_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("osc2vol")>0 ? 1: 0.15
		chnset Smessage, "idOSC2_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("osc3vol")>0 ? 1: 0.15
		chnset Smessage, "idOSC3_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("osc4vol")>0 ? 1: 0.15
		chnset Smessage, "idOSC4_LED"
    endif
    
    if kTrigENVOSC == 1 then
        Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("env1osc1")+chnget:k("env1osc2")+chnget:k("env1osc3")+chnget:k("env1osc4")>0 ? 230 : 140, chnget:k("env1osc1")+chnget:k("env1osc2")+chnget:k("env1osc3")+chnget:k("env1osc4")>0 ? 255 : 220
		chnset Smessage, "idENV1_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("env2osc1")+chnget:k("env2osc2")+chnget:k("env2osc3")+chnget:k("env2osc4")>0 ? 230 : 140, chnget:k("env2osc1")+chnget:k("env2osc2")+chnget:k("env2osc3")+chnget:k("env2osc4")>0 ? 255 : 220
		chnset Smessage, "idENV2_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("env3osc1")+chnget:k("env3osc2")+chnget:k("env3osc3")+chnget:k("env3osc4")>0 ? 230 : 140, chnget:k("env3osc1")+chnget:k("env3osc2")+chnget:k("env3osc3")+chnget:k("env3osc4")>0 ? 255 : 220
		chnset Smessage, "idENV3_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("env4osc1")+chnget:k("env4osc2")+chnget:k("env4osc3")+chnget:k("env4osc4")>0 ? 230 : 140, chnget:k("env4osc1")+chnget:k("env4osc2")+chnget:k("env4osc3")+chnget:k("env4osc4")>0 ? 255 : 220
		chnset Smessage, "idENV4_BUTTON"
		
		Smessage sprintfk "alpha(%f)", chnget:k("env1osc1")+chnget:k("env1osc2")+chnget:k("env1osc3")+chnget:k("env1osc4")>0 ? 1: 0.15
		chnset Smessage, "idENV1_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("env2osc1")+chnget:k("env2osc2")+chnget:k("env2osc3")+chnget:k("env2osc4")>0 ? 1: 0.15
		chnset Smessage, "idENV2_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("env3osc1")+chnget:k("env3osc2")+chnget:k("env3osc3")+chnget:k("env3osc4")>0 ? 1: 0.15
		chnset Smessage, "idENV3_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("env4osc1")+chnget:k("env4osc2")+chnget:k("env4osc3")+chnget:k("env4osc4")>0 ? 1: 0.15
		chnset Smessage, "idENV4_LED"
    endif
    
    if kFxUse == 1 then
        Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("distswitch")>0 ? 230 : 140, chnget:k("distswitch")>0 ? 255 : 220
		chnset Smessage, "idFX1_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("eqswitch")>0 ? 230 : 140, chnget:k("eqswitch")>0 ? 255 : 220
		chnset Smessage, "idFX2_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("chorusswitch")>0 ? 230 : 140, chnget:k("chorusswitch")>0 ? 255 : 220
		chnset Smessage, "idFX3_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("delswitch")>0 ? 230 : 140, chnget:k("delswitch")>0 ? 255 : 220
		chnset Smessage, "idFX4_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("revswitch")>0 ? 230 : 140, chnget:k("revswitch")>0 ? 255 : 220
		chnset Smessage, "idFX5_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", chnget:k("compswitch")>0 ? 230 : 140, chnget:k("compswitch")>0 ? 255 : 220
		chnset Smessage, "idFX6_BUTTON"
		
		Smessage sprintfk "alpha(%f)", chnget:k("distswitch")>0 ? 1: 0.15
		chnset Smessage, "idFX1_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("eqswitch")>0 ? 1: 0.15
		chnset Smessage, "idFX2_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("chorusswitch")>0 ? 1: 0.15
		chnset Smessage, "idFX3_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("delswitch")>0 ? 1: 0.15
		chnset Smessage, "idFX4_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("revswitch")>0 ? 1: 0.15
		chnset Smessage, "idFX5_LED"
		Smessage sprintfk "alpha(%f)", chnget:k("compswitch")>0 ? 1: 0.15
		chnset Smessage, "idFX6_LED"	
    endif
    
    if kFilterUse == 1  || kOscUse == 1 then   
        Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", (((chnget:k("filter1mode1_K")-1)+(chnget:k("filter1mode2_K")-1))*(chnget:k("filter1osc1")+chnget:k("filter1osc2")+chnget:k("filter1osc3")+chnget:k("filter1osc4"))) > 0 ? 230 : 140, (((chnget:k("filter1mode1_K")-1)+(chnget:k("filter1mode2_K")-1))*(chnget:k("filter1osc1")+chnget:k("filter1osc2")+chnget:k("filter1osc3")+chnget:k("filter1osc4"))) > 0 ? 255 : 220
		chnset Smessage, "idFILTER1_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", (((chnget:k("filter2mode1_K")-1)+(chnget:k("filter2mode2_K")-1))*(chnget:k("filter2osc1")+chnget:k("filter2osc2")+chnget:k("filter2osc3")+chnget:k("filter2osc4"))) > 0 ? 230 : 140, (((chnget:k("filter2mode1_K")-1)+(chnget:k("filter2mode2_K")-1))*(chnget:k("filter2osc1")+chnget:k("filter2osc2")+chnget:k("filter2osc3")+chnget:k("filter2osc4"))) > 0 ? 255 : 220
		chnset Smessage, "idFILTER2_BUTTON"

        Smessage sprintfk "alpha(%f)", (((chnget:k("filter1mode1_K")-1)+(chnget:k("filter1mode2_K")-1))*(chnget:k("filter1osc1")+chnget:k("filter1osc2")+chnget:k("filter1osc3")+chnget:k("filter1osc4")))+chnget:k("filterP") > 0 ? 1: 0.15
		chnset Smessage, "idFILTER1_LED"
        Smessage sprintfk "alpha(%f)", (((chnget:k("filter2mode1_K")-1)+(chnget:k("filter2mode2_K")-1))*(chnget:k("filter2osc1")+chnget:k("filter2osc2")+chnget:k("filter2osc3")+chnget:k("filter2osc4")))+chnget:k("filterP") > 0 ? 1: 0.15
		chnset Smessage, "idFILTER2_LED"
		

		
        ktotf1 = chnget:k("osc1vol") > 0 ?    (chnget:k("filterP")  + chnget:k("filterP")*( chnget:k("filter1osc1")+chnget:k("filter2osc1")) == 1 ? 1: 0) : 0
        ktotf2 = chnget:k("osc2vol") > 0 ?    (chnget:k("filterP")  + chnget:k("filterP")*( chnget:k("filter1osc2")+chnget:k("filter2osc2")) == 1 ? 1: 0) : 0
        ktotf3 = chnget:k("osc3vol") > 0 ?    (chnget:k("filterP")  + chnget:k("filterP")*( chnget:k("filter1osc3")+chnget:k("filter2osc3")) == 1 ? 1: 0) : 0
        ktotf4 = chnget:k("osc4vol") > 0 ?    (chnget:k("filterP")  + chnget:k("filterP")*( chnget:k("filter1osc4")+chnget:k("filter2osc4")) == 1 ? 1: 0) : 0
        if ktotf1 == 1 || ktotf2 == 1 || ktotf3 == 1 || ktotf4 == 1 then
            chnset "visible(1)", "WARN_FILSIGN"
            chnset "visible(1)", "WARN_FILMSG"
        else
            chnset "visible(0)", "WARN_FILSIGN"
            chnset "visible(0)", "WARN_FILMSG"
        endif

            Smessage sprintfk "%s", ktotf1 == 1 ? "fontColour(\"red\")" : "fontColour(220,220,220)"
            chnset Smessage, "FILTER1BUT1"
            chnset Smessage, "FILTER2BUT1"
		
		    Smessage sprintfk "%s", ktotf2 == 1 ? "fontColour(\"red\")" : "fontColour(220,220,220)"
            chnset Smessage, "FILTER1BUT2"
            chnset Smessage, "FILTER2BUT2"
		
		    Smessage sprintfk "%s", ktotf3 == 1 ? "fontColour(\"red\")" : "fontColour(220,220,220)"
            chnset Smessage, "FILTER1BUT3"
            chnset Smessage, "FILTER2BUT3"
		
		    Smessage sprintfk "%s", ktotf4 == 1 ? "fontColour(\"red\")" : "fontColour(220,220,220)"
            chnset Smessage, "FILTER1BUT4"
            chnset Smessage, "FILTER2BUT4"

    endif
    
    if kLFOUse == 1 then
        Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", ((chnget:k("lfo1shape_K")-1)*(chnget:k("lfo1osc1")+chnget:k("lfo1osc2")+chnget:k("lfo1osc3")+chnget:k("lfo1osc4"))) > 0 ? 230 : 140, ((chnget:k("lfo1shape_K")-1)*(chnget:k("lfo1osc1")+chnget:k("lfo1osc2")+chnget:k("lfo1osc3")+chnget:k("lfo1osc4"))) > 0 ? 255 : 220
		chnset Smessage, "idLFO1_BUTTON"
		Smessage sprintfk "fontColour:0(\"255,255,255,%d\"), fontColour:1(\"255,255,255,%d\")", ((chnget:k("lfo2shape_K")-1)*(chnget:k("lfo2osc1")+chnget:k("lfo2osc2")+chnget:k("lfo2osc3")+chnget:k("lfo2osc4"))) > 0 ? 230 : 140, ((chnget:k("lfo2shape_K")-1)*(chnget:k("lfo2osc1")+chnget:k("lfo2osc2")+chnget:k("lfo2osc3")+chnget:k("lfo2osc4"))) > 0 ? 255 : 220
		chnset Smessage, "idLFO2_BUTTON"
		
		Smessage sprintfk "alpha(%f)", ((chnget:k("lfo1shape_K")-1)*(chnget:k("lfo1osc1")+chnget:k("lfo1osc2")+chnget:k("lfo1osc3")+chnget:k("lfo1osc4"))) > 0 ? 1: 0.15
		chnset Smessage, "idLFO1_LED"
		Smessage sprintfk "alpha(%f)", ((chnget:k("lfo2shape_K")-1)*(chnget:k("lfo2osc1")+chnget:k("lfo2osc2")+chnget:k("lfo2osc3")+chnget:k("lfo2osc4"))) > 0 ? 1: 0.15
		chnset Smessage, "idLFO2_LED"		
    endif



    if kTrigENVmode == 1 then
        Smessage sprintfk "visible(%d)", chnget:k("env1curve_custom") == 1 ? 0 : 1
		chnset Smessage, "ENV1_HIDCUST"
		Smessage sprintfk "visible(%d)", chnget:k("env2curve_custom") == 1 ? 0 : 1
		chnset Smessage, "ENV2_HIDCUST"
		Smessage sprintfk "visible(%d)", chnget:k("env3curve_custom") == 1 ? 0 : 1
		chnset Smessage, "ENV3_HIDCUST"
		Smessage sprintfk "visible(%d)", chnget:k("env4curve_custom") == 1 ? 0 : 1
		chnset Smessage, "ENV4_HIDCUST"
    endif

    kTrig1DETUNE changed chnget:k("osc1det"), chnget:k("osc1voice"), chnget:k("osc1vol")
    kTrig2DETUNE changed chnget:k("osc2det"), chnget:k("osc2voice"), chnget:k("osc2vol")
    kTrig3DETUNE changed chnget:k("osc3det"), chnget:k("osc3voice"), chnget:k("osc3vol")
    kTrig4DETUNE changed chnget:k("osc4det"), chnget:k("osc4voice"), chnget:k("osc4vol")
    kTrigEXPERTDETUNE changed chnget:k("detsh1"), chnget:k("detsh2"), chnget:k("detsh3"), chnget:k("detsh4"), chnget:k("detstyle0"), chnget:k("detstyle1"), chnget:k("detstyle2"), chnget:k("detstyle3"), chnget:k("detmix"), chnget:k("detlockL"), chnget:k("detlockR")
    if kTrig1DETUNE==1 || kTrigEXPERTDETUNE==1 then
    detunedisplay 1, 640, 390
    endif
    if kTrig2DETUNE==1 || kTrigEXPERTDETUNE==1 then
    detunedisplay 2, 640, 390
    endif
    if kTrig3DETUNE==1 || kTrigEXPERTDETUNE==1 then
    detunedisplay 3, 640, 390
    endif
    if kTrig4DETUNE==1 || kTrigEXPERTDETUNE==1 then
    detunedisplay 4, 640, 390
    endif
    

    if (kTrigENVOSC | kTrigOSCMODEENV) == 1 then
        ktot1 = chnget:k("env1osc1")*chnget:k("env1amp")+chnget:k("env2osc1")*chnget:k("env2amp")+chnget:k("env3osc1")*chnget:k("env3amp")+chnget:k("env4osc1")*chnget:k("env4amp")
        ktot2 = chnget:k("env1osc2")*chnget:k("env1amp")+chnget:k("env2osc2")*chnget:k("env2amp")+chnget:k("env3osc2")*chnget:k("env3amp")+chnget:k("env4osc2")*chnget:k("env4amp")
        ktot3 = chnget:k("env1osc3")*chnget:k("env1amp")+chnget:k("env2osc3")*chnget:k("env2amp")+chnget:k("env3osc3")*chnget:k("env3amp")+chnget:k("env4osc3")*chnget:k("env4amp")
        ktot4 = chnget:k("env1osc4")*chnget:k("env1amp")+chnget:k("env2osc4")*chnget:k("env2amp")+chnget:k("env3osc4")*chnget:k("env3amp")+chnget:k("env4osc4")*chnget:k("env4amp")
        ktot5 = chnget:k("env1osc1")*chnget:k("env1pitch")+chnget:k("env2osc1")*chnget:k("env2pitch")+chnget:k("env3osc1")*chnget:k("env3pitch")+chnget:k("env4osc1")*chnget:k("env4pitch")
        ktot6 = chnget:k("env1osc2")*chnget:k("env1pitch")+chnget:k("env2osc2")*chnget:k("env2pitch")+chnget:k("env3osc2")*chnget:k("env3pitch")+chnget:k("env4osc2")*chnget:k("env4pitch")
        ktot7 = chnget:k("env1osc3")*chnget:k("env1pitch")+chnget:k("env2osc3")*chnget:k("env2pitch")+chnget:k("env3osc3")*chnget:k("env3pitch")+chnget:k("env4osc3")*chnget:k("env4pitch")
        ktot8 = chnget:k("env1osc4")*chnget:k("env1pitch")+chnget:k("env2osc4")*chnget:k("env2pitch")+chnget:k("env3osc4")*chnget:k("env3pitch")+chnget:k("env4osc4")*chnget:k("env4pitch")
        ktot9 = chnget:k("env1osc1")*chnget:k("env1morph")+chnget:k("env2osc1")*chnget:k("env2morph")+chnget:k("env3osc1")*chnget:k("env3morph")+chnget:k("env4osc1")*chnget:k("env4morph")
        ktot10= chnget:k("env1osc2")*chnget:k("env1morph")+chnget:k("env2osc2")*chnget:k("env2morph")+chnget:k("env3osc2")*chnget:k("env3morph")+chnget:k("env4osc2")*chnget:k("env4morph")
        ktot11= chnget:k("env1osc3")*chnget:k("env1morph")+chnget:k("env2osc3")*chnget:k("env2morph")+chnget:k("env3osc3")*chnget:k("env3morph")+chnget:k("env4osc3")*chnget:k("env4morph")
        ktot12= chnget:k("env1osc4")*chnget:k("env1morph")+chnget:k("env2osc4")*chnget:k("env2morph")+chnget:k("env3osc4")*chnget:k("env3morph")+chnget:k("env4osc4")*chnget:k("env4morph")
        ktot13= chnget:k("env1osc1")*chnget:k("env1filter")+chnget:k("env2osc1")*chnget:k("env2filter")+chnget:k("env3osc1")*chnget:k("env3filter")+chnget:k("env4osc1")*chnget:k("env4filter")
        ktot14= chnget:k("env1osc2")*chnget:k("env1filter")+chnget:k("env2osc2")*chnget:k("env2filter")+chnget:k("env3osc2")*chnget:k("env3filter")+chnget:k("env4osc2")*chnget:k("env4filter")
        ktot15= chnget:k("env1osc1")*chnget:k("env1lfo")+chnget:k("env2osc1")*chnget:k("env2lfo")+chnget:k("env3osc1")*chnget:k("env3lfo")+chnget:k("env4osc1")*chnget:k("env4lfo")
        ktot16= chnget:k("env1osc2")*chnget:k("env1lfo")+chnget:k("env2osc2")*chnget:k("env2lfo")+chnget:k("env3osc2")*chnget:k("env3lfo")+chnget:k("env4osc2")*chnget:k("env4lfo")
        if ktot1 > 1 || ktot2 > 1 || ktot3 > 1 || ktot4 > 1 || ktot5 > 1 || ktot6 > 1 || ktot7 > 1 || ktot8 > 1 || ktot9 > 1 || ktot10 > 1 || ktot11 > 1 || ktot12 > 1 || ktot13 > 1 || ktot14 > 1 || ktot15 > 1 || ktot16 > 1 then
            chnset "visible(1)", "WARN_ENVSIGN"
            chnset "visible(1)", "WARN_ENVMSG"
        else
            chnset "visible(0)", "WARN_ENVSIGN"
            chnset "visible(0)", "WARN_ENVMSG"
        endif
    endif
    
    
    
    kAbout changed chnget:k("BUTTON_ABOUT")
    kPanic changed chnget:k("BUTTON_PANIC")
    kConsole changed chnget:k("button_debug")
    kClose changed chnget:k("BGCLOSE")
    if kAbout==1 then
		chnset "visible(1)", "GROUP_ABOUT"
		chnset "visible(1)", "GROUP_BGABOUT"
		chnset "visible(1)", "GROUP_BGCLOSE"
		chnset "visible(0)", "GROUP_CONSOLE"  
    endif 
    if kConsole==1 then
        chnset "visible(1)", "GROUP_CONSOLE"
    endif 
    if kClose==1 then
		chnset "visible(0)", "GROUP_ABOUT"
		chnset "visible(0)", "GROUP_BGABOUT" 
		chnset "visible(0)", "GROUP_BGCLOSE"
		chnset "visible(0)", "GROUP_CONSOLE" 
    endif
      
    
    kWFManager changed chnget:k("BUTTON_WFMANAG") 
    kClose1 changed chnget:k("BGCLOSE_1")
    if kWFManager == 1 then
		chnset "visible(1)", "GROUP_WFMANAG"
		chnset "visible(1)", "GROUP_BGWFMANAG"
        chnset "visible(1)", "GROUP_BGCLOSE_1" 
    endif 
    if kClose1==1 then
		chnset "visible(0)", "GROUP_WFMANAG"
		chnset "visible(0)", "GROUP_BGWFMANAG" 
		chnset "visible(0)", "GROUP_BGCLOSE_1" 
    endif 
    
    if kPanic==1 then
        turnoff2 2,0,0
        turnoff2 3,0,0
    endif
    
    
	if kTrigOSC==1 then
		Smessage sprintfk "visible(%d)", chnget:k("OSC1_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_OSC1" 
		Smessage sprintfk "visible(%d)", chnget:k("OSC2_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_OSC2"	
		Smessage sprintfk "visible(%d)", chnget:k("OSC3_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_OSC3"
		Smessage sprintfk "visible(%d)", chnget:k("OSC4_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_OSC4"
	endif

    if kTrigENV==1 then
		Smessage sprintfk "visible(%d)", chnget:k("ENV1_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_ENV1"
		Smessage sprintfk "visible(%d)", chnget:k("ENV2_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_ENV2"
		Smessage sprintfk "visible(%d)", chnget:k("ENV3_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_ENV3"
		Smessage sprintfk "visible(%d)", chnget:k("ENV4_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_ENV4"
	endif
	
	if kTrigLFO==1 then
		Smessage sprintfk "visible(%d)", chnget:k("LFO1_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_LFO1"
		Smessage sprintfk "visible(%d)", chnget:k("LFO2_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_LFO2"
	endif


    if kTrigLFOsync==1 then
        Smessage sprintfk "visible(%d)", chnget:k("lfo1bpm")==1 ? 1 : 0
		chnset Smessage, "lfo1mult_i"
		Smessage sprintfk "visible(%d)", chnget:k("lfo1bpm")==1 ? 1 : 0
		chnset Smessage, "lfo1hide_i"
		Smessage sprintfk "visible(%d)", chnget:k("lfo2bpm")==1 ? 1 : 0
		chnset Smessage, "lfo2mult_i"
		Smessage sprintfk "visible(%d)", chnget:k("lfo2bpm")==1 ? 1 : 0
		chnset Smessage, "lfo2hide_i"
    endif
    
    
   
    if kTrigOSCMODEENV==1 then		
		Smessage sprintfk "visible(%d)", chnget:k("env1filter")==1 || chnget:k("env1lfo")==1 ? 0 : 1
		chnset Smessage, "ENV1OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("env1filter")==1 || chnget:k("env1lfo")==1 ? 0 : 1
		chnset Smessage, "ENV1OSC4_BUTTON"
		if (chnget:k("env1filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "ENV1OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "ENV1OSC2_BUTTON"
        elseif (chnget:k("env1lfo")==1) then
		    Smessage sprintfk "text(%s)","LFO1"
		    chnset Smessage, "ENV1OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","LFO2"
		    chnset Smessage, "ENV1OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "ENV1OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "ENV1OSC2_BUTTON"
        endif
        
        Smessage sprintfk "visible(%d)", chnget:k("env2filter")==1 || chnget:k("env2lfo")==1 ? 0 : 1
		chnset Smessage, "ENV2OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("env2filter")==1 || chnget:k("env2lfo")==1 ? 0 : 1
		chnset Smessage, "ENV2OSC4_BUTTON"
		if (chnget:k("env2filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "ENV2OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "ENV2OSC2_BUTTON"
        elseif (chnget:k("env2lfo")==1) then
		    Smessage sprintfk "text(%s)","LFO1"
		    chnset Smessage, "ENV2OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","LFO2"
		    chnset Smessage, "ENV2OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "ENV2OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "ENV2OSC2_BUTTON"
        endif
        
        Smessage sprintfk "visible(%d)", chnget:k("env3filter")==1 || chnget:k("env3lfo")==1 ? 0 : 1
		chnset Smessage, "ENV3OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("env3filter")==1 || chnget:k("env3lfo")==1 ? 0 : 1
		chnset Smessage, "ENV3OSC4_BUTTON"
		if (chnget:k("env3filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "ENV3OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "ENV3OSC2_BUTTON"
        elseif (chnget:k("env3lfo")==1) then
		    Smessage sprintfk "text(%s)","LFO1"
		    chnset Smessage, "ENV3OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","LFO2"
		    chnset Smessage, "ENV3OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "ENV3OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "ENV3OSC2_BUTTON"
        endif
        
        Smessage sprintfk "visible(%d)", chnget:k("env4filter")==1 || chnget:k("env4lfo")==1 ? 0 : 1
		chnset Smessage, "ENV4OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("env4filter")==1 || chnget:k("env4lfo")==1 ? 0 : 1
		chnset Smessage, "ENV4OSC4_BUTTON"
		if (chnget:k("env4filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "ENV4OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "ENV4OSC2_BUTTON"
        elseif (chnget:k("env4lfo")==1) then
		    Smessage sprintfk "text(%s)","LFO1"
		    chnset Smessage, "ENV4OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","LFO2"
		    chnset Smessage, "ENV4OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "ENV4OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "ENV4OSC2_BUTTON"
        endif
   endif
   
   
   if kTrigOSCMODELFO==1 then
		Smessage sprintfk "visible(%d)", chnget:k("lfo1filter")==1 ? 0 : 1
		chnset Smessage, "LFO1OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("lfo1filter")==1 ? 0 : 1
		chnset Smessage, "LFO1OSC4_BUTTON"
		if (chnget:k("lfo1filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "LFO1OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "LFO1OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "LFO1OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "LFO1OSC2_BUTTON"
        endif
        
        Smessage sprintfk "visible(%d)", chnget:k("lfo2filter")==1 ? 0 : 1
		chnset Smessage, "LFO2OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("lfo2filter")==1 ? 0 : 1
		chnset Smessage, "LFO2OSC4_BUTTON"
		if (chnget:k("lfo2filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "LFO2OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "LFO2OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "LFO2OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "LFO2OSC2_BUTTON"
        endif
       
   endif
   
   
   if kTrigFILTER==1 then
        Smessage sprintfk "visible(%d)", chnget:k("FILTER1_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_FILTER1"
        Smessage sprintfk "visible(%d)", chnget:k("FILTER2_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_FILTER2"
   endif
   if kTrigEFFECT==1 then
        Smessage sprintfk "visible(%d)", chnget:k("EFFECT1_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_EFFECT1"
        Smessage sprintfk "visible(%d)", chnget:k("EFFECT2_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_EFFECT2"
		Smessage sprintfk "visible(%d)", chnget:k("EFFECT3_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_EFFECT3"
		Smessage sprintfk "visible(%d)", chnget:k("EFFECT4_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_EFFECT4"
		Smessage sprintfk "visible(%d)", chnget:k("EFFECT5_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_EFFECT5"
	    Smessage sprintfk "visible(%d)", chnget:k("EFFECT6_BUTTON")==1 ? 1 : 0
		chnset Smessage, "GROUP_EFFECT6"
   endif 

   
    
    ;//////////LMMS BLINKING COMBOBOX FIX///////////////
    kosc1wave1_K changed2 chnget:k("osc1wave1_K")
    kosc1wave1_B changed2 chnget:k("osc1wave1_B")
    if kosc1wave1_B ==1 then
        ktemp chnget "osc1wave1_B"
        chnset ktemp,"osc1wave1_K"
    endif
    
    if kosc1wave1_K ==1 then
        ktemp chnget "osc1wave1_K"
        chnset ktemp,"osc1wave1_B"
    endif
    
    kosc1wave2_K changed2 chnget:k("osc1wave2_K")
    kosc1wave2_B changed2 chnget:k("osc1wave2_B")
    if kosc1wave2_B ==1 then
        ktemp chnget "osc1wave2_B"
        chnset ktemp,"osc1wave2_K"
    endif
    
    if kosc1wave2_K ==1 then
        ktemp chnget "osc1wave2_K"
        chnset ktemp,"osc1wave2_B"
    endif
    
    kosc2wave1_K changed2 chnget:k("osc2wave1_K")
    kosc2wave1_B changed2 chnget:k("osc2wave1_B")
    if kosc2wave1_B ==1 then
        ktemp chnget "osc2wave1_B"
        chnset ktemp,"osc2wave1_K"
    endif
    
    if kosc2wave1_K ==1 then
        ktemp chnget "osc2wave1_K"
        chnset ktemp,"osc2wave1_B"
    endif
    
    kosc2wave2_K changed2 chnget:k("osc2wave2_K")
    kosc2wave2_B changed2 chnget:k("osc2wave2_B")
    if kosc2wave2_B ==1 then
        ktemp chnget "osc2wave2_B"
        chnset ktemp,"osc2wave2_K"
    endif
    
    if kosc2wave2_K ==1 then
        ktemp chnget "osc2wave2_K"
        chnset ktemp,"osc2wave2_B"
    endif
    
    kosc3wave1_K changed2 chnget:k("osc3wave1_K")
    kosc3wave1_B changed2 chnget:k("osc3wave1_B")
    if kosc3wave1_B ==1 then
        ktemp chnget "osc3wave1_B"
        chnset ktemp,"osc3wave1_K"
    endif
    
    if kosc3wave1_K ==1 then
        ktemp chnget "osc3wave1_K"
        chnset ktemp,"osc3wave1_B"
    endif
    
    kosc3wave2_K changed2 chnget:k("osc3wave2_K")
    kosc3wave2_B changed2 chnget:k("osc3wave2_B")
    if kosc3wave2_B ==1 then
        ktemp chnget "osc3wave2_B"
        chnset ktemp,"osc3wave2_K"
    endif
    
    if kosc3wave2_K ==1 then
        ktemp chnget "osc3wave2_K"
        chnset ktemp,"osc3wave2_B"
    endif
    
    kosc4wave1_K changed2 chnget:k("osc4wave1_K")
    kosc4wave1_B changed2 chnget:k("osc4wave1_B")
    if kosc4wave1_B ==1 then
        ktemp chnget "osc4wave1_B"
        chnset ktemp,"osc4wave1_K"
    endif
    
    if kosc4wave1_K ==1 then
        ktemp chnget "osc4wave1_K"
        chnset ktemp,"osc4wave1_B"
    endif
    
    kosc4wave2_K changed2 chnget:k("osc4wave2_K")
    kosc4wave2_B changed2 chnget:k("osc4wave2_B")
    if kosc4wave2_B ==1 then
        ktemp chnget "osc4wave2_B"
        chnset ktemp,"osc4wave2_K"
    endif
    
    if kosc4wave2_K ==1 then
        ktemp chnget "osc4wave2_K"
        chnset ktemp,"osc4wave2_B"
    endif
    
    klfo1shape_K changed2 chnget:k("lfo1shape_K")
    klfo1shape_B changed2 chnget:k("lfo1shape_B")
    if klfo1shape_B ==1 then
        ktemp chnget "lfo1shape_B"
        chnset ktemp,"lfo1shape_K"
    endif
    
    if klfo1shape_K ==1 then
        ktemp chnget "lfo1shape_K"
        chnset ktemp,"lfo1shape_B"
    endif
    
    klfo2shape_K changed2 chnget:k("lfo2shape_K")
    klfo2shape_B changed2 chnget:k("lfo2shape_B")
    if klfo2shape_B ==1 then
        ktemp chnget "lfo2shape_B"
        chnset ktemp,"lfo2shape_K"
    endif
    
    if klfo2shape_K ==1 then
        ktemp chnget "lfo2shape_K"
        chnset ktemp,"lfo2shape_B"
    endif
    
    kfilter1mode1_K changed2 chnget:k("filter1mode1_K")
    kfilter1mode1_B changed2 chnget:k("filter1mode1_B")
    if kfilter1mode1_B ==1 then
        ktemp chnget "filter1mode1_B"
        chnset ktemp,"filter1mode1_K"
    endif
    
    if kfilter1mode1_K ==1 then
        ktemp chnget "filter1mode1_K"
        chnset ktemp,"filter1mode1_B"
    endif
    
    kfilter1mode2_K changed2 chnget:k("filter1mode2_K")
    kfilter1mode2_B changed2 chnget:k("filter1mode2_B")
    if kfilter1mode2_B ==1 then
        ktemp chnget "filter1mode2_B"
        chnset ktemp,"filter1mode2_K"
    endif
    
    if kfilter1mode2_K ==1 then
        ktemp chnget "filter1mode2_K"
        chnset ktemp,"filter1mode2_B"
    endif
    
    kfilter2mode1_K changed2 chnget:k("filter2mode1_K")
    kfilter2mode1_B changed2 chnget:k("filter2mode1_B")
    if kfilter2mode1_B ==1 then
        ktemp chnget "filter2mode1_B"
        chnset ktemp,"filter2mode1_K"
    endif
    
    if kfilter2mode1_K ==1 then
        ktemp chnget "filter2mode1_K"
        chnset ktemp,"filter2mode1_B"
    endif
    
    kfilter2mode2_K changed2 chnget:k("filter2mode2_K")
    kfilter2mode2_B changed2 chnget:k("filter2mode2_B")
    if kfilter2mode2_B ==1 then
        ktemp chnget "filter2mode2_B"
        chnset ktemp,"filter2mode2_K"
    endif
    
    if kfilter2mode2_K ==1 then
        ktemp chnget "filter2mode2_K"
        chnset ktemp,"filter2mode2_B"
    endif
    
    
    
    
    
    
gkmonopoly	chnget	"monopoly"
	gkLegTim	chnget	"LegTim"
	gkLegTim	/=1000
    gkSARetrig	chnget	"SARetrig"
    gkMasterVolume chnget "MasterVol"
    
	gkosc1wave1 chnget "osc1wave1_B"
    gkosc1wave2 chnget "osc1wave2_B"
    gkosc1morph chnget "osc1morph" 
    gkosc1vol chnget "osc1vol"
    gkosc1det chnget "osc1det"
    gkosc1detmix chnget "osc1detmix"
    gkosc1wid chnget "osc1wid"
    gkosc1voice chnget "osc1voice"
    gkosc1octave chnget "osc1octave"
    gkosc1semi chnget "osc1semi"
    gkosc1cent chnget "osc1cent"
    gkosc1pan chnget "osc1pan"
    gkosc1noise chnget "osc1noise"
        
    gkosc2wave1 chnget "osc2wave1_B"
    gkosc2wave2 chnget "osc2wave2_B"

    gkosc2morph chnget "osc2morph" 
    gkosc2vol chnget "osc2vol"
    gkosc2det chnget "osc2det"
    gkosc2wid chnget "osc2wid"
    gkosc2voice chnget "osc2voice"
    gkosc2octave chnget "osc2octave"
    gkosc2semi chnget "osc2semi"
    gkosc2cent chnget "osc2cent"
    gkosc2pan chnget "osc2pan"
    gkosc2noise chnget "osc2noise"
        
    gkosc3wave1 chnget "osc3wave1_B"
    gkosc3wave2 chnget "osc3wave2_B"
    gkosc3morph chnget "osc3morph" 
    gkosc3vol chnget "osc3vol"
    gkosc3det chnget "osc3det"
    gkosc3wid chnget "osc3wid"
    gkosc3voice chnget "osc3voice"
    gkosc3octave chnget "osc3octave"
    gkosc3semi chnget "osc3semi"
    gkosc3cent chnget "osc3cent"
    gkosc3pan chnget "osc3pan"
    gkosc3noise chnget "osc3noise"
    
    gkosc4wave1 chnget "osc4wave1_B"
    gkosc4wave2 chnget "osc4wave2_B"
    gkosc4morph chnget "osc4morph" 
    gkosc4vol chnget "osc4vol"
    gkosc4det chnget "osc4det"
    gkosc4wid chnget "osc4wid"
    gkosc4voice chnget "osc4voice"
    gkosc4octave chnget "osc4octave"
    gkosc4semi chnget "osc4semi"
    gkosc4cent chnget "osc4cent"
    gkosc4pan chnget "osc4pan"
    gkosc4noise chnget "osc4noise"    
    
    gkosc1lfoamp chnget "osc1lfoamp"
    gkosc1lfofreq chnget "osc1lfofreq"
    gkosc1lfoamnt chnget "osc1lfoamnt"
    
    gkpitchamnt chnget "pitchamnt"
    gkenvamt    chnget "envamt"
    
    gkfilter1mode1 chnget "filter1mode1_B"
    gkfilter1cut1 chnget "filter1cut1"
    gkfilter1cut1 /=156.25
    gkfilter1res1 chnget "filter1res1"
    gkfilter1keytrack1 chnget "filter1keytrack1"
    gkfilter1mode2 chnget "filter1mode2_B"
    gkfilter1cut2 chnget "filter1cut2"
    gkfilter1res2 chnget "filter1res2"
    gkfilter1keytrack2 chnget "filter1keytrack2"
    gkfilter1drive chnget "filter1drive"
            
    gkfilter1osc1 chnget "filter1osc1"
    gkfilter1osc2 chnget "filter1osc2"
    gkfilter1osc3 chnget "filter1osc3"
    gkfilter1osc4 chnget "filter1osc4"
    
    gkfilter2mode1 chnget "filter2mode1_B"
    gkfilter2cut1 chnget "filter2cut1"
    gkfilter2cut1 /=156.25
    gkfilter2res1 chnget "filter2res1"
    gkfilter2keytrack1 chnget "filter2keytrack1"
    gkfilter2mode2 chnget "filter2mode2_B"
    gkfilter2cut2 chnget "filter2cut2"
    gkfilter2res2 chnget "filter2res2"
    gkfilter2keytrack2 chnget "filter2keytrack2"
    gkfilter2drive chnget "filter2drive"
    
    gkfilter2osc1 chnget "filter2osc1"
    gkfilter2osc2 chnget "filter2osc2"
    gkfilter2osc3 chnget "filter2osc3"
    gkfilter2osc4 chnget "filter2osc4"
   
    gklfo1shape chnget "lfo1shape_B"
    gklfo1gain chnget "lfo1gain"
    gklfo1rate chnget "lfo1rate"
    gklfo1mult chnget "lfo1mult"
    gklfo1bpm chnget "lfo1bpm"
    gklfo1musical chnget "lfo1musical"
    gklfo1amt chnget "lfo1amt"
    gklfo1amt/=100
    gklfo1audiorate chnget "lfo1audiorate"
    
    gklfo2shape chnget "lfo2shape_B"
    gklfo2gain chnget "lfo2gain"
    gklfo2rate chnget "lfo2rate"
    gklfo2mult chnget "lfo2mult"
    gklfo2bpm chnget "lfo2bpm"
    gklfo2musical chnget "lfo2musical"
    gklfo2amt chnget "lfo2amt"
    gklfo2amt/=100
    gklfo2audiorate chnget "lfo2audiorate" 
      
    gklfo1osc1 chnget "lfo1osc1"
    gklfo1osc2 chnget "lfo1osc2"
    gklfo1osc3 chnget "lfo1osc3"
    gklfo1osc4 chnget "lfo1osc4"
    
    gklfo2osc1 chnget "lfo2osc1"
    gklfo2osc2 chnget "lfo2osc2"
    gklfo2osc3 chnget "lfo2osc3"
    gklfo2osc4 chnget "lfo2osc4"
    
    gklfoarate chnget "lfoarate"
    
    gkenv1a chnget "env1a"
    gkenv1d chnget "env1d"
    gkenv1s chnget "env1s"
    gkenv1r chnget "env1r"

    gkenv2a chnget "env2a"
    gkenv2d chnget "env2d"
    gkenv2s chnget "env2s"
    gkenv2r chnget "env2r"

    gkenv3a chnget "env3a"
    gkenv3d chnget "env3d"
    gkenv3s chnget "env3s"
    gkenv3r chnget "env3r"

    gkenv4a chnget "env4a"
    gkenv4d chnget "env4d"
    gkenv4s chnget "env4s"
    gkenv4r chnget "env4r"

    gkGlide chnget "SAGlide"
    

    if changed2:k(chnget:S("saveFile")) == 1 then
        gSFileName chnget "saveFile"
        event "i", 1003, 0, .1 
    endif

    if changed:k(chnget:S("openFile")) == 1 then
        reinit PRESLOAD2
            ;Custom made preset-system : restore a ToneZ preset from a .tzp or .tzp2 file
            PRESLOAD2:
            gSFileName chnget "openFile"
            Swext cabbageGetFileExtension gSFileName
            ;Check is not canceled
            iInit strcmp gSFileName, "."
            if iInit == 1 then
                icomp strcmp Swext, ".tzp2" ;ToneZ v2 preset
                if icomp == 0 then
                    event "i", 1007, 0, .1
                endif
                icomp strcmp Swext, ".tzp" ;ToneZ v1 preset
                if icomp == 0 then
                    event "i", 1008, 0, .1
                endif
                ;label updater
                ires strindex gSFileName, "dummy"
                if ires !=0 then
                    gSFileNameLastUsed = gSFileName
                    Snamenoext_file cabbageGetFileNoExtension gSFileName
                    Smessage sprintf "text(\"%s\")",Snamenoext_file
                    chnset Smessage, "PresetName"
                    //chnset Smessage, "PresetStringI"
                    cabbageSetStateValue "PresetNameSave", Snamenoext_file
                    chnset "active(1)","reloadI"   
                endif
                chnset "dummy","saveFile"
            endif
            chnset "populate(\"*.tzp2;*.tzp\")", "boxI"
        rireturn
    endif

    if changed2:k(chnget:S("box")) == 1 then
        reinit PRESLOAD3
        ;Custom made preset-system : restore a ToneZ preset from a .tzp or .tzp2 file
        PRESLOAD3:
        gSFileName chnget "box"
        Swext cabbageGetFileExtension gSFileName
        ;Check is not canceled
        iInit strcmp gSFileName, "."
        if iInit == 1 then
            icomp strcmp Swext, ".tzp2" ;ToneZ v2 preset
            if icomp == 0 then
                event "i", 1007, 0, .1
            endif
            icomp strcmp Swext, ".tzp" ;ToneZ v1 preset
            if icomp == 0 then
                event "i", 1008, 0, .1
            endif
            ;label updater
            ires strindex gSFileName, "dummy"
            if ires !=0 then
                gSFileNameLastUsed = gSFileName
                Snamenoext_file cabbageGetFileNoExtension gSFileName
                Smessage sprintf "text(\"%s\")",Snamenoext_file
                chnset Smessage, "PresetName"
                cabbageSetStateValue "PresetNameSave", Snamenoext_file
                chnset "active(1)","reloadI"   
            endif
            chnset "dummy","saveFile"
        endif
        chnset "populate(\"*.tzp2;*.tzp\")", "boxI"     
        rireturn
    endif   
    
    if changed:k(chnget:S("opendir")) == 1 then
        gSpath chnget "opendir"
        event "i", 1004, 0, .1
    endif
    
    
    if changed2:k(chnget:k("reload")) == 1 then
        reinit PRESLOAD4
        PRESLOAD4:
            gSFileName = gSFileNameLastUsed 
            ;Check is not canceled
            iInit strcmp gSFileName, "."
            if iInit == 1 then
                Swext cabbageGetFileExtension gSFileName
                icomp strcmp Swext, ".tzp2" ;ToneZ v2 preset
                if icomp == 0 then
                    event "i", 1007, 0, .1
                endif
                icomp strcmp Swext, ".tzp" ;ToneZ v1 preset
                if icomp == 0 then
                    event "i", 1008, 0, .1
                endif
            endif
        rireturn
    endif

    ;CUSTOM WAVEFORM MANAGER
    if changed:k(chnget:S("WFM_Open_1")) == 1 then
        gSFileName2 chnget "WFM_Open_1"      
        event "i", 2001, 0, .1
    endif
    
    if changed:k(chnget:S("WFM_Save_1")) == 1 then
        gSFileName2 chnget "WFM_Save_1"   
        event "i", 2003, 0, .1, 1
    endif
    
    if changed2:k(chnget:S("WFM_List_1")) == 1 then
        gSFileName2 chnget "WFM_List_1"     
        event "i", 2001, 0, .1
    endif
    
    if changed:k(chnget:k("WFM_Reset_1")) == 1 then
              event "i", 2001, 0, .1, 2
    endif
      
    if changed:k(chnget:S("WFM_Open_2")) == 1 then
        gSFileName2 chnget "WFM_Open_2"       
        event "i", 2002, 0, .1
    endif
    
    if changed:k(chnget:S("WFM_Save_2")) == 1 then
        gSFileName2 chnget "WFM_Save_2"   
        event "i", 2003, 0, .1, 2
    endif

    if changed2:k(chnget:S("WFM_List_2")) == 1 then
        gSFileName2 chnget "WFM_List_2"      
        event "i", 2002, 0, .1
    endif
    
    if changed:k(chnget:k("WFM_Reset_2")) == 1 then
          event "i", 2002, 0, .1, 2
    endif

    if changed:k(chnget:k("WFM_WAV_Clear")) == 1 then        
        event "i", 2000, 0, .1, 2
    endif

    if changed:k(chnget:S("WFM_Open_WAV")) == 1 then
        gSWaveName chnget "WFM_Open_WAV"        
        event "i", 2000, 0, .1, 1
    endif
    
    if changed:k(chnget:k("WFM_WAV_Size")) == 1 || changed:k(chnget:k("WFM_WAV_Start")) == 1  then
        event "i", 2000, 0, .1, 0
    endif
    
    if changed:k(chnget:k("WFM_WAVtoWF1")) == 1 then
        event "i", "WAVtoWF", 0, .1, 1
        
    endif
   
    if changed:k(chnget:k("WFM_WAVtoWF2")) == 1 then
        event "i", "WAVtoWF", 0, .1, 2
    endif

endin




;//MIDI waveguide from Iain Mc Curdy examples
instr	2	;triggered via MIDI
    gkNoteTrig init 1
    givel		veloc	0,1	;read in midi note velocity
    gknum	=	p4		;update a global krate variable for note pitch
    ipbrange chnget "pbrange"
    ipbrange*=100
    gkpb pchbend 0, ipbrange

    if i(gkmonopoly)==0 then		;if we are *not* in legato mode...
        
    knum	=	p4		 		;pitch equal to the original note pitch
    ivel	init	givel
    kvel = ivel

    asuml,asumr ToneZ knum,kvel,gkpb, 0 
           
    chnmix asuml, "outputL"
    chnmix asumr, "outputR"

    else				;otherwise... (i.e. legato mode)
        
        iactive	=	i(gkactive)			;number of active notes of instr 3 (note in release are disregarded)
        if iactive==0 then					;...if no notes are active
            event_i	"i",p1+1,0,-1				;...start a new held note
        endif
    endif
endin



instr	3	;waveguide instrument. MIDI notes are directed here.
;*******************************************************************************LEGATO*********************************************	
    kporttime	linseg	0,0.001,1		;portamento time function rises quickly from zero to a held value
    kporttime	=	kporttime*gkLegTim	;scale portamento time function with value from GUI knob widget

    krel	release					;sense when  note has been released
    gkactive	=	1-krel			;if note is in release, gkactive=0, otherwise =1


    iold = i(gkoldnum)
    if gkGlide==1 && iold!=0 then
        knum	SsplinePort	gkoldnum,kporttime,2,0	;GLISSANDO TIME PROPORTIONAL TO NOTE GAP (OPTION SET TO '1'), THEREFORE PORTAMENTO TIME DEPENDENT UPON NOTE GAP. LARGER INTERVALS WILL RESULT IN PROPORTIONALLY LONGER PORTAMENTO TIMES.
	else
	    knum	SsplinePort	gknum,kporttime,2,0
	    
	endif
	gkoldnum = gknum
	
    kactive	active	p1-1			;...check number of active midi notes (previous instrument)
    if kactive==0 then				;if no midi notes are active...
        turnoff					;... turn this instrument off
    endif
    
    ivel	init	givel
    kvel = ivel


    asuml,asumr ToneZ knum,kvel,gkpb, gkNoteTrig 
          
    
    chnmix asuml, "outputL"
    chnmix asumr, "outputR"
endin


instr 6 ;Updater for preset name label  
    schedule 4005, 0.2, 1
endin

instr EFFECT    
    asigL chnget "outputL"
    asigR chnget "outputR"
    denorm asigL,asigR
    ascL = asigL
    ascR = asigR
    
    asigL, asigR ToneZ_FX_DIST asigL, asigR 
    asigL, asigR ToneZ_FX_CHORUS asigL, asigR
    asigL, asigR ToneZ_FX_EQ asigL, asigR
    
    if chnget:i("delrevorder") == 0 then
        asigL, asigR ToneZ_FX_REV asigL, asigR, ascL, ascR
        
        asigL, asigR ToneZ_FX_DEL asigL, asigR
    else
        asigL, asigR ToneZ_FX_DEL asigL, asigR
        asigL, asigR ToneZ_FX_REV asigL, asigR, ascL, ascR
    endif
    
    asigL, asigR ToneZ_FX_COMP asigL, asigR
    
    ktrig	metro	60					;refresh 60 times per second
    kvalL	max_k	asigL*gkMasterVolume/500, ktrig, 1
    kvalR	max_k	asigR*gkMasterVolume/500, ktrig, 1
    
    kvallogL = log(kvalL* (20-1)+1) / (log(20))
    kvallogR = log(kvalR* (20-1)+1) / (log(20))
    
    outs		asigL*gkMasterVolume*0.3/100, asigR*gkMasterVolume*0.3/100

    chnset kvallogL, "vMeterL"
    chnset kvallogR, "vMeterR"
    
    chnclear "outputL"
    chnclear "outputR"


    chnclear "outputL"
    chnclear "outputR"
endin






;===============================================
instr 1003 ;save presets
        ;Check if not canceled
        iInit strcmp gSFileName, "."
        iDummy strcmp gSFileName, "dummy"
        if iDummy == 0 then
            prints ">>Save button set to 'dummy'\n"
            goto SKIPDUMMY
        endif
        
        if iInit == 1 then
            ;If file extension is missing, add it
            if strrindex(gSFileName, ".tzp2") == -1 then
                gSFileName strcat gSFileName, ".tzp2"
            endif

            tablew 200, 0, gi_paramarray ;ToneZ version 200 = v2.0.0
            tablew chnget:i("pbrange"), 1, gi_paramarray
            tablew chnget:i("MasterVol"),2, gi_paramarray
            tablew chnget:i("detstyle0"),3, gi_paramarray
            tablew chnget:i("detstyle1"),4, gi_paramarray
            tablew chnget:i("detstyle2"),5, gi_paramarray
            tablew chnget:i("detstyle3"),6, gi_paramarray
            tablew chnget:i("detsh1"),7, gi_paramarray
            tablew chnget:i("detsh2"),8, gi_paramarray
            tablew chnget:i("detsh3"),9, gi_paramarray
            tablew chnget:i("detsh4"),10, gi_paramarray
            tablew chnget:i("detmix"),11, gi_paramarray
            tablew chnget:i("monopoly"),12, gi_paramarray
            tablew chnget:i("LegTim"),13, gi_paramarray
            tablew chnget:i("SARetrig"),14, gi_paramarray
            tablew chnget:i("SAGlide"),15, gi_paramarray
            tablew chnget:i("osc1wave1_B"),16, gi_paramarray
            tablew chnget:i("osc1wave2_B"),17, gi_paramarray
            tablew chnget:i("osc1morph"),18, gi_paramarray
            tablew chnget:i("osc1vol"),19, gi_paramarray
            tablew chnget:i("osc1det"),20, gi_paramarray
            tablew chnget:i("osc1wid"),21, gi_paramarray
            tablew chnget:i("osc1phase"),22, gi_paramarray
            tablew chnget:i("osc1voice"),23, gi_paramarray
            tablew chnget:i("osc1octave"),24, gi_paramarray
            tablew chnget:i("osc1semi"),25, gi_paramarray
            tablew chnget:i("osc1cent"),26, gi_paramarray
            tablew chnget:i("osc1retrig"),27, gi_paramarray
            tablew chnget:i("osc1pan"),28, gi_paramarray
            tablew chnget:i("osc1noise"),29, gi_paramarray
            tablew chnget:i("osc2wave1_B"),30, gi_paramarray
            tablew chnget:i("osc2wave2_B"),31, gi_paramarray
            tablew chnget:i("osc2morph"),32, gi_paramarray
            tablew chnget:i("osc2vol"),33, gi_paramarray
            tablew chnget:i("osc2det"),34, gi_paramarray
            tablew chnget:i("osc2wid"),35, gi_paramarray
            tablew chnget:i("osc2phase"),36, gi_paramarray
            tablew chnget:i("osc2voice"),37, gi_paramarray
            tablew chnget:i("osc2octave"),38, gi_paramarray
            tablew chnget:i("osc2semi"),39, gi_paramarray
            tablew chnget:i("osc2cent"),40, gi_paramarray
            tablew chnget:i("osc2retrig"),41, gi_paramarray
            tablew chnget:i("osc2pan"),42, gi_paramarray
            tablew chnget:i("osc2noise"),43, gi_paramarray
            tablew chnget:i("osc3wave1_B"),44, gi_paramarray
            tablew chnget:i("osc3wave2_B"),45, gi_paramarray
            tablew chnget:i("osc3morph"),46, gi_paramarray
            tablew chnget:i("osc3vol"),47, gi_paramarray
            tablew chnget:i("osc3det"),48, gi_paramarray
            tablew chnget:i("osc3wid"),49, gi_paramarray
            tablew chnget:i("osc3phase"),50, gi_paramarray
            tablew chnget:i("osc3voice"),51, gi_paramarray
            tablew chnget:i("osc3octave"),52, gi_paramarray
            tablew chnget:i("osc3semi"),53, gi_paramarray
            tablew chnget:i("osc3cent"),54, gi_paramarray
            tablew chnget:i("osc3retrig"),55, gi_paramarray
            tablew chnget:i("osc3pan"),56, gi_paramarray
            tablew chnget:i("osc3noise"),57, gi_paramarray
            tablew chnget:i("osc4wave1_B"),58, gi_paramarray
            tablew chnget:i("osc4wave2_B"),59, gi_paramarray
            tablew chnget:i("osc4morph"),60, gi_paramarray
            tablew chnget:i("osc4vol"),61, gi_paramarray
            tablew chnget:i("osc4det"),62, gi_paramarray
            tablew chnget:i("osc4wid"),63, gi_paramarray
            tablew chnget:i("osc4phase"),64, gi_paramarray
            tablew chnget:i("osc4voice"),65, gi_paramarray
            tablew chnget:i("osc4octave"),66, gi_paramarray
            tablew chnget:i("osc4semi"),67, gi_paramarray
            tablew chnget:i("osc4cent"),68, gi_paramarray
            tablew chnget:i("osc4retrig"),69, gi_paramarray
            tablew chnget:i("osc4pan"),70, gi_paramarray
            tablew chnget:i("osc4noise"),71, gi_paramarray
            tablew chnget:i("OSC1_BUTTON"),72, gi_paramarray
            tablew chnget:i("OSC2_BUTTON"),73, gi_paramarray
            tablew chnget:i("OSC3_BUTTON"),74, gi_paramarray
            tablew chnget:i("OSC4_BUTTON"),75, gi_paramarray
            tablew chnget:i("env1a"),76, gi_paramarray
            tablew chnget:i("env1d"),77, gi_paramarray
            tablew chnget:i("env1s"),78, gi_paramarray
            tablew chnget:i("env1r"),79, gi_paramarray
            tablew chnget:i("env1amt"),80, gi_paramarray
            tablew chnget:i("env1curve_exp"),81, gi_paramarray
            tablew chnget:i("env1curve_lin"),82, gi_paramarray
            tablew chnget:i("env1curve_custom"),83, gi_paramarray
            tablew chnget:i("env1acurve"),84, gi_paramarray
            tablew chnget:i("env1dcurve"),85, gi_paramarray
            tablew chnget:i("env1rcurve"),86, gi_paramarray
            tablew chnget:i("env1osc1"),87, gi_paramarray
            tablew chnget:i("env1osc2"),88, gi_paramarray
            tablew chnget:i("env1osc3"),89, gi_paramarray
            tablew chnget:i("env1osc4"),90, gi_paramarray
            tablew chnget:i("env1amp"),91, gi_paramarray
            tablew chnget:i("env1pitch"),92, gi_paramarray
            tablew chnget:i("env1morph"),93, gi_paramarray
            tablew chnget:i("env1filter"),94, gi_paramarray
            tablew chnget:i("env1lfo"),95, gi_paramarray
            tablew chnget:i("env2a"),96, gi_paramarray
            tablew chnget:i("env2d"),97, gi_paramarray
            tablew chnget:i("env2s"),98, gi_paramarray
            tablew chnget:i("env2r"),99, gi_paramarray
            tablew chnget:i("env2amt"),100, gi_paramarray
            tablew chnget:i("env2curve_exp"),101, gi_paramarray
            tablew chnget:i("env2curve_lin"),102, gi_paramarray
            tablew chnget:i("env2curve_custom"),103, gi_paramarray
            tablew chnget:i("env2acurve"),104, gi_paramarray
            tablew chnget:i("env2dcurve"),105, gi_paramarray
            tablew chnget:i("env2rcurve"),106, gi_paramarray
            tablew chnget:i("env2osc1"),107, gi_paramarray
            tablew chnget:i("env2osc2"),108, gi_paramarray
            tablew chnget:i("env2osc3"),109, gi_paramarray
            tablew chnget:i("env2osc4"),110, gi_paramarray
            tablew chnget:i("env2amp"),111, gi_paramarray
            tablew chnget:i("env2pitch"),112, gi_paramarray
            tablew chnget:i("env2morph"),113, gi_paramarray
            tablew chnget:i("env2filter"),114, gi_paramarray
            tablew chnget:i("env2lfo"),115, gi_paramarray
            tablew chnget:i("env3a"),116, gi_paramarray
            tablew chnget:i("env3d"),117, gi_paramarray
            tablew chnget:i("env3s"),118, gi_paramarray
            tablew chnget:i("env3r"),119, gi_paramarray
            tablew chnget:i("env3amt"),120, gi_paramarray
            tablew chnget:i("env3curve_exp"),121, gi_paramarray
            tablew chnget:i("env3curve_lin"),122, gi_paramarray
            tablew chnget:i("env3curve_custom"),123, gi_paramarray
            tablew chnget:i("env3acurve"),124, gi_paramarray
            tablew chnget:i("env3dcurve"),125, gi_paramarray
            tablew chnget:i("env3rcurve"),126, gi_paramarray
            tablew chnget:i("env3osc1"),127, gi_paramarray
            tablew chnget:i("env3osc2"),128, gi_paramarray
            tablew chnget:i("env3osc3"),129, gi_paramarray
            tablew chnget:i("env3osc4"),130, gi_paramarray
            tablew chnget:i("env3amp"),131, gi_paramarray
            tablew chnget:i("env3pitch"),132, gi_paramarray
            tablew chnget:i("env3morph"),133, gi_paramarray
            tablew chnget:i("env3filter"),134, gi_paramarray
            tablew chnget:i("env3lfo"),135, gi_paramarray
            tablew chnget:i("env4a"),136, gi_paramarray
            tablew chnget:i("env4d"),137, gi_paramarray
            tablew chnget:i("env4s"),138, gi_paramarray
            tablew chnget:i("env4r"),139, gi_paramarray
            tablew chnget:i("env4amt"),140, gi_paramarray
            tablew chnget:i("env4curve_exp"),141, gi_paramarray
            tablew chnget:i("env4curve_lin"),142, gi_paramarray
            tablew chnget:i("env4curve_custom"),143, gi_paramarray
            tablew chnget:i("env4acurve"),144, gi_paramarray
            tablew chnget:i("env4dcurve"),145, gi_paramarray
            tablew chnget:i("env4rcurve"),146, gi_paramarray
            tablew chnget:i("env4osc1"),147, gi_paramarray
            tablew chnget:i("env4osc2"),148, gi_paramarray
            tablew chnget:i("env4osc3"),149, gi_paramarray
            tablew chnget:i("env4osc4"),150, gi_paramarray
            tablew chnget:i("env4amp"),151, gi_paramarray
            tablew chnget:i("env4pitch"),152, gi_paramarray
            tablew chnget:i("env4morph"),153, gi_paramarray
            tablew chnget:i("env4filter"),154, gi_paramarray
            tablew chnget:i("env4lfo"),155, gi_paramarray
            tablew chnget:i("ENV1_BUTTON"),156, gi_paramarray
            tablew chnget:i("ENV2_BUTTON"),157, gi_paramarray
            tablew chnget:i("ENV3_BUTTON"),158, gi_paramarray
            tablew chnget:i("ENV4_BUTTON"),159, gi_paramarray
            tablew chnget:i("lfo1shape_B"),160, gi_paramarray
            tablew chnget:i("lfo1gain"),161, gi_paramarray
            tablew chnget:i("lfo1rate"),162, gi_paramarray
            tablew chnget:i("lfo1amt"),163, gi_paramarray
            tablew chnget:i("lfo1mult"),164, gi_paramarray
            tablew chnget:i("lfo1bpm"),165, gi_paramarray
            tablew chnget:i("lfo1audiorate"),166, gi_paramarray
            tablew chnget:i("lfo1osc1"),167, gi_paramarray
            tablew chnget:i("lfo1osc2"),168, gi_paramarray
            tablew chnget:i("lfo1osc3"),169, gi_paramarray
            tablew chnget:i("lfo1osc4"),170, gi_paramarray
            tablew chnget:i("lfo1amp"),171, gi_paramarray
            tablew chnget:i("lfo1pitch"),172, gi_paramarray
            tablew chnget:i("lfo1morph"),173, gi_paramarray
            tablew chnget:i("lfo1filter"),174, gi_paramarray
            tablew chnget:i("lfo2shape_B"),175, gi_paramarray
            tablew chnget:i("lfo2gain"),176, gi_paramarray
            tablew chnget:i("lfo2rate"),177, gi_paramarray
            tablew chnget:i("lfo2amt"),178, gi_paramarray
            tablew chnget:i("lfo2mult"),179, gi_paramarray
            tablew chnget:i("lfo2bpm"),180, gi_paramarray
            tablew chnget:i("lfo2audiorate"),181, gi_paramarray
            tablew chnget:i("lfo2osc1"),182, gi_paramarray
            tablew chnget:i("lfo2osc2"),183, gi_paramarray
            tablew chnget:i("lfo2osc3"),184, gi_paramarray
            tablew chnget:i("lfo2osc4"),185, gi_paramarray
            tablew chnget:i("lfo2amp"),186, gi_paramarray
            tablew chnget:i("lfo2pitch"),187, gi_paramarray
            tablew chnget:i("lfo2morph"),188, gi_paramarray
            tablew chnget:i("lfo2filter"),189, gi_paramarray
            tablew chnget:i("LFO1_BUTTON"),190, gi_paramarray
            tablew chnget:i("LFO2_BUTTON"),191, gi_paramarray
            tablew chnget:i("filter1mode1_B"),192, gi_paramarray
            tablew chnget:i("filter1cut1"),193, gi_paramarray
            tablew chnget:i("filter1res1"),194, gi_paramarray
            tablew chnget:i("filter1keytrack1"),195, gi_paramarray
            tablew chnget:i("filter1mode2_B"),196, gi_paramarray
            tablew chnget:i("filter1cut2"),197, gi_paramarray
            tablew chnget:i("filter1res2"),198, gi_paramarray
            tablew chnget:i("filter1keytrack2"),199, gi_paramarray
            tablew chnget:i("filter1drive"),200, gi_paramarray
            tablew chnget:i("filter1osc1"),201, gi_paramarray
            tablew chnget:i("filter1osc2"),202, gi_paramarray
            tablew chnget:i("filter1osc3"),203, gi_paramarray
            tablew chnget:i("filter1osc4"),204, gi_paramarray
            tablew chnget:i("filter2mode1_B"),205, gi_paramarray
            tablew chnget:i("filter2cut1"),206, gi_paramarray
            tablew chnget:i("filter2res1"),207, gi_paramarray
            tablew chnget:i("filter2keytrack1"),208, gi_paramarray
            tablew chnget:i("filter2mode2_B"),209, gi_paramarray
            tablew chnget:i("filter2cut2"),210, gi_paramarray
            tablew chnget:i("filter2res2"),211, gi_paramarray
            tablew chnget:i("filter2keytrack2"),212, gi_paramarray
            tablew chnget:i("filter2drive"),213, gi_paramarray
            tablew chnget:i("filter2osc1"),214, gi_paramarray
            tablew chnget:i("filter2osc2"),215, gi_paramarray
            tablew chnget:i("filter2osc3"),216, gi_paramarray
            tablew chnget:i("filter2osc4"),217, gi_paramarray
            tablew chnget:i("filterP"),218, gi_paramarray
            tablew chnget:i("FILTER1_BUTTON"),219, gi_paramarray
            tablew chnget:i("FILTER2_BUTTON"),220, gi_paramarray
            tablew chnget:i("distswitch"),221, gi_paramarray
            tablew chnget:i("drywetdist"),222, gi_paramarray
            tablew chnget:i("distlevel"),223, gi_paramarray
            tablew chnget:i("distclip"),224, gi_paramarray
            tablew chnget:i("distpowershape"),225, gi_paramarray
            tablew chnget:i("distsaturator"),226, gi_paramarray
            tablew chnget:i("distbitcrusher"),227, gi_paramarray
            tablew chnget:i("distfoldover"),228, gi_paramarray
            tablew chnget:i("eqswitch"),229, gi_paramarray
            tablew chnget:i("dryweteq"),230, gi_paramarray
            tablew chnget:i("eqlevel"),231, gi_paramarray
            tablew chnget:i("eqlowfreq"),232, gi_paramarray
            tablew chnget:i("eqlowamp"),233, gi_paramarray
            tablew chnget:i("eqhighfreq"),234, gi_paramarray
            tablew chnget:i("eqhighamp"),235, gi_paramarray
            tablew chnget:i("eqmidfreq"),236, gi_paramarray
            tablew chnget:i("eqmidamp"),237, gi_paramarray
            tablew chnget:i("chorusswitch"),238, gi_paramarray
            tablew chnget:i("drywetchorus"),239, gi_paramarray
            tablew chnget:i("choruslevel"),240, gi_paramarray
            tablew chnget:i("chorusrate"),241, gi_paramarray
            tablew chnget:i("chorusdepth"),242, gi_paramarray
            tablew chnget:i("chorusoffset"),243, gi_paramarray
            tablew chnget:i("choruswidth"),244, gi_paramarray
            tablew chnget:i("chorusstereowidth"),245, gi_paramarray
            tablew chnget:i("chorusmode1"),246, gi_paramarray
            tablew chnget:i("chorusmode2"),247, gi_paramarray
            tablew chnget:i("chorusmode3"),248, gi_paramarray
            tablew chnget:i("delswitch"),249, gi_paramarray
            tablew chnget:i("deltempo"),250, gi_paramarray
            tablew chnget:i("delRhyMlt"),251, gi_paramarray
            tablew chnget:i("deldamp"),252, gi_paramarray
            tablew chnget:i("delfback"),253, gi_paramarray
            tablew chnget:i("delwidth"),254, gi_paramarray
            tablew chnget:i("delrevorder"),255, gi_paramarray
            tablew chnget:i("drywetdel"),256, gi_paramarray
            tablew chnget:i("dellevel"),257, gi_paramarray
            tablew chnget:i("revswitch"),258, gi_paramarray
            tablew chnget:i("revtype"),259, gi_paramarray
            tablew chnget:i("revsize"),260, gi_paramarray
            tablew chnget:i("revdel"),261, gi_paramarray
            tablew chnget:i("revdamp"),262, gi_paramarray
            tablew chnget:i("revpitchmod"),263, gi_paramarray
            tablew chnget:i("revwred"),264, gi_paramarray
            tablew chnget:i("revCutLPF"),265, gi_paramarray
            tablew chnget:i("revCutHPF"),266, gi_paramarray
            tablew chnget:i("drywetrev"),267, gi_paramarray
            tablew chnget:i("revlevel"),268, gi_paramarray
            tablew chnget:i("revSCswitch"),269, gi_paramarray
            tablew chnget:i("revSCthresh"),270, gi_paramarray
            tablew chnget:i("revSCrel"),271, gi_paramarray
            tablew chnget:i("compswitch"),272, gi_paramarray
            tablew chnget:i("compLowKnee"),273, gi_paramarray
            tablew chnget:i("compHighKnee"),274, gi_paramarray
            tablew chnget:i("compatt"),275, gi_paramarray
            tablew chnget:i("comprel"),276, gi_paramarray
            tablew chnget:i("compratio"),277, gi_paramarray
            tablew chnget:i("compgain"),278, gi_paramarray
            tablew chnget:i("drywetcomp"),279, gi_paramarray
            tablew chnget:i("EFFECT1_BUTTON"),280, gi_paramarray
            tablew chnget:i("EFFECT3_BUTTON"),281, gi_paramarray
            tablew chnget:i("EFFECT2_BUTTON"),282, gi_paramarray
            tablew chnget:i("EFFECT5_BUTTON"),283, gi_paramarray
            tablew chnget:i("EFFECT4_BUTTON"),284, gi_paramarray
            tablew chnget:i("EFFECT6_BUTTON"),285, gi_paramarray
            tablew chnget:i("lfo1musical"),286, gi_paramarray
            tablew chnget:i("lfo2musical"),287, gi_paramarray
            tablew chnget:i("distcarac"),288, gi_paramarray
        
            itablesize1 = table(1, gi_customwf_size)        
            i_temp1 ftgentmp 0, 0, itablesize1, 7, 0, itablesize1, 0
            vcopy_i  i_temp1, 21000, itablesize1, 0, 0
            
            itablesize2 = table(2, gi_customwf_size)        
            i_temp2 ftgentmp 0, 0, itablesize2, 7, 0, itablesize2, 0
            vcopy_i  i_temp2, 22000, itablesize2, 0, 0
            
            ;Save parameters ftable + customwf to the file
            ires strindex gSFileName, "dummy"
            if ires !=0 then
                ftsave gSFileName, 1, 30000, i_temp1, i_temp2
            endif
        
        
            ires strindex gSFileName, "dummy"
            if ires !=0 then
                gSFileNameLastUsed = gSFileName
                Snamenoext_file cabbageGetFileNoExtension gSFileName
                Smessage sprintf "text(\"%s\")",Snamenoext_file
                chnset Smessage, "PresetName"
                cabbageSetStateValue "PresetNameSave", Snamenoext_file
                chnset "active(1)","reloadI"   
            endif
            prints "Saving ToneZ V2 preset to : "
            prints gSFileName
            prints "\n"
            chnset "dummy","saveFile"
            chnset "file(\"dummy\")","saveFileI"
        endif
        chnset "populate(\"*.tzp2;*.tzp\")", "boxI"
        SKIPDUMMY:
    ;chnset "dummy","saveFile" ; Tricks used to be able to save 2 times the same file in a row (force the "saveFile" name to change)
endin


instr 1004 ;Updater for path (may no longer be useful)
    Smessage sprintfk "populate(\"*.tzp2;*.tzp\",\"%s\")",gSpath
    chnset Smessage, "boxI"
    Smessage2 sprintfk "text(%s)",gSpath
    chnset Smessage2,"PathTextI"
endin

opcode noquote, S,S
Sin xin
inamelen strlen Sin
    
    if inamelen > 1 then
        Sout strsub Sin, 1, inamelen-1       
    else
        Sout = "<No Preset>"
    endif 

xout Sout

endop

instr 4005 ; Actual instrument for preset name update
    Sname cabbageGetStateValue "PresetNameSave"
    Snameshort = noquote(Sname)    
    Smes sprintf "text(\"%s\")",Snameshort 
    chnset Smes,"PresetName"
    turnoff
endin

instr 1007 ; ToneZ v2 preset loader
    prints "loading "
    prints gSFileName
    prints "\n***This is a ToneZ v2 preset***\n"
    i_customwf1_temp ftgentmp 0, 0, 8192, 7, 0, 8192, 0 //max size allowed = 8192
    i_customwf2_temp ftgentmp 0, 0, 8192, 7, 0, 8192, 0 //max size allowed = 8192
    ftload gSFileName, 1, 30000, i_customwf1_temp, i_customwf2_temp
            
    iVersion = table(0, gi_paramarray)
    print iVersion
            
    if iVersion == 200 then
        //if needed for future version, to ensure ToneZ v2.0.0 sounds the same if changes made in the future.
    endif
            
    chnset table(1, gi_paramarray), "pbrange"
    chnset table(2, gi_paramarray), "MasterVol"
    chnset table(3, gi_paramarray), "detstyle0"
    chnset table(4, gi_paramarray), "detstyle1"
    chnset table(5, gi_paramarray), "detstyle2"
    chnset table(6, gi_paramarray), "detstyle3"
    chnset table(7, gi_paramarray), "detsh1"
    chnset table(8, gi_paramarray), "detsh2"
    chnset table(9, gi_paramarray), "detsh3"
    chnset table(10, gi_paramarray), "detsh4"
    chnset table(11, gi_paramarray), "detmix"
    chnset table(12, gi_paramarray), "monopoly"
    chnset table(13, gi_paramarray), "LegTim"
    chnset table(14, gi_paramarray), "SARetrig"
    chnset table(15, gi_paramarray), "SAGlide"
    chnset table(16, gi_paramarray), "osc1wave1_B"
    chnset table(17, gi_paramarray), "osc1wave2_B"
    chnset table(18, gi_paramarray), "osc1morph"
    chnset table(19, gi_paramarray), "osc1vol"
    chnset table(20, gi_paramarray), "osc1det"
    chnset table(21, gi_paramarray), "osc1wid"
    chnset table(22, gi_paramarray), "osc1phase"
    chnset table(23, gi_paramarray), "osc1voice"
    chnset table(24, gi_paramarray), "osc1octave"
    chnset table(25, gi_paramarray), "osc1semi"
    chnset table(26, gi_paramarray), "osc1cent"
    chnset table(27, gi_paramarray), "osc1retrig"
    chnset table(28, gi_paramarray), "osc1pan"
    chnset table(29, gi_paramarray), "osc1noise"
    chnset table(30, gi_paramarray), "osc2wave1_B"
    chnset table(31, gi_paramarray), "osc2wave2_B"
    chnset table(32, gi_paramarray), "osc2morph"
    chnset table(33, gi_paramarray), "osc2vol"
    chnset table(34, gi_paramarray), "osc2det"
    chnset table(35, gi_paramarray), "osc2wid"
    chnset table(36, gi_paramarray), "osc2phase"
    chnset table(37, gi_paramarray), "osc2voice"
    chnset table(38, gi_paramarray), "osc2octave"
    chnset table(39, gi_paramarray), "osc2semi"
    chnset table(40, gi_paramarray), "osc2cent"
    chnset table(41, gi_paramarray), "osc2retrig"
    chnset table(42, gi_paramarray), "osc2pan"
    chnset table(43, gi_paramarray), "osc2noise"
    chnset table(44, gi_paramarray), "osc3wave1_B"
    chnset table(45, gi_paramarray), "osc3wave2_B"
    chnset table(46, gi_paramarray), "osc3morph"
    chnset table(47, gi_paramarray), "osc3vol"
    chnset table(48, gi_paramarray), "osc3det"
    chnset table(49, gi_paramarray), "osc3wid"
    chnset table(50, gi_paramarray), "osc3phase"
    chnset table(51, gi_paramarray), "osc3voice"
    chnset table(52, gi_paramarray), "osc3octave"
    chnset table(53, gi_paramarray), "osc3semi"
    chnset table(54, gi_paramarray), "osc3cent"
    chnset table(55, gi_paramarray), "osc3retrig"
    chnset table(56, gi_paramarray), "osc3pan"
    chnset table(57, gi_paramarray), "osc3noise"
    chnset table(58, gi_paramarray), "osc4wave1_B"
    chnset table(59, gi_paramarray), "osc4wave2_B"
    chnset table(60, gi_paramarray), "osc4morph"
    chnset table(61, gi_paramarray), "osc4vol"
    chnset table(62, gi_paramarray), "osc4det"
    chnset table(63, gi_paramarray), "osc4wid"
    chnset table(64, gi_paramarray), "osc4phase"
    chnset table(65, gi_paramarray), "osc4voice"
    chnset table(66, gi_paramarray), "osc4octave"
    chnset table(67, gi_paramarray), "osc4semi"
    chnset table(68, gi_paramarray), "osc4cent"
    chnset table(69, gi_paramarray), "osc4retrig"
    chnset table(70, gi_paramarray), "osc4pan"
    chnset table(71, gi_paramarray), "osc4noise"
    chnset table(72, gi_paramarray), "OSC1_BUTTON"
    chnset table(73, gi_paramarray), "OSC2_BUTTON"
    chnset table(74, gi_paramarray), "OSC3_BUTTON"
    chnset table(75, gi_paramarray), "OSC4_BUTTON"
    chnset table(76, gi_paramarray), "env1a"
    chnset table(77, gi_paramarray), "env1d"
    chnset table(78, gi_paramarray), "env1s"
    chnset table(79, gi_paramarray), "env1r"
    chnset table(80, gi_paramarray), "env1amt"
    chnset table(81, gi_paramarray), "env1curve_exp"
    chnset table(82, gi_paramarray), "env1curve_lin"
    chnset table(83, gi_paramarray), "env1curve_custom"
    chnset table(84, gi_paramarray), "env1acurve"
    chnset table(85, gi_paramarray), "env1dcurve"
    chnset table(86, gi_paramarray), "env1rcurve"
    chnset table(87, gi_paramarray), "env1osc1"
    chnset table(88, gi_paramarray), "env1osc2"
    chnset table(89, gi_paramarray), "env1osc3"
    chnset table(90, gi_paramarray), "env1osc4"
    chnset table(91, gi_paramarray), "env1amp"
    chnset table(92, gi_paramarray), "env1pitch"
    chnset table(93, gi_paramarray), "env1morph"
    chnset table(94, gi_paramarray), "env1filter"
    chnset table(95, gi_paramarray), "env1lfo"
    chnset table(96, gi_paramarray), "env2a"
    chnset table(97, gi_paramarray), "env2d"
    chnset table(98, gi_paramarray), "env2s"
    chnset table(99, gi_paramarray), "env2r"
    chnset table(100, gi_paramarray), "env2amt"
    chnset table(101, gi_paramarray), "env2curve_exp"
    chnset table(102, gi_paramarray), "env2curve_lin"
    chnset table(103, gi_paramarray), "env2curve_custom"
    chnset table(104, gi_paramarray), "env2acurve"
    chnset table(105, gi_paramarray), "env2dcurve"
    chnset table(106, gi_paramarray), "env2rcurve"
    chnset table(107, gi_paramarray), "env2osc1"
    chnset table(108, gi_paramarray), "env2osc2"
    chnset table(109, gi_paramarray), "env2osc3"
    chnset table(110, gi_paramarray), "env2osc4"
    chnset table(111, gi_paramarray), "env2amp"
    chnset table(112, gi_paramarray), "env2pitch"
    chnset table(113, gi_paramarray), "env2morph"
    chnset table(114, gi_paramarray), "env2filter"
    chnset table(115, gi_paramarray), "env2lfo"
    chnset table(116, gi_paramarray), "env3a"
    chnset table(117, gi_paramarray), "env3d"
    chnset table(118, gi_paramarray), "env3s"
    chnset table(119, gi_paramarray), "env3r"
    chnset table(120, gi_paramarray), "env3amt"
    chnset table(121, gi_paramarray), "env3curve_exp"
    chnset table(122, gi_paramarray), "env3curve_lin"
    chnset table(123, gi_paramarray), "env3curve_custom"
    chnset table(124, gi_paramarray), "env3acurve"
    chnset table(125, gi_paramarray), "env3dcurve"
    chnset table(126, gi_paramarray), "env3rcurve"
    chnset table(127, gi_paramarray), "env3osc1"
    chnset table(128, gi_paramarray), "env3osc2"
    chnset table(129, gi_paramarray), "env3osc3"
    chnset table(130, gi_paramarray), "env3osc4"
    chnset table(131, gi_paramarray), "env3amp"
    chnset table(132, gi_paramarray), "env3pitch"
    chnset table(133, gi_paramarray), "env3morph"
    chnset table(134, gi_paramarray), "env3filter"
    chnset table(135, gi_paramarray), "env3lfo"
    chnset table(136, gi_paramarray), "env4a"
    chnset table(137, gi_paramarray), "env4d"
    chnset table(138, gi_paramarray), "env4s"
    chnset table(139, gi_paramarray), "env4r"
    chnset table(140, gi_paramarray), "env4amt"
    chnset table(141, gi_paramarray), "env4curve_exp"
    chnset table(142, gi_paramarray), "env4curve_lin"
    chnset table(143, gi_paramarray), "env4curve_custom"
    chnset table(144, gi_paramarray), "env4acurve"
    chnset table(145, gi_paramarray), "env4dcurve"
    chnset table(146, gi_paramarray), "env4rcurve"
    chnset table(147, gi_paramarray), "env4osc1"
    chnset table(148, gi_paramarray), "env4osc2"
    chnset table(149, gi_paramarray), "env4osc3"
    chnset table(150, gi_paramarray), "env4osc4"
    chnset table(151, gi_paramarray), "env4amp"
    chnset table(152, gi_paramarray), "env4pitch"
    chnset table(153, gi_paramarray), "env4morph"
    chnset table(154, gi_paramarray), "env4filter"
    chnset table(155, gi_paramarray), "env4lfo"
    chnset table(156, gi_paramarray), "ENV1_BUTTON"
    chnset table(157, gi_paramarray), "ENV2_BUTTON"
    chnset table(158, gi_paramarray), "ENV3_BUTTON"
    chnset table(159, gi_paramarray), "ENV4_BUTTON"
    chnset table(160, gi_paramarray), "lfo1shape_B"
    chnset table(161, gi_paramarray), "lfo1gain"
    chnset table(162, gi_paramarray), "lfo1rate"
    chnset table(163, gi_paramarray), "lfo1amt"
    chnset table(164, gi_paramarray), "lfo1mult"
    chnset table(165, gi_paramarray), "lfo1bpm"
    chnset table(166, gi_paramarray), "lfo1audiorate"
    chnset table(167, gi_paramarray), "lfo1osc1"
    chnset table(168, gi_paramarray), "lfo1osc2"
    chnset table(169, gi_paramarray), "lfo1osc3"
    chnset table(170, gi_paramarray), "lfo1osc4"
    chnset table(171, gi_paramarray), "lfo1amp"
    chnset table(172, gi_paramarray), "lfo1pitch"
    chnset table(173, gi_paramarray), "lfo1morph"
    chnset table(174, gi_paramarray), "lfo1filter"
    chnset table(175, gi_paramarray), "lfo2shape_B"
    chnset table(176, gi_paramarray), "lfo2gain"
    chnset table(177, gi_paramarray), "lfo2rate"
    chnset table(178, gi_paramarray), "lfo2amt"
    chnset table(179, gi_paramarray), "lfo2mult"
    chnset table(180, gi_paramarray), "lfo2bpm"
    chnset table(181, gi_paramarray), "lfo2audiorate"
    chnset table(182, gi_paramarray), "lfo2osc1"
    chnset table(183, gi_paramarray), "lfo2osc2"
    chnset table(184, gi_paramarray), "lfo2osc3"
    chnset table(185, gi_paramarray), "lfo2osc4"
    chnset table(186, gi_paramarray), "lfo2amp"
    chnset table(187, gi_paramarray), "lfo2pitch"
    chnset table(188, gi_paramarray), "lfo2morph"
    chnset table(189, gi_paramarray), "lfo2filter"
    chnset table(190, gi_paramarray), "LFO1_BUTTON"
    chnset table(191, gi_paramarray), "LFO2_BUTTON"
    chnset table(192, gi_paramarray), "filter1mode1_B"
    chnset table(193, gi_paramarray), "filter1cut1"
    chnset table(194, gi_paramarray), "filter1res1"
    chnset table(195, gi_paramarray), "filter1keytrack1"
    chnset table(196, gi_paramarray), "filter1mode2_B"
    chnset table(197, gi_paramarray), "filter1cut2"
    chnset table(198, gi_paramarray), "filter1res2"
    chnset table(199, gi_paramarray), "filter1keytrack2"
    chnset table(200, gi_paramarray), "filter1drive"
    chnset table(201, gi_paramarray), "filter1osc1"
    chnset table(202, gi_paramarray), "filter1osc2"
    chnset table(203, gi_paramarray), "filter1osc3"
    chnset table(204, gi_paramarray), "filter1osc4"
    chnset table(205, gi_paramarray), "filter2mode1_B"
    chnset table(206, gi_paramarray), "filter2cut1"
    chnset table(207, gi_paramarray), "filter2res1"
    chnset table(208, gi_paramarray), "filter2keytrack1"
    chnset table(209, gi_paramarray), "filter2mode2_B"
    chnset table(210, gi_paramarray), "filter2cut2"
    chnset table(211, gi_paramarray), "filter2res2"
    chnset table(212, gi_paramarray), "filter2keytrack2"
    chnset table(213, gi_paramarray), "filter2drive"
    chnset table(214, gi_paramarray), "filter2osc1"
    chnset table(215, gi_paramarray), "filter2osc2"
    chnset table(216, gi_paramarray), "filter2osc3"
    chnset table(217, gi_paramarray), "filter2osc4"
    chnset table(218, gi_paramarray), "filterP"
    chnset table(219, gi_paramarray), "FILTER1_BUTTON"
    chnset table(220, gi_paramarray), "FILTER2_BUTTON"
    chnset table(221, gi_paramarray), "distswitch"
    chnset table(222, gi_paramarray), "drywetdist"
    chnset table(223, gi_paramarray), "distlevel"
    chnset table(224, gi_paramarray), "distclip"
    chnset table(225, gi_paramarray), "distpowershape"
    chnset table(226, gi_paramarray), "distsaturator"
    chnset table(227, gi_paramarray), "distbitcrusher"
    chnset table(228, gi_paramarray), "distfoldover"
    chnset table(229, gi_paramarray), "eqswitch"
    chnset table(230, gi_paramarray), "dryweteq"
    chnset table(231, gi_paramarray), "eqlevel"
    chnset table(232, gi_paramarray), "eqlowfreq"
    chnset table(233, gi_paramarray), "eqlowamp"
    chnset table(234, gi_paramarray), "eqhighfreq"
    chnset table(235, gi_paramarray), "eqhighamp"
    chnset table(236, gi_paramarray), "eqmidfreq"
    chnset table(237, gi_paramarray), "eqmidamp"
    chnset table(238, gi_paramarray), "chorusswitch"
    chnset table(239, gi_paramarray), "drywetchorus"
    chnset table(240, gi_paramarray), "choruslevel"
    chnset table(241, gi_paramarray), "chorusrate"
    chnset table(242, gi_paramarray), "chorusdepth"
    chnset table(243, gi_paramarray), "chorusoffset"
    chnset table(244, gi_paramarray), "choruswidth"
    chnset table(245, gi_paramarray), "chorusstereowidth"
    chnset table(246, gi_paramarray), "chorusmode1"
    chnset table(247, gi_paramarray), "chorusmode2"
    chnset table(248, gi_paramarray), "chorusmode3"
    chnset table(249, gi_paramarray), "delswitch"
    chnset table(250, gi_paramarray), "deltempo"
    chnset table(251, gi_paramarray), "delRhyMlt"
    chnset table(252, gi_paramarray), "deldamp"
    chnset table(253, gi_paramarray), "delfback"
    chnset table(254, gi_paramarray), "delwidth"
    chnset table(255, gi_paramarray), "delrevorder"
    chnset table(256, gi_paramarray), "drywetdel"
    chnset table(257, gi_paramarray), "dellevel"
    chnset table(258, gi_paramarray), "revswitch"
    chnset table(259, gi_paramarray), "revtype"
    chnset table(260, gi_paramarray), "revsize"
    chnset table(261, gi_paramarray), "revdel"
    chnset table(262, gi_paramarray), "revdamp"
    chnset table(263, gi_paramarray), "revpitchmod"
    chnset table(264, gi_paramarray), "revwred"
    chnset table(265, gi_paramarray), "revCutLPF"
    chnset table(266, gi_paramarray), "revCutHPF"
    chnset table(267, gi_paramarray), "drywetrev"
    chnset table(268, gi_paramarray), "revlevel"
    chnset table(269, gi_paramarray), "revSCswitch"
    chnset table(270, gi_paramarray), "revSCthresh"
    chnset table(271, gi_paramarray), "revSCrel"
    chnset table(272, gi_paramarray), "compswitch"
    chnset table(273, gi_paramarray), "compLowKnee"
    chnset table(274, gi_paramarray), "compHighKnee"
    chnset table(275, gi_paramarray), "compatt"
    chnset table(276, gi_paramarray), "comprel"
    chnset table(277, gi_paramarray), "compratio"
    chnset table(278, gi_paramarray), "compgain"
    chnset table(279, gi_paramarray), "drywetcomp"
    chnset table(280, gi_paramarray), "EFFECT1_BUTTON"
    chnset table(281, gi_paramarray), "EFFECT3_BUTTON"
    chnset table(282, gi_paramarray), "EFFECT2_BUTTON"
    chnset table(283, gi_paramarray), "EFFECT5_BUTTON"
    chnset table(284, gi_paramarray), "EFFECT4_BUTTON"
    chnset table(285, gi_paramarray), "EFFECT6_BUTTON"
    chnset table(286, gi_paramarray), "lfo1musical"
    chnset table(287, gi_paramarray), "lfo2musical"
    chnset table(288, gi_paramarray), "distcarac"

    ilen = ftlen(i_customwf1_temp)
    tablew ilen, 1, gi_customwf_size   
    ilen = ftlen(i_customwf2_temp)
    tablew ilen, 2, gi_customwf_size 
    if table(1, gi_customwf_size) == 4 then
        prints "\n***No Custom WF 1 found..***\n"
        clearStateWF 1
        chnset "alpha(0.1)", "idCUSTOM1_LED"
        ;Clear the custom table 1
        i_customwftemp_1 ftgentmp 4022, 0, 4, 7, 0, 4, 0 ;mini 4 sized table = no custom WF loaded         
        tablecopy 21000, i_customwf1_temp   
        Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",4,21000
        Schannel sprintfk "genTableWF%d",1
        chnset Smessage, Schannel        
        gi_nextfree21000 vco2init-i_customwftemp_1, i_customwftemp_1+1, 1.05, 128, 2^16, i_customwftemp_1
        gitable_bl21000 = -i_customwftemp_1
     
    else
        prints "\n***Custom WF 1 found !! (size = %d)***\n", table(1, gi_customwf_size)
        chnset "alpha(1)", "idCUSTOM1_LED"
        WF1_PRES_PROCESS:
        
        iTable11 ftgentmp   4022, 0, table(1, gi_customwf_size), 7, 0, table(1, gi_customwf_size), 0
                
        scanhammer  i_customwf1_temp,21000,0,1
        scanhammer  i_customwf1_temp,iTable11,0,1
        SaveStateWF 1, i_customwf1_temp        
        Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",table(1, gi_customwf_size),21000
        Schannel sprintfk "genTableWF%d",1
        chnset Smessage, Schannel
        
        gi_nextfree21000 vco2init-iTable11, iTable11+1, 1.05, 128, 2^16, iTable11
        gitable_bl21000 = -iTable11
    endif
            
    if table(2, gi_customwf_size) == 4 then
        prints "\n***No Custom WF 2 found..***\n"
        clearStateWF 2
        chnset "alpha(0.1)", "idCUSTOM2_LED"
        i_customwftemp_2 ftgentmp 3645, 0, 4, 7, 0, 4, 0 ;mini 4 sized table = no custom WF loaded
        tablecopy 22000, i_customwf2_temp   
        Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",4,22000
        Schannel sprintfk "genTableWF%d",2
        chnset Smessage, Schannel        
        gi_nextfree22000 vco2init-i_customwftemp_2, i_customwftemp_2+1, 1.05, 128, 2^16, i_customwftemp_2
        gitable_bl22000 = -i_customwftemp_2
        event "i", 3000, 0, 0
        event "i", "UPGENTABVIEWOSC",0,0
    else
        prints "\n***Custom WF 2 found !! (size = %d)***\n", table(2, gi_customwf_size)
        chnset "alpha(1)", "idCUSTOM2_LED"
        
        WF2_PRES_PROCESS:
        
        iTable22 ftgentmp   3645, 0, table(2, gi_customwf_size), 7, 0, table(2, gi_customwf_size), 0
                
        scanhammer  i_customwf2_temp,22000,0,1
        scanhammer  i_customwf2_temp,iTable22,0,1
        SaveStateWF 1, i_customwf2_temp        
        Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",table(2, gi_customwf_size),22000
        Schannel sprintfk "genTableWF%d",2
        chnset Smessage, Schannel
        
        gi_nextfree22000 vco2init-iTable22, iTable22+1, 1.05, 128, 2^16, iTable22
        gitable_bl22000 = -iTable22
    endif

    event "i", 3000, 0, 0
    event "i", "UPGENTABVIEWOSC",0,0
    prints "SIZE1 = %d, SIZE2 = %d\n",table(1, gi_customwf_size),table(2, gi_customwf_size)
endin

instr 1008 ; ToneZ v1 preset loader for backward compatibility
    prints "loading "
    prints gSFileName
    prints "\n***This is a ToneZ v1 preset***\n"
    chnset "alpha(0.1)", "idCUSTOM1_LED"
    chnset "alpha(0.1)", "idCUSTOM2_LED"

    i_customwftemp_1 ftgentmp 1937, 0, 4, 7, 0, 4, 0 ;mini 4 sized table = no custom WF loaded
    ilen = ftlen(i_customwftemp_1)  
    prints "\n***Custom WF 1 size = %d***\n", ilen
    Smessage sprintfk "alpha(%f)", ilen > 4 ? 1 : 0.1
    chnset Smessage, "idCUSTOM1_LED"
    tablecopy 21000, i_customwftemp_1
    tablew ilen, 1, gi_customwf_size
    Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",table(1, gi_customwf_size),21000
    Schannel sprintfk "genTableWF%d",1
    chnset Smessage, Schannel
            
    gi_nextfree21000 vco2init-i_customwftemp_1, i_customwftemp_1+1, 1.05, 128, 2^16, i_customwftemp_1
    gitable_bl21000 = -i_customwftemp_1
  
    ;SAVE STATE  
    clearStateWF 1
    SaveStateWF 1, i_customwftemp_1
    i_customwftemp_2 ftgentmp 2068, 0, 4, 7, 0, 4, 0 ;mini 4 sized table = no custom WF loaded
    ilen = ftlen(i_customwftemp_2)  
    prints "\n***Custom WF 2 size = %d***\n", ilen
    Smessage sprintfk "alpha(%f)", ilen > 4 ? 1 : 0.1
    chnset Smessage, "idCUSTOM2_LED"
    tablecopy 22000, i_customwftemp_2
    tablew ilen, 2, gi_customwf_size
    Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",table(2, gi_customwf_size),22000
    Schannel sprintfk "genTableWF%d",2
    chnset Smessage, Schannel
               
    gi_nextfree22000 vco2init-i_customwftemp_2, i_customwftemp_2+1, 1.05, 128, 2^16, i_customwftemp_2
    gitable_bl22000 = -i_customwftemp_2


    ;SAVE STATE
    clearStateWF 2
    SaveStateWF 2, i_customwftemp_2

    prints "\n***ToneZ v1 compatibility mode***\n"
    i1, i2, i3, i4 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4
    chnset i1, "pbrange"
    chnset i2, "monopoly"
    chnset i3, "LegTim"
    chnset i4, "SARetrig"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13 
    chnset i1,  "osc1wave1_B"
    chnset i2,  "osc1wave2_B"
    chnset i3,  "osc1morph"
    chnset i4,  "osc1vol"
    chnset i5,  "osc1det"
    chnset i6,  "osc1wid"
    chnset i7,  "osc1phase"
    chnset i8,  "osc1voice"
    chnset i9,  "osc1octave"
    chnset i10, "osc1semi"
    chnset i11, "osc1cent"
    chnset i12, "osc1retrig"
    chnset i13, "osc1pan"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13 
    chnset i1,  "osc2wave1_B"
    chnset i2,  "osc2wave2_B"
    chnset i3,  "osc2morph"
    chnset i4,  "osc2vol"
    chnset i5,  "osc2det"
    chnset i6,  "osc2wid"
    chnset i7,  "osc2phase"
    chnset i8,  "osc2voice"
    chnset i9,  "osc2octave"
    chnset i10, "osc2semi"
    chnset i11, "osc2cent"
    chnset i12, "osc2retrig"
    chnset i13, "osc2pan"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13 
    chnset i1,  "osc3wave1_B"
    chnset i2,  "osc3wave2_B"
    chnset i3,  "osc3morph"
    chnset i4,  "osc3vol"
    chnset i5,  "osc3det"
    chnset i6,  "osc3wid"
    chnset i7,  "osc3phase"
    chnset i8,  "osc3voice"
    chnset i9,  "osc3octave"
    chnset i10, "osc3semi"
    chnset i11, "osc3cent"
    chnset i12, "osc3retrig"
    chnset i13, "osc3pan"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13 
    chnset i1,  "osc4wave1_B"
    chnset i2,  "osc4wave2_B"
    chnset i3,  "osc4morph"
    chnset i4,  "osc4vol"
    chnset i5,  "osc4det"
    chnset i6,  "osc4wid"
    chnset i7,  "osc4phase"
    chnset i8,  "osc4voice"
    chnset i9,  "osc4octave"
    chnset i10, "osc4semi"
    chnset i11, "osc4cent"
    chnset i12, "osc4retrig"
    chnset i13, "osc4pan"
    i1, i2, i3, i4 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4
    chnset i1, "OSC1_BUTTON"
    chnset i2, "OSC2_BUTTON"
    chnset i3, "OSC3_BUTTON"
    chnset i4, "OSC4_BUTTON"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 
    chnset i1,  "env1a"
    chnset i2,  "env1d"
    chnset i3,  "env1s"
    chnset i4,  "env1r"
    chnset i5,  "env1amt"
    chnset i6,  "env1osc1"
    chnset i7,  "env1osc2"
    chnset i8,  "env1osc3"
    chnset i9,  "env1osc4"
    chnset i10, "env1amp"
    chnset i11, "env1pitch"
    chnset i12, "env1filter"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 
    chnset i1,  "env2a"
    chnset i2,  "env2d"
    chnset i3,  "env2s"
    chnset i4,  "env2r"
    chnset i5,  "env2amt"
    chnset i6,  "env2osc1"
    chnset i7,  "env2osc2"
    chnset i8,  "env2osc3"
    chnset i9,  "env2osc4"
    chnset i10, "env2amp"
    chnset i11, "env2pitch"
    chnset i12, "env2filter"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 
    chnset i1,  "env3a"
    chnset i2,  "env3d"
    chnset i3,  "env3s"
    chnset i4,  "env3r"
    chnset i5,  "env3amt"
    chnset i6,  "env3osc1"
    chnset i7,  "env3osc2"
    chnset i8,  "env3osc3"
    chnset i9,  "env3osc4"
    chnset i10, "env3amp"
    chnset i11, "env3pitch"
    chnset i12, "env3filter"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 
    chnset i1,  "env4a"
    chnset i2,  "env4d"
    chnset i3,  "env4s"
    chnset i4,  "env4r"
    chnset i5,  "env4amt"
    chnset i6,  "env4osc1"
    chnset i7,  "env4osc2"
    chnset i8,  "env4osc3"
    chnset i9,  "env4osc4"
    chnset i10, "env4amp"
    chnset i11, "env4pitch"
    chnset i12, "env4filter"
    i1, i2, i3, i4 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4
    chnset i1, "ENV1_BUTTON"
    chnset i2, "ENV2_BUTTON"
    chnset i3, "ENV3_BUTTON"
    chnset i4, "ENV4_BUTTON"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11 
    chnset i1,  "lfo1shape_B"
    chnset i2,  "lfo1gain"
    chnset i3,  "lfo1rate"
    chnset i4,  "lfo1amt"
    chnset i5,  "lfo1osc1"
    chnset i6,  "lfo1osc2"
    chnset i7,  "lfo1osc3"
    chnset i8,  "lfo1osc4"
    chnset i9,  "lfo1amp"
    chnset i10, "lfo1pitch"
    chnset i11, "lfo1filter"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11 
    chnset i1,  "lfo2shape_B"
    chnset i2,  "lfo2gain"
    chnset i3,  "lfo2rate"
    chnset i4,  "lfo2amt"
    chnset i5,  "lfo2osc1"
    chnset i6,  "lfo2osc2"
    chnset i7,  "lfo2osc3"
    chnset i8,  "lfo2osc4"
    chnset i9,  "lfo2amp"
    chnset i10, "lfo2pitch"
    chnset i11, "lfo2filter"
    i1, i2 init 0
    fini gSFileName, 0, 1, i1, i2
    chnset i1, "LFO1_BUTTON"
    chnset i2, "LFO2_BUTTON"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 
    chnset i1,  "filter1mode1_B"
    chnset i2,  "filter1cut1"
    chnset i3,  "filter1res1"
    chnset i4,  "filter1keytrack1"
    chnset i5,  "filter1mode2_B"
    chnset i6,  "filter1cut2"
    chnset i7,  "filter1res2"
    chnset i8,  "filter1keytrack2"
    chnset i9,  "filter1osc1"
    chnset i10, "filter1osc2"
    chnset i11, "filter1osc3"
    chnset i12, "filter1osc4"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12 
    chnset i1,  "filter2mode1_B"
    chnset i2,  "filter2cut1"
    chnset i3,  "filter2res1"
    chnset i4,  "filter2keytrack1"
    chnset i5,  "filter2mode2_B"
    chnset i6,  "filter2cut2"
    chnset i7,  "filter2res2"
    chnset i8,  "filter2keytrack2"
    chnset i9,  "filter2osc1"
    chnset i10, "filter2osc2"
    chnset i11, "filter2osc3"
    chnset i12, "filter2osc4"
    i1, i2 init 0
    fini gSFileName, 0, 1, i1, i2
    chnset i1, "FILTER1_BUTTON"
    chnset i2, "FILTER2_BUTTON"
    i1, i2, i3, i4, i5 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5
    chnset i1, "distswitch"
    chnset i2, "drywetdist"
    chnset i3, "distlevel"
    chnset i4, "distpowershape"
    chnset i5, "distsaturator"
    i1, i2, i3, i4, i5, i6, i7 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7
    chnset i1, "chorusswitch"
    chnset i2, "drywetchorus"
    chnset i3, "choruslevel"
    chnset i4, "chorusrate"
    chnset i5, "chorusdepth"
    chnset i6, "chorusoffset"
    chnset i7, "choruswidth"
    i1, i2, i3, i4, i5, i6, i7 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7
    chnset i1, "eqswitch"
    chnset i2, "dryweteq"
    chnset i3, "eqlevel"
    chnset i4, "eqlowfreq"
    chnset i5, "eqhighfreq"
    chnset i6, "eqlowamp"
    chnset i7, "eqhighamp"
    i1, i2, i3, i4, i5, i6, i7, i8, i9 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9
    chnset i1, "revswitch"
    chnset i2, "revtype"
    chnset i3, "revsize"
    chnset i4, "revdamp"
    chnset i5, "revpitchmod"
    chnset i6, "revCutLPF"
    chnset i7, "revCutHPF"
    chnset i8, "drywetrev"
    chnset i9, "revlevel"
    i1, i2, i3, i4, i5, i6, i7, i8, i9 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9
    chnset i1, "delswitch"
    chnset i2, "deltempo"
    chnset i3, "delRhyMlt"
    chnset i4, "deldamp"
    chnset i5, "delfback"
    chnset i6, "delwidth"
    chnset i7, "delClockSource"
    chnset i8, "drywetdel"
    chnset i9, "dellevel"
    i1, i2, i3, i4, i5, i6, i7, i8, i9 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9
    chnset i1, "compswitch"
    chnset i2, "compthresh"
    chnset i3, "compatt"
    chnset i4, "comprel"
    chnset i5, "compratio"
    chnset i6, "compgain"
    chnset i7, "compLowKnee"
    chnset i8, "compHighKnee"
    chnset i9, "drywetcomp"
    i1, i2, i3, i4, i5, i6 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6
    chnset i1, "EFFECT1_BUTTON"
    chnset i2, "EFFECT2_BUTTON"
    chnset i3, "EFFECT3_BUTTON"
    chnset i4, "EFFECT4_BUTTON"
    chnset i5, "EFFECT5_BUTTON"
    chnset i6, "EFFECT6_BUTTON"
    i1, i2, i3, i4, i5, i6, i7, i8 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8
    chnset i1, "detsh1"
    chnset i2, "detsh2"
    chnset i3, "detsh3"
    chnset i4, "detsh4"
    chnset i5, "MasterVol"
    chnset i6, "revdel"
    chnset i7, "distbitcrusher"
    chnset i8, "distfoldover" 
    i1, i2, i3, i4, i5, i6 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6
    chnset i1, "env1morph"
    chnset i2, "env2morph"
    chnset i3, "env3morph"
    chnset i4, "env4morph"
    chnset i5, "lfo1morph"
    chnset i6, "lfo2morph"
    i1, i2, i3, i4, i5, i6, i7, i8, i9, i10 init 0
    fini gSFileName, 0, 1, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10
    chnset i1, "env1slope"
    chnset i2, "env2slope"
    chnset i3, "env3slope"
    chnset i4, "env4slope"
    chnset i5, "SAGlide"
    chnset i6, "revwred"
    chnset i7, "lfo1mult"
    chnset i8, "lfo2mult"
    chnset i9, "lfo1bpm"
    chnset i10, "lfo2bpm"        
        
    ;///////LMMS FIX///////////
    ktemp chnget "osc1wave1_B"
    chnset ktemp,"osc1wave1_K"
    ktemp chnget "osc1wave2_B"
    chnset ktemp,"osc1wave2_K"
    ktemp chnget "osc2wave1_B"
    chnset ktemp,"osc2wave1_K"
    ktemp chnget "osc2wave2_B"
    chnset ktemp,"osc2wave2_K"
    ktemp chnget "osc3wave1_B"
    chnset ktemp,"osc3wave1_K"
    ktemp chnget "osc3wave2_B"
    chnset ktemp,"osc3wave2_K"
    ktemp chnget "osc4wave1_B"
    chnset ktemp,"osc4wave1_K"
    ktemp chnget "osc4wave2_B"
    chnset ktemp,"osc4wave2_K"
    ktemp chnget "lfo1shape_B"
    if ktemp == 0 then 
        ktemp = 1
        chnset ktemp, "lfo1shape_B"
    endif
    chnset ktemp,"lfo1shape_K"
    ktemp chnget "lfo2shape_B"
    if ktemp == 0 then 
        ktemp = 1
        chnset ktemp, "lfo2shape_B"
    endif
    chnset ktemp,"lfo2shape_K"
    ktemp chnget "filter1mode1_B"
    if ktemp == 0 then 
        ktemp = 1
        chnset ktemp, "filter1mode1_B"
    endif
    chnset ktemp,"filter1mode1_K"
    ktemp chnget "filter1mode2_B"
    if ktemp == 0 then 
        ktemp = 1
        chnset ktemp, "filter1mode2_B"
    endif
    chnset ktemp,"filter1mode2_K"
    ktemp chnget "filter2mode1_B"
    if ktemp == 0 then 
        ktemp = 1
        chnset ktemp, "filter2mode1_B"
    endif
    chnset ktemp,"filter2mode1_K"
    ktemp chnget "filter2mode2_B"
    if ktemp == 0 then 
        ktemp = 1
        chnset ktemp, "filter2mode2_B"
    endif
    chnset ktemp,"filter2mode2_K"
;//ToneZ V1 backward compatibility
    chnset 50, "detmix"
    chnset 0, "lfo1audiorate"
    chnset 0, "lfo2audiorate"
    chnset 0, "lfo1musical"
    chnset 0, "lfo2musical"
    chnset 0, "osc1noise"
    chnset 0, "osc2noise"
    chnset 0, "osc3noise"
    chnset 0, "osc4noise"
    chnset 1, "chorusmode1"
    chnset 2, "env1acurve"
    chnset -2, "env1dcurve"
    chnset -2, "env1rcurve"
    chnset 2, "env2acurve"
    chnset -2, "env2dcurve"
    chnset -2, "env2rcurve"
    chnset 2, "env3acurve"
    chnset -2, "env3dcurve"
    chnset -2, "env3rcurve"
    chnset 2, "env4acurve"
    chnset -2, "env4dcurve"
    chnset -2, "env4rcurve"
    chnset 1, "filterS"
    chnset 0, "distclip"
    chnset 1, "filter1drive"
    chnset 1, "filter2drive"
    chnset 0, "delrevorder"
    chnset 0, "filterP"
    chnset 1, "eqmidamp"
    chnset 300, "eqmidfreq"
    chnset 100, "chorusstereowidth"
    chnset 0.03, "revSCrel"
    chnset -30, "revSCthresh"
    chnset 0, "revSCswitch"
    chnset 0, "distcarac"
    chnset 100-chnget:i("revwred"),"revwred" 
    chnset 1, "detstyle0"
    if chnget:i("osc1wave1_B") == 12 then
        chnset 1, "osc1wave1_B"
        chnset 1, "osc1noise"
    endif
    if chnget:i("osc2wave1_B") == 12 then
        chnset 1, "osc2wave1_B"
        chnset 1, "osc2noise"
    endif
    if chnget:i("osc3wave1_B") == 12 then
        chnset 1, "osc3wave1_B"
        chnset 1, "osc3noise"
    endif
    if chnget:i("osc4wave1_B") == 12 then
        chnset 1, "osc4wave1_B"
        chnset 1, "osc4noise"
    endif
    if chnget:i("lfo1pitch") == 1 then
        chnset chnget:i("lfo1amt")/20, "lfo1amt"
    endif
    if chnget:i("lfo2pitch") == 1 then
        chnset chnget:i("lfo2amt")/20, "lfo2amt"
    endif
    if chnget:i("env1slope") == 0 then
        chnset 1, "env1curve_exp"
    else
        chnset 1, "env1curve_lin"
    endif
    if chnget:i("env2slope") == 0 then
        chnset 1, "env2curve_exp"
    else
        chnset 1, "env2curve_lin"
    endif
    if chnget:i("env3slope") == 0 then
        chnset 1, "env3curve_exp"
    else
        chnset 1, "env3curve_lin"
    endif
    if chnget:i("env4slope") == 0 then
        chnset 1, "env4curve_exp"
    else
        chnset 1, "env4curve_lin"
    endif
            
    chnset "value(-1)", "WFM_List_1"
    chnset "value(-1)", "WFM_List_1I"
    chnset "value(-1)", "WFM_List_2"
    chnset "value(-1)", "WFM_List_2I"
            
ficlose gSFileName
    
endin


instr GENTABVIEW ; Gentable display event listener
    kenv1a chnget "env1a"
    kenv1d chnget "env1d"
    kenv1s chnget "env1s"
    kenv1r chnget "env1r"
    kenv1curve_exp chnget "env1curve_exp"
    kenv1curve_lin chnget "env1curve_lin"
    kenv1curve_custom chnget "env1curve_custom"
    kenv1acurve chnget "env1acurve"
    kenv1dcurve chnget "env1dcurve"
    kenv1rcurve chnget "env1rcurve"

    kenv2a chnget "env2a"
    kenv2d chnget "env2d"
    kenv2s chnget "env2s"
    kenv2r chnget "env2r"
    kenv2curve_exp chnget "env2curve_exp"
    kenv2curve_lin chnget "env2curve_lin"
    kenv2curve_custom chnget "env2curve_custom"
    kenv2acurve chnget "env2acurve"
    kenv2dcurve chnget "env2dcurve"
    kenv2rcurve chnget "env2rcurve"

    kenv3a chnget "env3a"
    kenv3d chnget "env3d"
    kenv3s chnget "env3s"
    kenv3r chnget "env3r"
    kenv3curve_exp chnget "env3curve_exp"
    kenv3curve_lin chnget "env3curve_lin"
    kenv3curve_custom chnget "env3curve_custom"
    kenv3acurve chnget "env3acurve"
    kenv3dcurve chnget "env3dcurve"
    kenv3rcurve chnget "env3rcurve"

    kenv4a chnget "env4a"
    kenv4d chnget "env4d"
    kenv4s chnget "env4s"
    kenv4r chnget "env4r"
    kenv4curve_exp chnget "env4curve_exp"
    kenv4curve_lin chnget "env4curve_lin"
    kenv4curve_custom chnget "env4curve_custom"
    kenv4acurve chnget "env4acurve"
    kenv4dcurve chnget "env4dcurve"
    kenv4rcurve chnget "env4rcurve"

    if changed(gkosc1morph, gkosc1wave1, gkosc1wave2, gkosc2morph, gkosc2wave1, gkosc2wave2, gkosc3morph, gkosc3wave1, gkosc3wave2, gkosc4morph, gkosc4wave1, gkosc4wave2) == 1 then
        event "i", "UPGENTABVIEWOSC",0,0
    endif
    if changed(kenv1a, kenv1d, kenv1s, kenv1r, kenv1acurve, kenv1dcurve, kenv1rcurve, kenv1curve_exp, kenv1curve_lin, kenv1curve_custom) == 1 then
        event "i", "UPGENTABVIEWENV", 0, 0
    endif
    if changed(kenv2a, kenv2d, kenv2s, kenv2r, kenv2acurve, kenv2dcurve, kenv2rcurve, kenv2curve_exp, kenv2curve_lin, kenv2curve_custom) == 1 then
        event "i", "UPGENTABVIEWENV", 0, 0
    endif
    if changed(kenv3a, kenv3d, kenv3s, kenv3r, kenv3acurve, kenv3dcurve, kenv3rcurve, kenv3curve_exp, kenv3curve_lin, kenv3curve_custom) == 1 then
        event "i", "UPGENTABVIEWENV", 0, 0
    endif
    if changed(kenv4a, kenv4d, kenv4s, kenv4r, kenv4acurve, kenv4dcurve, kenv4rcurve, kenv4curve_exp, kenv4curve_lin, kenv4curve_custom) == 1 then
        event "i", "UPGENTABVIEWENV", 0, 0
    endif

endin

instr UPGENTABVIEWENV ; Updater for ENV gentable
    iAtt1 = 128*log10(chnget:i("env1a")*128)
    iDec1 = 128*log10(chnget:i("env1d")*128)
    iSus1 = chnget:i("env1s")
    iRel1 = 128*log10(chnget:i("env1r")+0.001*128)+130
    ienv1curve_exp = chnget:i("env1curve_exp")
    ienv1curve_lin = chnget:i("env1curve_lin")
    ienv1curve_custom = chnget:i("env1curve_custom")
    if ienv1curve_exp == 1 then
        ienv1acurve = 7
        ienv1dcurve = -7
        ienv1rcurve = -7
    elseif ienv1curve_lin == 1 then
        ienv1acurve = 0
        ienv1dcurve = 0
        ienv1rcurve = 0
    else
        ienv1acurve = chnget:i("env1acurve")
        ienv1dcurve = chnget:i("env1dcurve")
        ienv1rcurve = chnget:i("env1rcurve")
    endif
    iCurveA1 = ienv1acurve
    iCurveD1 = ienv1dcurve
    iCurveR1 = ienv1rcurve
    if iAtt1 < 1 then
        iAtt1 = 1
    endif
    if iDec1 < 1 then
        iDec1 = 1
    endif
    
    iAtt2 = 128*log10(chnget:i("env2a")*128)
    iDec2 = 128*log10(chnget:i("env2d")*128)
    iSus2 = chnget:i("env2s")
    iRel2 = 128*log10(chnget:i("env2r")+0.001*128)+130
    ienv2curve_exp = chnget:i("env2curve_exp")
    ienv2curve_lin = chnget:i("env2curve_lin")
    ienv2curve_custom = chnget:i("env2curve_custom")
    if ienv2curve_exp == 1 then
        ienv2acurve = 7
        ienv2dcurve = -7
        ienv2rcurve = -7
    elseif ienv2curve_lin == 1 then
        ienv2acurve = 0
        ienv2dcurve = 0
        ienv2rcurve = 0
    else
        ienv2acurve = chnget:i("env2acurve")
        ienv2dcurve = chnget:i("env2dcurve")
        ienv2rcurve = chnget:i("env2rcurve")
    endif
    iCurveA2 = ienv2acurve
    iCurveD2 = ienv2dcurve
    iCurveR2 = ienv2rcurve
    if iAtt2 < 1 then
        iAtt2 = 1
    endif
    if iDec2 < 1 then
        iDec2 = 1
    endif
    
    iAtt3 = 128*log10(chnget:i("env3a")*128)
    iDec3 = 128*log10(chnget:i("env3d")*128)
    iSus3 = chnget:i("env3s")
    iRel3 = 128*log10(chnget:i("env3r")+0.001*128)+130
    ienv3curve_exp = chnget:i("env3curve_exp")
    ienv3curve_lin = chnget:i("env3curve_lin")
    ienv3curve_custom = chnget:i("env3curve_custom")
    if ienv3curve_exp == 1 then
        ienv3acurve = 7
        ienv3dcurve = -7
        ienv3rcurve = -7
    elseif ienv3curve_lin == 1 then
        ienv3acurve = 0
        ienv3dcurve = 0
        ienv3rcurve = 0
    else
        ienv3acurve = chnget:i("env3acurve")
        ienv3dcurve = chnget:i("env3dcurve")
        ienv3rcurve = chnget:i("env3rcurve")
    endif
    iCurveA3 = ienv3acurve
    iCurveD3 = ienv3dcurve
    iCurveR3 = ienv3rcurve
    if iAtt3 < 1 then
        iAtt3 = 1
    endif
    if iDec3 < 1 then
        iDec3 = 1
    endif
    
    iAtt4 = 128*log10(chnget:i("env4a")*128)
    iDec4 = 128*log10(chnget:i("env4d")*128)
    iSus4 = chnget:i("env4s")
    iRel4 = 128*log10(chnget:i("env4r")+0.001*128)+130
    ienv4curve_exp = chnget:i("env4curve_exp")
    ienv4curve_lin = chnget:i("env4curve_lin")
    ienv4curve_custom = chnget:i("env4curve_custom")
    if ienv4curve_exp == 1 then
        ienv4acurve = 7
        ienv4dcurve = -7
        ienv4rcurve = -7
    elseif ienv4curve_lin == 1 then
        ienv4acurve = 0
        ienv4dcurve = 0
        ienv4rcurve = 0
    else
        ienv4acurve = chnget:i("env4acurve")
        ienv4dcurve = chnget:i("env4dcurve")
        ienv4rcurve = chnget:i("env4rcurve")
    endif
    iCurveA4 = ienv4acurve
    iCurveD4 = ienv4dcurve
    iCurveR4 = ienv4rcurve
    if iAtt4 < 1 then
        iAtt4 = 1
    endif
    if iDec4 < 1 then
        iDec4 = 1
    endif


    gienv11 ftgentmp 10021, 0, 2048, 16, 0, iAtt1, iCurveA1, 1, iDec1, iCurveD1, iSus1, 2048-iAtt1-iDec1-iRel1, 0, iSus1, iRel1, iCurveR1, 0
    gienv21 ftgentmp 10022, 0, 2048, 16, 0, iAtt2, iCurveA2, 1, iDec2, iCurveD2, iSus2, 2048-iAtt2-iDec2-iRel2, 0, iSus2, iRel2, iCurveR2, 0
    gienv31 ftgentmp 10023, 0, 2048, 16, 0, iAtt3, iCurveA3, 1, iDec3, iCurveD3, iSus3, 2048-iAtt3-iDec3-iRel3, 0, iSus3, iRel3, iCurveR3, 0
    gienv41 ftgentmp 10024, 0, 2048, 16, 0, iAtt4, iCurveA4, 1, iDec4, iCurveD4, iSus4, 2048-iAtt4-iDec4-iRel4, 0, iSus4, iRel4, iCurveR4, 0
    chnset "tableNumber(10021)", "genTableEnv1"
    chnset "tableNumber(10022)", "genTableEnv2"
    chnset "tableNumber(10023)", "genTableEnv3"
    chnset "tableNumber(10024)", "genTableEnv4"   
endin

instr UPGENTABVIEWOSC ;Updater for OSC gentable
    gitable ftgentmp 55, 0, 129, 7, 0, 64, 1, 0, -1, 64, 0
    gitable1 ftgentmp 56, 0, 129, 10, 1
    gitable2 ftgentmp 57, 0, 129, 7, 0, 32, 1, 64, -1, 32, 0
    gitable3 ftgentmp 58, 0, 129, 7, 0, 0, 1, 64, 1, 0, -1, 64, -1, 0, 0
    gitable4 ftgentmp 59, 0, 129, 7, 0, 0, 1, 96, 1, 0, -1, 32, -1, 0, 0
    gitable5 ftgentmp 60, 0, 129, 6, 1, 16, -1, 16, 1, 8, -.5, 8, .5, 2, -.5, 1, 1, 2, -.5, 1, 1, 2, -.5, 10, 1, 2, -.5, 1, .1, 2, -.1, 2, 0
    gitable6 ftgentmp 61, 0, 129, 13, 1, 1, 0, 0, 0, -.1, 0, .3, 0, -.5, 0, .7, 0, -.9, 0, 1, 0, -1, 0 
    gitable7 ftgentmp 62, 0, 129, 13, 1, 1, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, -.1, 0, .1, 0, -.2, .3, 0, -.7, 0, .2, 0, -.1
    gitable8 ftgentmp 63, 0, 129, 13, 1, 1, 0, 1, -.8, 0, .6, 0, 0, 0, .4, 0, 0, 0, 0, .1, -.2, -.3, .5
    gitable10 ftgentmp 64, 0, 129, 13, 1, 1, 0, 5, 0, 5, 0 ,10
    gitable11 ftgentmp 65, 0, 129,9, 1,2,0, 3,2,0, 9,0.333,180
        
    isel11 = i(gkosc1wave1)+54
    isel12 = i(gkosc1wave2)+54
    isel21 = i(gkosc2wave1)+54
    isel22 = i(gkosc2wave2)+54
    isel31 = i(gkosc3wave1)+54
    isel32 = i(gkosc3wave2)+54
    isel41 = i(gkosc4wave1)+54
    isel42 = i(gkosc4wave2)+54
    
    icoef1 chnget "osc1morph"
    icoef1 /= 100
    icoef2 chnget "osc2morph"
    icoef2 /= 100
    icoef3 chnget "osc3morph"
    icoef3 /= 100
    icoef4 chnget "osc4morph"
    icoef4 /= 100
   
    tableimix 10011, 0, 129, isel12, 0, icoef1, isel11, 0, 1-icoef1
    tableimix 10012, 0, 129, isel22, 0, icoef2, isel21, 0, 1-icoef2
    tableimix 10013, 0, 129, isel32, 0, icoef3, isel31, 0, 1-icoef3
    tableimix 10014, 0, 129, isel42, 0, icoef4, isel41, 0, 1-icoef4
    chnset "tableNumber(10011)", "genTabOSC1"
    chnset "tableNumber(10012)", "genTabOSC2"
    chnset "tableNumber(10013)", "genTabOSC3"
    chnset "tableNumber(10014)", "genTabOSC4"
endin

instr 2000 ; WF Manager - WAV LOADER
    if p4 == 1 then ;1 = New wave loaded
        itable1 ftgentmp 20000, 0, 8192, 1, gSWaveName, 0, 0, 0
    elseif p4 == 2 then ;2 = Clear
        itable1 ftgentmp 20000, 0, 8192, 7, 0, 8192, 0
    endif
       
    Smessage sprintfk "sampleRange(%d,%d), tableNumber(20000)",chnget:k("WFM_WAV_Start"),chnget:k("WFM_WAV_Start")+pow(2,chnget:k("WFM_WAV_Size"))
   
    chnset Smessage, "genTableWFWAV"
endin

instr 2001 ; WF Manager - WF1 LOADER
    Slistboxval chnget "WFM_List_1"
    icomp strcmp Slistboxval, "value(-1)"

    if p4 == 2 then
        clearStateWF 1
        chnset "value(-1)", "WFM_List_1"
        chnset "value(-1)", "WFM_List_1I"
        i_customwftemp_1 ftgentmp 1937, 0, 4, 7, 0, 4, 0 ;mini 4 sized table = no custom WF loaded
        goto WF1_PROCESS ;go back to loading process, with the 4 sized table
    elseif icomp != 0 then
   
        Swext cabbageGetFileExtension gSFileName2
            i_customwftemp_1 ftgentmp 1937, 0, 8192, 7, 0, 8192, 0 ;temp ftable to store the custom WF, max size allowed = 8192
            iInit strcmp gSFileName2, "."
            if iInit == 1 then
            
                icomp strcmp Swext, ".tzf" ;ToneZ WF
                if icomp == 0 then
                    prints "\n***This is a ToneZ WF !*** (%d,%d)\n", 1,21000 
        
                    ftload gSFileName2, 1, i_customwftemp_1
                    
                    WF1_PROCESS:
                    ilen = ftlen(i_customwftemp_1)  
                    prints "\n***Custom WF 1 size = %d***\n", ilen
                    Smessage sprintfk "alpha(%f)", ilen > 4 ? 1 : 0.1
                    chnset Smessage, "idCUSTOM1_LED"
                    if powerOfTwo(ilen) == 1 then
            
               
                    ;scanhammer i_customwftemp_1, 21000,0,1
                    tablecopy 21000, i_customwftemp_1
                    tablew ilen, 1, gi_customwf_size
                    Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",table(1, gi_customwf_size),21000
                    Schannel sprintfk "genTableWF%d",1
                    chnset Smessage, Schannel
            
                    gi_nextfree21000 vco2init-i_customwftemp_1, i_customwftemp_1+1, 1.05, 128, 2^16, i_customwftemp_1
                    gitable_bl21000 = -i_customwftemp_1
                    SaveStateWF 1, i_customwftemp_1
                    else
                        prints "\n***WF size must be power of 2***\n", ilen
            
            
                    endif

                else
                    prints "\n***This is not a ToneZ WF...***\n"
                endif
            endif
    endif
    WF1_CLEARED:
    event "i", 3000, 0, 0
    event "i", "UPGENTABVIEWOSC",0,0
prints "SIZE1 = %d, SIZE2 = %d\n",table(1, gi_customwf_size),table(2, gi_customwf_size)
endin



instr 2002 ; WF Manager - WF2 LOADER
    Slistboxval chnget "WFM_List_2"
    icomp strcmp Slistboxval, "value(-1)" ;Avoid trigering the loading when the RESET button is clicked...

    if p4 == 2 then
        clearStateWF 2
        chnset "value(-1)", "WFM_List_2"
        chnset "value(-1)", "WFM_List_2I"
        i_customwftemp_2 ftgentmp 2068, 0, 4, 7, 0, 4, 0 ;mini 4 sized table = no custom WF loaded
        goto WF2_PROCESS ;go back to loading process, with the 4 sized table
    elseif icomp != 0 then
        
        Swext cabbageGetFileExtension gSFileName2
        i_customwftemp_2 ftgentmp 2068, 0, 8192, 7, 0, 8192, 0 ;temp ftable to store the custom WF, max size allowed = 8192
    
        iInit strcmp gSFileName2, "."
        if iInit == 1 then
            
            icomp strcmp Swext, ".tzf" ;ToneZ WF
            if icomp == 0 then
                prints "\n***This is a ToneZ WF !*** (%d,%d)\n", 2,22000 
        
                ftload gSFileName2, 1, i_customwftemp_2
                WF2_PROCESS:
                ilen = ftlen(i_customwftemp_2)  
                prints "\n***Custom WF 2 size = %d***\n", ilen
                Smessage sprintfk "alpha(%f)", ilen > 4 ? 1 : 0.1
                chnset Smessage, "idCUSTOM2_LED"
                if powerOfTwo(ilen) == 1 then
                    tablecopy 22000, i_customwftemp_2
                    tablew ilen, 2, gi_customwf_size
                    Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",table(2, gi_customwf_size),22000
                    Schannel sprintfk "genTableWF%d",2
                    chnset Smessage, Schannel
               
                    gi_nextfree22000 vco2init-i_customwftemp_2, i_customwftemp_2+1, 1.05, 128, 2^16, i_customwftemp_2
                    gitable_bl22000 = -i_customwftemp_2
                    SaveStateWF 2, i_customwftemp_2
                else
                    prints "\n***WF size must be power of 2***\n", ilen
                endif
            else
                prints "\n***This is not a ToneZ WF...***\n"
            endif
        endif
    endif
    WF2_CLEARED:
    event "i", 3000, 0, 0
    event "i", "UPGENTABVIEWOSC",0,0
endin



instr 2003 ; WF Manager - WF Saving
    if p4 == 1 then
        ilen = table(1, gi_customwf_size)    
        if ilen != 0 then
            i_temp1 ftgentmp 0, 0, ilen, 7, 0, ilen, 0
            vcopy_i  i_temp1, 21000, ilen, 0, 0
            ;Check if not canceled
            iInit strcmp gSFileName2, "."
            if iInit == 1 then
                ;Add .tzf extension if missing
                if strrindex(gSFileName2, ".tzf") == -1 then
                    gSFileName2 strcat gSFileName2, ".tzf"
                endif
                ;Save ftable to the file
                ftsave gSFileName2, 1, i_temp1
           endif
        endif
        chnset "populate(\"*.tzf\")", "WFM_List_1I"
    endif
    if p4 == 2 then
        ilen = table(2, gi_customwf_size)    
        if ilen != 0 then
            i_temp2 ftgentmp 0, 0, ilen, 7, 0, ilen, 0
            vcopy_i  i_temp2, 22000, ilen, 0, 0
            ;Check if not canceled
            iInit strcmp gSFileName2, "."
            if iInit == 1 then
                ;Add .tzf extension if missing
                if strrindex(gSFileName2, ".tzf") == -1 then
                    gSFileName2 strcat gSFileName2, ".tzf"
                endif
                ;Save ftable to the file
                ftsave gSFileName2, 1, i_temp2
           endif
        endif
        chnset "populate(\"*.tzf\")", "WFM_List_2I"
    endif
endin



instr 3000 ;; WF Manager - Custom WF Vizualizer
    itarget = 128
    itable1 ftgentmp 66, 0, 128, 7, 0, 128, 0
    itable2 ftgentmp 67, 0, 128, 7, 0, 128, 0
    icount = 0
    istep = 0
    itablenum = 21000
     icust = table(1, gi_customwf_size)
    while icount < ftlen(66) do
        tablew    table(istep, itablenum), icount, 66
        icount = icount +1
        istep = istep+(icust/itarget)
    od
    icount = 0
    istep = 0
    itablenum = 22000
    icust = table(2, gi_customwf_size)
    while icount < ftlen(67) do
        tablew    table(istep, itablenum), icount, 67
        icount = icount +1
        istep = istep+(icust/itarget)
    od
endin

instr getState ; restore plugin state on load
    kHaveState = cabbageHasStateData()
    if kHaveState == 1 then
        //to fix this : https://forum.cabbageaudio.com/t/cannot-get-cabbagesetstatevalue-to-work-outside-main-instrument/3040
        kSize1 cabbageGetStateValue "CusTabSize1"
        kSize2 cabbageGetStateValue "CusTabSize2"
        event "i", "getSavedTables", 0, .1, kSize1, kSize2
        turnoff
    endif
    kToneZversion cabbageGetStateValue "Ver" ;Check ToneZ version, and maybe do some adjustments for retro compatibility..
    cabbageSetStateValue "Ver", 200 ;Update ToneZ version into the state (200 = v2.0.0)
    turnoff
endin


instr getSavedTables ;restore plugin custom WaveForms on load
    if p4 > 0 then
        Smessage sprintfk "alpha(%f)", p4 > 4 ? 1 : 0.1
        chnset Smessage, "idCUSTOM1_LED"
        kArr[]  init    p4
        kArr cabbageGetStateValue "CusTab1"
        iTable11 ftgentmp   4022, 0, p4, 7, 0, p4, 0
        copya2ftab kArr, iTable11
        tablecopy 21000, iTable11 
        tablew p4, 1, gi_customwf_size 
        Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",p4,21000
        Schannel sprintfk "genTableWF%d",1
        chnset Smessage, Schannel
        TRIGTRIH:
        gi_nextfree21000 vco2init-iTable11, iTable11+1, 1.05, 128, 2^16, iTable11
        gitable_bl21000 = -iTable11                   
        prints "Restore state table1 (%d samples)\n",table(1, gi_customwf_size)
        reinit TRIGTRIH
    endif
    
    if p5 > 0 then
        Smessage sprintfk "alpha(%f)", p5 > 4 ? 1 : 0.1
        chnset Smessage, "idCUSTOM2_LED"
        kArr[]  init    p5
        kArr cabbageGetStateValue "CusTab2"
        iTable22 ftgentmp   3645, 0, p5, 7, 0, p5, 0
        copya2ftab kArr, iTable22
        tablecopy 22000, iTable22 
        tablew p5, 2, gi_customwf_size 
        Smessage sprintfk "sampleRange(0,%d), tableNumber(%d)",p5,22000
        Schannel sprintfk "genTableWF%d",2
        chnset Smessage, Schannel
        TRIGTRIH2:
        gi_nextfree22000 vco2init-iTable22, iTable22+1, 1.05, 128, 2^16, iTable22
        gitable_bl22000 = -iTable22                   
        prints "Restore state table2 (%d samples)\n",table(2, gi_customwf_size)
        reinit TRIGTRIH2
    endif
    event "i", 3000, 0, 0
    event "i", "UPGENTABVIEWOSC",0,0
    turnoff
endin



instr WAVtoWF ; WF MANAGER - Convert .wav -> ToneZ WF
    isize = pow(2,chnget:i("WFM_WAV_Size"))
    istart = chnget:i("WFM_WAV_Start")
    if p4 == 1 then
        prints "isize=%d ; istart=%d",isize,istart
        vcopy_i  21000, 20000, isize, 0, istart
  
        Smessage sprintfk "sampleRange(%d,%d), tableNumber(21000)",0,isize
        chnset Smessage, "genTableWF1"

        tablew isize, 1, gi_customwf_size
        i_customwftemp_1 ftgentmp 5064, 0, isize, 7, 0, isize, 0
    
        vcopy_i  i_customwftemp_1, 21000, isize, 0, 0
        
        gi_nextfree21000 vco2init-i_customwftemp_1, i_customwftemp_1+1, 1.05, 128, 2^16, i_customwftemp_1
        gitable_bl21000 = -i_customwftemp_1  
        SaveStateWF 1, i_customwftemp_1
        event "i", 3000, 0, 0
        event "i", "UPGENTABVIEWOSC",0,0
    elseif p4 == 2 then
        prints "isize=%d ; istart=%d",isize,istart
        vcopy_i  22000, 20000, isize, 0, istart
  
        Smessage sprintfk "sampleRange(%d,%d), tableNumber(22000)",0,isize
        chnset Smessage, "genTableWF2"

        tablew isize, 2, gi_customwf_size
        i_customwftemp_2 ftgentmp 7095, 0, isize, 7, 0, isize, 0
    
        vcopy_i  i_customwftemp_2, 22000, isize, 0, 0
        
        gi_nextfree22000 vco2init-i_customwftemp_2, i_customwftemp_2+1, 1.05, 128, 2^16, i_customwftemp_2
        gitable_bl22000 = -i_customwftemp_2
        SaveStateWF 2, i_customwftemp_2
        event "i", 3000, 0, 0
        event "i", "UPGENTABVIEWOSC",0,0
    endif    
endin

</CsInstruments>
<CsScore>

f20000 0 8192 7 0 8192 0
f21000 0 8192 7 0 8192 0
f22000 0 8192 7 0 8192 0

f10011 0 4097 7 0 128 1 128 .5 2048 .5 1024 0
f10012 0 4097 7 0 128 1 128 .5 2048 .5 1024 0
f10013 0 4097 7 0 128 1 128 .5 2048 .5 1024 0
f10014 0 4097 7 0 128 1 128 .5 2048 .5 1024 0
f10021 0 2048 7 0 128 1 128 .5 2048 .5 1024 0
f10022 0 2048 7 0 128 1 128 .5 2048 .5 1024 0
f10023 0 2048 7 0 128 1 128 .5 2048 .5 1024 0
f10024 0 2048 7 0 128 1 128 .5 2048 .5 1024 0
i 1  0 [3600*24*7] ;read var stored in instr1
i 6 0 1
i "getState" 0.01 2 ;0.01 to get state after init


i"GENTABVIEW" 0 z
i"EFFECT" 0 z

i 3000 0.02 0.0 ;0.02 to update viz after get state
i "UPGENTABVIEWOSC" 0.02 0


f0 z


</CsScore>
</CsoundSynthesizer>