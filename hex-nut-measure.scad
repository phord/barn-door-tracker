include <shapes.scad>;

pivot_width = 1 ;

floor_depth=1;

block_size = 11;
block_height = 5;

hex_nut_width = 9;
hex_nut_height = 3.3 ;
drive_screw_diameter = 5 ;

smooth_bar_diameter = 8.4;
threaded_rod_diameter = 8.6;
dRod = smooth_bar_diameter ;

end_size = 7.5;
clamp_size = 10;

module pivotmotormount(){
difference(){
  union() {	
	// Main housing
	translate(v=[-block_size/2,-block_size/2,-block_height/2])
		minkowski() {
			cube(size = [ block_size,block_size,block_height]);
			cylinder(r=block_size/4);
		}

	// Pivot axis
	hull() {
		translate(v=[-block_size/2-pivot_width,0,0]) rotate(a=[0,90,0]) 
				cylinder(h = block_size+pivot_width*2 , r=block_height/2, $fn=32);
		translate(v=[-block_size/2,-pivot_width,-block_height/2])    cube(size = [ block_size,pivot_width*2,block_height]);
	}
  }

	// drive screw path
	translate(v=[0,0,-block_height/2-2])
		cylinder(h=block_height+4, r=drive_screw_diameter/2);

	// nut trap
	translate(v=[0,0, block_height-hex_nut_height]) hexagon(size=hex_nut_width,height=block_height);
	translate(v=[0,0, -hex_nut_height-floor_depth]) hexagon(size=hex_nut_width,height=block_height);

	// Pivot rod
	translate(v=[-block_size/2-pivot_width-1,0,0]) rotate(a=[0,90,0]) rotate([0, 0, 22.5]) cylinder(h = pivot_width+(block_size-hex_nut_width)/4 , r=dRod/2 / cos(22.5), $fn=8);
	translate(v=[ block_size/2+pivot_width+1,0,0]) rotate(a=[0,-90,0]) rotate([0, 0, 22.5]) cylinder(h = pivot_width+(block_size-hex_nut_width)/4  , r=dRod/2 / cos(22.5), $fn=8);
}
}

pivotmotormount();
