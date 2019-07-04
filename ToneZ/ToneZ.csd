
;****************************************************************************
;****************************************************************************
;****************************************************************************
;****************************************************************************
;                           ToneZ v1.3
;                       T0NIT0 RMX - 2019
;                   https://t0nit0rmx.github.io
;
;Designed in Cabbage. 
;Some parts of the code, especially the effects,
;come from Iain McCurdy example
;http://iainmccurdy.org/csound.html
;****************************************************************************
;****************************************************************************
;****************************************************************************
;****************************************************************************


<Cabbage>
;*****************************************************************************************************************
;**********************************************GUI****************************************************************
;*****************************************************************************************************************

;******************STYLES
#define rsliderstyle colour(20,30,40,0), fontcolour("silver"), trackercolour("lightblue"), outlinecolour(70,70,70,100), trackerinsideradius(.8), style("normal")
#define nsliderstyle colour(11,21,31), fontcolour("silver"), trackercolour("lightblue")
#define buttonstyle imgfile("on", "img/buttonon.svg"), imgfile("off", "img/buttonoff.svg"), fontcolour:1("white"), fontcolour:0(220,220,220), colour("lightblue")
#define buttonstyleon imgfile("on", "img/buttonon.svg"), imgfile("off", "img/buttonon.svg"), fontcolour:1("white"), fontcolour:1("white"), colour:0("lightblue"), colour:1("lightblue")
#define buttontabstyle fontcolour:1("white"), fontcolour:0(220,220,220), colour("lightblue"), imgfile("on", "img/tabon.svg"), imgfile("off", "img/taboff.svg")
#define checkboxstyle fontcolour:1("white"), fontcolour:0(220,220,220), colour("lightblue"), imgfile("on", "img/buttonon.svg"), imgfile("off", "img/buttonoff.svg")
#define bgstyle colour(20, 30, 40)
#define bgtabstyle file("img/tab.svg")
#define hsliderstyle trackercolour(0, 0, 0, 0) colour("lightblue")   textcolour(0, 0, 0, 0) fontcolour(0, 0, 0, 0), imgfile("Slider", "img/slidt.svg")imgfile("Background", "img/slidbg.svg")
#define rsliderhiddenstyle alpha(1), popuptext(0), colour(20,30,40,255), fontcolour("silver"), trackercolour("lightblue"), outlinecolour(70,70,70,100), trackerinsideradius(.8), style("normal")

;******************KEYBOARD
form caption("ToneZ") size(719, 468), colour(0,10,20), pluginid("T0N1"), guirefresh(10)


;*******************HEADER
groupbox bounds(560, 0, 172, 407), plant("GUI_HEADER"){
    image bounds(0, 0, 175, 407), colour(20, 30, 40, 255)
    image        bounds(1, -5, 158, 419), colour(20, 30, 40, 255)
    image        bounds(10, 72, 138, 1), colour("lightblue")
    image        bounds(10, 120, 138, 1), colour("lightblue")
    image        bounds(10, 277, 138, 1), colour("lightblue")
    image        bounds(10, 323, 138, 1), colour("lightblue")
    label bounds(5,20,150,10), text("BROKEN GUI"), fontcolour("red")
    label bounds(5,30,150,10), text("Click on the 'About' button"), fontcolour("red")
    label bounds(5,40,150,10), text("& Ask for help on Discord"), fontcolour("red")
    
    image bounds(12, 8, 130, 56), file("img/logo.png"), colour(0,0,0,0)
    listbox bounds(2, 190, 156, 85), populate("*.tzp","factorypresets") channel("box") channeltype("string") identchannel("boxI") fontcolour(220,220,220) value(.), highlightcolour(123,154,164), colour(20,30,40)
    filebutton bounds(15, 145, 60, 19), channel("saveFile"), text("Save"), populate("*.tzp","preset"), mode("save"), $buttonstyle
    filebutton bounds(84, 145, 60, 19), channel("openFile") text("Open"), populate("*.tzp"), mode("file"), $buttonstyle
    filebutton bounds(15, 165, 60, 19), channel("opendir") text("Folder"), populate("*.tzp"), mode("directory"), $buttonstyle
    button bounds(84, 165, 60, 19), channel("reload") text("Reload") identchannel("reloadI") latched(0), active(0) $buttonstyle
    rslider bounds(75, 75, 75, 43), text("Volume"),    channel("MasterVol"), range(0, 500, 100, 0.43, 0.01), popuppostfix(" %"), $rsliderstyle
    nslider bounds(17, 77, 55, 23),       channel("pbrange"), range(1, 24, 12, 1, 1) , $nsliderstyle
    label bounds(0, 102, 90, 11), text("PB. Range")
    label bounds(15,328,150,15), text("PORTAMENTO"), align("left")
    button  bounds(120, 326, 30, 17), text("OFF", "ON"), channel("monopoly"), $checkboxstyle
    rslider bounds(15, 350, 47, 43), text("Leg.Time"),    channel("LegTim"), range(1, 5000, 100, 0.25, 1), popuppostfix(" ms"), $rsliderstyle
    label bounds(77, 360, 40, 11), text("Retrig")
    checkbox   bounds(120, 360, 10, 10), channel("SARetrig"), , identchannel("SARetrigID"), $checkboxstyle
    label bounds(79, 377, 40, 11), text("Glide")
    checkbox   bounds(120, 377, 10, 10), channel("SAGlide"), $checkboxstyle
    button bounds(0, 0, 160, 70), channel("BUTTON_PANIC"),latched(0), alpha(0)
    button bounds(100, 2, 58, 20), channel("BUTTON_ABOUT") text("About..."),latched(0), $buttonstyle
    
    label bounds(47,127,150,15), text("PRESETS")
    label bounds(50,282,150,15), text("EXPERT")
    label bounds(50,295,150,15), text("DETUNE")
    label bounds(3, 130, 80, 10) text("<No Preset>") identchannel("PresetName")
    rslider bounds(0, 285, 35, 35), text("A"),    channel("detsh1"), range(-.5, .5, 0, 1, 0.0001), popuppostfix(" "), $rsliderstyle
    rslider bounds(20, 285, 35, 35), text("B"),    channel("detsh2"), range(-.5, .5, 0, 1, 0.0001), popuppostfix(" "), $rsliderstyle
    rslider bounds(40, 285, 35, 35), text("C"),    channel("detsh3"), range(-.5, .5, 0, 1, 0.0001), popuppostfix(" "), $rsliderstyle
    rslider bounds(60, 285, 35, 35), text("D"),    channel("detsh4"), range(-.5, .5, 0, 1, 0.0001), popuppostfix(" "), $rsliderstyle

texteditor bounds(0, 0, 80, 20), wrap(0), colour(20,30,40), fontcolour(160,160,160), channel("PresetString"), identchannel("PresetStringI"), text("<No Preset>"), active(0), alpha(0)
texteditor bounds(0, 0, 80, 20), wrap(0), colour(20,30,40), fontcolour(160,160,160), channel("PathText"), identchannel("PathTextI"), text("factorypresets"), active(0), alpha(0)
label bounds(0, 0, 80, 20) text(" "), alpha(0)

}

keyboard bounds(0, 402, 719, 66), middlec(5), keydowncolour("lightblue"), mouseoverkeycolour(165,205,218,20), arrowbackgroundcolour(20,30,40,100), arrowcolour("white"), blacknotecolour(20,30,40), whitenotecolour(240,240,255)


;*******************OSC
groupbox bounds(5, 5, 305, 125), , identchannel("GROUP_OSCALL"), plant("GUI_OSCALL"){
    image        bounds(0, 0, 305, 110), colour(0,10,20)
    groupbox bounds(0, 20, 305, 110), visible(1), identchannel("GROUP_OSC1"), plant("GUI_OSC1"){
        image        bounds(0, 0, 305, 110), colour(20, 30, 40, 255), $bgtabstyle
        label bounds(245,4,50,20), text("OSC1")
        combobox bounds(5, 5, 70, 20), fontcolour("silver") channel("osc1wave1_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Noise"), value(1), colour(20,30,40), align("centre")
        combobox bounds(76, 5, 70, 20), fontcolour("silver") channel("osc1wave2_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell"), value(1), colour(20,30,40), align("centre")
        rslider bounds(55, 5, 20, 20),       channel("osc1wave1_K"), range(1, 12, 1, 1, 1), $rsliderhiddenstyle
        rslider bounds(119, 5, 35, 20),      channel("osc1wave2_K"), range(1, 11, 1, 1, 1), $rsliderhiddenstyle
        label bounds(25, 28, 100, 11), text("Morph")
        hslider bounds(3, 26, 149, 15) range(0, 100, 0, 1, 0.01),  channel("osc1morph"), popuppostfix(" %"), $hsliderstyle

        
        rslider bounds(50, 50, 50, 50),     channel("osc1vol"),      range(0, 100, 100, 1, 0.01),   text("Volume"), popuppostfix(" %"),      $rsliderstyle 
        rslider bounds(100, 50, 50, 50),    channel("osc1det"),      range(0, 100, 0, 0.5, 0.01),   text("Detune"), popuppostfix(" %"),    $rsliderstyle
        rslider bounds(150, 50, 50, 50),    channel("osc1wid"),      range(0, 100, 100, 1, 0.01),   text("Width"), popuppostfix(" %"),    $rsliderstyle

        nslider bounds(5, 54, 40, 25),     channel("osc1voice"),      range(1, 8, 1, 1, 1),     $nsliderstyle
        label bounds(0, 85, 50, 11), text("Voices")
        nslider bounds(255, 54, 40, 25),    channel("osc1octave"),      range(-3, 3, 0, 1, 1),     $nsliderstyle
        nslider bounds(210, 54, 40, 25),    channel("osc1semi"),      range(-12, 12, 0, 0.5, 1),     $nsliderstyle
        label bounds(250, 85, 50, 11), text("Octave")
        label bounds(205, 85, 50, 11), text("Semi")
        rslider bounds(140, 5, 45, 35),      channel("osc1cent"),        range(-100, 100, 0, 1, 1) text("Cent"), popuppostfix(" "), $rsliderstyle
        rslider bounds(170, 5, 45, 35),      channel("osc1pan"),        range(0, 100, 50, 1, 0.01) text("Pan"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(200, 5, 45, 35),    channel("osc1phase"),      range(0, 360, 0, 1, 0.01),   text("Phase"), popuppostfix(" °"),   $rsliderstyle
        label bounds(242, 25, 40, 11), text("Retrig")
        checkbox bounds(283, 25, 10, 10),   channel("osc1retrig"),text("Retrig"),     , $checkboxstyle
        
    }
    groupbox bounds(0, 20, 305, 110), visible(0), identchannel("GROUP_OSC2"), plant("GUI_OSC2"){
        image        bounds(0, 0, 305, 110), colour(20, 30, 40, 255), $bgtabstyle
        label bounds(245,4,50,20), text("OSC2")
        combobox bounds(5, 5, 70, 20), fontcolour("silver") channel("osc2wave1_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Noise"), value(1), colour(20,30,40), align("centre")
        combobox bounds(76, 5, 70, 20), fontcolour("silver") channel("osc2wave2_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell"), value(1), colour(20,30,40), align("centre")
        rslider bounds(55, 5, 20, 20),       channel("osc2wave1_K"), range(1, 12, 1, 1, 1), $rsliderhiddenstyle
        rslider bounds(119, 5, 35, 20),      channel("osc2wave2_K"), range(1, 11, 1, 1, 1), $rsliderhiddenstyle
        label bounds(25, 28, 100, 11), text("Morph")
        hslider bounds(3, 26, 149, 15) range(0, 100, 0, 1, 0.01),  channel("osc2morph"), popuppostfix(" %"), $hsliderstyle

        
        rslider bounds(50, 50, 50, 50),     channel("osc2vol"),      range(0, 100, 0, 1, 0.01),   text("Volume"), popuppostfix(" %"),      $rsliderstyle 
        rslider bounds(100, 50, 50, 50),    channel("osc2det"),      range(0, 100, 0, 0.5, 0.01),   text("Detune"), popuppostfix(" %"),    $rsliderstyle
        rslider bounds(150, 50, 50, 50),    channel("osc2wid"),      range(0, 100, 100, 1, 0.01),   text("Width"), popuppostfix(" %"),    $rsliderstyle

        nslider bounds(5, 54, 40, 25),     channel("osc2voice"),      range(1, 8, 1, 1, 1),     $nsliderstyle
        label bounds(0, 85, 50, 11), text("Voices")
        nslider bounds(255, 54, 40, 25),    channel("osc2octave"),      range(-3, 3, 0, 1, 1),     $nsliderstyle
        nslider bounds(210, 54, 40, 25),    channel("osc2semi"),      range(-12, 12, 0, 0.5, 1),     $nsliderstyle
        label bounds(250, 85, 50, 11), text("Octave")
        label bounds(205, 85, 50, 11), text("Semi")
        rslider bounds(140, 5, 45, 35),      channel("osc2cent"),        range(-100, 100, 0, 1, 1) text("Cent"), popuppostfix(" "),  $rsliderstyle
        rslider bounds(170, 5, 45, 35),      channel("osc2pan"),        range(0, 100, 50, 1, 0.01) text("Pan"), popuppostfix(" %"),  $rsliderstyle
        rslider bounds(200, 5, 45, 35),    channel("osc2phase"),      range(0, 360, 0, 1, 0.01),   text("Phase"), popuppostfix(" °"),     $rsliderstyle
        label bounds(242, 25, 40, 11), text("Retrig")
        checkbox bounds(283, 25, 10, 10),   channel("osc2retrig"),text("Retrig"),     , $checkboxstyle
        
    }
    groupbox bounds(0, 20, 305, 110), visible(0), identchannel("GROUP_OSC3"), plant("GUI_OSC3"){
        image        bounds(0, 0, 305, 110), colour(20, 30, 40, 255), $bgtabstyle
        label bounds(245,4,50,20), text("OSC3")
        combobox bounds(5, 5, 70, 20), fontcolour("silver") channel("osc3wave1_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Noise"), value(1), colour(20,30,40), align("centre")
        combobox bounds(76, 5, 70, 20), fontcolour("silver") channel("osc3wave2_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell"), value(1), colour(20,30,40), align("centre")
        rslider bounds(55, 5, 20, 20),       channel("osc3wave1_K"), range(1, 12, 1, 1, 1), alpha(0.2), $rsliderhiddenstyle
        rslider bounds(119, 5, 35, 20),      channel("osc3wave2_K"), range(1, 11, 1, 1, 1), alpha(0.2), $rsliderhiddenstyle
        label bounds(25, 28, 100, 11), text("Morph")
        hslider bounds(3, 26, 149, 15) range(0, 100, 0, 1, 0.01),  channel("osc3morph"), popuppostfix(" %"),  $hsliderstyle

        
        rslider bounds(50, 50, 50, 50),     channel("osc3vol"),      range(0, 100, 0, 1, 0.01),   text("Volume"), popuppostfix(" %"),      $rsliderstyle 
        rslider bounds(100, 50, 50, 50),    channel("osc3det"),      range(0, 100, 0, 0.5, 0.01),   text("Detune"), popuppostfix(" %"),    $rsliderstyle
        rslider bounds(150, 50, 50, 50),    channel("osc3wid"),      range(0, 100, 100, 1, 0.01),   text("Width"), popuppostfix(" %"),    $rsliderstyle

        nslider bounds(5, 54, 40, 25),     channel("osc3voice"),      range(1, 8, 1, 1, 1),     $nsliderstyle
        label bounds(0, 85, 50, 11), text("Voices")
        nslider bounds(255, 54, 40, 25),    channel("osc3octave"),      range(-3, 3, 0, 1, 1),     $nsliderstyle
        nslider bounds(210, 54, 40, 25),    channel("osc3semi"),      range(-12, 12, 0, 0.5, 1),     $nsliderstyle
        label bounds(250, 85, 50, 11), text("Octave")
        label bounds(205, 85, 50, 11), text("Semi")
        rslider bounds(140, 5, 45, 35),      channel("osc3cent"),        range(-100, 100, 0, 1, 1) text("Cent"), popuppostfix(" "),  $rsliderstyle
        rslider bounds(170, 5, 45, 35),      channel("osc3pan"),        range(0, 100, 50, 1, 0.01) text("Pan"), popuppostfix(" %"),  $rsliderstyle
        rslider bounds(200, 5, 45, 35),    channel("osc3phase"),      range(0, 360, 0, 1, 0.01),   text("Phase"), popuppostfix(" °"),     $rsliderstyle
        label bounds(242, 25, 40, 11), text("Retrig")
        checkbox bounds(283, 25, 10, 10),   channel("osc3retrig"),text("Retrig"),     , $checkboxstyle
        
    }
    groupbox bounds(0, 20, 305, 110), visible(0), identchannel("GROUP_OSC4"), plant("GUI_OSC4"){
        image        bounds(0, 0, 305, 110), colour(20, 30, 40, 255), $bgtabstyle
        label bounds(245,4,50,20), text("OSC4")
        combobox bounds(5, 5, 70, 20), fontcolour("silver") channel("osc4wave1_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell","Noise"), value(1), colour(20,30,40), align("centre")
        combobox bounds(76, 5, 70, 20), fontcolour("silver") channel("osc4wave2_B"), items("Saw","Sine","Triangle","Square","Pulse","Buzz","Fizz","Ring","Croon","Plane","Bell"), value(1), colour(20,30,40), align("centre")
        rslider bounds(55, 5, 20, 20),       channel("osc4wave1_K"), range(1, 12, 1, 1, 1), alpha(0.2), $rsliderhiddenstyle
        rslider bounds(119, 5, 35, 20),      channel("osc4wave2_K"), range(1, 11, 1, 1, 1), alpha(0.2), $rsliderhiddenstyle
        label bounds(25, 28, 100, 11), text("Morph")
        hslider bounds(3, 26, 149, 15) range(0, 100, 0, 1, 0.01),  channel("osc4morph"), popuppostfix(" %"),  $hsliderstyle

        
        rslider bounds(50, 50, 50, 50),     channel("osc4vol"),      range(0, 100, 0, 1, 0.01),   text("Volume"), popuppostfix(" %"),      $rsliderstyle 
        rslider bounds(100, 50, 50, 50),    channel("osc4det"),      range(0, 100, 0, 0.5, 0.01),   text("Detune"), popuppostfix(" %"),    $rsliderstyle
        rslider bounds(150, 50, 50, 50),    channel("osc4wid"),      range(0, 100, 100, 1, 0.01),   text("Width"), popuppostfix(" %"),    $rsliderstyle

        nslider bounds(5, 54, 40, 25),     channel("osc4voice"),      range(1, 8, 1, 1, 1),     $nsliderstyle
        label bounds(0, 85, 50, 11), text("Voices")
        nslider bounds(255, 54, 40, 25),    channel("osc4octave"),      range(-3, 3, 0, 1, 1),     $nsliderstyle
        nslider bounds(210, 54, 40, 25),    channel("osc4semi"),      range(-12, 12, 0, 0.5, 1),     $nsliderstyle
        label bounds(250, 85, 50, 11), text("Octave")
        label bounds(205, 85, 50, 11), text("Semi")
        rslider bounds(140, 5, 45, 35),      channel("osc4cent"),        range(-100, 100, 0, 1, 1) text("Cent"), popuppostfix(" "),  $rsliderstyle
        rslider bounds(170, 5, 45, 35),      channel("osc4pan"),        range(0, 100, 50, 1, 0.01) text("Pan"), popuppostfix(" %"),  $rsliderstyle
        rslider bounds(200, 5, 45, 35),    channel("osc4phase"),      range(0, 360, 0, 1, 0.01),   text("Phase"), popuppostfix(" °"),     $rsliderstyle
        label bounds(242, 25, 40, 11), text("Retrig")
        checkbox bounds(283, 25, 10, 10),   channel("osc4retrig"),text("Retrig"),     , $checkboxstyle
        
    }
    button bounds(0, 3, 50, 19),text("OSC1"),channel("OSC1_BUTTON"), radiogroup(101), $buttontabstyle, value(1)
    button bounds(50, 3, 50, 19),text("OSC2"),channel("OSC2_BUTTON"), radiogroup(101), $buttontabstyle
    button bounds(100, 3, 50, 19),text("OSC3"),channel("OSC3_BUTTON"), radiogroup(101), $buttontabstyle
    button bounds(150, 3, 50, 19),text("OSC4"),channel("OSC4_BUTTON"), radiogroup(101), $buttontabstyle
}



;*******************ENVELOPPES
;1
groupbox bounds(320, 5, 230, 125), , identchannel("GROUP_ENVALL"), plant("GUI_ENVALL"){
    image        bounds(0, 0, 230, 110), colour(0,10,20)
    groupbox bounds(0, 20, 230, 110), visible(1) , identchannel("GROUP_ENV1"), plant("GUI_ENV1"){
        image    bounds(0, 0, 230, 110), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(172,4,50,20), text("ENV1")
        rslider  bounds(0, 58, 45, 45),    channel("env1a"),        range(0.007, 10, 0.001, 0.5, 0.001),   text("A"), popuppostfix(" s"),    $rsliderstyle
        rslider  bounds(38, 58, 45, 45),   channel("env1d"),        range(0, 10, 0, 0.5, 0.001),   text("D"), popuppostfix(" s"),  $rsliderstyle
        rslider  bounds(76, 58, 45, 45),   channel("env1s"),        range(0.001, 1, 1, 1, 0.001),   text("S"), popuppostfix(" "),     $rsliderstyle
        rslider  bounds(114, 58, 45, 45),   channel("env1r"),        range(0.007, 10, 0.001, 0.5, 0.001),   text("R"), popuppostfix(" s"), $rsliderstyle
        rslider  bounds(170, 58, 45, 45),  channel("env1amt"), identchannel("ENV1AMT_BUTTON"),   range(-100, 100, 100, 1, 0.01),   text("Amt"), popuppostfix(" %"), $rsliderstyle

        button bounds(5, 30, 38, 17),   channel("env1osc1"), identchannel("ENV1OSC1_BUTTON"), text("OSC1"), value(1), $checkboxstyle
        button bounds(43, 30, 38, 17),   channel("env1osc2"), identchannel("ENV1OSC2_BUTTON"), text("OSC2"), value(1), $checkboxstyle
        button bounds(81, 30, 38, 17),  channel("env1osc3"), identchannel("ENV1OSC3_BUTTON"), text("OSC3"), value(1), $checkboxstyle
        button bounds(119, 30, 38, 17),  channel("env1osc4"), identchannel("ENV1OSC4_BUTTON"), text("OSC4"), value(1), $checkboxstyle
        button bounds(5, 7, 38, 17),     channel("env1amp"), text("Amp"), radiogroup(102), value(1), $buttonstyle 
        button bounds(43, 7, 38, 17),     channel("env1pitch"), text("Pitch"), radiogroup(102), $buttonstyle 
        button bounds(81, 7, 38, 17),     channel("env1morph"), text("Morph"), radiogroup(102), $buttonstyle  
        button bounds(119, 7, 38, 17),     channel("env1filter"), text("Filter"), radiogroup(102), $buttonstyle
        button bounds(175, 30, 38, 17),  channel("env1slope"), text("EXP","LIN"), value(0), $buttonstyleon
    }
    groupbox bounds(0, 20, 230, 110), visible(0) , identchannel("GROUP_ENV2"), plant("GUI_ENV2"){
        image    bounds(0, 0, 230, 110), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(172,4,50,20), text("ENV2")
        rslider  bounds(0, 58, 45, 45),    channel("env2a"),        range(0.001, 10, 0.001, 0.5, 0.001),   text("A"), popuppostfix(" s"),   $rsliderstyle
        rslider  bounds(38, 58, 45, 45),   channel("env2d"),        range(0, 10, 0, 0.5, 0.001),   text("D"), popuppostfix(" s"),  $rsliderstyle
        rslider  bounds(76, 58, 45, 45),   channel("env2s"),        range(0.001, 1, 0.001, 0.5, 0.01),   text("S"), popuppostfix(" "),     $rsliderstyle
        rslider  bounds(114, 58, 45, 45),   channel("env2r"),        range(0.001, 10, 0.001, 0.5, 0.001),   text("R"), popuppostfix(" s"), $rsliderstyle
        rslider  bounds(170, 58, 45, 45),  channel("env2amt"), identchannel("ENV2AMT_BUTTON"),   range(-100, 100, 100, 1, 0.01),   text("Amt"), popuppostfix(" %"), $rsliderstyle

        button bounds(5, 30, 38, 17),   channel("env2osc1"), identchannel("ENV2OSC1_BUTTON"), text("OSC1"), value(0), $checkboxstyle
        button bounds(43, 30, 38, 17),   channel("env2osc2"), identchannel("ENV2OSC2_BUTTON"), text("OSC2"), value(0), $checkboxstyle
        button bounds(81, 30, 38, 17),  channel("env2osc3"), identchannel("ENV2OSC3_BUTTON"), text("OSC3"), value(0), $checkboxstyle
        button bounds(119, 30, 38, 17),  channel("env2osc4"), identchannel("ENV2OSC4_BUTTON"), text("OSC4"), value(0), $checkboxstyle
        button bounds(5, 7, 38, 17),     channel("env2amp"), text("Amp"), radiogroup(103), value(1), $buttonstyle 
        button bounds(43, 7, 38, 17),     channel("env2pitch"), text("Pitch"), radiogroup(103), $buttonstyle 
        button bounds(81, 7, 38, 17),     channel("env2morph"), text("Morph"), radiogroup(103), $buttonstyle  
        button bounds(119, 7, 38, 17),     channel("env2filter"), text("Filter"), radiogroup(103), $buttonstyle
        button bounds(175, 30, 38, 17),  channel("env2slope"), text("EXP","LIN"), value(0), $buttonstyleon 
    }
    groupbox bounds(0, 20, 230, 110), visible(0) , identchannel("GROUP_ENV3"), plant("GUI_ENV3"){
        image    bounds(0, 0, 230, 110), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(172,4,50,20), text("ENV3")
        rslider  bounds(0, 58, 45, 45),    channel("env3a"),        range(0.001, 10, 0.001, 0.5, 0.001),   text("A"), popuppostfix(" s"),   $rsliderstyle
        rslider  bounds(38, 58, 45, 45),   channel("env3d"),        range(0, 10, 0, 0.5, 0.001),   text("D"), popuppostfix(" s"),  $rsliderstyle
        rslider  bounds(76, 58, 45, 45),   channel("env3s"),        range(0.001, 1, 0.001, 0.5, 0.01),   text("S"), popuppostfix(" "),     $rsliderstyle
        rslider  bounds(114, 58, 45, 45),   channel("env3r"),        range(0.001, 10, 0.001, 0.5, 0.001),   text("R"), popuppostfix(" s"), $rsliderstyle
        rslider  bounds(170, 58, 45, 45),  channel("env3amt"), identchannel("ENV3AMT_BUTTON"),  range(-100, 100, 100, 1, 0.01),   text("Amt"), popuppostfix(" %"), $rsliderstyle

        button bounds(5, 30, 38, 17),   channel("env3osc1"), identchannel("ENV3OSC1_BUTTON"), text("OSC1"), value(0), $checkboxstyle
        button bounds(43, 30, 38, 17),   channel("env3osc2"), identchannel("ENV3OSC2_BUTTON"), text("OSC2"), value(0), $checkboxstyle
        button bounds(81, 30, 38, 17),  channel("env3osc3"), identchannel("ENV3OSC3_BUTTON"), text("OSC3"), value(0), $checkboxstyle
        button bounds(119, 30, 38, 17),  channel("env3osc4"), identchannel("ENV3OSC4_BUTTON"), text("OSC4"), value(0), $checkboxstyle
        button bounds(5, 7, 38, 17),     channel("env3amp"), text("Amp"), radiogroup(104), value(1), $buttonstyle 
        button bounds(43, 7, 38, 17),     channel("env3pitch"), text("Pitch"), radiogroup(104), $buttonstyle 
        button bounds(81, 7, 38, 17),     channel("env3morph"), text("Morph"), radiogroup(104), $buttonstyle  
        button bounds(119, 7, 38, 17),     channel("env3filter"), text("Filter"), radiogroup(104), $buttonstyle
        button bounds(175, 30, 38, 17),  channel("env3slope"), text("EXP","LIN"), value(0), $buttonstyleon 
    }
    groupbox bounds(0, 20, 230, 110), visible(0) , identchannel("GROUP_ENV4"), plant("GUI_ENV4"){
        image    bounds(0, 0, 230, 110), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(172,4,50,20), text("ENV4")
        rslider  bounds(0, 58, 45, 45),    channel("env4a"),        range(0.001, 10, 0.001, 0.25, 0.001),   text("A"), popuppostfix(" s"),   $rsliderstyle
        rslider  bounds(38, 58, 45, 45),   channel("env4d"),        range(0, 10, 0, 0.25, 0.001),   text("D"), popuppostfix(" s"),  $rsliderstyle
        rslider  bounds(76, 58, 45, 45),   channel("env4s"),        range(0.001, 1, 0.001, 0.5, 0.01),   text("S"), popuppostfix(" "),     $rsliderstyle
        rslider  bounds(114, 58, 45, 45),   channel("env4r"),        range(0.001, 10, 0.001, 0.25, 0.001),   text("R"), popuppostfix(" s"), $rsliderstyle
        rslider  bounds(170, 58, 45, 45),  channel("env4amt"), identchannel("ENV4AMT_BUTTON"),   range(-100, 100, 100, 1, 0.01),   text("Amt"), popuppostfix(" %"), $rsliderstyle

        button bounds(5, 30, 38, 17),   channel("env4osc1"), identchannel("ENV4OSC1_BUTTON"), text("OSC1"), value(0), $checkboxstyle
        button bounds(43, 30, 38, 17),   channel("env4osc2"), identchannel("ENV4OSC2_BUTTON"), text("OSC2"), value(0), $checkboxstyle
        button bounds(81, 30, 38, 17),  channel("env4osc3"), identchannel("ENV4OSC3_BUTTON"), text("OSC3"), value(0), $checkboxstyle
        button bounds(119, 30, 38, 17),  channel("env4osc4"), identchannel("ENV4OSC4_BUTTON"), text("OSC4"), value(0), $checkboxstyle
        button bounds(5, 7, 38, 17),     channel("env4amp"), text("Amp"), radiogroup(105), value(1), $buttonstyle 
        button bounds(43, 7, 38, 17),     channel("env4pitch"), text("Pitch"), radiogroup(105), $buttonstyle 
        button bounds(81, 7, 38, 17),     channel("env4morph"), text("Morph"), radiogroup(105), $buttonstyle  
        button bounds(119, 7, 38, 17),     channel("env4filter"), text("Filter"), radiogroup(105), $buttonstyle
        button bounds(175, 30, 38, 17),  channel("env4slope"), text("EXP","LIN"), value(0), $buttonstyleon 
    }
    image        bounds(205, 2, 18, 18), file("img/warning.png"), identchannel("WARN_ENVSIGN"), visible(0)
    rslider  bounds(188,3,50,20), popuptext("You are using 2 envelopes of the same type on the same oscillator. Unexpected behaviour may occur. Click on the 'About...' button (top right) & read the user manual for more infos."), identchannel("WARN_ENVMSG"), visible(0), alpha(0)
    
    button bounds(0, 3, 50, 19),text("ENV1"),channel("ENV1_BUTTON"), radiogroup(106), $buttontabstyle, value(1)
    button bounds(50, 3, 50, 19),text("ENV2"),channel("ENV2_BUTTON"), radiogroup(106), $buttontabstyle
    button bounds(100, 3, 50, 19),text("ENV3"),channel("ENV3_BUTTON"), radiogroup(106), $buttontabstyle
    button bounds(150, 3, 50, 19),text("ENV4"),channel("ENV4_BUTTON"), radiogroup(106), $buttontabstyle
    
}


;*******************LFO
;1
groupbox bounds(320, 140, 230, 125), , identchannel("GROUP_LFOALL"), plant("GUI_LFOALL"){
    image        bounds(0, 0, 230, 110), colour(0,10,20)
    groupbox bounds(0, 20, 230, 110), visible(1) , identchannel("GROUP_LFO1"), plant("GUI_LFO1"){
        image    bounds(0, 0, 230, 110), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(172,4,50,20), text("LFO1")
        combobox bounds(5, 64, 70, 20), fontcolour("silver") channel("lfo1shape_B"), items("-","Sine","Triangle","Square","Saw Dn","Saw Up","Random"), value(1), colour(20,30,40), align("centre")
        rslider  bounds(55, 64, 20, 20),    channel("lfo1shape_K"),       range(1, 7, 0, 1, 1), $rsliderhiddenstyle
        label    bounds(13,88,50,11), text("Shape")
        rslider  bounds(80, 58, 45, 45),   channel("lfo1gain"),        range(0, 20, 0.5, 0.25, 0.01),   text("Gain"), popuppostfix(" "),  $rsliderstyle
        rslider  bounds(126, 58, 45, 45),   channel("lfo1rate"),        range(0, 1000, 4, 0.25, 0.01),   text("Rate"), popuppostfix(" Hz"), identchannel("lfo1rate_i")     $rsliderstyle
        image        bounds(126, 58, 45, 45), colour(20, 30, 40, 255), channel("lfo1hide") identchannel("lfo1hide_i")
        rslider  bounds(126, 58, 45, 45),   channel("lfo1mult"), value(0),     range(1, 32, 1, 1, 1),   text("Rate"), popupprefix("1/"), popuppostfix(" Beat"), identchannel("lfo1mult_i")     $rsliderstyle
        rslider  bounds(170, 58, 45, 45),  channel("lfo1amt"),         range(-100, 100, 100, 1, 0.01),   text("Amt"), popuppostfix(" %"), $rsliderstyle

        button bounds(5, 30, 38, 17),      channel("lfo1osc1"), identchannel("LFO1OSC1_BUTTON"), text("OSC1"),value(1), $checkboxstyle
        button bounds(43, 30, 38, 17),     channel("lfo1osc2"), identchannel("LFO1OSC2_BUTTON"), text("OSC2"),value(1), $checkboxstyle
        button bounds(81, 30, 38, 17),     channel("lfo1osc3"), identchannel("LFO1OSC3_BUTTON"), text("OSC3"),value(1), $checkboxstyle
        button bounds(119, 30, 38, 17),    channel("lfo1osc4"), identchannel("LFO1OSC4_BUTTON"), text("OSC4"),value(1), $checkboxstyle
        label bounds(150, 34, 70, 10), text("BPM Sync")  
        checkbox bounds(210, 34, 10, 10), channel("lfo1bpm"), text("BPM Sync"), $checkboxstyle
         
        button bounds(5, 7, 38, 17),     channel("lfo1amp"), text("Amp"), radiogroup(107), value(1), $buttonstyle 
        button bounds(43, 7, 38, 17),     channel("lfo1pitch"), text("Pitch"), radiogroup(107), $buttonstyle 
        button bounds(81, 7, 38, 17),     channel("lfo1morph"), text("Morph"), radiogroup(107), $buttonstyle  
        button bounds(119, 7, 38, 17),     channel("lfo1filter"), text("Filter"), radiogroup(107), $buttonstyle 
    }
     groupbox bounds(0, 20, 230, 110), visible(0) , identchannel("GROUP_LFO2"), plant("GUI_LFO2"){
        image    bounds(0, 0, 230, 110), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(172,4,50,20), text("LFO2")
        combobox bounds(5, 64, 70, 20), fontcolour("silver") channel("lfo2shape_B"), items("-","Sine","Triangle","Square","Saw Dn","Saw Up","Random"), value(1), colour(20,30,40), align("centre")
        rslider  bounds(55, 64, 20, 20),    channel("lfo2shape_K"),       range(1, 7, 0, 1, 1), $rsliderhiddenstyle
        label    bounds(13,88,50,11), text("Shape")
        rslider  bounds(80, 58, 45, 45),   channel("lfo2gain"),        range(0, 20, 0.5, 0.25, 0.01),   text("Gain"), popuppostfix(" "),  $rsliderstyle
        rslider  bounds(126, 58, 45, 45),   channel("lfo2rate"),        range(0, 1000, 4, 0.25, 0.01),   text("Rate"), popuppostfix(" Hz"), identchannel("lfo2rate_i")     $rsliderstyle
        image        bounds(126, 58, 45, 45), colour(20, 30, 40, 255), channel("lfo2hide") identchannel("lfo2hide_i")
        rslider  bounds(126, 58, 45, 45),   channel("lfo2mult"), value(0),     range(1, 32, 1, 1, 1),   text("Rate"), popupprefix("1/"), popuppostfix(" Beat"), identchannel("lfo2mult_i")     $rsliderstyle
        rslider  bounds(170, 58, 45, 45),  channel("lfo2amt"),         range(-100, 100, 100, 1, 0.01),   text("Amt"), popuppostfix(" %"), $rsliderstyle

        button bounds(5, 30, 38, 17),      channel("lfo2osc1"), identchannel("LFO2OSC1_BUTTON"), text("OSC1"), $checkboxstyle
        button bounds(43, 30, 38, 17),     channel("lfo2osc2"), identchannel("LFO2OSC2_BUTTON"), text("OSC2"), $checkboxstyle
        button bounds(81, 30, 38, 17),     channel("lfo2osc3"), identchannel("LFO2OSC3_BUTTON"), text("OSC3"), $checkboxstyle
        button bounds(119, 30, 38, 17),    channel("lfo2osc4"), identchannel("LFO2OSC4_BUTTON"), text("OSC4"), $checkboxstyle
        label bounds(150, 34, 70, 10), text("BPM Sync")  
        checkbox bounds(210, 34, 10, 10), channel("lfo2bpm"), text("BPM Sync"), $checkboxstyle
        
        button bounds(5, 7, 38, 17),       channel("lfo2amp"), text("Amp"), radiogroup(108), value(1), $buttonstyle 
        button bounds(43, 7, 38, 17),      channel("lfo2pitch"), text("Pitch"), radiogroup(108), $buttonstyle 
        button bounds(81, 7, 38, 17),      channel("lfo2morph"), text("Morph"), radiogroup(108), $buttonstyle  
        button bounds(119, 7, 38, 17),     channel("lfo2filter"), text("Filter"), radiogroup(108), $buttonstyle 
    }
   
    button bounds(0, 3, 50, 19),text("LFO1"),channel("LFO1_BUTTON"), radiogroup(109),  $buttontabstyle, value(1)
    button bounds(50, 3, 50, 19),text("LFO2"),channel("LFO2_BUTTON"), radiogroup(109),  $buttontabstyle
}





;*******************FILTER
;1
groupbox bounds(5, 140, 305, 125), , identchannel("GROUP_FILTERALL"), plant("GUI_FILTERALL"){
    image        bounds(0, 0, 305, 125), colour(0,10,20)
    groupbox bounds(0, 20, 305, 125), visible(1) , identchannel("GROUP_FILTER1"), plant("GUI_FILTER1"){
        image    bounds(0, 0, 305, 110), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(208,4,100,20), text("FILTER1")
        combobox bounds(55, 15, 55, 20), fontcolour("silver") channel("filter1mode1_B"), items("-","LP3","LP2","HP","BP"), value(1), colour(20,30,40), align("centre")
        rslider bounds(83, 15, 35, 20), range(1, 5, 0, 1, 1),              channel("filter1mode1_K"), $rsliderhiddenstyle
        rslider bounds(120, 8, 45, 45) range(0, 20000, 1300, 0.25, 0.01),     channel("filter1cut1"), text("Cut 1.1"), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(180, 25, 45, 40) range(0.1, 10, 0.1, 1, 0.01),    channel("filter1res1"), text("Res 1.1"), popuppostfix(" "), $rsliderstyle
        rslider bounds(230, 25, 60, 40) range(-100, 100, 0, 1, 0.01),       channel("filter1keytrack1"),  text("Keytrack 1.1"), popuppostfix(" %"), $rsliderstyle
        label    bounds(57,38,50,11), text("Filter 1.1")
        combobox bounds(55, 65, 55, 20), fontcolour("silver") channel("filter1mode2_B"), items("-","LP3","LP2","HP","BP"), value(1), colour(20,30,40), align("centre")
        rslider bounds(83, 65, 35, 20), range(1, 5, 0, 1, 1),             channel("filter1mode2_K"), $rsliderhiddenstyle
        rslider bounds(120, 58, 45, 45) range(0, 20000, 1300, 0.25, 0.01), channel("filter1cut2"), text("Cut 1.2"), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(180, 65, 45, 40) range(0.1, 10, 0.1, 1, 0.01),   channel("filter1res2"), text("Res 1.2"), popuppostfix(" "), $rsliderstyle
        rslider bounds(230, 65, 60, 40) range(-100, 100, 0, 1, 0.01),       channel("filter1keytrack2"),  text("Keytrack 1.2"), popuppostfix(" %"), $rsliderstyle
        label    bounds(57,88,50,11), text("Filter 1.2")

        button bounds(5, 15, 38, 17), channel("filter1osc1"), text("OSC1"), value(1), identchannel("FILTER1BUT1"), $checkboxstyle
        button bounds(5, 35, 38, 17),channel("filter1osc2"), text("OSC2"), value(1), identchannel("FILTER1BUT2"), $checkboxstyle
        button bounds(5, 55, 38, 17), channel("filter1osc3"), text("OSC3"), value(1), identchannel("FILTER1BUT3"), $checkboxstyle
        button bounds(5, 75, 38, 17),channel("filter1osc4"), text("OSC4"), value(1), identchannel("FILTER1BUT4"), $checkboxstyle
    }
    groupbox bounds(0, 20, 305, 125), visible(0) , identchannel("GROUP_FILTER2"), plant("GUI_FILTER2"){
        image    bounds(0, 0, 305, 110), colour(20, 30, 40, 255), $bgtabstyle        
        label    bounds(208,4,100,20), text("FILTER2")
        combobox bounds(55, 15, 55, 20), fontcolour("silver") channel("filter2mode1_B"), items("-","LP3","LP2","HP","BP"), value(1), colour(20,30,40), align("centre")
        rslider bounds(83, 15, 35, 20), range(1, 5, 0, 1, 1),              channel("filter2mode1_K"), $rsliderhiddenstyle
        rslider bounds(120, 8, 45, 45) range(0, 20000, 1300, 0.25, 0.01),     channel("filter2cut1"), text("Cut 2.1"), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(180, 25, 45, 40) range(0.1, 10, 0.1, 1, 0.01),    channel("filter2res1"), text("Res 2.1"), popuppostfix(" "), $rsliderstyle
        rslider bounds(230, 25, 60, 40) range(-100, 100, 0, 1, 0.01),       channel("filter2keytrack1"),  text("Keytrack 2.1"), popuppostfix(" %"), $rsliderstyle
        label    bounds(57,38,50,11), text("Filter 2.1")
        combobox bounds(55, 65, 55, 20), fontcolour("silver") channel("filter2mode2_B"), items("-","LP3","LP2","HP","BP"), value(1), colour(20,30,40), align("centre") 
        rslider bounds(83, 65, 35, 20), range(1, 5, 0, 1, 1),             channel("filter2mode2_K"), $rsliderhiddenstyle
        rslider bounds(120, 58, 45, 45) range(0, 20000, 1300, 0.25, 0.01), channel("filter2cut2"), text("Cut 2.2"), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(180, 65, 45, 40) range(0.1, 10, 0.1, 1, 0.01),   channel("filter2res2"), text("Res 2.2"), popuppostfix(" "), $rsliderstyle
        rslider bounds(230, 65, 60, 40) range(-100, 100, 0, 1, 0.01),       channel("filter2keytrack2"),  text("Keytrack 2.2"), popuppostfix(" %"), $rsliderstyle
        label    bounds(57,88,50,11), text("Filter 2.2")

        button bounds(5, 15, 38, 17), channel("filter2osc1"), text("OSC1"), identchannel("FILTER2BUT1"), $checkboxstyle
        button bounds(5, 35, 38, 17),channel("filter2osc2"), text("OSC2"), identchannel("FILTER2BUT2"), $checkboxstyle
        button bounds(5, 55, 38, 17), channel("filter2osc3"), text("OSC3"), identchannel("FILTER2BUT3"), $checkboxstyle
        button bounds(5, 75, 38, 17),channel("filter2osc4"), text("OSC4"), identchannel("FILTER2BUT4"), $checkboxstyle
    }
    button bounds(0, 3, 50, 19),text("FILTER1"), channel("FILTER1_BUTTON"), radiogroup(110), $buttontabstyle, value(1)
    button bounds(50, 3, 50, 19),text("FILTER2"), channel("FILTER2_BUTTON"), radiogroup(110), $buttontabstyle
}


;**************EFFECT
groupbox bounds(5, 275, 545, 115), , identchannel("GROUP_EFFECTALL"), plant("GUI_EFFECTALL"){
    image        bounds(0, 0, 545, 190), colour(0,10,20)
    groupbox bounds(0, 20, 545, 190), visible(1) , identchannel("GROUP_EFFECT1"), plant("GUI_EFFECT1"){
        image    bounds(-1, 0, 548, 99), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(365,4,130,20), text("DISTORTION")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("distswitch"), $checkboxstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 100, 1, 0.01), channel("drywetdist"), popuppostfix(" %"), text("Dry/Wet"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("distlevel"), text("Volume"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(80, 20, 65, 65), range(0, 100, 63, 1, 0.01), channel("distpowershape"), text("Power"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(160, 20, 65, 65), range(0, 100, 0, 1, 0.01), channel("distsaturator"), text("Saturator"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(240, 20, 65, 65), range(0, 100, 0, 1, 0.01), channel("distbitcrusher"), text("Bit Crusher"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(320, 20, 65, 65), range(0, 100, 0, 0.25, 0.01), channel("distfoldover"), text("Foldover"), popuppostfix(" %"), $rsliderstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identchannel("GROUP_EFFECT3"), plant("GUI_EFFECT3"){
        image    bounds(-1, 0, 548, 99), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(430,4,100,20), text("EQ")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("eqswitch"), $checkboxstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 100, 1, 0.01), channel("dryweteq"), text("Dry/Wet"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("eqlevel"), text("Volume"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(180, 20, 65, 65), range(1, 20000, 300, 0.5, 0.01), channel("eqlowfreq"), text("Low"), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(260, 20, 65, 65), range(1, 20000, 8000, 0.5, 0.01), channel("eqhighfreq"), text("High"), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(140, 40, 45, 45), range(0, 2.5, 0.75, 1, 0.01), channel("eqlowamp"), text("Gain"), popuppostfix(" "), $rsliderstyle
        rslider bounds(320, 40, 45, 45), range(0, 2.5, 1.5, 1, 0.01), channel("eqhighamp"), text("Gain"), popuppostfix(" "), $rsliderstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identchannel("GROUP_EFFECT2"), plant("GUI_EFFECT2"){
        image    bounds(-1, 0, 548, 99), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(400,4,100,20), text("CHORUS")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("chorusswitch"), $checkboxstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 50, 1, 0.01), channel("drywetchorus"), text("Dry/Wet"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("choruslevel"), text("Volume"), popuppostfix(" %"), $rsliderstyle
        rslider  bounds(120, 20, 65, 65), text("Rate"), channel("chorusrate"), range(0.001, 40, 0.8,0.2), popuppostfix(" Hz"), $rsliderstyle
        rslider  bounds(180, 20, 65, 65), text("Depth"), channel("chorusdepth"), range(0, 100.00, 30), popuppostfix(" %"), $rsliderstyle
        rslider  bounds(320, 20, 65, 65), text("Offset"), channel("chorusoffset"), range(0.0001,0.1,0.001,0.5,0.0001), popuppostfix(" s"), $rsliderstyle
        rslider  bounds(260, 20, 65, 65), text("Width"), channel("choruswidth"), range(0, 100.00, 100), popuppostfix(" %"), $rsliderstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identchannel("GROUP_EFFECT5"), plant("GUI_EFFECT5"){
        image    bounds(-1, 0, 548, 99), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(410,4,100,20), text("DELAY")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("delswitch"), $checkboxstyle
        rslider bounds(20, 30, 50, 50), text("Tempo"), 	 		channel("deltempo"), 	range(40, 500, 128, 1, 1), popuppostfix(" BPM"), $rsliderstyle
        label bounds(5, 13, 70, 13), text("BPM Sync")  
        checkbox bounds(75, 15, 10, 10), channel("delClockSource"), text("BPM Sync"), value(1), $checkboxstyle
        rslider bounds(95, 30, 50, 50), text("Rhy.Mult."),		channel("delRhyMlt"), 	range(1, 16, 4, 1, 1), popuppostfix(" "), $rsliderstyle     
        rslider bounds(160, 30, 50, 50), text("Damping"),  		channel("deldamp"), 	range(0,20000, 3800,0.5), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(225, 30, 50, 50), text("Feedback"), 		channel("delfback"), 	range(0, 100.00, 60), popuppostfix(" %"), $rsliderstyle  
        rslider bounds(290, 30, 50, 50), text("Width"),			channel("delwidth"), 	range(0,  100.00, 100), popuppostfix(" %"), $rsliderstyle   
        rslider bounds(485, 40, 45, 45), range(0, 100, 25, 1, 0.01), channel("drywetdel"), text("Dry/Wet"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("dellevel"), text("Volume"), popuppostfix(" %"), $rsliderstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identchannel("GROUP_EFFECT4"), plant("GUI_EFFECT4"){
        image    bounds(-1, 0, 548, 99), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(405,4,100,20), text("REVERB")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("revswitch"), $checkboxstyle
        button bounds(22, 33, 30, 30), text("L","H"), channel("revtype"), popuppostfix(" "), $checkboxstyle
        label    bounds(12,65,50,11), text("Type")
        rslider bounds(65, 30, 50, 50), text("Size"), channel("revsize"), 	range(0, 100.00,85), popuppostfix(" %"), $rsliderstyle
        rslider bounds(115, 30, 50, 50), text("Pre-del."), channel("revdel"), 	range(0, 1000, 0, 0.25, 1), popuppostfix(" ms"), $rsliderstyle
        rslider bounds(165, 30, 50, 50), text("Damping"), channel("revdamp"), 	range(0, 20000, 10000, 0.5, 0.01), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(215, 30, 50, 50), text("Pitch Mod."), channel("revpitchmod"), range(0, 20.0, 1), identchannel("REVPITCHMOD_BUTTON"), popuppostfix(" "), $rsliderstyle
        rslider bounds(265, 30, 60, 50), text("Width Red."), channel("revwred"), range(0, 100.0, 0), popuppostfix(" %"), $rsliderstyle
        rslider bounds(330, 30, 50, 50), text("LPF"), channel("revCutLPF"), range(0, 20000, 20000, 0.5), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(370, 30, 50, 50), text("HPF"), channel("revCutHPF"), range(0, 20000, 200, 0.5), popuppostfix(" Hz"), $rsliderstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 15, 1, 0.01), channel("drywetrev"), text("Dry/Wet"), popuppostfix(" %"), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(0, 100.0, 100), channel("revlevel"), text("Volume"), popuppostfix(" %"), $rsliderstyle
    }
    groupbox bounds(0, 20, 545, 190), visible(0) , identchannel("GROUP_EFFECT6"), plant("GUI_EFFECT6"){
        image    bounds(-1, 0, 548, 99), colour(20, 30, 40, 255), $bgtabstyle
        label    bounds(360,4,130,20), text("COMPRESSOR")
        button  bounds(500, 5, 40, 20), text("OFF", "ON"), channel("compswitch"), $checkboxstyle
        rslider bounds(20, 30, 50, 50), channel("compthresh"), text("Threshold"), range(0,120,0), popuppostfix(" dB"), $rsliderstyle
        rslider bounds(95, 30, 50, 50), channel("compatt"), text("Attack"),  range(0,1,0.04,0.5,0.001), popuppostfix(" s"), $rsliderstyle
        rslider bounds(160, 30, 50, 50), channel("comprel"), text("Release"), range(0,2,0.01,0.5,0.001), popuppostfix(" s"), $rsliderstyle
        rslider bounds(225, 30, 50, 50), channel("compratio"), text("Ratio"), range(1,300,5,0.25), popuppostfix(" "), $rsliderstyle
        rslider bounds(440, 40, 45, 45), range(-40,40,20), channel("compgain"), text("Gain"), popuppostfix(" "), $rsliderstyle
        ;hrange   bounds(10, 64, 420, 30), channel("compLowKnee","compHighKnee"), range(0, 120, 48:60), alpha(0),  visible(0)
        rslider bounds(300, 30, 50, 50), channel("compLowKnee"), text("Low Knee"), range(0,120,48), popuppostfix(" dB"), $rsliderstyle
        rslider bounds(350, 30, 50, 50), channel("compHighKnee"), text("High Knee"), range(0,120,60), popuppostfix(" dB"), $rsliderstyle
        rslider bounds(485, 40, 45, 45), range(0, 100, 100, 1, 0.01), channel("drywetcomp"), text("Dry/Wet"), popuppostfix(" %"), $rsliderstyle
    }
    button bounds(0, 3, 50, 19),text("DIST"), channel("EFFECT1_BUTTON"), radiogroup(111), $buttontabstyle, value(1)
    button bounds(50, 3, 50, 19),text("EQ"), channel("EFFECT3_BUTTON"), radiogroup(111), $buttontabstyle
    button bounds(100, 3, 50, 19),text("CHORUS"), channel("EFFECT2_BUTTON"), radiogroup(111), $buttontabstyle
    button bounds(150, 3, 50, 19),text("DELAY"), channel("EFFECT5_BUTTON"), radiogroup(111), $buttontabstyle
    button bounds(200, 3, 50, 19),text("REVERB"), channel("EFFECT4_BUTTON"), radiogroup(111), $buttontabstyle
    button bounds(250, 3, 50, 19),text("COMP"), channel("EFFECT6_BUTTON"), radiogroup(111), $buttontabstyle
}


image    bounds(0, 0, 719, 468), visible(0), colour(0, 0, 0), alpha(0.8), identchannel("GROUP_BGABOUT")
button bounds(0, 0, 719, 468), visible(0), colour(0,0,0), alpha(0), identchannel("GROUP_BGCLOSE"), channel("BGCLOSE")

;ABOUT TAB
groupbox bounds(100, 100, 500, 300), visible(0) , identchannel("GROUP_ABOUT"), plant("GUI_ABOUT"){
    image    bounds(0, 0, 500, 300), colour(20, 30, 40, 255)
    label    bounds(0,20,500,20), text("ToneZ by T0NIT0 RMX - v1.3")
    infobutton bounds(400, 18, 100, 23), text("Check for updates"), file("https://t0nit0rmx.github.io/utils/tonez_uc?v=1.3"), latched(0), $buttonstyle
    label    bounds(130,100,100,10), text("[[USER MANUAL]]")
    image        bounds(100, 70, 150, 72), file("img/AboutMan.png"), colour(0,0,0,0.5)
    infobutton bounds(100, 70, 150, 72), file("https://t0nit0rmx.github.io/redir/ToneZAboutM.html"), colour(0,0,0), alpha(0)
    label    bounds(290,100,100,10), text("[[DISCORD CHAT]]")
    image        bounds(260, 70, 150, 72), file("img/AboutDisc.png"), colour(0,0,0,0.5)
    infobutton bounds(260, 70, 150, 72), file("https://t0nit0rmx.github.io/redir/ToneZAboutD.html"), colour(0,0,0), alpha(0)
    label    bounds(100,180,150,10), text("[[DOWNLAOD PRESET PACKS]]")
    image        bounds(100, 152, 150, 72), file("img/AboutPP.png"), colour(0,0,0,0.5)
    infobutton bounds(100, 152, 150, 72), file("https://t0nit0rmx.github.io/redir/ToneZAboutPP.html"), colour(0,0,0), alpha(0)
    label    bounds(260,180,150,10), text("[[DONATE ON PAYPAL]]")
    image        bounds(260, 152, 150, 72), file("img/AboutDon.png"), colour(0,0,0,0.5)
    infobutton bounds(260, 152, 150, 72), file("https://t0nit0rmx.github.io/redir/ToneZAboutP.html"), colour(0,0,0), alpha(0)

    groupbox bounds(100, 250, 200, 50) alpha(0.6){
        image    bounds(0, 0, 200, 50), colour(20, 30, 40, 255)
        label    bounds(40,10,100,10), text("Made in Cabbage"), align("left")
        label    bounds(40,25,100,10), text("cabbageaudio.com"), align("left")
        image        bounds(5, 10, 25, 40), file("img/CabbageLogo.svg")
        infobutton bounds(0, 0, 200, 50), file("http://cabbageaudio.com/"), colour(0,0,0), alpha(0)
    }
    groupbox bounds(260, 250, 200, 50) alpha(0.6){
        image    bounds(0, 0, 200, 50), colour(20, 30, 40, 255)
        label    bounds(40,10,100,10), text("T0NIT0 RMX - 2019"), align("left")
        label    bounds(40,25,100,10), text("t0nit0rmx.github.io"), align("left")
        image        bounds(0, 10, 28, 28), file("img/logov5.svg")
        infobutton bounds(0, 0, 200, 50), file("https://t0nit0rmx.github.io/"), colour(0,0,0), alpha(0)
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


gkoldnum init 0
gknum init 0

gkactive	init	0


;SAW
gitable ftgen 0, 0, 8193, 7, 0, 4096, 1, 0, -1, 4096, 0
; bandlimited versions
gi_nextfree vco2init-gitable, gitable+1, 1.05, 128, 2^16, gitable
gitable_bl = -gitable

;SINE				
gitable1 ftgen 0, 0, 8193, 10, 1			
gi_nextfree1 vco2init-gitable1, gitable1+1, 1.05, 128, 2^16, gitable1
gitable_bl1 = -gitable1

;SQUARE
gitable2 ftgen 0, 0, 8193, 7, 0, 0, 1, 4096, 1, 0, -1, 4096, -1, 0, 0
gi_nextfree2 vco2init-gitable2, gitable2+1, 1.05, 128, 2^16, gitable2
gitable_bl2 = -gitable2

;SQUARE (3/4)
gitable3 ftgen 0, 0, 8193, 7, 0, 0, 1, 6144, 1, 0, -1, 2048, -1, 0, 0
gi_nextfree3 vco2init-gitable3, gitable3+1, 1.05, 128, 2^16, gitable3
gitable_bl3 = -gitable3

;TRIANGLE
gitable4 ftgen 0, 0, 8193, 7, 0, 2048, 1, 4096, -1, 2048, 0			
gi_nextfree4 vco2init-gitable4, gitable4+1, 1.05, 128, 2^16, gitable4
gitable_bl4 = -gitable4

;SPECTRAL1
gitable5 ftgen 0, 0, 8193, 6, 1, 1024, -1, 1024, 1, 512, -.5, 512, .5, 128, -.5, 64, 1, 128, -.5, 64, 1, 128, -.5, 672, 1, 128, -.5, 64, .1, 128, -.1, 136, 0
gi_nextfree5 vco2init-gitable5, gitable5+1, 1.05, 128, 2^16, gitable5
gitable_bl5 = -gitable5

;SPECTRAL2
gitable6 ftgen 0, 0, 513, 13, 1, 1, 0, 0, 0, -.1, 0, .3, 0, -.5, 0, .7, 0, -.9, 0, 1, 0, -1, 0 
gi_nextfree6 vco2init-gitable6, gitable6+1, 1.05, 128, 2^16, gitable6
gitable_bl6 = -gitable6

;SPECTRAL3
gitable7 ftgen 0, 0, 513, 13, 1, 1, 0, 0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, -.1, 0, .1, 0, -.2, .3, 0, -.7, 0, .2, 0, -.1
gi_nextfree7 vco2init-gitable7, gitable7+1, 1.05, 128, 2^16, gitable7
gitable_bl7 = -gitable7

;SPECTRAL4
gitable8 ftgen 0, 0, 513, 13, 1, 1, 0, 1, -.8, 0, .6, 0, 0, 0, .4, 0, 0, 0, 0, .1, -.2, -.3, .5
gi_nextfree8 vco2init-gitable8, gitable8+1, 1.05, 128, 2^16, gitable8
gitable_bl8 = -gitable8

;SPECTRAL5
gitable10 ftgen 0, 0, 1025, 13, 1, 1, 0, 5, 0, 5, 0 ,10
; bandlimited versions
gi_nextfree10 vco2init-gitable10, gitable10+1, 1.05, 128, 2^16, gitable10
gitable_bl10 = -gitable10

;SPECTRAL6
gitable11 ftgen 0, 0, 2^10,9, 1,2,0, 3,2,0, 9,0.333,180
; bandlimited versions
gi_nextfree11 vco2init-gitable11, gitable11+1, 1.05, 128, 2^16, gitable11
gitable_bl11 = -gitable11

;DIST
gidist ftgen 0, 0, 512, "tanh", -10, 10, 0

;LFO
gitable9 ftgen 0, 0, 513, 21, 6, 5.74
gi_nextfree9 vco2init-gitable9, gitable9+1, 1.05, 128, 2^16, gitable9
gitable_bl9 = -gitable9







opcode	StChorus,aa,aakkak
;Iain McCurdy, 2012
;http://iainmccurdy.org/csound.html
	ainL,ainR,krate,kdepth,aoffset,kwidth	xin			;READ IN INPUT ARGUMENTS
	kmix=0.5
	ilfoshape	ftgentmp	0, 0, 131072, 19, 1, 0.5, 0,  0.5	;POSITIVE DOMAIN ONLY SINE WAVE
	kporttime	linseg	0,0.001,0.02					;RAMPING UP PORTAMENTO VARIABLE
	kChoDepth	portk	kdepth*0.01, kporttime				;SMOOTH VARIABLE CHANGES WITH PORTK
	aChoDepth	interp	kChoDepth					;INTERPOLATE TO CREATE A-RATE VERSION OF K-RATE VARIABLE
	amodL 		osciliktp 	krate, ilfoshape, 0			;LEFT CHANNEL LFO
	amodR 		osciliktp 	krate, ilfoshape, kwidth*0.5		;THE PHASE OF THE RIGHT CHANNEL LFO IS ADJUSTABLE
	amodL		=		(amodL*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (LEFT CHANNEL)
	amodR		=		(amodR*aChoDepth)+aoffset			;RESCALE AND OFFSET LFO (RIGHT CHANNEL)
	aChoL		vdelay	ainL, amodL*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (LEFT CHANNEL) 
	aChoR		vdelay	ainR, amodR*1000, 1.2*1000			;CREATE VARYING DELAYED / CHORUSED SIGNAL (RIGHT CHANNEL)
	aoutL		ntrpol 	ainL*0.6, aChoL*0.6, kmix			;MIX DRY AND WET SIGNAL (LEFT CHANNEL)
	aoutR		ntrpol 	ainR*0.6, aChoR*0.6, kmix			;MIX DRY AND WET SIGNAL (RIGHT CHANNEL)
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


opcode SuperOsc2, aa, akikkkkkkikkkkk

    aVol, kFreq, iPhase, kWave1, kWave2, kMorph, kDet, kWid, kVoice, iRetrig, kOct, kSemi, kCent, kpb, kNoteTrig xin
    amixL = 0
    amixR = 0 
    aVol/=100
    if k(aVol)!=0 then
        aVol limit aVol, 0, 1
        kWave1-=1
        kWave2-=1
        idiff1 chnget "detsh1"
        idiff2 chnget "detsh2"
        idiff3 chnget "detsh3"
        idiff4 chnget "detsh4"
        
        
       
        gkDT[] fillarray -.30/8-idiff4, .30/8+idiff4, -.30/5-idiff3, .30/5+idiff3, -.30/3-idiff2, .30/3+idiff2, -.30/2-idiff1, .30/2+idiff1
            
       
        gkP[] fillarray -.5, .5, .5, -.5, -.5, .5, .5, -.5
        kD[] = gkDT*kDet/100 + 1
        kW[] = gkP*kWid/100 + 0.5
        kWi[] = 1 - kW
        icnt = i(kVoice)
        kindex = 0 
        kchange changed kFreq,kOct,kSemi,kpb
        kfactor = kFreq*octave(kOct)*semitone(kSemi)*cent(kCent)*cent(kpb)
        
        if iRetrig=1 then
            iPhaseOsc = iPhase/360
        else
            iPhaseOsc = 2
        endif
     
          loop:   
            kfine = kD[kindex]
            aindex phasorbnk kfactor*kfine, kindex, icnt, iPhaseOsc
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
            itab[] fillarray ifn0, ifn1, ifn4, ifn2, ifn3, ifn5, ifn6, ifn7, ifn8, ifn8
    
            if kMorph > 99.99 then
                kMorph = 99.99
            endif
            
            asig     tabmorphak aindex, kMorph/100, kWave1, kWave2, ifn0, ifn1, ifn4, ifn2, ifn3, ifn5, ifn6, ifn7, ifn8, ifn10, ifn11, ifn11
           
                      if kWave1 == 11 then
                    asig rand 100,2,i(kindex)
                    asig limit asig, 0, 1          
                endif
            rireturn
            
        if(kVoice>1)then
            amixL = amixL+asig*kW[kindex]
            amixR = amixR+asig*kWi[kindex]
        else
            amixL = amixL+asig
            amixR = amixR+asig
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


opcode MultiFilter, aa, aaakkkkkkkkk
    al, ar, aenvfilter1, kmodefilter1, kcut1, kres1, ktrack1, kmodefilter2, kcut2, kres2, ktrack2, kpitch xin

    ascaled1 keytrack kpitch, a(kcut1)*156.25+aenvfilter1, ktrack1/100
    ascaled2 keytrack kpitch, a(kcut2), ktrack2/100
    kscaled2 rms ascaled2
    alpl = al
    alpr = ar
    if (kcut1 != 128) then
        if kmodefilter1 == 2 then
        ascaled1 limit ascaled1, 0, 12500 
            alpl lpf18  al, ascaled1, kres1,0
            alpr lpf18 ar, ascaled1, kres1,0
            
        endif
        if kmodefilter1 == 3 then
        ascaled1 limit ascaled1*2, 0, 21000
            alpl zdf_2pole al, ascaled1, kres1,0
            alpr zdf_2pole ar, ascaled1, kres1,0
        endif
    endif
    if (kcut1 != 0) then
        if kmodefilter1 == 4 then
            ascaled1 limit ascaled1, 0, 21000
            alpl zdf_2pole al, ascaled1, kres1,1
            alpr zdf_2pole ar, ascaled1, kres1,1
        endif
    endif
        if kmodefilter1 == 5 then
            ascaled1 limit ascaled1, 0, 21000
            alpl zdf_2pole al, ascaled1, kres1,2
            alpr zdf_2pole ar, ascaled1, kres1,2
        endif
    
    
    if (kcut2 != 128) then
        if kmodefilter2 == 2 then
        ascaled2 limit ascaled2, 0, 12500 
            alpl lpf18 alpl, ascaled2, kres2,0
            alpr lpf18 alpr, ascaled2, kres2,0
        endif
        if kmodefilter2 == 3 then
            kscaled2 limit kscaled2*2, 0, 21000
            alpl zdf_2pole alpl, ascaled2, kres2,0
            alpr zdf_2pole alpr, ascaled2, kres2,0
        endif
    endif
    if (kcut2 != 0) then
        if kmodefilter2 == 4 then
            kscaled2 limit kscaled2, 0, 21000
            alpl zdf_2pole alpl, ascaled2, kres2,1
            alpr zdf_2pole alpr, ascaled2, kres2,1
        endif
    endif
        if kmodefilter2 == 5 then
            kscaled2 limit kscaled2, 0, 21000
            alpl zdf_2pole alpl, ascaled2, kres2,2
            alpr zdf_2pole alpr, ascaled2, kres2,2
        endif
    denorm alpl,alpr
    xout alpl,alpr
endop


opcode	fastLFO,k,kkkkk
    kshape, kgain, krate, kmult, ksync xin
    if kshape>1 then    
        setksmps 16
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
            klfo = -klfo
        elseif kshape==6 then
            klfo lfo kgain, krate, 5
            klfo = -klfo
        elseif kshape==7 then
            klfo randi kgain, krate
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
    gienv1amp chnget "env1amp"
    gienv1filter chnget "env1filter"
    gienv1pitch chnget "env1pitch"
    gienv1morph chnget "env1morph"
    gienv1slope chnget "env1slope"
            
    gienv2osc1 chnget "env2osc1"
    gienv2osc2 chnget "env2osc2"
    gienv2osc3 chnget "env2osc3"
    gienv2osc4 chnget "env2osc4"
        
    gkenv2amt chnget "env2amt"
    gkenv2amt/=100
    gienv2amp chnget "env2amp"
    gienv2filter chnget "env2filter"
    gienv2pitch chnget "env2pitch"
    gienv2morph chnget "env2morph"
    gienv2slope chnget "env2slope"
            
    gienv3osc1 chnget "env3osc1"
    gienv3osc2 chnget "env3osc2"
    gienv3osc3 chnget "env3osc3"
    gienv3osc4 chnget "env3osc4"
        
    gkenv3amt chnget "env3amt"
    gkenv3amt/=100
    gienv3amp chnget "env3amp"
    gienv3filter chnget "env3filter"
    gienv3pitch chnget "env3pitch"
    gienv3morph chnget "env3morph"
    gienv3slope chnget "env3slope"
    
    gienv4osc1 chnget "env4osc1"
    gienv4osc2 chnget "env4osc2"
    gienv4osc3 chnget "env4osc3"
    gienv4osc4 chnget "envosc4"
        
    gkenv4amt chnget "env4amt"
    gkenv4amt/=100 
    gienv4amp chnget "env4amp"
    gienv4filter chnget "env4filter"
    gienv4pitch chnget "env4pitch"
    gienv4morph chnget "env4morph"
    gienv4slope chnget "env4slope"
     
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
    gkosc1det chnget "osc1det"
    gkosc1wid chnget "osc1wid"
    gkosc1voice chnget "osc1voice"
    gkosc1octave chnget "osc1octave"
    gkosc1semi chnget "osc1semi"
    gkosc1cent chnget "osc1cent"
    gkosc1pan chnget "osc1pan"
    
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
   
    gkfilter2osc1 chnget "filter2osc1"
    gkfilter2osc2 chnget "filter2osc2"
    gkfilter2osc3 chnget "filter2osc3"
    gkfilter2osc4 chnget "filter2osc4"
   
    gklfo1shape chnget "lfo1shape_B"
    gklfo1gain chnget "lfo1gain"
    gklfo1rate chnget "lfo1rate"
    gklfo1mult chnget "lfo1mult"
    gklfo1bpm chnget "lfo1bpm"
    gklfo1amt chnget "lfo1amt"
    gklfo1amt/=100
    
    gklfo2shape chnget "lfo2shape_B"
    gklfo2gain chnget "lfo2gain"
    gklfo2rate chnget "lfo2rate"
    gklfo2mult chnget "lfo2mult"
    gklfo2bpm chnget "lfo2bpm"
    gklfo2amt chnget "lfo2amt"
    gklfo2amt/=100 
      
    gklfo1osc1 chnget "lfo1osc1"
    gklfo1osc2 chnget "lfo1osc2"
    gklfo1osc3 chnget "lfo1osc3"
    gklfo1osc4 chnget "lfo1osc4"
    
    gklfo2osc1 chnget "lfo2osc1"
    gklfo2osc2 chnget "lfo2osc2"
    gklfo2osc3 chnget "lfo2osc3"
    gklfo2osc4 chnget "lfo2osc4"
    
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

    cngoto gkNoteTrig==1&&gkSARetrig==1, SHAPE_ENV
    reinit SHAPE_ENV
    SHAPE_ENV:
    if gienv1osc1+gienv1osc2+gienv1osc3+gienv1osc4!=0 then
        
        if gienv1slope==0 then
            aenv_1 mxadsr i(gkenv1a), i(gkenv1d), i(gkenv1s), i(gkenv1r), 0.01, 1
        else
            aenv_1 madsr i(gkenv1a), i(gkenv1d), i(gkenv1s), i(gkenv1r), 0.01, 1
        endif
        aenv_1 limit aenv_1,0,1
    else
        aenv_1 = 0
    endif
    
    if gienv2osc1+gienv2osc2+gienv2osc3+gienv2osc4!=0 then
        if gienv2slope==0 then
            aenv_2 mxadsr i(gkenv2a), i(gkenv2d), i(gkenv2s), i(gkenv2r), 0.01, 1
        else
            aenv_2 madsr i(gkenv2a), i(gkenv2d), i(gkenv2s), i(gkenv2r), 0.01, 1
        endif
        aenv_2 limit aenv_2,0,1
    else
        aenv_2 = 0
    endif
    
    if gienv3osc1+gienv3osc2+gienv3osc3+gienv3osc4!=0 then
        if gienv3slope==0 then
            aenv_3 mxadsr i(gkenv3a), i(gkenv3d), i(gkenv3s), i(gkenv3r), 0.01, 1
        else
            aenv_3 madsr i(gkenv3a), i(gkenv3d), i(gkenv3s), i(gkenv3r), 0.01, 1
        endif
        aenv_3 limit aenv_3,0,1
    else
        aenv_3 = 0
    endif
    
    if gienv4osc1+gienv4osc2+gienv4osc3+gienv4osc4!=0 then
        if gienv4slope==0 then
            aenv_4 mxadsr i(gkenv4a), i(gkenv4d), i(gkenv4s), i(gkenv4r), 0.01, 1
        else
            aenv_4 madsr i(gkenv4a), i(gkenv4d), i(gkenv4s), i(gkenv4r), 0.01, 1
        endif
        aenv_4 limit aenv_4,0,1
    else
        aenv_4 = 0
    endif
    
    rireturn
	
	if gklfo1shape != 1 then
        klfo1 fastLFO gklfo1shape, gklfo1gain, gklfo1rate, gklfo1mult, gklfo1bpm
    else
        klfo1 = 1
    endif
    if gklfo2shape != 1 then
        klfo2 fastLFO gklfo2shape, gklfo2gain, gklfo2rate, gklfo2mult, gklfo2bpm
    else
        klfo2 = 1
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
    
    
    ;ENV : MORPH
    gkosc1morph init 0
    gkosc2morph init 0
    gkosc3morph init 0
    gkosc4morph init 0
            
    if (gienv1morph==1) then
        if (gienv1osc1==1) then
            gkosc1morph = gkosc1morph + gkenv1amt*100*downsamp(aenv_1)
        endif
        if (gienv1osc2==1) then
            gkosc2morph = gkosc2morph + gkenv1amt*100*downsamp(aenv_1)
        endif
        if (gienv1osc3==1) then
            gkosc3morph = gkosc3morph + gkenv1amt*100*downsamp(aenv_1)
        endif
        if (gienv1osc4==1) then
            gkosc4morph = gkosc4morph + gkenv1amt*100*downsamp(aenv_1)
        endif
    endif
    if (gienv2morph==1) then
        if (gienv2osc1==1) then
            gkosc1morph = gkosc1morph + gkenv2amt*100*downsamp(aenv_2)
        endif
        if (gienv2osc2==1) then
            gkosc2morph = gkosc2morph + gkenv2amt*100*downsamp(aenv_2)
        endif
        if (gienv2osc3==1) then
            gkosc3morph = gkosc3morph + gkenv2amt*100*downsamp(aenv_2)
        endif
        if (gienv2osc4==1) then
            gkosc4morph = gkosc4morph + gkenv2amt*100*downsamp(aenv_2)
        endif
    endif
    if (gienv3morph==1) then
        if (gienv3osc1==1) then
            gkosc1morph = gkosc1morph + gkenv3amt*100*downsamp(aenv_3)
        endif
        if (gienv3osc2==1) then
            gkosc2morph = gkosc2morph + gkenv3amt*100*downsamp(aenv_3)
        endif
        if (gienv3osc3==1) then
            gkosc3morph = gkosc3morph + gkenv3amt*100*downsamp(aenv_3)
        endif
        if (gienv3osc4==1) then
            gkosc4morph = gkosc4morph + gkenv3amt*100*downsamp(aenv_3)
        endif
    endif
    if (gienv4morph==1) then
        if (gienv4osc1==1) then
            gkosc1morph = gkosc1morph + gkenv4amt*100*downsamp(aenv_4)
        endif
        if (gienv4osc2==1) then
            gkosc2morph = gkosc2morph + gkenv4amt*100*downsamp(aenv_4)
        endif
        if (gienv4osc3==1) then
            gkosc3morph = gkosc3morph + gkenv4amt*100*downsamp(aenv_4)
        endif
        if (gienv4osc4==1) then
            gkosc4morph = gkosc4morph + gkenv4amt*100*downsamp(aenv_4)
        endif
    endif
       
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
    
    
    
    ;FILTER ROUTING + LFO : FILTER
    if (gilfo1filter==1) then
        if (gklfo1osc1==1) then
            gkfilter1cut1=gkfilter1cut1+(klfo1*gklfo1amt*10)
        endif
        if (gklfo1osc2==1) then
            gkfilter2cut1=gkfilter2cut1+(klfo1*gklfo1amt*10)
        endif
    endif
        
    if (gilfo2filter==1) then
        if (gklfo2osc1==1) then
            gkfilter1cut1=gkfilter1cut1+(klfo2*gklfo2amt*10)
        endif
        if (gklfo2osc2==1) then
            gkfilter2cut1=gkfilter2cut1+(klfo2*gklfo2amt*10)
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
    if (gilfo1amp==1) then
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
        
    if (gilfo2amp==1) then
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
   
        
    ;LFO : PITCH
    if (gilfo1pitch==1) then
        if (gklfo1osc1==1) then
            kosc1pitch=kosc1pitch+(klfo1*gklfo1amt)
        endif
        if (gklfo1osc2==1) then
            kosc2pitch=kosc2pitch+(klfo1*gklfo1amt)
        endif
        if (gklfo1osc3==1) then
            kosc3pitch=kosc3pitch+(klfo1*gklfo1amt)
        endif
        if (gklfo1osc4==1) then
            kosc4pitch=kosc4pitch+(klfo1*gklfo1amt)
        endif
    endif
        
    if (gilfo2pitch==1) then
        if (gklfo2osc1==1) then
            kosc1pitch=kosc1pitch+(klfo2*gklfo2amt)
        endif
        if (gklfo2osc2==1) then
            kosc2pitch=kosc2pitch+(klfo2*gklfo2amt)
        endif
        if (gklfo2osc3==1) then
            kosc3pitch=kosc3pitch+(klfo2*gklfo2amt)
        endif
        if (gklfo2osc4==1) then
            kosc4pitch=kosc4pitch+(klfo2*gklfo2amt)
        endif
    endif
        
    
    ;LFO : MORPH    
    if (gilfo1morph==1) then
        if (gklfo1osc1==1) then
            gkosc1morph =gkosc1morph +(klfo1*gklfo1amt*10)
        endif
        if (gklfo1osc2==1) then
            gkosc2morph =gkosc2morph +(klfo1*gklfo1amt*10)
        endif
        if (gklfo1osc3==1) then
            gkosc3morph =gkosc3morph +(klfo1*gklfo1amt*10)
        endif
        if (gklfo1osc4==1) then
            gkosc4morph =gkosc4morph +(klfo1*gklfo1amt*10)
        endif
    endif
    
    if (gilfo2morph==1) then
        if (gklfo2osc1==1) then
            gkosc1morph =gkosc1morph +(klfo2*gklfo2amt*10)
        endif
        if (gklfo2osc2==1) then
            gkosc2morph =gkosc2morph +(klfo2*gklfo2amt*10)
        endif
        if (gklfo2osc3==1) then
            gkosc3morph =gkosc3morph +(klfo2*gklfo2amt*10)
        endif
        if (gklfo2osc4==1) then
            gkosc4morph =gkosc4morph +(klfo2*gklfo2amt*10)
        endif
    endif    
        

    kvoicechange changed chnget:k("osc1voice"), chnget:k("osc2voice"), chnget:k("osc3voice"), chnget:k("osc4voice")
    if kvoicechange ==1 then
        reinit VOICECHANGE
    endif
      
    VOICECHANGE:                      
    a1l ,a1r SuperOsc2 gkosc1vol*aosc1envamp*kvel, kosc1pitch, iosc1phase, gkosc1wave1, gkosc1wave2, gkosc1morph, gkosc1det, gkosc1wid, gkosc1voice, iosc1retrig, gkosc1octave, gkosc1semi, gkosc1cent, gkpb, gkNoteTrig
    a1l ntrpol a1l*2,a(0),gkosc1pan/100
    a1r ntrpol a(0),a1r*2,gkosc1pan/100
    a2l ,a2r SuperOsc2 gkosc2vol*aosc2envamp*kvel, kosc2pitch, iosc2phase, gkosc2wave1, gkosc2wave2, gkosc2morph, gkosc2det, gkosc2wid, gkosc2voice, iosc2retrig, gkosc2octave, gkosc2semi, gkosc2cent, gkpb, gkNoteTrig
    a2l ntrpol a2l*2,a(0),gkosc2pan/100
    a2r ntrpol a(0),a2r*2,gkosc2pan/100
    a3l ,a3r SuperOsc2 gkosc3vol*aosc3envamp*kvel, kosc3pitch, iosc3phase, gkosc3wave1, gkosc3wave2, gkosc3morph, gkosc3det, gkosc3wid, gkosc3voice, iosc3retrig, gkosc3octave, gkosc3semi, gkosc3cent, gkpb, gkNoteTrig
    a3l ntrpol a3l*2,a(0),gkosc3pan/100
    a3r ntrpol a(0),a3r*2,gkosc3pan/100
    a4l ,a4r SuperOsc2 gkosc4vol*aosc4envamp*kvel, kosc4pitch, iosc4phase, gkosc4wave1, gkosc4wave2, gkosc4morph, gkosc4det, gkosc4wid, gkosc4voice, iosc4retrig, gkosc4octave, gkosc4semi, gkosc4cent, gkpb, gkNoteTrig  
    a4l ntrpol a4l*2,a(0),gkosc4pan/100
    a4r ntrpol a(0),a4r*2,gkosc4pan/100
    rireturn
                                 
     ; FILTER
    a1fl=a1l
    a1fr=a1r 
    a2fl=a2l
    a2fr=a2r
    a3fl=a3l
    a3fr=a3r
    a4fl=a4l
    a4fr=a4r 
        
    aenvfilter1 interp kenvfilter1
    aenvfilter2 interp kenvfilter2 
    kpitch=knum
                            
    if (gkfilter1osc1==1 && (gkfilter1mode1 != 0 || gkfilter1mode2 != 0)) then
        a1l, a1r MultiFilter a1l, a1r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch
    endif
    if (gkfilter1osc2==1 && (gkfilter1mode1 != 0 || gkfilter1mode2 != 0)) then
        a2l, a2r MultiFilter a2l, a2r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch
    endif
    if (gkfilter1osc3==1 && (gkfilter1mode1 != 0 || gkfilter1mode2 != 0)) then
        a3l, a3r MultiFilter a3l, a3r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch
    endif
    if (gkfilter1osc4==1 && (gkfilter1mode1 != 0 || gkfilter1mode2 != 0)) then
        a4l, a4r MultiFilter a4l, a4r, aenvfilter1, gkfilter1mode1, gkfilter1cut1, gkfilter1res1, gkfilter1keytrack1, gkfilter1mode2, gkfilter1cut2, gkfilter1res2, gkfilter1keytrack2, kpitch
    endif
        
    if (gkfilter2osc1==1 && (gkfilter2mode1 != 0 || gkfilter2mode2 != 0)) then
        a1l, a1r MultiFilter a1l, a1r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch
    endif
    if (gkfilter2osc2==1 && (gkfilter2mode1 != 0 || gkfilter2mode2 != 0)) then
        a2l, a2r MultiFilter a2l, a2r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch
    endif
    if (gkfilter2osc3==1 && (gkfilter2mode1 != 0 || gkfilter2mode2 != 0)) then
        a3l, a3r MultiFilter a3l, a3r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch
    endif
    if (gkfilter2osc4==1 && (gkfilter2mode1 != 0 || gkfilter2mode2 != 0)) then
        a4l, a4r MultiFilter a4l, a4r, aenvfilter2, gkfilter2mode1, gkfilter2cut1, gkfilter2res1, gkfilter2keytrack1, gkfilter2mode2, gkfilter2cut2, gkfilter2res2, gkfilter2keytrack2, kpitch
    endif
        
    asuml = (a1l+a2l+a3l+a4l)
    asumr = (a1r+a2r+a3r+a4r)
    
    gkNoteTrig	=	0
    xout asuml,asumr
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
    kTrigOSCMODEENV changed chnget:k("env1amp"), chnget:k("env1pitch"), chnget:k("env1morph"), chnget:k("env1filter"), chnget:k("env2amp"), chnget:k("env2pitch"), chnget:k("env2morph"), chnget:k("env2filter"), chnget:k("env3amp"), chnget:k("env3pitch"), chnget:k("env3morph"), chnget:k("env3filter"), chnget:k("env4amp"), chnget:k("env4pitch"), chnget:k("env4morph"), chnget:k("env4filter")
    kTrigOSCMODELFO changed chnget:k("lfo1amp"), chnget:k("lfo1pitch"), chnget:k("lfo1filter"), chnget:k("lfo2amp"), chnget:k("lfo2pitch"), chnget:k("lfo2filter")
    kTrigFILTER changed chnget:k("FILTER1_BUTTON"), chnget:k("FILTER2_BUTTON")
    kTrigEFFECT changed chnget:k("EFFECT1_BUTTON"), chnget:k("EFFECT2_BUTTON"), chnget:k("EFFECT3_BUTTON"), chnget:k("EFFECT4_BUTTON"), chnget:k("EFFECT5_BUTTON"), chnget:k("EFFECT6_BUTTON")
    kTrigOSCFILTER changed chnget:k("filter1osc1"), chnget:k("filter1osc2"), chnget:k("filter1osc3"), chnget:k("filter1osc4"), chnget:k("filter2osc1"), chnget:k("filter2osc2"), chnget:k("filter2osc3"), chnget:k("filter1osc4")    
    kTrigENVOSC changed chnget:k("env1osc1"), chnget:k("env1osc2"), chnget:k("env1osc3"), chnget:k("env1osc4"), chnget:k("env2osc1"), chnget:k("env2osc2"), chnget:k("env2osc3"), chnget:k("env2osc4"), chnget:k("env3osc1"), chnget:k("env3osc2"), chnget:k("env3osc3"), chnget:k("env3osc4"), chnget:k("env4osc1"),chnget:k("env4osc2"), chnget:k("env4osc3"), chnget:k("env4osc4") 
    

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
        if ktot1 > 1 || ktot2 > 1 || ktot3 > 1 || ktot4 > 1 || ktot5 > 1 || ktot6 > 1 || ktot7 > 1 || ktot8 > 1 || ktot9 > 1 || ktot10 > 1 || ktot11 > 1 || ktot12 > 1 || ktot13 > 1 || ktot14 > 1 then
            chnset "visible(1)", "WARN_ENVSIGN"
            chnset "visible(1)", "WARN_ENVMSG"
        else
            chnset "visible(0)", "WARN_ENVSIGN"
            chnset "visible(0)", "WARN_ENVMSG"
        endif
    endif
    
    kAbout changed chnget:k("BUTTON_ABOUT")
    kPanic changed chnget:k("BUTTON_PANIC")
    kClose changed chnget:k("BGCLOSE")
    if kAbout==1 then
		chnset "visible(1)", "GROUP_ABOUT"
		chnset "visible(1)", "GROUP_BGABOUT"
		chnset "visible(1)", "GROUP_BGCLOSE" 
    endif 
    if kClose==1 then
		chnset "visible(0)", "GROUP_ABOUT"
		chnset "visible(0)", "GROUP_BGABOUT" 
		chnset "visible(0)", "GROUP_BGCLOSE" 
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
		
		Smessage sprintfk "visible(%d)", chnget:k("env1filter")==1 ? 0 : 1
		chnset Smessage, "ENV1OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("env1filter")==1 ? 0 : 1
		chnset Smessage, "ENV1OSC4_BUTTON"
		if (chnget:k("env1filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "ENV1OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "ENV1OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "ENV1OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "ENV1OSC2_BUTTON"
        endif
        
        Smessage sprintfk "visible(%d)", chnget:k("env2filter")==1 ? 0 : 1
		chnset Smessage, "ENV2OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("env2filter")==1 ? 0 : 1
		chnset Smessage, "ENV2OSC4_BUTTON"
		if (chnget:k("env2filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "ENV2OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "ENV2OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "ENV2OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "ENV2OSC2_BUTTON"
        endif
        
        Smessage sprintfk "visible(%d)", chnget:k("env3filter")==1 ? 0 : 1
		chnset Smessage, "ENV3OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("env3filter")==1 ? 0 : 1
		chnset Smessage, "ENV3OSC4_BUTTON"
		if (chnget:k("env3filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "ENV3OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
		    chnset Smessage, "ENV3OSC2_BUTTON"
		else
		    Smessage sprintfk "text(%s)","OSC1"
		    chnset Smessage, "ENV3OSC1_BUTTON"
            Smessage sprintfk "text(%s)","OSC2"
		    chnset Smessage, "ENV3OSC2_BUTTON"
        endif
        
        Smessage sprintfk "visible(%d)", chnget:k("env4filter")==1 ? 0 : 1
		chnset Smessage, "ENV4OSC3_BUTTON"
		Smessage sprintfk "visible(%d)", chnget:k("env4filter")==1 ? 0 : 1
		chnset Smessage, "ENV4OSC4_BUTTON"
		if (chnget:k("env4filter")==1) then
		    Smessage sprintfk "text(%s)","FILTER1"
		    chnset Smessage, "ENV4OSC1_BUTTON"
		    Smessage sprintfk "text(%s)","FILTER2"
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

    if kTrigOSCFILTER==1 then
        if (chnget:k("filter2osc1")==1) then
             
            Smessage sprintfk "visible(%d)", chnget:k("filter2osc2")==1 ? 1 : 0
		chnset Smessage, "FILTER2BUT2"
            chnset "value(0)", "FILTER2BUT2"
            chnset "value(0)", "FILTER2BUT3"
            chnset "value(0)", "FILTER2BUT4"
        endif
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
    gkosc1wid chnget "osc1wid"
    gkosc1voice chnget "osc1voice"
    gkosc1octave chnget "osc1octave"
    gkosc1semi chnget "osc1semi"
    gkosc1cent chnget "osc1cent"
    gkosc1pan chnget "osc1pan"
    
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
   
    gkfilter2osc1 chnget "filter2osc1"
    gkfilter2osc2 chnget "filter2osc2"
    gkfilter2osc3 chnget "filter2osc3"
    gkfilter2osc4 chnget "filter2osc4"
   
    gklfo1shape chnget "lfo1shape_B"
    gklfo1gain chnget "lfo1gain"
    gklfo1rate chnget "lfo1rate"
    gklfo1mult chnget "lfo1mult"
    gklfo1bpm chnget "lfo1bpm"
    gklfo1amt chnget "lfo1amt"
    gklfo1amt/=100
    
    gklfo2shape chnget "lfo2shape_B"
    gklfo2gain chnget "lfo2gain"
    gklfo2rate chnget "lfo2rate"
    gklfo2mult chnget "lfo2mult"
    gklfo2bpm chnget "lfo2bpm"
    gklfo2amt chnget "lfo2amt"
    gklfo2amt/=100 
      
    gklfo1osc1 chnget "lfo1osc1"
    gklfo1osc2 chnget "lfo1osc2"
    gklfo1osc3 chnget "lfo1osc3"
    gklfo1osc4 chnget "lfo1osc4"
    
    gklfo2osc1 chnget "lfo2osc1"
    gklfo2osc2 chnget "lfo2osc2"
    gklfo2osc3 chnget "lfo2osc3"
    gklfo2osc4 chnget "lfo2osc4"
    
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
    

    if changed:k(chnget:S("saveFile")) == 1 then
        gSFileName chnget "saveFile"
        event "i", 1003, 0, .1 
    endif


    if changed:k(chnget:S("openFile")) == 1 then
        gSFileName chnget "openFile"
        gSspecificDelim = "/"  
        event "i", 1002, 0, .1
    endif

    if changed:k(chnget:S("box")) == 1 then
        gSFileName chnget "box"
        gSspecificDelim = "\\"
        event "i", 1002, 0, .1
    endif   
    
    if changed:k(chnget:S("opendir")) == 1 then
        gSpath chnget "opendir"
        event "i", 1004, 0, .1
    endif
    
    
    
    if changed:k(chnget:k("reload")) == 1 then
        gSFileName = "."
        event "i", 1002, 0, .1
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

instr 6
    schedule 4005, 0.1, 1
endin

instr EFFECT
    asuml chnget "outputL"
    asumr chnget "outputR"
    denorm asuml,asumr
    ;DIST  
    kdistswitch chnget "distswitch"
    if kdistswitch == 1 then
        kdrywetdist chnget "drywetdist"
        kpowershape chnget "distpowershape"
        ksaturator chnget "distsaturator"
        kbitcrusher chnget "distbitcrusher"
        kbitcrusher scale kbitcrusher/100,1,16
        
        kfoldover chnget "distfoldover"
        
        kdistlevel chnget "distlevel"
        ifullscale=0dbfs    
        if kpowershape > 0 then
            if kpowershape > 94 then
                kpowershape = 94
            endif
            asumldist 	powershape 	asuml, 1.001-kpowershape/100, ifullscale
            asumrdist	powershape 	asumr, 1.001-kpowershape/100, ifullscale
        else
            asumldist=asuml
            asumrdist=asumr
        endif
	    
        if ksaturator > 0 then
            asumldist distort1 asumldist, ksaturator/100+0.1, 1, 0, 0, 1
            asumrdist distort1 asumrdist, ksaturator/100+0.1, 1, 0, 0, 1
        endif
        
        if kbitcrusher < 16 || kfoldover > 1 then
            asumldist	LoFi	asumldist,kbitcrusher*0.6,kfoldover*256/100
            asumrdist	LoFi	asumrdist,kbitcrusher*0.6,kfoldover*256/100
        endif
    else
        kdrywetdist = 0
    endif
        
    amixdistL ntrpol asuml, asumldist*kdistlevel/100, kdrywetdist/100
    amixdistR ntrpol asumr, asumrdist*kdistlevel/100, kdrywetdist/100
    denorm amixdistL,amixdistR
        
        
    ;CHORUS
    kchorusswitch chnget "chorusswitch"  
    if kchorusswitch == 1 then
        kdrywetchorus chnget "drywetchorus"  
        kchorusporttime	linseg	0,0.001,0.05                                                     
        kchorusrate chnget "chorusrate"
        kchorusdepth chnget "chorusdepth"
        kchorusoffset chnget "chorusoffset"
        kchoruswidth chnget "choruswidth"
        kchoruslevel chnget "choruslevel"
        kchoruslevel	portk	kchoruslevel,kchorusporttime
        kchorusoffset	portk	kchorusoffset,kchorusporttime*0.5
        aoffset	interp	kchorusoffset
 
        kchorustrem	rspline	0,-1,0.1,0.5
        kchorustrem	pow	2,kchorustrem
        achorusL,achorusR	StChorus	amixdistL,amixdistR,kchorusrate,kchorusdepth/100*kchorustrem,aoffset,kchoruswidth/100
    else
        kdrywetchorus = 0
    endif    
    
    amixchorusL ntrpol		amixdistL, achorusL*kchoruslevel/100, kdrywetchorus/100	
    amixchorusR ntrpol		amixdistR, achorusR*kchoruslevel/100, kdrywetchorus/100
    denorm amixchorusL,amixchorusR
   
       
    ;EQ
    keqswitch chnget "eqswitch"
    if keqswitch == 1 then
        kdryweteq chnget "dryweteq"
        keqlowfreq chnget "eqlowfreq"
        keqhighfreq chnget "eqhighfreq"
        keqlowamp chnget "eqlowamp"
        keqhighamp chnget "eqhighamp"
        keqlevel chnget "eqlevel"
        if keqlowamp != 1 then
           asumleqlow pareq amixchorusL, keqlowfreq, keqlowamp, 0.71,1
           asumreqlow pareq amixchorusR, keqlowfreq, keqlowamp, 0.71,1
        else
           asumleqlow=amixchorusL
           asumreqlow=amixchorusR
        endif
        
        if keqhighamp != 1 then
            asumleqhigh pareq asumleqlow, keqhighfreq, keqhighamp, 0.71,2
            asumreqhigh pareq asumreqlow, keqhighfreq, keqhighamp, 0.71,2
        else
            asumleqhigh=asumleqlow
            asumreqhigh=asumreqlow
        endif
    else
        kdryweteq = 0
    endif
    
    amixeqL ntrpol amixchorusL, asumleqhigh*keqlevel/100, kdryweteq/100
    amixeqR ntrpol amixchorusR, asumreqhigh*keqlevel/100, kdryweteq/100
    denorm amixeqL,amixeqR

    ;REV
    krevswitch		chnget	"revswitch"
    if krevswitch == 1 then
        kdrywetrev		chnget	"drywetrev"
        krevtype		chnget  "revtype"
        krevsize		chnget	"revsize"
        krevdamp		chnget	"revdamp"
        krevpitchmod   chnget	"revpitchmod"
	    krevwred chnget "revwred"
	
        krevCutLPF     chnget  "revCutLPF"
        krevCutHPF     chnget  "revCutHPF"
        
        krevlevel     chnget  "revlevel"
        krevdel chnget "revdel"
        arevdel = krevdel
        denorm		amixeqL, amixeqR
        if krevtype==0 then
           
            kSwitch		changed		krevpitchmod	
            if	kSwitch=1	then
                reinit	UPDATE		
            endif				
            UPDATE:				
            arvbL, arvbR reverbsc 	amixeqL, amixeqR, krevsize/100, krevdamp, sr, i(krevpitchmod)
            rireturn			
        else
            arvbL, arvbR 	freeverb 	amixeqL, amixeqR, krevsize/100, 1-krevdamp/20000
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
    else
        kdrywetrev = 0
    endif
    
    
    arvbL = arvbL + (arvbR*(krevwred/100))
    arvbR = arvbR + (arvbL*(krevwred/100))
    

	amixrevL ntrpol		amixeqL, arvbL*krevlevel/100, kdrywetrev/100	
	amixrevR ntrpol		amixeqR, arvbR*krevlevel/100, kdrywetrev/100 
    denorm amixrevL,amixrevR
    
    ;DELAY
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
            delayw	amixrevL

         ;left channel delay (note that 'atime' is doubled) 
         abuf	delayr	10			;
         atapL	deltap3	atime*2
         atapL	tone	atapL,kdeldamp
            delayw	afirst+(atapL*kdelfback/100)

         ;right channel delay (note that 'atime' is doubled) 
         abuf	delayr	10
         atapR	deltap3	atime*2
         atapR	tone	atapR,kdeldamp
            delayw	amixrevR+(atapR*kdelfback/100)
	
         ;create width control. note that if width is zero the result is the same as 'simple' mode
         atapL	=	afirst+atapL+(atapR*(1-kdelwidth/100))
         atapR	=	atapR+(atapL*(1-kdelwidth/100))
    else
        kdrywetdel = 0
    endif
	
	amixdelL		ntrpol		amixrevL, atapL*kdellevel/100, kdrywetdel/100	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE EFFECT SIGNAL
	amixdelR		ntrpol		amixrevR, atapR*kdellevel/100, kdrywetdel/100 ;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE EFFECT SIGNAL
    denorm amixdelL,amixdelR
    

    ;COMP
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
        aC_L 	compress amixdelL, amixdelL, kcompthresh, kcompLowKnee, kcompHighKnee, kcompratio, kcompatt, kcomprel, i(klook)	
        aC_R 	compress amixdelR, amixdelR, kcompthresh, kcompLowKnee, kcompHighKnee, kcompratio, kcompatt, kcomprel, i(klook)
        aC_L	*=	ampdb(kcompgain)							
        aC_R	*=	ampdb(kcompgain)
    else
        kdrywetcomp = 0
    endif
    
    amixcompL ntrpol		amixdelL, aC_L, kdrywetcomp/100	
	amixcompR ntrpol		amixdelR, aC_R, kdrywetcomp/100 
    denorm amixcompL,amixcompR
    
    
    outs		amixcompL*gkMasterVolume*0.3/100, amixcompR*gkMasterVolume*0.3/100

    chnclear "outputL"
    chnclear "outputR"
endin



instr 1002 ;restore presets
    iInit strcmp gSFileName, "."
    if iInit == 1 then
             
        if strrindex(gSFileName, ".tzp") == -1 then
            gSFileName strcat gSFileName, ".tzp"
        endif
    
    
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
        chnset ktemp,"lfo1shape_K"
        ktemp chnget "lfo2shape_B"
        chnset ktemp,"lfo2shape_K"
        ktemp chnget "filter1mode1_B"
        chnset ktemp,"filter1mode1_K"
        ktemp chnget "filter1mode2_B"
        chnset ktemp,"filter1mode2_K"
        ktemp chnget "filter2mode1_B"
        chnset ktemp,"filter2mode1_K"
        ktemp chnget "filter2mode2_B"
        chnset ktemp,"filter2mode2_K"
        
        
        ires strindex gSFileName, "dummy"
    if ires !=0 then
        istrlen    strlen   gSFileName
    
        idelimiter strrindex gSFileName, gSspecificDelim
        S2    strsub gSFileName, idelimiter + 1, istrlen 
        idelimiter strrindex S2, "."
        S3 strsub S2, 0, idelimiter
        
        idelimiter strrindex S3, "/"
        if idelimiter != -1 then
            S2    strsub S3, idelimiter + 1, istrlen  ; "String2"
            idelimiter strrindex S2, "."
            S3 strsub S2, 0, idelimiter
        endif
        
        Smessage sprintfk "text(\"%s\")",S3
        chnset Smessage, "PresetName"
      
        chnset Smessage, "PresetStringI"   
        chnset "active(1)","reloadI"
    endif
    chnset "dummy","saveFile"
    
    
        
        
        ficlose gSFileName
    endif
    chnset "refreshfiles()", "boxI"







endin

;===============================================
instr 1003 ;save presets
    
    iInit strcmp gSFileName, "."
    if iInit == 1 then
    
    if strrindex(gSFileName, ".tzp") == -1 then
        gSFileName strcat gSFileName, ".tzp"
    endif

    fprints gSFileName, "%f %f %f %f ", chnget:i("pbrange"), chnget:i("monopoly"), chnget:i("LegTim"), chnget:i("SARetrig")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("osc1wave1_B"), chnget:i("osc1wave2_B"), chnget:i("osc1morph"), chnget:i("osc1vol"), chnget:i("osc1det"), chnget:i("osc1wid"), chnget:i("osc1phase"), chnget:i("osc1voice"), chnget:i("osc1octave"), chnget:i("osc1semi"), chnget:i("osc1cent"), chnget:i("osc1retrig"), chnget:i("osc1pan")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("osc2wave1_B"), chnget:i("osc2wave2_B"), chnget:i("osc2morph"), chnget:i("osc2vol"), chnget:i("osc2det"), chnget:i("osc2wid"), chnget:i("osc2phase"), chnget:i("osc2voice"), chnget:i("osc2octave"), chnget:i("osc2semi"), chnget:i("osc2cent"), chnget:i("osc2retrig"), chnget:i("osc2pan")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("osc3wave1_B"), chnget:i("osc3wave2_B"), chnget:i("osc3morph"), chnget:i("osc3vol"), chnget:i("osc3det"), chnget:i("osc3wid"), chnget:i("osc3phase"), chnget:i("osc3voice"), chnget:i("osc3octave"), chnget:i("osc3semi"), chnget:i("osc3cent"), chnget:i("osc3retrig"), chnget:i("osc3pan")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("osc4wave1_B"), chnget:i("osc4wave2_B"), chnget:i("osc4morph"), chnget:i("osc4vol"), chnget:i("osc4det"), chnget:i("osc4wid"), chnget:i("osc4phase"), chnget:i("osc4voice"), chnget:i("osc4octave"), chnget:i("osc4semi"), chnget:i("osc4cent"), chnget:i("osc4retrig"), chnget:i("osc4pan")
    fprints gSFileName, "%f %f %f %f ", chnget:i("OSC1_BUTTON"), chnget:i("OSC2_BUTTON"), chnget:i("OSC3_BUTTON"), chnget:i("OSC4_BUTTON")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("env1a"), chnget:i("env1d"), chnget:i("env1s"), chnget:i("env1r"), chnget:i("env1amt"), chnget:i("env1osc1"), chnget:i("env1osc2"), chnget:i("env1osc3"), chnget:i("env1osc4"), chnget:i("env1amp"), chnget:i("env1pitch"), chnget:i("env1filter")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("env2a"), chnget:i("env2d"), chnget:i("env2s"), chnget:i("env2r"), chnget:i("env2amt"), chnget:i("env2osc1"), chnget:i("env2osc2"), chnget:i("env2osc3"), chnget:i("env2osc4"), chnget:i("env2amp"), chnget:i("env2pitch"), chnget:i("env2filter")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("env3a"), chnget:i("env3d"), chnget:i("env3s"), chnget:i("env3r"), chnget:i("env3amt"), chnget:i("env3osc1"), chnget:i("env3osc2"), chnget:i("env3osc3"), chnget:i("env3osc4"), chnget:i("env3amp"), chnget:i("env3pitch"), chnget:i("env3filter")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("env4a"), chnget:i("env4d"), chnget:i("env4s"), chnget:i("env4r"), chnget:i("env4amt"), chnget:i("env4osc1"), chnget:i("env4osc2"), chnget:i("env4osc3"), chnget:i("env4osc4"), chnget:i("env4amp"), chnget:i("env4pitch"), chnget:i("env4filter")
    fprints gSFileName, "%f %f %f %f ", chnget:i("ENV1_BUTTON"), chnget:i("ENV2_BUTTON"), chnget:i("ENV3_BUTTON"), chnget:i("ENV4_BUTTON")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f ", chnget:i("lfo1shape_B"), chnget:i("lfo1gain"), chnget:i("lfo1rate"), chnget:i("lfo1amt"), chnget:i("lfo1osc1"), chnget:i("lfo1osc2"), chnget:i("lfo1osc3"), chnget:i("lfo1osc4"), chnget:i("lfo1amp"), chnget:i("lfo1pitch"), chnget:i("lfo1filter")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f ", chnget:i("lfo2shape_B"), chnget:i("lfo2gain"), chnget:i("lfo2rate"), chnget:i("lfo2amt"), chnget:i("lfo2osc1"), chnget:i("lfo2osc2"), chnget:i("lfo2osc3"), chnget:i("lfo2osc4"), chnget:i("lfo2amp"), chnget:i("lfo2pitch"), chnget:i("lfo2filter")
    fprints gSFileName, "%f %f ", chnget:i("LFO1_BUTTON"), chnget:i("LFO2_BUTTON")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("filter1mode1_B"), chnget:i("filter1cut1"), chnget:i("filter1res1"), chnget:i("filter1keytrack1"), chnget:i("filter1mode2_B"), chnget:i("filter1cut2"), chnget:i("filter1res2"), chnget:i("filter1keytrack2"), chnget:i("filter1osc1"), chnget:i("filter1osc2"), chnget:i("filter1osc3"), chnget:i("filter1osc4")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f %f %f ", chnget:i("filter2mode1_B"), chnget:i("filter2cut1"), chnget:i("filter2res1"), chnget:i("filter2keytrack1"), chnget:i("filter2mode2_B"), chnget:i("filter2cut2"), chnget:i("filter2res2"), chnget:i("filter2keytrack2"), chnget:i("filter2osc1"), chnget:i("filter2osc2"), chnget:i("filter2osc3"), chnget:i("filter2osc4")
    fprints gSFileName, "%f %f ", chnget:i("FILTER1_BUTTON"), chnget:i("FILTER2_BUTTON")
    fprints gSFileName, "%f %f %f %f %f ", chnget:i("distswitch"), chnget:i("drywetdist"), chnget:i("distlevel"), chnget:i("distpowershape"), chnget:i("distsaturator")
    fprints gSFileName, "%f %f %f %f %f %f %f ", chnget:i("chorusswitch"), chnget:i("drywetchorus"), chnget:i("choruslevel"), chnget:i("chorusrate"), chnget:i("chorusdepth"), chnget:i("chorusoffset"), chnget:i("choruswidth")
    fprints gSFileName, "%f %f %f %f %f %f %f ", chnget:i("eqswitch"), chnget:i("dryweteq"), chnget:i("eqlevel"), chnget:i("eqlowfreq"), chnget:i("eqhighfreq"), chnget:i("eqlowamp"), chnget:i("eqhighamp")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f ", chnget:i("revswitch"), chnget:i("revtype"), chnget:i("revsize"), chnget:i("revdamp"), chnget:i("revpitchmod"), chnget:i("revCutLPF"), chnget:i("revCutHPF"), chnget:i("drywetrev"), chnget:i("revlevel")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f ", chnget:i("delswitch"), chnget:i("deltempo"), chnget:i("delRhyMlt"), chnget:i("deldamp"), chnget:i("delfback"), chnget:i("delwidth"), chnget:i("delClockSource"), chnget:i("drywetdel"), chnget:i("dellevel")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f ", chnget:i("compswitch"), chnget:i("compthresh"), chnget:i("compatt"), chnget:i("comprel"), chnget:i("compratio"), chnget:i("compgain"), chnget:i("compLowKnee"), chnget:i("compHighKnee"), chnget:i("drywetcomp")
    fprints gSFileName, "%f %f %f %f %f %f ", chnget:i("EFFECT1_BUTTON"), chnget:i("EFFECT2_BUTTON"), chnget:i("EFFECT3_BUTTON"), chnget:i("EFFECT4_BUTTON"), chnget:i("EFFECT5_BUTTON"), chnget:i("EFFECT6_BUTTON")
    fprints gSFileName, "%f %f %f %f %f %f %f %f ", chnget:i("detsh1"), chnget:i("detsh2"), chnget:i("detsh3"), chnget:i("detsh4"), chnget:i("MasterVol"), chnget:i("revdel"), chnget:i("distbitcrusher"), chnget:i("distfoldover")
    fprints gSFileName, "%f %f %f %f %f %f ", chnget:i("env1morph"), chnget:i("env2morph"), chnget:i("env3morph"), chnget:i("env4morph"), chnget:i("lfo1morph"), chnget:i("lfo2morph")
    fprints gSFileName, "%f %f %f %f %f %f %f %f %f %f ", chnget:i("env1slope"), chnget:i("env2slope"), chnget:i("env3slope"), chnget:i("env4slope"), chnget:i("SAGlide"), chnget:i("revwred"), chnget:i("lfo1mult"), chnget:i("lfo2mult"), chnget:i("lfo1bpm"), chnget:i("lfo2bpm")
    ficlose gSFileName
    
    ires strindex gSFileName, "dummy"
    if ires !=0 then
        istrlen    strlen   gSFileName
        idelimiter strrindex gSFileName, gSspecificDelim
        S2    strsub gSFileName, idelimiter + 1, istrlen  ; "String2"
        idelimiter strrindex S2, "."
        S3 strsub S2, 0, idelimiter
        
        idelimiter strrindex S3, "/"
        if idelimiter != -1 then
            S2    strsub S3, idelimiter + 1, istrlen  ; "String2"
            idelimiter strrindex S2, "."
            S3 strsub S2, 0, idelimiter
        endif
        
        Smessage sprintf "text(\"%s\")",S3
        chnset Smessage, "PresetName"

        
        chnset Smessage, "PresetStringI"
        chnset "active(1)","reloadI"   
        
    endif
    chnset "dummy","saveFile"
    endif
    
    chnset "refreshfiles()", "boxI"
    
endin

instr 1004
    Smessage sprintfk "populate(\"*.tzp\",\"%s\")",gSpath
    chnset Smessage, "boxI"
    Smessage2 sprintfk "text(%s)",gSpath
    chnset Smessage2,"PathTextI"
endin


instr 4005
    Spreset chnget "PresetString"
Smes sprintf "text(\"%s\")",Spreset 
chnset Smes,"PresetName"
turnoff
endin

</CsInstruments>
<CsScore>
i 1  0 [3600*24*7] ;read var stored in instr1
i 6 0 1
i"EFFECT" 0 z
f0 z
</CsScore>
</CsoundSynthesizer>