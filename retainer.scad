rim_diam   = 24;
rim_height = 2;

filament_diam = 3;
tube_outer_diam = 8;
tube_inner_diam = 5;

socket_depth = 5;
socket_wall_thickness = 2;
socket_inner_diam = tube_outer_diam;

filament_opening = tube_inner_diam;

resolution = 8;

module hole(diam,len,sides=resolution) {
  function accurate_diam(diam,sides) = 1 / cos(180/sides) / 2 * diam;

  cylinder(r=accurate_diam(diam,sides),h=len,center=true,$fn=sides);
}

module retainer() {
  module body() {
    hull() {
      hole(rim_diam,rim_height,sides=resolution*3);

      translate([0,0,rim_height/2+socket_depth/2])
        hole(socket_inner_diam+socket_wall_thickness*2,socket_depth,sides=resolution);
    }
  }

  module holes() {
    translate([0,0,rim_height/2+socket_depth/2])
      hole(socket_inner_diam,socket_depth+0.05,resolution);

    hole(filament_opening,socket_depth*3,resolution);
  }

  difference() {
    body();
    holes();
  }
}

module bowden_tube() {
  height = 30;

  translate([0,0,rim_height/2+height/2])
    difference() {
      cylinder(r=tube_outer_diam/2,h=height,center=true,$fn=resolution*2);
      cylinder(r=tube_inner_diam/2,h=height+0.05,center=true,$fn=resolution*2);
    }
}

% bowden_tube();

// filament
% cylinder(r=filament_diam/2,h=socket_depth*8,center=true,$fn=resolution*2);
retainer();
