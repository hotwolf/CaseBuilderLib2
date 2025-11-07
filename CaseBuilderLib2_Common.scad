//###############################################################################
//# CaseBuilderLib2 - Default values and common functions                       #
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
//#   Common functions and definitions of global variables.                     #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   November 7, 2025                                                          #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

use     <CaseBuilderLib2_Boundary.scad>
use     <CaseBuilderLib2_Cavity.scad>
use     <CaseBuilderLib2_GripHole.scad>
use     <CaseBuilderLib2_Shell.scad>
use     <CaseBuilderLib2_Label.scad>
use     <CaseBuilderLib2_Hinge.scad>
use     <CaseBuilderLib2_Lock.scad>

//Color scheme
//============
objC      = "yellow"; //Object color
filC      = "orange"; //Filament color
errC      = "red";    //Error color
cavC      = "blue";   //Cavity color
ghC       = "blue";   //Grip hole color
dimC      = "gray";   //Color of dimension indicators
labC      = "gray";   //Label color

//Default values
//==============
defStage  =     1;     //Design stage
defOpenA  =   180;     //Opening angle
defIdimX  =    70;     //Inner X dimension
defIdimY  =    50;     //Inner Y dimension
defIdimZ  =    30;     //Inner Z dimension
defWallW  =     3;     //Wall thickness
defGapW   =     0.2;   //Gap between moving parts
defChamW  =     1;     //Chamfer width
defHSegW  =    10;     //Length of a hinge segment
defHSegD  =     5;     //Diameter of a hinge segment
defSlackX =     2;     //Object's slack in X direction
defSlackY =     2;     //Object's slack in Y direction
defSlackZ =     1;     //Object's slack in Z direction
defPlainB = false;     //Generate plain box
defObjX   =     0;     //Object offset in X direction 
defObjY   =     0;     //Object offset in Y direction 
defObjZ   =     0;     //Object offset in Z direction 
defGhX    =   [0];     //Grip hole positions
defGhW    =    15;     //Grip hole width
defLabT   =    "";     //Label text
defLabS   =     8;     //Label font size

//Parameter set
//=============
idxStage  =     0;     //Design stage
idxOpenA  =     1;     //Opening angle
idxIdimX  =     2;     //Inner X dimension
idxIdimY  =     3;     //Inner Y dimension
idxIdimZ  =     4;     //Inner Z dimension
idxWallW  =     5;     //Wall thickness
idxGapW   =     6;     //Gap between moving parts
idxChamW  =     7;     //Chamfer width
idxHSegW  =     8;     //Length of a hinge segment
idxHSegD  =     9;     //Diameter of a hinge segment
idxSlackX =    10;     //Object's slack in X direction
idxSlackY =    11;     //Object's slack in Y direction
idxSlackZ =    12;     //Object's slack in Z direction
idxPlainB =    13;     //Generate plain box
idxObjX   =    14;     //Object offset in X direction 
idxObjY   =    15;     //Object offset in Y direction 
idxObjZ   =    16;     //Object offset in Z direction 
idxGhX    =    17;     //Grip hole positions
idxGhW    =    18;     //Grip hole width
idxLabT   =    19;     //Label text
idxLabS   =    20;     //Label size

function pSet(stage  = defStage,   //Design stage
              openA  = defOpenA,   //Opening angle
              idimX  = defIdimX,   //Inner X dimension
              idimY  = defIdimY,   //Inner Y dimension
              idimZ  = defIdimZ,   //Inner Z dimension
              wallW  = defWallW,   //Wall thickness
              gapW   = defGapW,    //Gap between moving parts
              chamW  = defChamW,   //Chamfer width
              hSegW  = defHSegW,   //Length of a hinge segment
              hSegD  = defHSegD,   //Diameter of a hinge segment
              slackX = defSlackX,  //Object's slack in X direction
              slackY = defSlackY,  //Object's slack in Y direction
              slackZ = defSlackZ,  //Object's slack in Z direction
              plainB = defPlainB,  //Generate plain box
              objX   = defObjX,    //Object offset in X direction 
              objY   = defObjY,    //Object offset in Y direction 
              objZ   = defObjZ,    //Object offset in Z direction 
              ghX    = defGhX,     //Grip hole positions
              ghW    = defGhW,     //Grip hole width
              labT   = defLabT,    //Label text
              labS   = defLabS) =  //Label size
             [stage,               //Design stage
              openA,               //Opening angle
              idimX,               //Inner X dimension
              idimY,               //Inner Y dimension
              idimZ,               //Inner Z dimension
              wallW,               //Wall thickness
              gapW,                //Gap between moving parts
              chamW,               //Chamfer width
              hSegW,               //Length of a hinge segment
              hSegD,               //Diameter of a hinge segment
              slackX,              //Object's slack in X direction
              slackY,              //Object's slack in Y direction
              slackZ,              //Object's slack in Z direction
              plainB,              //Generate plain box          
              objX,                //Object offset in X direction 
              objY,                //Object offset in Y direction 
              objZ,                //Object offset in Z direction 
              ghX,                 //Grip hole positions
              ghW,                 //Grip hole width
              labT,                //Label text
              labS];               //Label size
                        
 //Common variables             
inf = 1000;                        //Huge number

//Common functions
//================
//Reuse from NopSCADlib:
function r2sides(r)   = $fn ? $fn : ceil(max(8*min(360/ $fa, r * 2 * PI / $fs), 5)); //Replicates the OpenSCAD logic to calculate the number of sides from the radius
function r2sides4n(r) = floor((r2sides(r) + 3) / 4) * 4;                           //Round up the number of sides to a multiple of 4 to ensure points land on all axes

//Check for even/odd numbers
function is_even(n) = (n/2) == floor(n/2);
function is_odd(n)  = (n/2) != floor(n/2);

//Common operations
//=================
//Object offset
module objOff(pSet) {
    //Short cuts
    objX   = pSet[idxObjX];    //Object offset in X direction 
    objY   = pSet[idxObjY];    //Object offset in Y direction 
    objZ   = pSet[idxObjZ];    //Object offset in Z direction 

    translate([objX,objY,objZ]) children();
}

//Position the lower part of the case
module lowerPos(pSet) {
    //Short cuts
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    hoffX  = hoffX(pSet);     //Hinge offset
    
    translate([0,-hoffX-wallW-idimY/2,0]) children(); 
}

//Positon the upper part of the case
module upperPos(pSet) {
    //Short cuts
    openA  = pSet[idxOpenA];  //Opening angle
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    hoffX  = hoffX(pSet);     //Hinge offset

    rotate([$preview ? -openA : -180,0,0]) translate([0,-hoffX-wallW-idimY/2,0]) children(); 
}

//Safe intersection
module safeIntersection() {
    difference () {
        intersection() {
            union() {
                children(0);
                translate([inf,inf,inf]) cube(1,center=true);
            }
            union() {
                children(1);
                translate([inf,inf,inf]) cube(1,center=true);
            }
        }
        translate([inf,inf,inf]) cube(2,center=true);     
    }
}

//Combined translate and rotate
module transrot(trans=[0,0,0],rot=[0,0,0]) {
    translate(trans) rotate(rot) children();
}

//Chamfer
module chamfer(chamW) {
    hull() {
        for (pos=[[ chamW,      0,     0],
                  [-chamW,      0,     0],
                  [      0, chamW,     0],
                  [      0,-chamW,     0],
                  [      0,     0, chamW],
                  [      0,     0,-chamW]]) {
            translate(pos) children();
          }
     }          
}

//X-Cut
module xCut(x=0) {
    difference() {
        children();
        translate([inf/2,0,0]) cube([inf+x,2*inf,2*inf],center=true);
    }
}

//Common shapes
//=============
//Cylinder with multiple of four sides
module cylinder4n(h,
                  r,
                  d      = undef,
                  r1     = undef,
                  r2     = undef,
                  d1     = undef,
                  d2     = undef,
                  center = false) {
    //First radius                
    R1 = is_undef(d1) ?
         is_undef(r1) ?
         is_undef(d)  ? r : d/2 : r1 : d1/2;        
                    
    //Second radius                
    R2 = is_undef(d2) ?
         is_undef(r2) ?
         is_undef(d)  ? r : d/2 : r2 : d2/2;        
                    
    cylinder(h=h,r1=R1,r2=R2,$fn=r2sides4n(max(R1,R2)),center=center);
}
 

module circle4n(r, d = undef) {
    R = is_undef(d) ? r : d / 2;
    circle(R,$fn=r2sides4n(R));
}
  
//Semi circle in the positive Y domain (reuse from NopSCADlib)
module semicircle4n(r, d = undef)
    intersection() {
        R = is_undef(d) ? r : d / 2;
        circle4n(R);

        sq = R + 1;
        translate([-sq, 0])
            square([2 * sq, sq]);
    }
            
//Quadrant in the positive X and Y domain (reuse from NopSCADlib)
module quadrant4n(r, d = undef)
    intersection() {
        R = is_undef(d) ? r : d / 2;
        circle4n(R);

        sq = R + 1;
        translate([-sq, 0])
            square([sq, sq]);
    }
    
//Sphere with multiple of 4 vertices (reuse from NopSCADlib)
module sphere4n(r = 1, d = undef) {
    R = is_undef(d) ? r : d / 2;
    rotate_extrude($fn=r2sides4n(R))
        rotate(-90)
            semicircle4n(R);
}         

//Hemiphere with multiple of 4 vertices
module hemisphere4n(r = 1, d = undef, shs =false) {
    R = is_undef(d) ? r : d / 2;
    rotate_extrude($fn=r2sides4n(R))
        rotate(shs ? 90 : -90)
            quadrant4n(R);
}

//Torus with multiple of 4 vertices
module torus4n(r1,            //Radius of the circle profile
               r2,            //Radius of the sweep
               d1    = undef, //Diameter of the circle profile
               d2    = undef, //Diameter of the sweep
               angle = 360) { //Angle of the sweep
    //First radius                
    R1 = is_undef(d1) ? r1 : d1/2;        

    //Second radius                
    R2 = is_undef(d2) ? r2 : d2/2;        

    //Torus
    rotate_extrude(angle=angle,$fn=r2sides4n(R1+R2))               
    translate([R2,0,0])               
    circle(R1,$fn=r2sides4n(R1));    
}

//Empty shape
module dummy() {}