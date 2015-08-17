joinfactor = 0.25;
goldenratio = 1.61803399;

gDefaultIR = 3/8/2*25.4;
gDefaultOR = 3/4/2*25.4;
gDefaultBlockORFactor = goldenratio;

gDefaultFlangeThickness = 1/16*25.4;
gDefaultFlangeRadius = 3/4/2*25.4;
gDefaultBushingLength = 1*25.4;

gDefaultBlockWidth = gDefaultOR*gDefaultBlockORFactor*2*3;
gDefaultBlockDepth = 12;

gDefaultHoleSize = 3/2;		// M3 screw hole

//bushing(gDefaultIR, gDefaultOR, gDefaultBushingLength, gDefaultFlangeRadius, gDefaultFlangeThickness);
//bushing(gDefaultIR, gDefaultOR, gDefaultBushingLength);
//bushingblock(gDefaultIR, gDefaultOR, gDefaultBushingLength*2, gDefaultBlockWidth, gDefaultBlockDepth,
//	gDefaultFlangeRadius, gDefaultFlangeThickness);

bushingblock(gDefaultIR, gDefaultOR, gDefaultBushingLength*goldenratio*goldenratio, gDefaultBlockWidth, gDefaultBlockDepth,
	gDefaultFlangeRadius, gDefaultFlangeThickness);

module bushing(IR, OR, length, flangeRadius, flangeThickness)
{
	difference()
	{
		union()
		{
			cylinder(r=OR, h=length);
			cylinder(r=flangeRadius, h=flangeThickness);
		}

		translate([0, 0, -joinfactor])
		cylinder(r=IR, h=length+joinfactor*2);
	}
}

module bushingblock(IR, OR, length,  width, depth, flangeRadius, flangeThickness)
{
	blockOR = OR*gDefaultBlockORFactor;

	difference()
	{
		union()
		{
			cylinder(r=blockOR, h=length);

			// A block that will later become the rounded attachment
			// to the flat mounting base
			translate([-blockOR*2, 0, 0])
			cube(size=[blockOR*4, blockOR, length]);

			// The platform block
			translate([-width/2, blockOR,0])
			cube(size=[width, depth, length]);
		}

		// Create the space for the bushing
		translate([0, 0, -joinfactor])
		cylinder(r=OR, h=length+2*joinfactor);

		// Do some smoothing at the connection between the bushing cover
		// and the platform plate
		translate([blockOR*2, 0, -joinfactor])
		cylinder(r=blockOR, h=length+2*joinfactor);

		translate([-blockOR*2, 0, -joinfactor])
		cylinder(r=blockOR, h=length+2*joinfactor);


		// put in some M3 holes for tapping to whatever size is needed
		for(trans=[
			[width/2-depth, 0, depth],
			[width/2-depth, 0, length-depth],
			[-width/2+depth, 0, depth],
			[-width/2+depth, 0, length-depth]])
		{
			translate(trans)
			rotate([-90, 0, 0])
			cylinder(r=gDefaultHoleSize, h=blockOR+depth+joinfactor, $fn=12);

		}

		// Don't create a space for the flange as it can sit on the
		// outside of the block as a holder
		// Or you may be using a bushing without a flange
		//
	}
}