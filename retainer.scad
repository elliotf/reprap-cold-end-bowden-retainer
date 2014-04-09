rim_diam   = 24;
rim_height = 2;

filament_diam = 3;
tube_outer_diam = 8;
tube_inner_diam = 5;

socket_depth = 5;
socket_wall_thickness = 2;
socket_inner_diam = tube_outer_diam;

filament_opening = tube_inner_diam;

resolution = 16;

module hole(diam,height,sides) {
}

module retainer() {
  module body() {
    cylinder(r=rim_diam/2,h=rim_height,center=true,$fn=resolution);

    translate([0,0,rim_height/2+socket_depth/2])
      cylinder(r=socket_inner_diam/2+socket_wall_thickness,h=socket_depth,center=true,$fn=resolution);
  }

  module holes() {
    translate([0,0,rim_height/2+socket_depth/2])
      cylinder(r=socket_inner_diam/2,h=socket_depth+0.05,center=true,$fn=resolution);

    cylinder(r=filament_opening/2,h=socket_depth*3,center=true,$fn=resolution);

    % cylinder(r=filament_diam/2,h=socket_depth*8,center=true,$fn=resolution);
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
      cylinder(r=tube_outer_diam/2,h=height,center=true);
      cylinder(r=tube_inner_diam/2,h=height+0.05,center=true);
    }
}

% bowden_tube();
retainer();
