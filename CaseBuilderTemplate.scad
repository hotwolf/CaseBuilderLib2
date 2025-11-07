//###############################################################################
//# CaseBuilderLib2 - Project Template                                          #
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
//#    This is a template for a new case design.                                #
//#                                                                             #
//###############################################################################
//# How to use this template:                                                   #
//#                                                                             #
//#    1. Preparation                                                           #
//#       1. Make a copy of the CaseBuilderLib2 project template.                #
//#          The temmplate is intended to be used with the OpenSCAD             #
//#          configurator.                                                      #
//#          The design of a customized case is done in three stages.           #
//#          Start by setting the `Stage` variable to "Model"                   #
//#          (value = 1).                                                       #
//#                                                                             #
//#    2. Model Stage                                                           #
//#       1. Design the cavities you'd like to caeve into the inside of your    #
//#          case and place them inside an instance of the `CaseBuilder(){...}` #
//#          module. Use the `objectCavity(pSet){...}` modifier to generate a   #
//#          cavities for given objects.                                        #
//#          Note! `objectCavity(pSet){...}` modifier  will the convex shapes   #
//#          will be wrapped in a hull. Use exact measures. Slack will be added #
//#          to the cavities automatically.                                     #
//#                                                                             #
//#       2. Configure the inner dimansions of the case by setting the          #
//#          `IdimX`, `IdimY`, and `IdimZ` variables.                           #
//#          If necessary, adjust the position of the content through the       #
//#          `ObjX`, `ObjY`, and `ObjZ` variables.                              #
//#                                                                             #
//#       3. If needed, add some grip holes by setting the variables            #
//#          `Gh1X`, `Gh2X`, or `Gh3X` to a value within the inner              #
//#          X dimension.                                                       #
//#          Further grip holes can be added by manually extending the          #
//#          `ghX` array within the instantiation of the                        #
//#          `CaseBuilder()` module.                                            #
//#                                                                             #
//#       4. Add an optional label to the case by setting the string            #
//#          variable `LabT`. The font size can be adjusted through             #
//#          the variable `LabS`.                                               #
//#                                                                             #
//#          Continue by setting the `Stage` variable to "Generate"             #
//#          (value = 2).                                                       #
//#                                                                             #
//#    3. Generate Stage                                                        #
//#       1. Do a final review of the design.                                   #
//#          Use the OpenA, UvisB, and LvisB variables for a                    #
//#          detailed inspection.                                               #
//#                                                                             #
//#       2. Render the design and generate a STL file                          #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   November 7, 2025                                                          #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib2.scad>

/* [View] */
//Design stage
Stage=2; // [1:Model, 2:Generate]

//Opening angle
OpenA=180; // [0:180]

/* [Design Options] */
//Inner X dimension
IdimX=70; // [1:200]
//Inner Y dimension
IdimY=34;  // [1:200]
//Inner Y dimension
IdimZ=30;  // [1:200]

//Plain Case
PlainB = false;

//Object offset in X direction
ObjX=0; // [-50:50]
//Object offset in Y direction
ObjY=0;  // [-50:50]
//Object offset in Z direction
ObjZ=0;  // [-50:50]

//First grip hole's X offset
Gh1X=-100;    // [-100:100]
//Second grip hole's X offset
Gh2X=--100; // [-100:100]
//Third grip hole's X offset
Gh3X=-100; // [-100:100]

//Label text
LabT="Optional label";
//Label size
LabS=8; // [0:40]

pSet = pSet(stage=Stage,            //Design stage
            openA=OpenA,            //Opening angle
            idimX=IdimX,            //Inner X dimension
            idimY=IdimY,            //Inner X dimension
            idimZ=IdimZ,            //Inner X dimension
           plainB=PlainB,           //Generate plain box
             objX=ObjX,             //Object offset in X direction
             objY=ObjY,             //Object offset in Y direction
             objZ=ObjZ,             //Object offset in Z direction
              ghX=[Gh1X,Gh2X,Gh3X], //Grip hole offsets
             labT=LabT,             //Label text
             labS=LabS);           //Label size


CaseBuilder(pSet) {

        objectCavity(pSet) {
        //!!! Your model goes here !!!
            translate([0,0,-10]) cylinder(10,d1=10,d2=30);
            translate([0,0,0]) cylinder(10,d1=30,d2=10);
       }

         //!!! Further cavities go here !!!
        
}
