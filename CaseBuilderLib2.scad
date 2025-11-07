//###############################################################################
//# CaseBuilderLib2 - A library for custom 3D printed cases                     #
//###############################################################################
//#    Copyright 2025 Dirk Heisswolf                                            #
//#    This file is part of the CaseBuilderLib2 project.                        #
//#                                                                             #
//#    This project is free software: you can redistribute it and/or modify     #
//#    it under the terms of the GNU General Public License as published by     #
//#    the Free Software Foundation, either version 3 of the License, or        #
//#    (at your option) any later version.                                      #
//#                                                                             #
//#    This project is distributed in the hope that it will be useful,          #
//#    but WITHOUT ANY WARRANTY; without even the implied warranty of           #
//#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
//#    GNU General Public License for more details.                             #
//#                                                                             #
//#    You should have received a copy of the GNU General Public License        #
//#    along with this project.  If not, see <http://www.gnu.org/licenses/>.    #
//#                                                                             #
//###############################################################################
//# Description:                                                                #
//#   Main include file.                                                        #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   November 7, 2025                                                          #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib2_Common.scad>

//Main builder module
module CaseBuilder(pSet) {
    //Short cuts
    stage  = pSet[idxStage];  //Design stage
    openA  = pSet[idxOpenA];  //Opening angle
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    chamW  = pSet[idxChamW];  //Chamfer width
    hsegW  = pSet[idxHSegW];  //Length of a hinge segment
    hsegD  = pSet[idxHSegD];  //Diameter of a hinge segment
    slackX = pSet[idxSlackX]; //Object's slack in X direction
    slackY = pSet[idxSlackY]; //Object's slack in Y direction
    slackZ = pSet[idxSlackZ]; //Object's slack in Z direction
    plainB = pSet[idxPlainB]; //Generate plain box
    objX   = pSet[idxObjX];   //Object offset in X direction 
    objY   = pSet[idxObjY];   //Object offset in Y direction 
    objZ   = pSet[idxObjZ];   //Object offset in Z direction 
    ghX    = pSet[idxGhX];    //Grip hole positions
    ghW    = pSet[idxGhW];    //Grip hole width
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size
 
    //Model stage
    //===========
    if ((stage==1)&&($preview)) {

        //Draw object        
        difference() {
            objOff(pSet)
            #color(errC)
                children();
            idimBb(pSet);
        }
        intersection() {
            objOff(pSet) 
                color(objC)
                children();
            idimBb(pSet);
        }
              
        //Draw grip hole positions
        color(ghC,0.55) ghPos(pSet);
      
        //Visualize inner dimensions
        color(dimC,0.35) idimBb(pSet);
        //idimBb(pSet,pad=10);
      
        //Preview label
        color(labC,0.75) flatLabel(pSet);
    }       
   
    //Generate stage
    //==============
    if ((stage==2)||(!$preview)) {

        //Lower part
        //xCut()
        lowerPos(pSet) {
            attachLowerLock(pSet)
            attachLowerHinge(pSet) 
                lowerShell(pSet);  
            
            if (!plainB) {
                difference() {
                    inlay(pSet);
                    union() {
                        children();                       
                        ghShapes(pSet) children();
                    }
                }
            }
        }

       //Upper part
        upperPos(pSet) {
            //xCut()
            engraveLabel(pSet)
            attachUpperLock(pSet)
            attachUpperHinge(pSet)
                upperShell(pSet);  
        }
    }
}

