//###############################################################################
//# CaseBuilderLib2 - Cavity                                                    #
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
//#   A cavities for user defined objects.                                      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   November 7, 2025                                                          #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib2_Common.scad>

//Object cavity
module objectCavity(pSet) {
    //Short cuts
    stage  = pSet[idxStage];  //Design stage
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    slackX = pSet[idxSlackX]; //Object's slack in X direction
    slackY = pSet[idxSlackY]; //Object's slack in Y direction
    slackZ = pSet[idxSlackZ]; //Object's slack in Z direction
  
    //Model stage
    //===========
    if ((stage==1)&&($preview)) {
        children();
    }

    //Generate stage
    //==============
    if ((stage==2)||(!$preview)) {
        hull() {
    
            translate([0,0,idimZ/2+1])
            linear_extrude(1)
            minkowski() {
                projection(cut=false) children();
                scale([slackX,slackY,0]) circle4n(r=1);
            }
                
             minkowski() {
                children();
                scale([slackX,slackY,slackZ]) sphere4n(r=1);
            }
        }
    }
}
