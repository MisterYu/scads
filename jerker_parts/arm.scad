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

module speaker_arm_bottom() {
    translate([0,-w_arm/2,0])
    difference() {
        cube([l_arm, w_arm, h_arm]);
        // hole for attaching to bracket
        translate([d_arm_under_seat+19,w_arm/2,-h_arm/2]) 
        cylinder(r=d_holes/2, h=2*h_arm);
        // hole for attaching in direction of arm
        translate([d_arm_under_seat-19,w_arm/2,-h_arm/2])
        cylinder(r=d_holes/2, h=2*h_arm);
    }
}

module speaker_support() {
    difference() {
        translate([0,-50,0])
        cube([h_speaker_seat,d_arm_under_seat,4]);
        // holes perpindicular to direction of arm
        for (i=[-1:2:1]) {
            translate([h_speaker_seat/2,i*(d_arm_under_seat/2-d_holes),4/2])
            cylinder(r=d_holes/2, h=2*support_thickness, center=true);
        }
    }
    //
    translate([(h_speaker_seat-support_thickness)/2,0,support_thickness])
    rotate([0,90,0])
    rotate([0,0,90])
    linear_extrude(height=support_thickness)
    polygon([[-d_arm_under_seat/2+10,0],[d_arm_under_seat/2-10,0],[0,h_arm-4]]);
}

union() {
speaker_arm_bottom();
speaker_support();
}