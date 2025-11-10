//###############################################################################
//# CaseBuilderLib2 - Lock                                                      #
//###############################################################################
//#    Copyright 2025 Dirk Heisswolf                                            #
//#    This file is part of the CaseBuilderLib2 project.                         #
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
//#   A "Pull Latch" lock.                                                      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   November 7, 2025                                                          #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib2_Common.scad>

//Lock shape
module lockShape(pSet,pad=0) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts

    lockOffs = 1;                                                        //Adjust tightness of the lock
    lockW    = max(20,0.5*idimX)-pad;                                    //Width of the lock
    lockZ    = -idimZ/2;                                                 //Z-pos of the latch
    lockY    = lockOffs+idimY/2-sqrt(pow(wallW+idimY,2)-pow(lockZ/2,2)); //Y-pos of the latch
    iRadY    = sqrt(pow(wallW+idimY,2)+pow(idimZ/2,2))+pad;              //Radius
    
    difference() {
        //Positives
        union() {
            intersection() {
                idimBb(pSet,pad=wallW);
                hull() {
                    translate([-0.5*lockW,-idimY,0]) cube([lockW,idimY,2]);
                    translate([ 0.25*lockW,0,lockZ]) rotate([90,0,0]) cylinder4n(h=idimY,d=wallW);
                    translate([-0.25*lockW,0,lockZ]) rotate([90,0,0]) cylinder4n(h=idimY,d=wallW);     
                }
            }           
        }
        //Negatives
        union() {
             idimBb(pSet,pad=2*pad-gapW+wallW/2);
             translate([0,0,lockZ]) lowerInfBb();        
        }
    }
    hull() {
        translate([ 0.25*lockW,lockY,lockZ]) sphere4n(r=wallW/2+gapW);
        translate([-0.25*lockW,lockY,lockZ]) sphere4n(r=wallW/2+gapW);
    }   
}

//Positive lower lock parts
module lowerLockPos(pSet) {
}

//Negative lower lock parts 
module lowerLockNeg(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts

    lockW  = max(20,0.5*idimX)-gapW;                              //Width of the lock
    lockZ  = -idimZ/2;                                        //Z-pos of the latch
    lockY  = idimY/2-sqrt(pow(wallW+idimY,2)-pow(lockZ/2,2)); //Y-pos of the latch
 
    lockShape(pSet,pad=0);
     hull() {
        translate([ 0.25*lockW,lockY,lockZ]) sphere4n(r=wallW/2+gapW);
        translate([-0.25*lockW,lockY,lockZ]) sphere4n(r=wallW/2+gapW);
        translate([ 0.2*lockW,lockY,lockZ-wallW]) sphere4n(r=wallW/2+gapW);
        translate([-0.2*lockW,lockY,lockZ-wallW]) sphere4n(r=wallW/2+gapW);
    }   
   
}

//Positive upper lock parts
module upperLockPos(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts

    lockShape(pSet,pad=gapW);






//    //Pull latch
//    if (lockO==2) {
//        intersection() {
//            hull() {
//               translate([-15,-10-idimY/2,-8]) cube([30,10,4]);
//               translate([-25,-10-idimY/2,-4+idimZ/2]) cube([50,10,4]);
//            }
//            union() {
//                translate([-idimX/2,-2-idimY/2,-4]) rotate([0,90,0]) cylinder4n(h=idimX,d=3);
//                translate([-idimX/2,-2.75-idimY/2,-5.5]) rotate([0,90,0]) cylinder4n(h=idimX,d=1.5);
//                translate([-idimX/2,-3.5-idimY/2,-5.5]) cube([idimX,1.5,idimZ/2]);
//                hull() {
//                    translate([-idimX/2,-3.5-idimY/2,-6+idimZ/2])   cube([idimX,1.5,2]);
//                    translate([-idimX/2,-wallW-idimY/2,-2+idimZ/2]) cube([idimX,wallW,2]);
//                }
//            }
//        }
//    }
}

//Negative upper lock parts 
module upperLockNeg(pSet) {
}

//Attach lower lock
module attachLowerLock(pSet) {
    lowerLockPos(pSet);
    difference() {
        children();
        lowerLockNeg(pSet);
    }
}

//Attach upper lock
module attachUpperLock(pSet) {
    upperLockPos(pSet);
    difference() {
        children();
        upperLockNeg(pSet);
    }
}
