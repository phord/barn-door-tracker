well_size = 43;
well_depth = 12;
pivot_width = 10 ;

wall_width=8;
floor_depth=4;

block_size = well_size + wall_width*2;
block_height = well_depth + floor_depth ;


smooth_bar_diameter = 8.4;
threaded_rod_diameter = 8.6;

end_size = 7.5;
clamp_size = 10;
wedge_width = 0;

module pivotmotormount(){
difference(){
  union() {
	// Main housing
	translate(v=[-block_size/2,-block_size/2,-block_height/2])
		minkowski() {
			cube(size = [ block_size,block_size,block_height]);
			cylinder(r=wall_width/2);
		}

	// Pivot axis
	hull() {
		translate(v=[-block_size/2-pivot_width,0,0]) rotate(a=[0,90,0]) rotate([0, 0, 22.5]) cylinder(h = block_size+pivot_width*2 , r=block_height/2, $fn=32);
		translate(v=[-block_size/2,-pivot_width,-block_height/2])    cube(size = [ block_size,pivot_width*2,block_height]);
	}
  }
	// motor well
	translate(v=[-well_size/2,-well_size/2,-(block_height-well_depth)]) cube(size = [well_size,well_size,well_depth+1]);

	// Nema 17
	rotate ([0,0,  45]) translate([20,0,0]) cube(size = [9,3.2,block_height+4], center = true);
	rotate ([0,0, -45]) translate([20,0,0]) cube(size = [9,3.2,block_height+4], center = true);
	rotate ([0,0, 135]) translate([20,0,0]) cube(size = [9,3.2,block_height+4], center = true);
	rotate ([0,0,-135]) translate([20,0,0]) cube(size = [9,3.2,block_height+4], center = true);
	translate(v=[0,0,-block_height/2-1]) cylinder(r=23/2,h=block_height+4);

	// Pivot rod
	translate(v=[-block_size/2-pivot_width-1,0,0]) rotate(a=[0,90,0]) rotate([0, 0, 22.5]) cylinder(h = pivot_width+1+wall_width/2 , r=threaded_rod_diameter/2 / cos(22.5), $fn=8);
	translate(v=[ block_size/2-wall_width/2 ,0,0]) rotate(a=[0,90,0]) rotate([0, 0, 22.5]) cylinder(h = pivot_width+1+wall_width/2 , r=threaded_rod_diameter/2 / cos(22.5), $fn=8);
}
}

pivotmotormount();
