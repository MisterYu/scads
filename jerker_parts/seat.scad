// speaker seat parameters
w_speaker_seat = 180;
l_speaker_seat = 150;
h_speaker_seat = 10;
r_plate_corner = 2;

// support arm parameters
l_arm = 130;
h_arm = 40.2;
w_arm = 20.25;
d_arm_under_seat = 100;
d_holes = 6;
support_thickness = 4;
$fn=50;

// TODO: break into 2; speaker seat and arm parts for easier printing

module speaker_seat() {
    w_offset = w_speaker_seat-2*r_plate_corner;
    l_offset = l_speaker_seat-2*r_plate_corner;
    difference() {        
        translate([d_arm_under_seat,-w_offset/2,-h_speaker_seat/2]) {
            rotate([0,0,90])
            // minkowski sum to get rounded corners
            minkowski() {        
                // square plate; h/2 because minkowski sums in all dimensions
                cube([w_offset, l_offset, h_speaker_seat/2], center=true);
                // rounded corners; h/2 because minkowski sums in all dimensions
                translate([w_offset/2, l_offset/2, 0])
                cylinder(h=h_speaker_seat/2, r=r_plate_corner,center=true);
            }
        }
        // holes perpindicular to direction of arm
        for (i=[-1:2:1]) {
            translate([h_speaker_seat/2,i*(d_arm_under_seat/2-d_holes),-h_speaker_seat/2])
            cylinder(r=d_holes/2, h=2*h_speaker_seat, center=true);
        }
        // holes in direction of arm
        translate([d_arm_under_seat-19,0,-h_speaker_seat/2])
        cylinder(r=d_holes/2, h=2*h_speaker_seat, center=true);
    }
}

speaker_seat();
