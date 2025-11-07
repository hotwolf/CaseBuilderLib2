//###############################################################################
//# CaseBuilderLib2 - Boundary Boxes and Checks                                 #
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
//#   Boudary boxes and checks for multiple purposes.                           #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   November 7, 2025                                                          #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib2_Common.scad>

//Local parameters
//================
errOff = 1; //Error indicator offset

//Boundary box around the inner dimensions 
module idimBb(pSet,pad=0) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
 
    iRadY  = sqrt(pow(wallW+idimY,2)+pow(idimZ/2,2))+pad;
    
    intersection() {
        translate([-idimX/2-pad,idimY/2+pad-inf,-idimZ/2-pad])
            cube([idimX+2*pad,inf,idimZ+2*pad]);
        translate([0,wallW+idimY/2,0])
        rotate([0,90,0])
            cylinder4n(h=idimX+2*pad+10,r=iRadY,center=true);
    }
}

module inlay(pSet) {
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    gapW   = pSet[idxGapW];   //Gap between moving parts

    difference() {
        idimBb(pSet=pSet,pad=0);
        translate([0,0,idimZ/2-gapW]) upperInfBb();
    }
}

//Boundary box around the inner dimensions of the lower inlay
module lowerInlBb(pSet,pad) {
    difference() {
        idimBb(pSet=pSet,pad=pad);
        upperInfBb();
    }
}
 
//Boundary box around the inner dimensions of the upper inlay
module upperInlBb(pSet,pad) {
    difference() {
        idimBb(pSet=pSet,pad=pad);
        lowerInfBb();
    }
}

//Lower infinite boundary
module lowerInfBb() {
    translate([0,0,-inf/2]) cube([2*inf,2*inf,inf],center=true);
}

//Upper infinite boundary
module upperInfBb() {
    translate([0,0,inf/2]) cube([2*inf,2*inf,inf],center=true);
}
