//POVRay-File created by 3d41.ulp v20110101
//C:/Users/Intel/Dropbox/NPN Automations/Projects/Smsgen/v2.1.brd
//5/13/2013 4:13:51 AM

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = 1020;
#local cam_z = -229;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -10;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 100;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 121;
#local lgt1_pos_y = 181;
#local lgt1_pos_z = 53;
#local lgt1_intense = 1.155360;
#local lgt2_pos_x = -121;
#local lgt2_pos_y = 181;
#local lgt2_pos_z = 53;
#local lgt2_intense = 1.155360;
#local lgt3_pos_x = 121;
#local lgt3_pos_y = 181;
#local lgt3_pos_z = -36;
#local lgt3_intense = 1.155360;
#local lgt4_pos_x = -121;
#local lgt4_pos_y = 181;
#local lgt4_pos_z = -36;
#local lgt4_intense = 1.155360;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 318.750000;
#declare pcb_y_size = 100.000000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(868);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-159.375000,0,-50.000000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro V2_1(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,8
<0.000000,0.000000><318.750000,0.000000>
<318.750000,0.000000><318.750000,100.000000>
<318.750000,100.000000><0.000000,100.000000>
<0.000000,100.000000><0.000000,0.000000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
cylinder{<69.824600,1,41.605200><69.824600,-5,41.605200>1.400000 texture{col_hls}}
cylinder{<69.824600,1,72.525200><69.824600,-5,72.525200>1.400000 texture{col_hls}}
cylinder{<144.744600,1,72.525200><144.744600,-5,72.525200>1.400000 texture{col_hls}}
cylinder{<144.744600,1,41.605200><144.744600,-5,41.605200>1.400000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_DIS_CERAMIC_50MM_76MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<136.702800,0.000000,23.088600>}#end		//ceramic disc capacitator C1  C050-025X075
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_DIS_CERAMIC_50MM_76MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<137.134600,0.000000,51.003200>}#end		//ceramic disc capacitator C2  C050-025X075
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_DIS_CERAMIC_50MM_76MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<139.547600,0.000000,23.088600>}#end		//ceramic disc capacitator C3  C050-025X075
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_DIS_CERAMIC_50MM_76MM("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<142.443200,0.000000,23.139400>}#end		//ceramic disc capacitator C4  C050-025X075
#ifndef(pack_D1) #declare global_pack_D1=yes; object {DIODE_DIS_DO35_102MM_H("1N4148DO35-10",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<186.131200,0.000000,13.995400>}#end		//Diode DO35 10mm hor. D1 1N4148DO35-10 DO35-10
#ifndef(pack_D2) #declare global_pack_D2=yes; object {DIODE_DIS_DO35_102MM_H("1N4148DO35-10",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<186.385200,0.000000,31.775400>}#end		//Diode DO35 10mm hor. D2 1N4148DO35-10 DO35-10
#ifndef(pack_D3) #declare global_pack_D3=yes; object {DIODE_DIS_DO35_102MM_H("1N4148DO35-10",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<186.131200,0.000000,49.809400>}#end		//Diode DO35 10mm hor. D3 1N4148DO35-10 DO35-10
#ifndef(pack_D4) #declare global_pack_D4=yes; object {DIODE_DIS_DO35_102MM_H("1N4148DO35-10",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<186.131200,0.000000,67.589400>}#end		//Diode DO35 10mm hor. D4 1N4148DO35-10 DO35-10
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP28("MEGA8-P","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<135.864600,0.000000,41.579800>translate<0,3.000000,0> }#end		//DIP28 300mil IC1 MEGA8-P DIL28-3
#ifndef(pack_IC1) object{SOCKET_DIP28()rotate<0,0.000000,0> rotate<0,0,0> translate<135.864600,0.000000,41.579800>}#end					//IC-Sockel 28Pin IC1 MEGA8-P
#ifndef(pack_IC2) #declare global_pack_IC2=yes; object {IC_DIS_DIP8("DS1307","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<105.054400,0.000000,25.273000>translate<0,3.000000,0> }#end		//DIP8 IC2 DS1307 DIL08
#ifndef(pack_IC2) object{SOCKET_DIP8()rotate<0,-90.000000,0> rotate<0,0,0> translate<105.054400,0.000000,25.273000>}#end					//IC-Sockel 8Pin IC2 DS1307
#ifndef(pack_IC3) #declare global_pack_IC3=yes; object {IC_DIS_DIP8("AT24CP","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<124.333000,0.000000,25.069800>translate<0,3.000000,0> }#end		//DIP8 IC3 AT24CP DIL08
#ifndef(pack_IC3) object{SOCKET_DIP8()rotate<0,-90.000000,0> rotate<0,0,0> translate<124.333000,0.000000,25.069800>}#end					//IC-Sockel 8Pin IC3 AT24CP
#ifndef(pack_JP1) #declare global_pack_JP1=yes; object {CON_PH_2X5()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<10.566400,0.000000,22.631400>}#end		//Header 2,54mm Grid 5Pin 2Row (jumper.lib) JP1  2X05
#ifndef(pack_JP2) #declare global_pack_JP2=yes; object {CON_PH_1X1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<59.766200,0.000000,60.756800>}#end		//Header 2,54mm Grid 1Pin 1Row (jumper.lib) JP2  1X01
#ifndef(pack_JP3) #declare global_pack_JP3=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<152.196800,0.000000,8.051800>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) JP3  1X02
#ifndef(pack_JP4) #declare global_pack_JP4=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<85.293200,0.000000,8.890000>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) JP4  1X02
#ifndef(pack_JP5) #declare global_pack_JP5=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<120.802400,0.000000,8.788400>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) JP5  1X02
#ifndef(pack_JP6) #declare global_pack_JP6=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<54.787800,0.000000,8.940800>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) JP6  1X02
#ifndef(pack_JP7) #declare global_pack_JP7=yes; object {CON_PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<26.568400,0.000000,9.626600>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) JP7  1X04
#ifndef(pack_JP8) #declare global_pack_JP8=yes; object {CON_PH_2X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<10.591800,0.000000,12.471400>}#end		//Header 2,54mm Grid 3Pin 2Row (jumper.lib) JP8  2X03
#ifndef(pack_JP9) #declare global_pack_JP9=yes; object {CON_PH_1X1()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<59.867800,0.000000,58.216800>}#end		//Header 2,54mm Grid 1Pin 1Row (jumper.lib) JP9  1X01
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(Red,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<53.644800,0.000000,71.958200>}#end		//Diskrete 5MM LED LED1  LED5MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(Green,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<180.035200,0.000000,17.297400>}#end		//Diskrete 5MM LED LED2  LED5MM
#ifndef(pack_LED3) #declare global_pack_LED3=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<180.035200,0.000000,35.331400>}#end		//Diskrete 5MM LED LED3  LED5MM
#ifndef(pack_LED4) #declare global_pack_LED4=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<180.289200,0.000000,53.365400>}#end		//Diskrete 5MM LED LED4  LED5MM
#ifndef(pack_LED5) #declare global_pack_LED5=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<180.543200,0.000000,71.145400>}#end		//Diskrete 5MM LED LED5  LED5MM
#ifndef(pack_LED6) #declare global_pack_LED6=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<53.797200,0.000000,59.207400>}#end		//Diskrete 5MM LED LED6  LED5MM
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {SPC_XTAL_5MM("",3,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<139.877800,0.000000,31.521400>}#end		//Quarz 4,9MM Q1  HC49U-V
#ifndef(pack_Q3) #declare global_pack_Q3=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<149.301200,0.000000,68.376800>}#end		//TO92 bend vertical Q3 BC547 TO92
#ifndef(pack_Q4) #declare global_pack_Q4=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<30.099000,0.000000,39.243000>}#end		//TO92 bend vertical Q4 BC547 TO92
#ifndef(pack_Q5) #declare global_pack_Q5=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<180.035200,0.000000,10.693400>}#end		//TO92 bend vertical Q5 BC547 TO92
#ifndef(pack_Q6) #declare global_pack_Q6=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<30.099000,0.000000,49.403000>}#end		//TO92 bend vertical Q6 BC547 TO92
#ifndef(pack_Q7) #declare global_pack_Q7=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<180.289200,0.000000,29.235400>}#end		//TO92 bend vertical Q7 BC547 TO92
#ifndef(pack_Q8) #declare global_pack_Q8=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<30.099000,0.000000,60.833000>}#end		//TO92 bend vertical Q8 BC547 TO92
#ifndef(pack_Q9) #declare global_pack_Q9=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<180.289200,0.000000,46.253400>}#end		//TO92 bend vertical Q9 BC547 TO92
#ifndef(pack_Q10) #declare global_pack_Q10=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<30.099000,0.000000,69.723000>}#end		//TO92 bend vertical Q10 BC547 TO92
#ifndef(pack_Q11) #declare global_pack_Q11=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<180.289200,0.000000,64.287400>}#end		//TO92 bend vertical Q11 BC547 TO92
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<56.718200,0.000000,26.619200>}#end		//Discrete Resistor 0,3W 10MM Grid R1  0207/10
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<64.719200,0.000000,68.199000>}#end		//Discrete Resistor 0,3W 10MM Grid R2  0207/10
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<154.330400,0.000000,58.191400>}#end		//Discrete Resistor 0,3W 10MM Grid R3  0207/10
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<108.712000,0.000000,55.626000>}#end		//Discrete Resistor 0,3W 10MM Grid R4  0207/10
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<108.864400,0.000000,51.739800>}#end		//Discrete Resistor 0,3W 10MM Grid R5  0207/10
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_TRIM_T7_YA("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<53.695600,0.000000,46.990000>}#end		//Trimmer TY7A serie R6  RTRIM3339P
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<37.363400,0.000000,53.238400>}#end		//Discrete Resistor 0,3W 10MM Grid R7  0207/10
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.939000,0.000000,41.783000>}#end		//Discrete Resistor 0,3W 10MM Grid R8  0207/10
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<35.179000,0.000000,39.243000>}#end		//Discrete Resistor 0,3W 10MM Grid R9  0207/10
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.939000,0.000000,36.703000>}#end		//Discrete Resistor 0,3W 10MM Grid R10  0207/10
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<170.535600,0.000000,13.563600>}#end		//Discrete Resistor 0,3W 10MM Grid R11  0207/10
#ifndef(pack_R12) #declare global_pack_R12=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<173.329600,0.000000,13.512800>}#end		//Discrete Resistor 0,3W 10MM Grid R12  0207/10
#ifndef(pack_R13) #declare global_pack_R13=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.939000,0.000000,51.943000>}#end		//Discrete Resistor 0,3W 10MM Grid R13  0207/10
#ifndef(pack_R14) #declare global_pack_R14=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<38.989000,0.000000,39.243000>}#end		//Discrete Resistor 0,3W 10MM Grid R14  0207/10
#ifndef(pack_R15) #declare global_pack_R15=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.939000,0.000000,46.863000>}#end		//Discrete Resistor 0,3W 10MM Grid R15  0207/10
#ifndef(pack_R16) #declare global_pack_R16=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<170.586400,0.000000,31.546800>}#end		//Discrete Resistor 0,3W 10MM Grid R16  0207/10
#ifndef(pack_R17) #declare global_pack_R17=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<173.583600,0.000000,31.546800>}#end		//Discrete Resistor 0,3W 10MM Grid R17  0207/10
#ifndef(pack_R18) #declare global_pack_R18=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.939000,0.000000,62.103000>}#end		//Discrete Resistor 0,3W 10MM Grid R18  0207/10
#ifndef(pack_R19) #declare global_pack_R19=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<38.989000,0.000000,67.183000>}#end		//Discrete Resistor 0,3W 10MM Grid R19  0207/10
#ifndef(pack_R20) #declare global_pack_R20=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.939000,0.000000,57.023000>}#end		//Discrete Resistor 0,3W 10MM Grid R20  0207/10
#ifndef(pack_R21) #declare global_pack_R21=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<170.586400,0.000000,49.504600>}#end		//Discrete Resistor 0,3W 10MM Grid R21  0207/10
#ifndef(pack_R22) #declare global_pack_R22=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<173.558200,0.000000,49.530000>}#end		//Discrete Resistor 0,3W 10MM Grid R22  0207/10
#ifndef(pack_R23) #declare global_pack_R23=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.939000,0.000000,72.263000>}#end		//Discrete Resistor 0,3W 10MM Grid R23  0207/10
#ifndef(pack_R24) #declare global_pack_R24=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<35.179000,0.000000,67.183000>}#end		//Discrete Resistor 0,3W 10MM Grid R24  0207/10
#ifndef(pack_R25) #declare global_pack_R25=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<19.939000,0.000000,67.183000>}#end		//Discrete Resistor 0,3W 10MM Grid R25  0207/10
#ifndef(pack_R26) #declare global_pack_R26=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<170.967400,0.000000,67.183000>}#end		//Discrete Resistor 0,3W 10MM Grid R26  0207/10
#ifndef(pack_R27) #declare global_pack_R27=yes; object {RES_DIS_0207_10MM(texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture{pigment{checker Black White}finish{phong 0.2 ambient (0.1 * global_ambient_mul)}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<173.939200,0.000000,67.259200>}#end		//Discrete Resistor 0,3W 10MM Grid R27  0207/10
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_BAT1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.112800,1.300000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<86.131400,0,19.293800> texture{col_thl}}
#ifndef(global_pack_BAT1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.112800,1.300000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<86.131400,0,39.293800> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<136.702800,0,25.628600> texture{col_thl}}
#ifndef(global_pack_C1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<136.702800,0,20.548600> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<139.674600,0,51.003200> texture{col_thl}}
#ifndef(global_pack_C2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<134.594600,0,51.003200> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<139.547600,0,20.548600> texture{col_thl}}
#ifndef(global_pack_C3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<139.547600,0,25.628600> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<142.443200,0,20.599400> texture{col_thl}}
#ifndef(global_pack_C4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<142.443200,0,25.679400> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<186.131200,0,19.075400> texture{col_thl}}
#ifndef(global_pack_D1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<186.131200,0,8.915400> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<186.385200,0,36.855400> texture{col_thl}}
#ifndef(global_pack_D2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<186.385200,0,26.695400> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<186.131200,0,54.889400> texture{col_thl}}
#ifndef(global_pack_D3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<186.131200,0,44.729400> texture{col_thl}}
#ifndef(global_pack_D4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<186.131200,0,72.669400> texture{col_thl}}
#ifndef(global_pack_D4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<186.131200,0,62.509400> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<119.354600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<121.894600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<124.434600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<126.974600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<129.514600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<132.054600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<134.594600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<137.134600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<139.674600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<142.214600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<144.754600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<147.294600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<149.834600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<152.374600,0,37.769800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<152.374600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<149.834600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<147.294600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<144.754600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<142.214600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<139.674600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<137.134600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<134.594600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<132.054600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<129.514600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<126.974600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<124.434600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<121.894600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<119.354600,0,45.389800> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<108.864400,0,21.463000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<108.864400,0,24.003000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<108.864400,0,26.543000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<108.864400,0,29.083000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<101.244400,0,29.083000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<101.244400,0,26.543000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<101.244400,0,24.003000> texture{col_thl}}
#ifndef(global_pack_IC2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<101.244400,0,21.463000> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<128.143000,0,21.259800> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<128.143000,0,23.799800> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<128.143000,0,26.339800> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<128.143000,0,28.879800> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.523000,0,28.879800> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.523000,0,26.339800> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.523000,0,23.799800> texture{col_thl}}
#ifndef(global_pack_IC3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.812800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<120.523000,0,21.259800> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<9.296400,0,27.711400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<11.836400,0,27.711400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<9.296400,0,25.171400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<11.836400,0,25.171400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<9.296400,0,22.631400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<11.836400,0,22.631400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<9.296400,0,20.091400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<11.836400,0,20.091400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<9.296400,0,17.551400> texture{col_thl}}
#ifndef(global_pack_JP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<11.836400,0,17.551400> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<59.766200,0,60.756800> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<150.926800,0,8.051800> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<153.466800,0,8.051800> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<86.563200,0,8.890000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<84.023200,0,8.890000> texture{col_thl}}
#ifndef(global_pack_JP5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<122.072400,0,8.788400> texture{col_thl}}
#ifndef(global_pack_JP5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<119.532400,0,8.788400> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<56.057800,0,8.940800> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<53.517800,0,8.940800> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<22.758400,0,9.626600> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<25.298400,0,9.626600> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.838400,0,9.626600> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<30.378400,0,9.626600> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<9.321800,0,15.011400> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<11.861800,0,15.011400> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<9.321800,0,12.471400> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<11.861800,0,12.471400> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<9.321800,0,9.931400> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,1.016000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<11.861800,0,9.931400> texture{col_thl}}
#ifndef(global_pack_JP9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.828800,1.016000,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<59.867800,0,58.216800> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<195.148200,0,7.010400> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<195.148200,0,18.948400> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<207.340200,0,18.948400> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<193.116200,0,12.979400> texture{col_thl}}
#ifndef(global_pack_K1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<207.340200,0,7.010400> texture{col_thl}}
#ifndef(global_pack_K2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<195.148200,0,24.790400> texture{col_thl}}
#ifndef(global_pack_K2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<195.148200,0,36.728400> texture{col_thl}}
#ifndef(global_pack_K2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<207.340200,0,36.728400> texture{col_thl}}
#ifndef(global_pack_K2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<193.116200,0,30.759400> texture{col_thl}}
#ifndef(global_pack_K2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<207.340200,0,24.790400> texture{col_thl}}
#ifndef(global_pack_K3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<195.148200,0,42.570400> texture{col_thl}}
#ifndef(global_pack_K3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<195.148200,0,54.508400> texture{col_thl}}
#ifndef(global_pack_K3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<207.340200,0,54.508400> texture{col_thl}}
#ifndef(global_pack_K3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<193.116200,0,48.539400> texture{col_thl}}
#ifndef(global_pack_K3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<207.340200,0,42.570400> texture{col_thl}}
#ifndef(global_pack_K4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<195.148200,0,60.350400> texture{col_thl}}
#ifndef(global_pack_K4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<195.148200,0,72.288400> texture{col_thl}}
#ifndef(global_pack_K4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<207.340200,0,72.288400> texture{col_thl}}
#ifndef(global_pack_K4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<193.116200,0,66.319400> texture{col_thl}}
#ifndef(global_pack_K4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.133600,1.320800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<207.340200,0,60.350400> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<53.644800,0,73.228200> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<53.644800,0,70.688200> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<180.035200,0,16.027400> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<180.035200,0,18.567400> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<180.035200,0,34.061400> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<180.035200,0,36.601400> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<180.289200,0,52.095400> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<180.289200,0,54.635400> texture{col_thl}}
#ifndef(global_pack_LED5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<180.543200,0,69.875400> texture{col_thl}}
#ifndef(global_pack_LED5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<180.543200,0,72.415400> texture{col_thl}}
#ifndef(global_pack_LED6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<53.797200,0,60.477400> texture{col_thl}}
#ifndef(global_pack_LED6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.778000,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<53.797200,0,57.937400> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<142.290800,0,31.521400> texture{col_thl}}
#ifndef(global_pack_Q1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<137.464800,0,31.521400> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<116.357400,0,30.937200> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<113.817400,0,30.937200> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<149.301200,0,65.536800> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<149.376200,0,68.376800> texture{col_thl}}
#ifndef(global_pack_Q3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<149.301200,0,71.216800> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.099000,0,36.403000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.174000,0,39.243000> texture{col_thl}}
#ifndef(global_pack_Q4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.099000,0,42.083000> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<177.195200,0,10.693400> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<180.035200,0,10.618400> texture{col_thl}}
#ifndef(global_pack_Q5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<182.875200,0,10.693400> texture{col_thl}}
#ifndef(global_pack_Q6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.099000,0,46.563000> texture{col_thl}}
#ifndef(global_pack_Q6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.174000,0,49.403000> texture{col_thl}}
#ifndef(global_pack_Q6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.099000,0,52.243000> texture{col_thl}}
#ifndef(global_pack_Q7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<177.449200,0,29.235400> texture{col_thl}}
#ifndef(global_pack_Q7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<180.289200,0,29.160400> texture{col_thl}}
#ifndef(global_pack_Q7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<183.129200,0,29.235400> texture{col_thl}}
#ifndef(global_pack_Q8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.099000,0,57.993000> texture{col_thl}}
#ifndef(global_pack_Q8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.174000,0,60.833000> texture{col_thl}}
#ifndef(global_pack_Q8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.099000,0,63.673000> texture{col_thl}}
#ifndef(global_pack_Q9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<177.449200,0,46.253400> texture{col_thl}}
#ifndef(global_pack_Q9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<180.289200,0,46.178400> texture{col_thl}}
#ifndef(global_pack_Q9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<183.129200,0,46.253400> texture{col_thl}}
#ifndef(global_pack_Q10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.099000,0,66.883000> texture{col_thl}}
#ifndef(global_pack_Q10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.174000,0,69.723000> texture{col_thl}}
#ifndef(global_pack_Q10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<30.099000,0,72.563000> texture{col_thl}}
#ifndef(global_pack_Q11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<177.449200,0,64.287400> texture{col_thl}}
#ifndef(global_pack_Q11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<180.289200,0,64.212400> texture{col_thl}}
#ifndef(global_pack_Q11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<183.129200,0,64.287400> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<51.638200,0,26.619200> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<61.798200,0,26.619200> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<64.719200,0,63.119000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<64.719200,0,73.279000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<149.250400,0,58.191400> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<159.410400,0,58.191400> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<103.632000,0,55.626000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<113.792000,0,55.626000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<103.784400,0,51.739800> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<113.944400,0,51.739800> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<56.235600,0,46.990000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<53.695600,0,49.530000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<51.155600,0,46.990000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<37.363400,0,58.318400> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<37.363400,0,48.158400> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<25.019000,0,41.783000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.859000,0,41.783000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<35.179000,0,44.323000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<35.179000,0,34.163000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<25.019000,0,36.703000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.859000,0,36.703000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<170.535600,0,8.483600> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<170.535600,0,18.643600> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<173.329600,0,8.432800> texture{col_thl}}
#ifndef(global_pack_R12) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<173.329600,0,18.592800> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<25.019000,0,51.943000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.859000,0,51.943000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<38.989000,0,44.323000> texture{col_thl}}
#ifndef(global_pack_R14) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<38.989000,0,34.163000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<25.019000,0,46.863000> texture{col_thl}}
#ifndef(global_pack_R15) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.859000,0,46.863000> texture{col_thl}}
#ifndef(global_pack_R16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<170.586400,0,26.466800> texture{col_thl}}
#ifndef(global_pack_R16) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<170.586400,0,36.626800> texture{col_thl}}
#ifndef(global_pack_R17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<173.583600,0,26.466800> texture{col_thl}}
#ifndef(global_pack_R17) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<173.583600,0,36.626800> texture{col_thl}}
#ifndef(global_pack_R18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<25.019000,0,62.103000> texture{col_thl}}
#ifndef(global_pack_R18) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.859000,0,62.103000> texture{col_thl}}
#ifndef(global_pack_R19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<38.989000,0,72.263000> texture{col_thl}}
#ifndef(global_pack_R19) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<38.989000,0,62.103000> texture{col_thl}}
#ifndef(global_pack_R20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<25.019000,0,57.023000> texture{col_thl}}
#ifndef(global_pack_R20) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.859000,0,57.023000> texture{col_thl}}
#ifndef(global_pack_R21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<170.586400,0,44.424600> texture{col_thl}}
#ifndef(global_pack_R21) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<170.586400,0,54.584600> texture{col_thl}}
#ifndef(global_pack_R22) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<173.558200,0,44.450000> texture{col_thl}}
#ifndef(global_pack_R22) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<173.558200,0,54.610000> texture{col_thl}}
#ifndef(global_pack_R23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<25.019000,0,72.263000> texture{col_thl}}
#ifndef(global_pack_R23) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.859000,0,72.263000> texture{col_thl}}
#ifndef(global_pack_R24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<35.179000,0,72.263000> texture{col_thl}}
#ifndef(global_pack_R24) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<35.179000,0,62.103000> texture{col_thl}}
#ifndef(global_pack_R25) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<25.019000,0,67.183000> texture{col_thl}}
#ifndef(global_pack_R25) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<14.859000,0,67.183000> texture{col_thl}}
#ifndef(global_pack_R26) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<170.967400,0,62.103000> texture{col_thl}}
#ifndef(global_pack_R26) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<170.967400,0,72.263000> texture{col_thl}}
#ifndef(global_pack_R27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<173.939200,0,62.179200> texture{col_thl}}
#ifndef(global_pack_R27) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.184400,1.000000,1,16,1+global_tmp,0) rotate<0,-90.000000,0>translate<173.939200,0,72.339200> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<56.235600,0,36.652200> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<56.235600,0,30.149800> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<51.714400,0,36.652200> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<51.714400,0,30.149800> texture{col_thl}}
#ifndef(global_pack_SG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<138.582400,0,62.722600> texture{col_thl}}
#ifndef(global_pack_SG1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.930400,0.800000,1,16,1+global_tmp,0) rotate<0,-270.000000,0>translate<138.582400,0,70.322600> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<75.284600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<77.824600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<80.364600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<82.904600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<85.444600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<87.984600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<90.524600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<93.064600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<95.604600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<98.144600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<100.684600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<103.224600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<105.764600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<108.304600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<110.844600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.612800,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<113.384600,0,72.525200> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<8.509000,0,36.823000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<8.509000,0,41.823000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<8.509000,0,46.823000> texture{col_thl}}
#ifndef(global_pack_X2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<8.509000,0,51.823000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<8.509000,0,57.143000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<8.509000,0,62.143000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<8.509000,0,67.143000> texture{col_thl}}
#ifndef(global_pack_X3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<8.509000,0,72.143000> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.402400,0,17.722200> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.402400,0,22.722200> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.402400,0,27.722200> texture{col_thl}}
#ifndef(global_pack_X4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.402400,0,32.722200> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.199200,0,37.432600> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.199200,0,42.432600> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.199200,0,47.432600> texture{col_thl}}
#ifndef(global_pack_X5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.199200,0,52.432600> texture{col_thl}}
#ifndef(global_pack_X6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.326200,0,57.397000> texture{col_thl}}
#ifndef(global_pack_X6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.326200,0,62.397000> texture{col_thl}}
#ifndef(global_pack_X6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.326200,0,67.397000> texture{col_thl}}
#ifndef(global_pack_X6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(2.006600,1.193800,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<222.326200,0,72.397000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<165.811200,0,34.569400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<101.041200,0,39.649400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<106.121200,0,34.569400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<108.661200,0,34.569400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<84.531200,0,24.409400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<126.441200,0,77.749400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<122.631200,0,19.329400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<125.171200,0,6.629400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<103.581200,0,44.729400> texture{col_thl}}
object{TOOLS_PCB_VIA(1.422400,0.609600,1,16,1,0) translate<111.201200,0,30.759400> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.521200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.521200,0.000000,32.029400>}
box{<0,0,-0.304800><40.640000,0.035000,0.304800> rotate<0,-90.000000,0> translate<4.521200,0.000000,32.029400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,39.649400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,-90.000000,0> translate<5.791200,0.000000,39.649400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,53.619400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,49.809400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<5.791200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,53.619400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,63.779400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<5.791200,0.000000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,-1.535000,11.709400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,-1.535000,9.169400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<7.061200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,0.000000,24.409400>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,90.000000,0> translate<7.061200,0.000000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,-1.535000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,-1.535000,24.409400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<7.061200,-1.535000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,-1.535000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,-1.535000,23.139400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<7.061200,-1.535000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,0.000000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,25.679400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<7.061200,0.000000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.521200,0.000000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,28.219400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<4.521200,0.000000,32.029400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,-1.535000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,-1.535000,30.759400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<7.061200,-1.535000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,39.649400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,37.109400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<5.791200,0.000000,39.649400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,47.269400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<5.791200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,53.619400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,56.159400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<5.791200,0.000000,53.619400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<5.791200,0.000000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,66.319400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<5.791200,0.000000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,36.823000>}
box{<0,0,-0.304800><0.337102,0.035000,0.304800> rotate<0,58.163735,0> translate<8.331200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,46.823000>}
box{<0,0,-0.304800><0.480506,0.035000,0.304800> rotate<0,68.278225,0> translate<8.331200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,56.159400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,57.143000>}
box{<0,0,-0.304800><0.999541,0.035000,0.304800> rotate<0,-79.748338,0> translate<8.331200,0.000000,56.159400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,66.319400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,67.143000>}
box{<0,0,-0.304800><0.842573,0.035000,0.304800> rotate<0,-77.812718,0> translate<8.331200,0.000000,66.319400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,-1.535000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.296400,-1.535000,22.631400>}
box{<0,0,-0.304800><1.090722,0.035000,0.304800> rotate<0,27.756709,0> translate<8.331200,-1.535000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.296400,0.000000,25.171400>}
box{<0,0,-0.304800><1.090722,0.035000,0.304800> rotate<0,27.756709,0> translate<8.331200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,0.000000,28.219400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.296400,0.000000,27.711400>}
box{<0,0,-0.304800><1.090722,0.035000,0.304800> rotate<0,27.756709,0> translate<8.331200,0.000000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,6.629400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<7.061200,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.321800,-1.535000,9.931400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,-1.535000,9.169400>}
box{<0,0,-0.304800><0.811609,0.035000,0.304800> rotate<0,69.859086,0> translate<9.321800,-1.535000,9.931400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,-1.535000,11.709400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,-1.535000,11.709400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<7.061200,-1.535000,11.709400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.321800,-1.535000,12.471400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,-1.535000,11.709400>}
box{<0,0,-0.304800><0.811609,0.035000,0.304800> rotate<0,69.859086,0> translate<9.321800,-1.535000,12.471400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.321800,0.000000,15.011400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,15.519400>}
box{<0,0,-0.304800><0.579766,0.035000,0.304800> rotate<0,-61.185168,0> translate<9.321800,0.000000,15.011400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,16.789400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,15.519400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<9.601200,0.000000,15.519400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.296400,0.000000,17.551400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,16.789400>}
box{<0,0,-0.304800><0.820699,0.035000,0.304800> rotate<0,68.194090,0> translate<9.296400,0.000000,17.551400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.296400,0.000000,20.091400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,20.599400>}
box{<0,0,-0.304800><0.592425,0.035000,0.304800> rotate<0,-59.032347,0> translate<9.296400,0.000000,20.091400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,36.823000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,35.839400>}
box{<0,0,-0.304800><1.469820,0.035000,0.304800> rotate<0,42.002405,0> translate<8.509000,0.000000,36.823000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,-1.535000,36.823000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,-1.535000,35.839400>}
box{<0,0,-0.304800><1.469820,0.035000,0.304800> rotate<0,42.002405,0> translate<8.509000,-1.535000,36.823000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,41.823000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,42.189400>}
box{<0,0,-0.304800><1.152020,0.035000,0.304800> rotate<0,-18.543818,0> translate<8.509000,0.000000,41.823000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,51.823000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,52.349400>}
box{<0,0,-0.304800><1.212435,0.035000,0.304800> rotate<0,-25.730649,0> translate<8.509000,0.000000,51.823000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,62.143000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,62.509400>}
box{<0,0,-0.304800><1.152020,0.035000,0.304800> rotate<0,-18.543818,0> translate<8.509000,0.000000,62.143000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.509000,0.000000,72.143000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,72.669400>}
box{<0,0,-0.304800><1.212435,0.035000,0.304800> rotate<0,-25.730649,0> translate<8.509000,0.000000,72.143000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.871200,0.000000,20.599400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.601200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,-1.535000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.871200,-1.535000,34.569400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<9.601200,-1.535000,35.839400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<4.521200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.871200,0.000000,79.019400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<4.521200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.871200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.836400,0.000000,20.091400>}
box{<0,0,-0.304800><1.090722,0.035000,0.304800> rotate<0,27.756709,0> translate<10.871200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<7.061200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,4.089400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<7.061200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,6.629400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<9.601200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.861800,-1.535000,9.931400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,10.439400>}
box{<0,0,-0.304800><0.579766,0.035000,0.304800> rotate<0,-61.185168,0> translate<11.861800,-1.535000,9.931400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.861800,-1.535000,12.471400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,12.979400>}
box{<0,0,-0.304800><0.579766,0.035000,0.304800> rotate<0,-61.185168,0> translate<11.861800,-1.535000,12.471400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.861800,0.000000,15.011400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,15.519400>}
box{<0,0,-0.304800><0.579766,0.035000,0.304800> rotate<0,-61.185168,0> translate<11.861800,0.000000,15.011400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,16.789400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,15.519400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<12.141200,0.000000,15.519400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.836400,0.000000,17.551400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,16.789400>}
box{<0,0,-0.304800><0.820699,0.035000,0.304800> rotate<0,68.194090,0> translate<11.836400,0.000000,17.551400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.836400,0.000000,20.091400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,20.599400>}
box{<0,0,-0.304800><0.592425,0.035000,0.304800> rotate<0,-59.032347,0> translate<11.836400,0.000000,20.091400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.836400,0.000000,22.631400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,21.869400>}
box{<0,0,-0.304800><0.820699,0.035000,0.304800> rotate<0,68.194090,0> translate<11.836400,0.000000,22.631400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,21.869400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.141200,0.000000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.836400,-1.535000,25.171400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,25.679400>}
box{<0,0,-0.304800><0.592425,0.035000,0.304800> rotate<0,-59.032347,0> translate<11.836400,-1.535000,25.171400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<11.836400,0.000000,27.711400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,28.219400>}
box{<0,0,-0.304800><0.592425,0.035000,0.304800> rotate<0,-59.032347,0> translate<11.836400,0.000000,27.711400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,33.299400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<9.601200,0.000000,35.839400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,28.219400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,33.299400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<12.141200,0.000000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.411200,-1.535000,10.439400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.141200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,12.979400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.411200,-1.535000,12.979400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.141200,-1.535000,12.979400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.411200,-1.535000,24.409400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<12.141200,-1.535000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.411200,-1.535000,12.979400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,14.249400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.411200,-1.535000,12.979400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,18.059400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<12.141200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,42.189400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.601200,0.000000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,52.349400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.601200,0.000000,52.349400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,62.509400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.601200,0.000000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,72.669400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.601200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,0.000000,36.703000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,-1.535000,36.703000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,0.000000,41.783000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,0.000000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,0.000000,46.863000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,-1.535000,46.863000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,-1.535000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,0.000000,51.943000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,0.000000,52.349400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,0.000000,57.023000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,0.000000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,-1.535000,57.023000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,-1.535000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,0.000000,62.103000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,0.000000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,0.000000,67.183000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,-1.535000,67.183000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,-1.535000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.859000,0.000000,72.263000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<14.681200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.411200,-1.535000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.951200,-1.535000,12.979400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<13.411200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.491200,-1.535000,40.919400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.681200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.491200,-1.535000,51.079400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.681200,-1.535000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.491200,-1.535000,61.239400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.681200,-1.535000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.491200,-1.535000,71.399400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.681200,-1.535000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,18.059400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.301200,0.000000,10.439400>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<14.681200,0.000000,18.059400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.301200,0.000000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<22.758400,0.000000,9.626600>}
box{<0,0,-0.304800><0.932564,0.035000,0.304800> rotate<0,60.638244,0> translate<22.301200,0.000000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,6.629400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,6.629400>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.141200,-1.535000,6.629400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,6.629400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,9.169400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<24.841200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,0.000000,18.059400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,28.219400>}
box{<0,0,-0.304800><14.368410,0.035000,0.304800> rotate<0,-44.997030,0> translate<14.681200,0.000000,18.059400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,28.219400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<24.841200,0.000000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.491200,-1.535000,40.919400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,40.919400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.491200,-1.535000,40.919400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.491200,-1.535000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,51.079400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.491200,-1.535000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.491200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,61.239400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.491200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<18.491200,-1.535000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,71.399400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<18.491200,-1.535000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,0.000000,36.703000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<24.841200,0.000000,35.839400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,0.000000,36.703000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<24.841200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,40.919400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,-1.535000,41.783000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<24.841200,-1.535000,40.919400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,0.000000,46.863000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<24.841200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,-1.535000,51.943000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<24.841200,-1.535000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,0.000000,57.023000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<24.841200,0.000000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,-1.535000,62.103000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<24.841200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,0.000000,67.183000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<24.841200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.019000,-1.535000,72.263000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<24.841200,-1.535000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<25.298400,-1.535000,9.626600>}
box{<0,0,-0.304800><0.646578,0.035000,0.304800> rotate<0,-44.997030,0> translate<24.841200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,-1.535000,12.979400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,-1.535000,10.439400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<27.381200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<15.951200,-1.535000,12.979400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,-1.535000,12.979400>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<15.951200,-1.535000,12.979400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,37.109400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.841200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,37.109400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,-90.000000,0> translate<27.381200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,47.269400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.841200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,47.269400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,-90.000000,0> translate<27.381200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,57.429400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.841200,0.000000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,63.779400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<27.381200,0.000000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,-1.535000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.838400,-1.535000,9.626600>}
box{<0,0,-0.304800><0.932564,0.035000,0.304800> rotate<0,60.638244,0> translate<27.381200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,40.919400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.651200,-1.535000,40.919400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.841200,-1.535000,40.919400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.651200,-1.535000,51.079400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.841200,-1.535000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.651200,-1.535000,71.399400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.841200,-1.535000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,37.109400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.381200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.651200,-1.535000,40.919400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,39.649400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<28.651200,-1.535000,40.919400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,47.269400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.381200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.651200,-1.535000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,49.809400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<28.651200,-1.535000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,57.429400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<27.381200,0.000000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,61.239400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.841200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<27.381200,0.000000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,66.319400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<27.381200,0.000000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<24.841200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,67.589400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<24.841200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<28.651200,-1.535000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,70.129400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<28.651200,-1.535000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,0.000000,36.403000>}
box{<0,0,-0.304800><0.728432,0.035000,0.304800> rotate<0,75.867180,0> translate<29.921200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,-1.535000,36.403000>}
box{<0,0,-0.304800><0.728432,0.035000,0.304800> rotate<0,75.867180,0> translate<29.921200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,-1.535000,42.083000>}
box{<0,0,-0.304800><0.207205,0.035000,0.304800> rotate<0,30.895326,0> translate<29.921200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,0.000000,46.563000>}
box{<0,0,-0.304800><0.728432,0.035000,0.304800> rotate<0,75.867180,0> translate<29.921200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,-1.535000,52.243000>}
box{<0,0,-0.304800><0.207205,0.035000,0.304800> rotate<0,30.895326,0> translate<29.921200,-1.535000,52.349400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,0.000000,57.993000>}
box{<0,0,-0.304800><0.590980,0.035000,0.304800> rotate<0,-72.486191,0> translate<29.921200,0.000000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,-1.535000,63.673000>}
box{<0,0,-0.304800><0.207205,0.035000,0.304800> rotate<0,30.895326,0> translate<29.921200,-1.535000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,66.319400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,0.000000,66.883000>}
box{<0,0,-0.304800><0.590980,0.035000,0.304800> rotate<0,-72.486191,0> translate<29.921200,0.000000,66.319400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,0.000000,66.883000>}
box{<0,0,-0.304800><0.728432,0.035000,0.304800> rotate<0,75.867180,0> translate<29.921200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.099000,0.000000,72.563000>}
box{<0,0,-0.304800><0.207205,0.035000,0.304800> rotate<0,30.895326,0> translate<29.921200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,39.649400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.174000,-1.535000,39.243000>}
box{<0,0,-0.304800><0.478611,0.035000,0.304800> rotate<0,58.112601,0> translate<29.921200,-1.535000,39.649400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,49.809400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.174000,-1.535000,49.403000>}
box{<0,0,-0.304800><0.478611,0.035000,0.304800> rotate<0,58.112601,0> translate<29.921200,-1.535000,49.809400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.174000,-1.535000,60.833000>}
box{<0,0,-0.304800><0.478611,0.035000,0.304800> rotate<0,58.112601,0> translate<29.921200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.174000,-1.535000,69.723000>}
box{<0,0,-0.304800><0.478611,0.035000,0.304800> rotate<0,58.112601,0> translate<29.921200,-1.535000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.191200,-1.535000,63.779400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.921200,-1.535000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.378400,-1.535000,9.626600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.461200,-1.535000,11.709400>}
box{<0,0,-0.304800><2.945524,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.378400,-1.535000,9.626600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.461200,-1.535000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.461200,-1.535000,59.969400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<32.461200,-1.535000,59.969400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.191200,-1.535000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.461200,-1.535000,63.779400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<31.191200,-1.535000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<30.378400,0.000000,9.626600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,14.249400>}
box{<0,0,-0.304800><6.537626,0.035000,0.304800> rotate<0,-44.997030,0> translate<30.378400,0.000000,9.626600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,14.249400>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,-90.000000,0> translate<35.001200,0.000000,14.249400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.871200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,-1.535000,34.569400>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.871200,-1.535000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,-1.535000,42.189400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.921200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,-1.535000,43.459400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.001200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,51.079400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,-90.000000,0> translate<35.001200,0.000000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,72.669400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.921200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,75.209400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<35.001200,0.000000,75.209400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.179000,0.000000,34.163000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<35.001200,0.000000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.179000,0.000000,34.163000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<35.001200,0.000000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.179000,-1.535000,34.163000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<35.001200,-1.535000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,-1.535000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.179000,-1.535000,44.323000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<35.001200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.179000,0.000000,62.103000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<35.001200,0.000000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.179000,0.000000,62.103000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<35.001200,0.000000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.179000,0.000000,72.263000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<35.001200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,75.209400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.271200,0.000000,76.479400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<35.001200,0.000000,75.209400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,-1.535000,44.729400>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<29.921200,-1.535000,52.349400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.363400,0.000000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,0.000000,47.269400>}
box{<0,0,-0.304800><0.906606,0.035000,0.304800> rotate<0,78.684874,0> translate<37.363400,0.000000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.363400,-1.535000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,-1.535000,47.269400>}
box{<0,0,-0.304800><0.906606,0.035000,0.304800> rotate<0,78.684874,0> translate<37.363400,-1.535000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,0.000000,48.539400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<35.001200,0.000000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.363400,0.000000,48.158400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,0.000000,48.539400>}
box{<0,0,-0.304800><0.420445,0.035000,0.304800> rotate<0,-64.978818,0> translate<37.363400,0.000000,48.158400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.363400,0.000000,58.318400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,0.000000,57.429400>}
box{<0,0,-0.304800><0.906606,0.035000,0.304800> rotate<0,78.684874,0> translate<37.363400,0.000000,58.318400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,0.000000,34.569400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.001200,0.000000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,-1.535000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,44.729400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<37.541200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.461200,-1.535000,59.969400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,53.619400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<32.461200,-1.535000,59.969400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,0.000000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,0.000000,62.509400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.001200,0.000000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<31.191200,-1.535000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,71.399400>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,-44.997030,0> translate<31.191200,-1.535000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,0.000000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.989000,0.000000,34.163000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<38.811200,0.000000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.989000,-1.535000,44.323000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<38.811200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,0.000000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.989000,0.000000,62.103000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<38.811200,0.000000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.989000,-1.535000,62.103000>}
box{<0,0,-0.304800><0.443592,0.035000,0.304800> rotate<0,66.366242,0> translate<38.811200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.989000,-1.535000,72.263000>}
box{<0,0,-0.304800><0.881713,0.035000,0.304800> rotate<0,-78.361194,0> translate<38.811200,-1.535000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,0.000000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.351200,0.000000,37.109400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<38.811200,0.000000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.351200,0.000000,47.269400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<37.541200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.351200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.351200,0.000000,47.269400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.351200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.351200,0.000000,61.239400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<37.541200,0.000000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.351200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.351200,0.000000,73.939400>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,90.000000,0> translate<41.351200,0.000000,73.939400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.351200,0.000000,73.939400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.621200,0.000000,75.209400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.351200,0.000000,73.939400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<9.601200,0.000000,6.629400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.701200,0.000000,6.629400>}
box{<0,0,-0.304800><38.100000,0.035000,0.304800> rotate<0,0.000000,0> translate<9.601200,0.000000,6.629400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<29.921200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.701200,-1.535000,37.109400>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<29.921200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.701200,0.000000,6.629400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.971200,0.000000,7.899400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<47.701200,0.000000,6.629400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.971200,0.000000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.971200,0.000000,7.899400>}
box{<0,0,-0.304800><57.150000,0.035000,0.304800> rotate<0,-90.000000,0> translate<48.971200,0.000000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<37.541200,-1.535000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.241200,-1.535000,47.269400>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<37.541200,-1.535000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.241200,-1.535000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.155600,-1.535000,46.990000>}
box{<0,0,-0.304800><0.956134,0.035000,0.304800> rotate<0,16.989702,0> translate<50.241200,-1.535000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,0.000000,29.489400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<51.511200,0.000000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<8.331200,-1.535000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,-1.535000,30.759400>}
box{<0,0,-0.304800><43.180000,0.035000,0.304800> rotate<0,0.000000,0> translate<8.331200,-1.535000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,0.000000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,0.000000,30.759400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<51.511200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.638200,0.000000,26.619200>}
box{<0,0,-0.304800><0.353781,0.035000,0.304800> rotate<0,68.957938,0> translate<51.511200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,0.000000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.714400,0.000000,30.149800>}
box{<0,0,-0.304800><0.690955,0.035000,0.304800> rotate<0,-72.892460,0> translate<51.511200,0.000000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.714400,0.000000,30.149800>}
box{<0,0,-0.304800><0.642575,0.035000,0.304800> rotate<0,71.560328,0> translate<51.511200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,-1.535000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.714400,-1.535000,30.149800>}
box{<0,0,-0.304800><0.642575,0.035000,0.304800> rotate<0,71.560328,0> translate<51.511200,-1.535000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,0.000000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.714400,0.000000,36.652200>}
box{<0,0,-0.304800><0.837815,0.035000,0.304800> rotate<0,-75.958743,0> translate<51.511200,0.000000,35.839400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,-1.535000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.714400,-1.535000,36.652200>}
box{<0,0,-0.304800><0.837815,0.035000,0.304800> rotate<0,-75.958743,0> translate<51.511200,-1.535000,35.839400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.511200,-1.535000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.781200,-1.535000,34.569400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<51.511200,-1.535000,35.839400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.517800,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,9.169400>}
box{<0,0,-0.304800><0.580322,0.035000,0.304800> rotate<0,-23.197059,0> translate<53.517800,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,9.169400>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,-90.000000,0> translate<54.051200,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.701200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,-1.535000,30.759400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<47.701200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.695600,0.000000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,49.809400>}
box{<0,0,-0.304800><0.452234,0.035000,0.304800> rotate<0,-38.154708,0> translate<53.695600,0.000000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.797200,0.000000,57.937400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,58.699400>}
box{<0,0,-0.304800><0.803219,0.035000,0.304800> rotate<0,-71.560328,0> translate<53.797200,0.000000,57.937400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.797200,0.000000,60.477400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,61.239400>}
box{<0,0,-0.304800><0.803219,0.035000,0.304800> rotate<0,-71.560328,0> translate<53.797200,0.000000,60.477400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.971200,0.000000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,70.129400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<48.971200,0.000000,65.049400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.644800,0.000000,70.688200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,70.129400>}
box{<0,0,-0.304800><0.690955,0.035000,0.304800> rotate<0,53.969065,0> translate<53.644800,0.000000,70.688200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.644800,-1.535000,70.688200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,-1.535000,70.129400>}
box{<0,0,-0.304800><0.690955,0.035000,0.304800> rotate<0,53.969065,0> translate<53.644800,-1.535000,70.688200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.644800,0.000000,73.228200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,73.939400>}
box{<0,0,-0.304800><0.819125,0.035000,0.304800> rotate<0,-60.251142,0> translate<53.644800,0.000000,73.228200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.057800,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,9.169400>}
box{<0,0,-0.304800><0.580322,0.035000,0.304800> rotate<0,-23.197059,0> translate<56.057800,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.057800,-1.535000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,-1.535000,9.169400>}
box{<0,0,-0.304800><0.580322,0.035000,0.304800> rotate<0,-23.197059,0> translate<56.057800,-1.535000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,29.489400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.051200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.235600,0.000000,30.149800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,29.489400>}
box{<0,0,-0.304800><0.750053,0.035000,0.304800> rotate<0,61.695172,0> translate<56.235600,0.000000,30.149800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,-1.535000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,-1.535000,30.759400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.051200,-1.535000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.235600,0.000000,30.149800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,30.759400>}
box{<0,0,-0.304800><0.705736,0.035000,0.304800> rotate<0,-59.739620,0> translate<56.235600,0.000000,30.149800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.235600,-1.535000,30.149800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,-1.535000,30.759400>}
box{<0,0,-0.304800><0.705736,0.035000,0.304800> rotate<0,-59.739620,0> translate<56.235600,-1.535000,30.149800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.235600,0.000000,36.652200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,35.839400>}
box{<0,0,-0.304800><0.887184,0.035000,0.304800> rotate<0,66.366242,0> translate<56.235600,0.000000,36.652200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.235600,0.000000,36.652200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,37.109400>}
box{<0,0,-0.304800><0.579209,0.035000,0.304800> rotate<0,-52.121576,0> translate<56.235600,0.000000,36.652200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,-1.535000,44.729400>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.811200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.235600,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,47.269400>}
box{<0,0,-0.304800><0.452234,0.035000,0.304800> rotate<0,-38.154708,0> translate<56.235600,0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,47.269400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<56.591200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<32.461200,-1.535000,11.709400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,-1.535000,11.709400>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<32.461200,-1.535000,11.709400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,-1.535000,11.709400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<56.591200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,33.299400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<56.591200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,33.299400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<56.591200,0.000000,35.839400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,49.809400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.051200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,58.699400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,58.699400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.051200,0.000000,58.699400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,61.239400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.051200,0.000000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,-1.535000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,-1.535000,65.049400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<54.051200,-1.535000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.766200,0.000000,60.756800>}
box{<0,0,-0.304800><0.797576,0.035000,0.304800> rotate<0,37.232377,0> translate<59.131200,0.000000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,58.699400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.867800,0.000000,58.216800>}
box{<0,0,-0.304800><0.880615,0.035000,0.304800> rotate<0,33.229518,0> translate<59.131200,0.000000,58.699400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,-1.535000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.401200,-1.535000,48.539400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<56.591200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.591200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.671200,0.000000,14.249400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<56.591200,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.671200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.671200,0.000000,14.249400>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,-90.000000,0> translate<61.671200,0.000000,14.249400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.671200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.798200,0.000000,26.619200>}
box{<0,0,-0.304800><0.948342,0.035000,0.304800> rotate<0,-82.298517,0> translate<61.671200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.211200,-1.535000,62.509400>}
box{<0,0,-0.304800><25.400000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.811200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.051200,0.000000,73.939400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.211200,0.000000,73.939400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.051200,0.000000,73.939400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.211200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.719200,-1.535000,63.119000>}
box{<0,0,-0.304800><0.793521,0.035000,0.304800> rotate<0,-50.191116,0> translate<64.211200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.211200,0.000000,73.939400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.719200,0.000000,73.279000>}
box{<0,0,-0.304800><0.833182,0.035000,0.304800> rotate<0,52.427948,0> translate<64.211200,0.000000,73.939400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.719200,-1.535000,63.119000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.481200,-1.535000,62.509400>}
box{<0,0,-0.304800><0.975836,0.035000,0.304800> rotate<0,38.657257,0> translate<64.719200,-1.535000,63.119000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.719200,0.000000,63.119000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.481200,0.000000,63.779400>}
box{<0,0,-0.304800><1.008351,0.035000,0.304800> rotate<0,-40.911683,0> translate<64.719200,0.000000,63.119000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.561200,0.000000,21.869400>}
box{<0,0,-0.304800><16.164461,0.035000,0.304800> rotate<0,44.997030,0> translate<59.131200,0.000000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.561200,0.000000,21.869400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.561200,0.000000,23.139400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<70.561200,0.000000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.481200,0.000000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.561200,0.000000,63.779400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<65.481200,0.000000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.481200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.831200,-1.535000,56.159400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,44.997030,0> translate<65.481200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.284600,-1.535000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.641200,-1.535000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<75.284600,-1.535000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<75.641200,-1.535000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.911200,-1.535000,70.129400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<75.641200,-1.535000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.561200,0.000000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.181200,0.000000,71.399400>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.561200,0.000000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<77.824600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<78.181200,0.000000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<77.824600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.721200,0.000000,71.399400>}
box{<0,0,-0.304800><30.532871,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.131200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.364600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<80.721200,0.000000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<80.364600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.561200,0.000000,21.869400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,0.000000,9.169400>}
box{<0,0,-0.304800><17.960512,0.035000,0.304800> rotate<0,44.997030,0> translate<70.561200,0.000000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<82.904600,-1.535000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,-1.535000,72.669400>}
box{<0,0,-0.304800><0.384652,0.035000,0.304800> rotate<0,-22.015707,0> translate<82.904600,-1.535000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,-1.535000,77.749400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,-1.535000,72.669400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<83.261200,-1.535000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,-1.535000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.023200,-1.535000,8.890000>}
box{<0,0,-0.304800><1.249773,0.035000,0.304800> rotate<0,-52.427948,0> translate<83.261200,-1.535000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.023200,0.000000,8.890000>}
box{<0,0,-0.304800><0.811609,0.035000,0.304800> rotate<0,20.134975,0> translate<83.261200,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<13.411200,-1.535000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.531200,-1.535000,24.409400>}
box{<0,0,-0.304800><71.120000,0.035000,0.304800> rotate<0,0.000000,0> translate<13.411200,-1.535000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<52.781200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.531200,-1.535000,34.569400>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,0.000000,0> translate<52.781200,-1.535000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<76.911200,-1.535000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.531200,-1.535000,70.129400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<76.911200,-1.535000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,-1.535000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,-1.535000,5.359400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<83.261200,-1.535000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,-1.535000,11.709400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,-1.535000,9.169400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<85.801200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,-1.535000,11.709400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,-1.535000,11.709400>}
box{<0,0,-0.304800><26.670000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.131200,-1.535000,11.709400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.561200,0.000000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,0.000000,38.379400>}
box{<0,0,-0.304800><21.552615,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.561200,0.000000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.531200,-1.535000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,-1.535000,71.399400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<84.531200,-1.535000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.444600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,0.000000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<85.444600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.444600,-1.535000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,-1.535000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<85.444600,-1.535000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,0.000000,39.649400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,0.000000,71.399400>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,90.000000,0> translate<85.801200,0.000000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,0.000000,38.379400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.131400,0.000000,39.293800>}
box{<0,0,-0.304800><0.972193,0.035000,0.304800> rotate<0,-70.140156,0> translate<85.801200,0.000000,38.379400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,0.000000,39.649400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.131400,0.000000,39.293800>}
box{<0,0,-0.304800><0.485266,0.035000,0.304800> rotate<0,47.117987,0> translate<85.801200,0.000000,39.649400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.563200,-1.535000,8.890000>}
box{<0,0,-0.304800><0.811609,0.035000,0.304800> rotate<0,20.134975,0> translate<85.801200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<86.131400,0.000000,19.293800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.071200,0.000000,19.329400>}
box{<0,0,-0.304800><0.940474,0.035000,0.304800> rotate<0,-2.169207,0> translate<86.131400,0.000000,19.293800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.531200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.071200,-1.535000,37.109400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<84.531200,-1.535000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.531200,0.000000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.341200,0.000000,28.219400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<84.531200,0.000000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.341200,0.000000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.341200,0.000000,28.219400>}
box{<0,0,-0.304800><43.180000,0.035000,0.304800> rotate<0,-90.000000,0> translate<88.341200,0.000000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.984600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.341200,0.000000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<87.984600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.984600,-1.535000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.341200,-1.535000,72.669400>}
box{<0,0,-0.304800><0.384652,0.035000,0.304800> rotate<0,-22.015707,0> translate<87.984600,-1.535000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.341200,-1.535000,75.209400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.341200,-1.535000,72.669400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<88.341200,-1.535000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,0.000000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.611200,0.000000,25.679400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<83.261200,0.000000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.611200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.611200,0.000000,59.969400>}
box{<0,0,-0.304800><34.290000,0.035000,0.304800> rotate<0,90.000000,0> translate<89.611200,0.000000,59.969400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,0.000000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.501200,0.000000,4.089400>}
box{<0,0,-0.304800><21.552615,0.035000,0.304800> rotate<0,44.997030,0> translate<83.261200,0.000000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.041200,0.000000,39.649400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.041200,0.000000,68.859400>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,90.000000,0> translate<101.041200,0.000000,68.859400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<89.611200,0.000000,59.969400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.041200,0.000000,71.399400>}
box{<0,0,-0.304800><16.164461,0.035000,0.304800> rotate<0,-44.997030,0> translate<89.611200,0.000000,59.969400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<100.684600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.041200,0.000000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<100.684600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.071200,0.000000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,0.000000,19.329400>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.071200,0.000000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.244400,-1.535000,21.463000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,-1.535000,21.869400>}
box{<0,0,-0.304800><1.141588,0.035000,0.304800> rotate<0,-20.853082,0> translate<101.244400,-1.535000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.244400,0.000000,26.543000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,0.000000,26.949400>}
box{<0,0,-0.304800><1.141588,0.035000,0.304800> rotate<0,-20.853082,0> translate<101.244400,0.000000,26.543000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.244400,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,-1.535000,29.489400>}
box{<0,0,-0.304800><1.141588,0.035000,0.304800> rotate<0,-20.853082,0> translate<101.244400,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.041200,-1.535000,39.649400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,-1.535000,40.919400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<101.041200,-1.535000,39.649400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,0.000000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,20.599400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<102.311200,0.000000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,21.869400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<103.581200,0.000000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,28.219400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<102.311200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,28.219400>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,-90.000000,0> translate<103.581200,0.000000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,-1.535000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,-1.535000,30.759400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<102.311200,-1.535000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,54.889400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<103.581200,0.000000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.831200,-1.535000,56.159400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,-1.535000,56.159400>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.831200,-1.535000,56.159400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<101.041200,0.000000,68.859400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,71.399400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<101.041200,0.000000,68.859400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.224600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<103.224600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.632000,0.000000,55.626000>}
box{<0,0,-0.304800><0.738350,0.035000,0.304800> rotate<0,-86.049134,0> translate<103.581200,0.000000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,-1.535000,56.159400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.632000,-1.535000,55.626000>}
box{<0,0,-0.304800><0.535814,0.035000,0.304800> rotate<0,84.554087,0> translate<103.581200,-1.535000,56.159400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.784400,0.000000,51.739800>}
box{<0,0,-0.304800><0.642575,0.035000,0.304800> rotate<0,71.560328,0> translate<103.581200,0.000000,52.349400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,-1.535000,21.869400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.851200,-1.535000,19.329400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<102.311200,-1.535000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<105.764600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.121200,0.000000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<105.764600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.121200,0.000000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.121200,0.000000,71.399400>}
box{<0,0,-0.304800><36.830000,0.035000,0.304800> rotate<0,90.000000,0> translate<106.121200,0.000000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,0.000000,21.869400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,0.000000,26.949400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<103.581200,0.000000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<106.121200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,-1.535000,32.029400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<106.121200,-1.535000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.304600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,0.000000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<108.304600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,0.000000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,0.000000,71.399400>}
box{<0,0,-0.304800><36.830000,0.035000,0.304800> rotate<0,90.000000,0> translate<108.661200,0.000000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.621200,0.000000,75.209400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,0.000000,75.209400>}
box{<0,0,-0.304800><66.040000,0.035000,0.304800> rotate<0,0.000000,0> translate<42.621200,0.000000,75.209400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.864400,0.000000,26.543000>}
box{<0,0,-0.304800><0.454369,0.035000,0.304800> rotate<0,63.430762,0> translate<108.661200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,0.000000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.864400,0.000000,29.083000>}
box{<0,0,-0.304800><0.454369,0.035000,0.304800> rotate<0,63.430762,0> translate<108.661200,0.000000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.864400,0.000000,21.463000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,0.000000,21.869400>}
box{<0,0,-0.304800><1.141588,0.035000,0.304800> rotate<0,-20.853082,0> translate<108.864400,0.000000,21.463000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.864400,0.000000,24.003000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,0.000000,24.409400>}
box{<0,0,-0.304800><1.141588,0.035000,0.304800> rotate<0,-20.853082,0> translate<108.864400,0.000000,24.003000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.864400,-1.535000,29.083000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,-1.535000,29.489400>}
box{<0,0,-0.304800><1.141588,0.035000,0.304800> rotate<0,-20.853082,0> translate<108.864400,-1.535000,29.083000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,-1.535000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,-1.535000,32.029400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<108.661200,-1.535000,32.029400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,-1.535000,56.159400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,-1.535000,62.509400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<103.581200,-1.535000,56.159400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,-1.535000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,-1.535000,30.759400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<103.581200,-1.535000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,0.000000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,0.000000,30.759400>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,-90.000000,0> translate<111.201200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,-1.535000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,-1.535000,33.299400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<109.931200,-1.535000,32.029400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,0.000000,75.209400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,0.000000,72.669400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<108.661200,0.000000,75.209400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<110.844600,0.000000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,0.000000,72.669400>}
box{<0,0,-0.304800><0.384652,0.035000,0.304800> rotate<0,-22.015707,0> translate<110.844600,0.000000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<84.531200,-1.535000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<112.471200,-1.535000,70.129400>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<84.531200,-1.535000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<36.271200,0.000000,76.479400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<112.471200,0.000000,76.479400>}
box{<0,0,-0.304800><76.200000,0.035000,0.304800> rotate<0,0.000000,0> translate<36.271200,0.000000,76.479400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,0.000000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,28.219400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<109.931200,0.000000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,-1.535000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,-1.535000,28.219400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<111.201200,-1.535000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,28.219400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<113.741200,0.000000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,39.649400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<113.741200,0.000000,39.649400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,45.999400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<113.741200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,0.000000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,54.889400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<111.201200,0.000000,52.349400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<112.471200,-1.535000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,-1.535000,71.399400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<112.471200,-1.535000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.384600,-1.535000,72.525200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,-1.535000,71.399400>}
box{<0,0,-0.304800><1.180927,0.035000,0.304800> rotate<0,72.419490,0> translate<113.384600,-1.535000,72.525200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.792000,0.000000,55.626000>}
box{<0,0,-0.304800><0.738350,0.035000,0.304800> rotate<0,-86.049134,0> translate<113.741200,0.000000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.817400,0.000000,30.937200>}
box{<0,0,-0.304800><0.193441,0.035000,0.304800> rotate<0,-66.797001,0> translate<113.741200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.944400,0.000000,51.739800>}
box{<0,0,-0.304800><0.690955,0.035000,0.304800> rotate<0,-72.892460,0> translate<113.741200,0.000000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,-1.535000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.011200,-1.535000,24.409400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<109.931200,-1.535000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<85.801200,-1.535000,5.359400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.281200,-1.535000,5.359400>}
box{<0,0,-0.304800><30.480000,0.035000,0.304800> rotate<0,0.000000,0> translate<85.801200,-1.535000,5.359400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,0.000000,21.869400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.281200,0.000000,28.219400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<109.931200,0.000000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.281200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.281200,0.000000,28.219400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<116.281200,0.000000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.281200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.357400,0.000000,30.937200>}
box{<0,0,-0.304800><0.193441,0.035000,0.304800> rotate<0,-66.797001,0> translate<116.281200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<14.681200,-1.535000,14.249400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.551200,-1.535000,14.249400>}
box{<0,0,-0.304800><102.870000,0.035000,0.304800> rotate<0,0.000000,0> translate<14.681200,-1.535000,14.249400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.551200,0.000000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.551200,0.000000,26.949400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<117.551200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<116.281200,-1.535000,5.359400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,-1.535000,7.899400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<116.281200,-1.535000,5.359400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<104.851200,-1.535000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,-1.535000,19.329400>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<104.851200,-1.535000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.551200,0.000000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,0.000000,30.759400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<117.551200,0.000000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,0.000000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,0.000000,30.759400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<118.821200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,39.649400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,0.000000,34.569400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,44.997030,0> translate<113.741200,0.000000,39.649400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<87.071200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,-1.535000,37.109400>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,0.000000,0> translate<87.071200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<103.581200,-1.535000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,-1.535000,44.729400>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<103.581200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,0.000000,45.999400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.741200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.354600,-1.535000,37.769800>}
box{<0,0,-0.304800><0.848907,0.035000,0.304800> rotate<0,-51.069086,0> translate<118.821200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,-1.535000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.354600,-1.535000,45.389800>}
box{<0,0,-0.304800><0.848907,0.035000,0.304800> rotate<0,-51.069086,0> translate<118.821200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.354600,0.000000,45.389800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<118.821200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,-1.535000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.532400,-1.535000,8.788400>}
box{<0,0,-0.304800><1.138475,0.035000,0.304800> rotate<0,-51.336803,0> translate<118.821200,-1.535000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<119.532400,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,9.169400>}
box{<0,0,-0.304800><0.676327,0.035000,0.304800> rotate<0,-34.284614,0> translate<119.532400,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,14.249400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,9.169400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<120.091200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<118.821200,-1.535000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,20.599400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<118.821200,-1.535000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,0.000000,11.709400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,0.000000,20.599400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<120.091200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<115.011200,-1.535000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,24.409400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<115.011200,-1.535000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.551200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,0.000000,26.949400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<117.551200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,-1.535000,28.219400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,28.219400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<113.741200,-1.535000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.523000,0.000000,21.259800>}
box{<0,0,-0.304800><0.789037,0.035000,0.304800> rotate<0,-56.817738,0> translate<120.091200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.523000,-1.535000,21.259800>}
box{<0,0,-0.304800><0.789037,0.035000,0.304800> rotate<0,-56.817738,0> translate<120.091200,-1.535000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.523000,-1.535000,23.799800>}
box{<0,0,-0.304800><0.747036,0.035000,0.304800> rotate<0,54.685177,0> translate<120.091200,-1.535000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.523000,0.000000,26.339800>}
box{<0,0,-0.304800><0.747036,0.035000,0.304800> rotate<0,54.685177,0> translate<120.091200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,28.219400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.523000,-1.535000,28.879800>}
box{<0,0,-0.304800><0.789037,0.035000,0.304800> rotate<0,-56.817738,0> translate<120.091200,-1.535000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,0.000000,11.709400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,0.000000,10.439400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<120.091200,0.000000,11.709400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,0.000000,10.439400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<121.361200,0.000000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.091200,-1.535000,14.249400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,-1.535000,14.249400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<120.091200,-1.535000,14.249400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<120.523000,-1.535000,23.799800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,-1.535000,24.409400>}
box{<0,0,-0.304800><1.036432,0.035000,0.304800> rotate<0,-36.024996,0> translate<120.523000,-1.535000,23.799800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,0.000000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,0.000000,45.999400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<121.361200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<113.741200,0.000000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,0.000000,47.269400>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,44.997030,0> translate<113.741200,0.000000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.894600,0.000000,45.389800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<121.361200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.072400,0.000000,8.788400>}
box{<0,0,-0.304800><0.806825,0.035000,0.304800> rotate<0,28.176730,0> translate<121.361200,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<12.141200,-1.535000,4.089400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,-1.535000,4.089400>}
box{<0,0,-0.304800><110.490000,0.035000,0.304800> rotate<0,0.000000,0> translate<12.141200,-1.535000,4.089400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.072400,-1.535000,8.788400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,-1.535000,9.169400>}
box{<0,0,-0.304800><0.676327,0.035000,0.304800> rotate<0,-34.284614,0> translate<122.072400,-1.535000,8.788400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<117.551200,-1.535000,14.249400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,-1.535000,19.329400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<117.551200,-1.535000,14.249400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.894600,0.000000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,0.000000,37.109400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<121.894600,0.000000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,0.000000,37.109400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<122.631200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,0.000000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.901200,0.000000,20.599400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<122.631200,0.000000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.901200,0.000000,29.489400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<122.631200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.901200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.901200,0.000000,29.489400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,90.000000,0> translate<123.901200,0.000000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<35.001200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.901200,-1.535000,42.189400>}
box{<0,0,-0.304800><88.900000,0.035000,0.304800> rotate<0,0.000000,0> translate<35.001200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.901200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.901200,-1.535000,44.729400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<123.901200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<123.901200,-1.535000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.434600,-1.535000,45.389800>}
box{<0,0,-0.304800><0.848907,0.035000,0.304800> rotate<0,-51.069086,0> translate<123.901200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,-1.535000,4.089400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.171200,-1.535000,6.629400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<122.631200,-1.535000,4.089400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<108.661200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.171200,-1.535000,34.569400>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<108.661200,-1.535000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<124.434600,0.000000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.171200,0.000000,37.109400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<124.434600,0.000000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.171200,0.000000,6.629400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.171200,0.000000,37.109400>}
box{<0,0,-0.304800><30.480000,0.035000,0.304800> rotate<0,90.000000,0> translate<125.171200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<111.201200,-1.535000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,-1.535000,33.299400>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,0.000000,0> translate<111.201200,-1.535000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,-1.535000,48.539400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,-1.535000,45.999400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<126.441200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.401200,-1.535000,48.539400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,-1.535000,48.539400>}
box{<0,0,-0.304800><66.040000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.401200,-1.535000,48.539400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<83.261200,-1.535000,77.749400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,-1.535000,77.749400>}
box{<0,0,-0.304800><43.180000,0.035000,0.304800> rotate<0,0.000000,0> translate<83.261200,-1.535000,77.749400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<10.871200,0.000000,79.019400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,0.000000,79.019400>}
box{<0,0,-0.304800><115.570000,0.035000,0.304800> rotate<0,0.000000,0> translate<10.871200,0.000000,79.019400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,0.000000,77.749400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,0.000000,79.019400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<126.441200,0.000000,79.019400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,-1.535000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.974600,-1.535000,45.389800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<126.441200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,-1.535000,14.249400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.711200,-1.535000,20.599400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<121.361200,-1.535000,14.249400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<121.361200,-1.535000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.711200,-1.535000,24.409400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<121.361200,-1.535000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<125.171200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.711200,-1.535000,37.109400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<125.171200,-1.535000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.974600,-1.535000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.711200,-1.535000,37.109400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<126.974600,-1.535000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.711200,-1.535000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,-1.535000,21.259800>}
box{<0,0,-0.304800><0.789037,0.035000,0.304800> rotate<0,-56.817738,0> translate<127.711200,-1.535000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<127.711200,-1.535000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,-1.535000,23.799800>}
box{<0,0,-0.304800><0.747036,0.035000,0.304800> rotate<0,54.685177,0> translate<127.711200,-1.535000,24.409400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,-1.535000,21.259800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,-1.535000,20.599400>}
box{<0,0,-0.304800><1.067102,0.035000,0.304800> rotate<0,38.231302,0> translate<128.143000,-1.535000,21.259800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,0.000000,21.259800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,21.869400>}
box{<0,0,-0.304800><1.036432,0.035000,0.304800> rotate<0,-36.024996,0> translate<128.143000,0.000000,21.259800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,21.869400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<128.981200,0.000000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,0.000000,23.799800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,23.139400>}
box{<0,0,-0.304800><1.067102,0.035000,0.304800> rotate<0,38.231302,0> translate<128.143000,0.000000,23.799800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,0.000000,23.799800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,24.409400>}
box{<0,0,-0.304800><1.036432,0.035000,0.304800> rotate<0,-36.024996,0> translate<128.143000,0.000000,23.799800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,0.000000,26.339800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,25.679400>}
box{<0,0,-0.304800><1.067102,0.035000,0.304800> rotate<0,38.231302,0> translate<128.143000,0.000000,26.339800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,24.409400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,25.679400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<128.981200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,0.000000,26.339800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,26.949400>}
box{<0,0,-0.304800><1.036432,0.035000,0.304800> rotate<0,-36.024996,0> translate<128.143000,0.000000,26.339800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,28.219400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,26.949400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<128.981200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,0.000000,28.879800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,0.000000,28.219400>}
box{<0,0,-0.304800><1.067102,0.035000,0.304800> rotate<0,38.231302,0> translate<128.143000,0.000000,28.879800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.143000,-1.535000,28.879800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,-1.535000,29.489400>}
box{<0,0,-0.304800><1.036432,0.035000,0.304800> rotate<0,-36.024996,0> translate<128.143000,-1.535000,28.879800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,-1.535000,53.619400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,-1.535000,45.999400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<128.981200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<38.811200,-1.535000,53.619400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,-1.535000,53.619400>}
box{<0,0,-0.304800><90.170000,0.035000,0.304800> rotate<0,0.000000,0> translate<38.811200,-1.535000,53.619400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,-1.535000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.514600,-1.535000,45.389800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<128.981200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,-1.535000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.251200,-1.535000,37.109400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<126.441200,-1.535000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<129.514600,-1.535000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.251200,-1.535000,37.109400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<129.514600,-1.535000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<102.311200,-1.535000,40.919400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.251200,-1.535000,40.919400>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<102.311200,-1.535000,40.919400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<88.341200,-1.535000,75.209400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.251200,-1.535000,75.209400>}
box{<0,0,-0.304800><41.910000,0.035000,0.304800> rotate<0,0.000000,0> translate<88.341200,-1.535000,75.209400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.521200,0.000000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.521200,0.000000,45.999400>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,-90.000000,0> translate<131.521200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<112.471200,0.000000,76.479400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.521200,0.000000,57.429400>}
box{<0,0,-0.304800><26.940768,0.035000,0.304800> rotate<0,44.997030,0> translate<112.471200,0.000000,76.479400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<131.521200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.054600,0.000000,45.389800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<131.521200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,-1.535000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.791200,-1.535000,33.299400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<128.981200,-1.535000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.251200,-1.535000,40.919400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.791200,-1.535000,38.379400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<130.251200,-1.535000,40.919400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.054600,-1.535000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.791200,-1.535000,38.379400>}
box{<0,0,-0.304800><0.956134,0.035000,0.304800> rotate<0,-39.608074,0> translate<132.054600,-1.535000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<98.501200,0.000000,4.089400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.061200,0.000000,4.089400>}
box{<0,0,-0.304800><35.560000,0.035000,0.304800> rotate<0,0.000000,0> translate<98.501200,0.000000,4.089400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.061200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.061200,0.000000,4.089400>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,-90.000000,0> translate<134.061200,0.000000,4.089400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,26.949400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,-90.000000,0> translate<135.331200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.594600,0.000000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,37.109400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<134.594600,0.000000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.594600,-1.535000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,-1.535000,38.379400>}
box{<0,0,-0.304800><0.956134,0.035000,0.304800> rotate<0,-39.608074,0> translate<134.594600,-1.535000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,-1.535000,38.379400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<135.331200,-1.535000,38.379400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,43.459400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<135.331200,0.000000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.594600,0.000000,45.389800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,44.729400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<134.594600,0.000000,45.389800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.594600,0.000000,45.389800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,45.999400>}
box{<0,0,-0.304800><0.956134,0.035000,0.304800> rotate<0,-39.608074,0> translate<134.594600,0.000000,45.389800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,45.999400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,-90.000000,0> translate<135.331200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.594600,0.000000,51.003200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,51.079400>}
box{<0,0,-0.304800><0.740531,0.035000,0.304800> rotate<0,-5.905751,0> translate<134.594600,0.000000,51.003200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<128.981200,-1.535000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,-1.535000,20.599400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<128.981200,-1.535000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<134.061200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,23.139400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<134.061200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,25.679400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<135.331200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<132.791200,-1.535000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,-1.535000,33.299400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<132.791200,-1.535000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,-1.535000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,-1.535000,37.109400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<136.601200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,38.379400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<136.601200,0.000000,38.379400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,0.000000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,42.189400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<135.331200,0.000000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.702800,0.000000,20.548600>}
box{<0,0,-0.304800><0.113592,0.035000,0.304800> rotate<0,26.563298,0> translate<136.601200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,-1.535000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.702800,-1.535000,20.548600>}
box{<0,0,-0.304800><0.113592,0.035000,0.304800> rotate<0,26.563298,0> translate<136.601200,-1.535000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.702800,0.000000,25.628600>}
box{<0,0,-0.304800><0.113592,0.035000,0.304800> rotate<0,26.563298,0> translate<136.601200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,-1.535000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.702800,-1.535000,25.628600>}
box{<0,0,-0.304800><0.113592,0.035000,0.304800> rotate<0,26.563298,0> translate<136.601200,-1.535000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.134600,-1.535000,37.769800>}
box{<0,0,-0.304800><0.848907,0.035000,0.304800> rotate<0,-51.069086,0> translate<136.601200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,38.379400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.134600,0.000000,37.769800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<136.601200,0.000000,38.379400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,0.000000,26.949400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<137.871200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.464800,0.000000,31.521400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,0.000000,30.759400>}
box{<0,0,-0.304800><0.863600,0.035000,0.304800> rotate<0,61.923426,0> translate<137.464800,0.000000,31.521400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.464800,-1.535000,31.521400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,-1.535000,32.029400>}
box{<0,0,-0.304800><0.650557,0.035000,0.304800> rotate<0,-51.336803,0> translate<137.464800,-1.535000,31.521400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<135.331200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,-1.535000,42.189400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<135.331200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<109.931200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,-1.535000,62.509400>}
box{<0,0,-0.304800><27.940000,0.035000,0.304800> rotate<0,0.000000,0> translate<109.931200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.582400,-1.535000,62.722600>}
box{<0,0,-0.304800><0.742469,0.035000,0.304800> rotate<0,-16.686317,0> translate<137.871200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,0.000000,20.599400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<136.601200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,-1.535000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,23.139400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<136.601200,-1.535000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,0.000000,25.679400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<137.871200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,-1.535000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,32.029400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<137.871200,-1.535000,32.029400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,37.109400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<139.141200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.582400,0.000000,62.722600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,0.000000,62.509400>}
box{<0,0,-0.304800><0.598090,0.035000,0.304800> rotate<0,20.882068,0> translate<138.582400,0.000000,62.722600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,0.000000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,0.000000,62.509400>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,90.000000,0> translate<139.141200,0.000000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<130.251200,-1.535000,75.209400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,66.319400>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,44.997030,0> translate<130.251200,-1.535000,75.209400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<138.582400,-1.535000,70.322600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,70.129400>}
box{<0,0,-0.304800><0.591256,0.035000,0.304800> rotate<0,19.071101,0> translate<138.582400,-1.535000,70.322600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.547600,0.000000,20.548600>}
box{<0,0,-0.304800><0.409563,0.035000,0.304800> rotate<0,7.124546,0> translate<139.141200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.547600,0.000000,25.628600>}
box{<0,0,-0.304800><0.409563,0.035000,0.304800> rotate<0,7.124546,0> translate<139.141200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.674600,-1.535000,37.769800>}
box{<0,0,-0.304800><0.848907,0.035000,0.304800> rotate<0,-51.069086,0> translate<139.141200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,0.000000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.674600,0.000000,51.003200>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,8.129566,0> translate<139.141200,0.000000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.547600,0.000000,20.548600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,0.000000,20.599400>}
box{<0,0,-0.304800><0.865093,0.035000,0.304800> rotate<0,-3.366238,0> translate<139.547600,0.000000,20.548600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<137.871200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,-1.535000,44.729400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<137.871200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.674600,-1.535000,45.389800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,-1.535000,44.729400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<139.674600,-1.535000,45.389800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.674600,0.000000,45.389800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,0.000000,45.999400>}
box{<0,0,-0.304800><0.956134,0.035000,0.304800> rotate<0,-39.608074,0> translate<139.674600,0.000000,45.389800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.674600,0.000000,51.003200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,0.000000,51.079400>}
box{<0,0,-0.304800><0.740531,0.035000,0.304800> rotate<0,-5.905751,0> translate<139.674600,0.000000,51.003200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,0.000000,51.079400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<140.411200,0.000000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,-1.535000,71.399400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<139.141200,-1.535000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.681200,-1.535000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.681200,-1.535000,45.999400>}
box{<0,0,-0.304800><19.050000,0.035000,0.304800> rotate<0,-90.000000,0> translate<141.681200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.131200,-1.535000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.681200,-1.535000,65.049400>}
box{<0,0,-0.304800><82.550000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.131200,-1.535000,65.049400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<141.681200,-1.535000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.214600,-1.535000,45.389800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<141.681200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.443200,0.000000,20.599400>}
box{<0,0,-0.304800><2.032000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.411200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,19.329400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<142.951200,0.000000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.443200,0.000000,20.599400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,20.599400>}
box{<0,0,-0.304800><0.508000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.443200,0.000000,20.599400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.443200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,25.679400>}
box{<0,0,-0.304800><0.508000,0.035000,0.304800> rotate<0,0.000000,0> translate<142.443200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,25.679400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<142.951200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.290800,0.000000,31.521400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,32.029400>}
box{<0,0,-0.304800><0.833182,0.035000,0.304800> rotate<0,-37.566113,0> translate<142.290800,0.000000,31.521400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.214600,0.000000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,37.109400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<142.214600,0.000000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,37.109400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<142.951200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,66.319400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,-1.535000,66.319400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.141200,-1.535000,66.319400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<122.631200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,-1.535000,9.169400>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<122.631200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,-1.535000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,-1.535000,9.169400>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.221200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<136.601200,0.000000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,0.000000,23.139400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<136.601200,0.000000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<139.141200,-1.535000,23.139400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,-1.535000,23.139400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<139.141200,-1.535000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,0.000000,23.139400>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,-90.000000,0> translate<144.221200,0.000000,23.139400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<126.441200,0.000000,77.749400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,0.000000,59.969400>}
box{<0,0,-0.304800><25.144717,0.035000,0.304800> rotate<0,44.997030,0> translate<126.441200,0.000000,77.749400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,0.000000,59.969400>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,90.000000,0> translate<144.221200,0.000000,59.969400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.754600,0.000000,37.769800>}
box{<0,0,-0.304800><0.848907,0.035000,0.304800> rotate<0,-51.069086,0> translate<144.221200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.754600,0.000000,45.389800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<144.221200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,-1.535000,66.319400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.761200,-1.535000,62.509400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<142.951200,-1.535000,66.319400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.761200,-1.535000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.761200,-1.535000,62.509400>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.761200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.761200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.761200,0.000000,67.589400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<146.761200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.761200,-1.535000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.294600,-1.535000,45.389800>}
box{<0,0,-0.304800><0.810017,0.035000,0.304800> rotate<0,48.810853,0> translate<146.761200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<144.221200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.031200,-1.535000,9.169400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<144.221200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<147.294600,-1.535000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.031200,-1.535000,37.109400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<147.294600,-1.535000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.031200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.031200,-1.535000,37.109400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<148.031200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.761200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,0.000000,58.699400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<146.761200,0.000000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.250400,0.000000,58.191400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,0.000000,58.699400>}
box{<0,0,-0.304800><0.510534,0.035000,0.304800> rotate<0,-84.283844,0> translate<149.250400,0.000000,58.191400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,-1.535000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,-1.535000,65.536800>}
box{<0,0,-0.304800><0.487400,0.035000,0.304800> rotate<0,90.000000,0> translate<149.301200,-1.535000,65.536800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<146.761200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,0.000000,67.589400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<146.761200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,-1.535000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,-1.535000,71.216800>}
box{<0,0,-0.304800><0.182600,0.035000,0.304800> rotate<0,-90.000000,0> translate<149.301200,-1.535000,71.216800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<140.411200,-1.535000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,-1.535000,71.399400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<140.411200,-1.535000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.376200,0.000000,68.376800>}
box{<0,0,-0.304800><0.790964,0.035000,0.304800> rotate<0,-84.553401,0> translate<149.301200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.031200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,-1.535000,9.169400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<148.031200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.834600,-1.535000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,-1.535000,38.379400>}
box{<0,0,-0.304800><0.956134,0.035000,0.304800> rotate<0,-39.608074,0> translate<149.834600,-1.535000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,-1.535000,38.379400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,-90.000000,0> translate<150.571200,-1.535000,38.379400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.834600,0.000000,45.389800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,0.000000,45.999400>}
box{<0,0,-0.304800><0.956134,0.035000,0.304800> rotate<0,-39.608074,0> translate<149.834600,0.000000,45.389800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,0.000000,48.539400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,0.000000,45.999400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,-90.000000,0> translate<150.571200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.926800,-1.535000,8.051800>}
box{<0,0,-0.304800><1.172809,0.035000,0.304800> rotate<0,72.345101,0> translate<150.571200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.031200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.841200,-1.535000,5.359400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,44.997030,0> translate<148.031200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<142.951200,0.000000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.111200,0.000000,9.169400>}
box{<0,0,-0.304800><14.368410,0.035000,0.304800> rotate<0,44.997030,0> translate<142.951200,0.000000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.374600,-1.535000,37.769800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.111200,-1.535000,37.109400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<152.374600,-1.535000,37.769800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<152.374600,0.000000,45.389800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.111200,0.000000,44.729400>}
box{<0,0,-0.304800><0.989297,0.035000,0.304800> rotate<0,41.875106,0> translate<152.374600,0.000000,45.389800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.111200,0.000000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.466800,0.000000,8.051800>}
box{<0,0,-0.304800><1.172809,0.035000,0.304800> rotate<0,72.345101,0> translate<153.111200,0.000000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.111200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.466800,-1.535000,8.051800>}
box{<0,0,-0.304800><1.172809,0.035000,0.304800> rotate<0,72.345101,0> translate<153.111200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.111200,-1.535000,9.169400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.381200,-1.535000,10.439400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<153.111200,-1.535000,9.169400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.921200,-1.535000,42.189400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<150.571200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<154.381200,-1.535000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<158.191200,-1.535000,10.439400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<154.381200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<150.571200,0.000000,48.539400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<159.461200,0.000000,57.429400>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,-44.997030,0> translate<150.571200,0.000000,48.539400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<159.410400,0.000000,58.191400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<159.461200,0.000000,57.429400>}
box{<0,0,-0.304800><0.763691,0.035000,0.304800> rotate<0,86.180237,0> translate<159.410400,0.000000,58.191400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<148.031200,-1.535000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<165.811200,-1.535000,34.569400>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,0.000000,0> translate<148.031200,-1.535000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.111200,0.000000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<168.351200,0.000000,29.489400>}
box{<0,0,-0.304800><21.552615,0.035000,0.304800> rotate<0,44.997030,0> translate<153.111200,0.000000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<168.351200,0.000000,21.869400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<168.351200,0.000000,29.489400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,90.000000,0> translate<168.351200,0.000000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<165.811200,0.000000,34.569400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<168.351200,0.000000,37.109400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<165.811200,0.000000,34.569400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<168.351200,0.000000,68.859400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<168.351200,0.000000,37.109400>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,-90.000000,0> translate<168.351200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<153.111200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<169.621200,-1.535000,37.109400>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,0.000000,0> translate<153.111200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<156.921200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<169.621200,-1.535000,54.889400>}
box{<0,0,-0.304800><17.960512,0.035000,0.304800> rotate<0,-44.997030,0> translate<156.921200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<169.621200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.586400,-1.535000,36.626800>}
box{<0,0,-0.304800><1.079126,0.035000,0.304800> rotate<0,26.563298,0> translate<169.621200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<169.621200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.586400,-1.535000,54.584600>}
box{<0,0,-0.304800><1.012183,0.035000,0.304800> rotate<0,17.524412,0> translate<169.621200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.535600,-1.535000,8.483600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,7.899400>}
box{<0,0,-0.304800><0.683916,0.035000,0.304800> rotate<0,58.667435,0> translate<170.535600,-1.535000,8.483600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<168.351200,0.000000,21.869400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,0.000000,19.329400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<168.351200,0.000000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.535600,0.000000,18.643600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,0.000000,19.329400>}
box{<0,0,-0.304800><0.772511,0.035000,0.304800> rotate<0,-62.588294,0> translate<170.535600,0.000000,18.643600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.586400,-1.535000,26.466800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,26.949400>}
box{<0,0,-0.304800><0.570794,0.035000,0.304800> rotate<0,-57.720546,0> translate<170.586400,-1.535000,26.466800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.586400,-1.535000,44.424600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,43.459400>}
box{<0,0,-0.304800><1.012183,0.035000,0.304800> rotate<0,72.469649,0> translate<170.586400,-1.535000,44.424600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<149.301200,-1.535000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,65.049400>}
box{<0,0,-0.304800><21.590000,0.035000,0.304800> rotate<0,0.000000,0> translate<149.301200,-1.535000,65.049400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<168.351200,0.000000,68.859400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,0.000000,71.399400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<168.351200,0.000000,68.859400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.967400,-1.535000,62.103000>}
box{<0,0,-0.304800><0.866955,0.035000,0.304800> rotate<0,-84.951942,0> translate<170.891200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,0.000000,71.399400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.967400,0.000000,72.263000>}
box{<0,0,-0.304800><0.866955,0.035000,0.304800> rotate<0,-84.951942,0> translate<170.891200,0.000000,71.399400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<172.161200,-1.535000,6.629400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<170.891200,-1.535000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<158.191200,-1.535000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<172.161200,-1.535000,10.439400>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<158.191200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<172.161200,-1.535000,42.189400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<170.891200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<172.161200,-1.535000,59.969400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<170.891200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<172.161200,-1.535000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,9.169400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<172.161200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.329600,-1.535000,8.432800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,9.169400>}
box{<0,0,-0.304800><0.743574,0.035000,0.304800> rotate<0,-82.141265,0> translate<173.329600,-1.535000,8.432800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.329600,0.000000,18.592800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,18.059400>}
box{<0,0,-0.304800><0.542990,0.035000,0.304800> rotate<0,79.210474,0> translate<173.329600,0.000000,18.592800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<158.191200,-1.535000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,25.679400>}
box{<0,0,-0.304800><21.552615,0.035000,0.304800> rotate<0,-44.997030,0> translate<158.191200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,28.219400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<173.431200,0.000000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,62.509400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<170.891200,-1.535000,65.049400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.558200,0.000000,44.450000>}
box{<0,0,-0.304800><0.998708,0.035000,0.304800> rotate<0,-82.688783,0> translate<173.431200,0.000000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.558200,0.000000,44.450000>}
box{<0,0,-0.304800><0.306909,0.035000,0.304800> rotate<0,65.551719,0> translate<173.431200,0.000000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.558200,-1.535000,54.610000>}
box{<0,0,-0.304800><0.306909,0.035000,0.304800> rotate<0,65.551719,0> translate<173.431200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.583600,-1.535000,26.466800>}
box{<0,0,-0.304800><0.802013,0.035000,0.304800> rotate<0,-79.040721,0> translate<173.431200,-1.535000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.583600,0.000000,26.466800>}
box{<0,0,-0.304800><0.506091,0.035000,0.304800> rotate<0,72.469649,0> translate<173.431200,0.000000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.583600,-1.535000,36.626800>}
box{<0,0,-0.304800><0.506091,0.035000,0.304800> rotate<0,72.469649,0> translate<173.431200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.939200,0.000000,62.179200>}
box{<0,0,-0.304800><1.068311,0.035000,0.304800> rotate<0,-61.602915,0> translate<173.431200,0.000000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.939200,-1.535000,62.179200>}
box{<0,0,-0.304800><0.605885,0.035000,0.304800> rotate<0,33.021688,0> translate<173.431200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.939200,0.000000,72.339200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<174.701200,0.000000,72.669400>}
box{<0,0,-0.304800><0.830467,0.035000,0.304800> rotate<0,-23.427147,0> translate<173.939200,0.000000,72.339200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<172.161200,-1.535000,6.629400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,-1.535000,6.629400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<172.161200,-1.535000,6.629400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,28.219400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,0.000000,30.759400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<173.431200,0.000000,28.219400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<170.891200,-1.535000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,-1.535000,32.029400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<170.891200,-1.535000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,0.000000,40.919400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<173.431200,0.000000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,0.000000,40.919400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,90.000000,0> translate<175.971200,0.000000,40.919400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<172.161200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,-1.535000,42.189400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<172.161200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,0.000000,47.269400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<173.431200,0.000000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,0.000000,58.699400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,0.000000,47.269400>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,-90.000000,0> translate<175.971200,0.000000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,0.000000,58.699400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<173.431200,0.000000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<172.161200,-1.535000,59.969400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,-1.535000,59.969400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<172.161200,-1.535000,59.969400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.195200,0.000000,10.693400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,10.439400>}
box{<0,0,-0.304800><0.258132,0.035000,0.304800> rotate<0,79.729597,0> translate<177.195200,0.000000,10.693400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,12.979400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<177.241200,0.000000,12.979400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,30.759400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<177.241200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,-1.535000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,-1.535000,32.029400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<175.971200,-1.535000,32.029400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,49.809400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<177.241200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,67.589400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<177.241200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.449200,0.000000,29.235400>}
box{<0,0,-0.304800><0.328299,0.035000,0.304800> rotate<0,50.682689,0> translate<177.241200,0.000000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.449200,0.000000,46.253400>}
box{<0,0,-0.304800><0.328299,0.035000,0.304800> rotate<0,-50.682689,0> translate<177.241200,0.000000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.449200,0.000000,64.287400>}
box{<0,0,-0.304800><0.789878,0.035000,0.304800> rotate<0,74.727225,0> translate<177.241200,0.000000,65.049400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,-1.535000,6.629400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,10.439400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<175.971200,-1.535000,6.629400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,12.979400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,15.519400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<177.241200,0.000000,12.979400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,0.000000,18.059400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,18.059400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<173.431200,0.000000,18.059400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,-1.535000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,29.489400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<177.241200,-1.535000,32.029400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,33.299400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<177.241200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,37.109400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<173.431200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,45.999400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<175.971200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,52.349400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<177.241200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<173.431200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,54.889400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<173.431200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<175.971200,-1.535000,59.969400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,63.779400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<175.971200,-1.535000,59.969400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<177.241200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,70.129400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<177.241200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<174.701200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,72.669400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<174.701200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.035200,-1.535000,10.618400>}
box{<0,0,-0.304800><0.310736,0.035000,0.304800> rotate<0,-35.170966,0> translate<179.781200,-1.535000,10.439400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,15.519400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.035200,0.000000,16.027400>}
box{<0,0,-0.304800><0.567961,0.035000,0.304800> rotate<0,-63.430762,0> translate<179.781200,0.000000,15.519400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,18.059400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.035200,0.000000,18.567400>}
box{<0,0,-0.304800><0.567961,0.035000,0.304800> rotate<0,-63.430762,0> translate<179.781200,0.000000,18.059400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.035200,0.000000,34.061400>}
box{<0,0,-0.304800><0.803219,0.035000,0.304800> rotate<0,-71.560328,0> translate<179.781200,0.000000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.035200,-1.535000,36.601400>}
box{<0,0,-0.304800><0.567961,0.035000,0.304800> rotate<0,63.430762,0> translate<179.781200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.289200,-1.535000,29.160400>}
box{<0,0,-0.304800><0.605231,0.035000,0.304800> rotate<0,32.926446,0> translate<179.781200,-1.535000,29.489400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,45.999400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.289200,-1.535000,46.178400>}
box{<0,0,-0.304800><0.538614,0.035000,0.304800> rotate<0,-19.409250,0> translate<179.781200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.289200,0.000000,52.095400>}
box{<0,0,-0.304800><0.567961,0.035000,0.304800> rotate<0,26.563298,0> translate<179.781200,0.000000,52.349400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.289200,-1.535000,54.635400>}
box{<0,0,-0.304800><0.567961,0.035000,0.304800> rotate<0,26.563298,0> translate<179.781200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,-1.535000,63.779400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.289200,-1.535000,64.212400>}
box{<0,0,-0.304800><0.667498,0.035000,0.304800> rotate<0,-40.440350,0> translate<179.781200,-1.535000,63.779400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.543200,0.000000,69.875400>}
box{<0,0,-0.304800><0.803219,0.035000,0.304800> rotate<0,18.433732,0> translate<179.781200,0.000000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<179.781200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<180.543200,0.000000,72.415400>}
box{<0,0,-0.304800><0.803219,0.035000,0.304800> rotate<0,18.433732,0> translate<179.781200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<151.841200,-1.535000,5.359400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,-1.535000,5.359400>}
box{<0,0,-0.304800><31.750000,0.035000,0.304800> rotate<0,0.000000,0> translate<151.841200,-1.535000,5.359400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<182.875200,0.000000,10.693400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,10.439400>}
box{<0,0,-0.304800><0.759718,0.035000,0.304800> rotate<0,19.530780,0> translate<182.875200,0.000000,10.693400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,10.439400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,15.519400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<183.591200,0.000000,15.519400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.129200,0.000000,29.235400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,29.489400>}
box{<0,0,-0.304800><0.527219,0.035000,0.304800> rotate<0,-28.799371,0> translate<183.129200,0.000000,29.235400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,29.489400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,33.299400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<183.591200,0.000000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.129200,-1.535000,46.253400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,-1.535000,45.999400>}
box{<0,0,-0.304800><0.527219,0.035000,0.304800> rotate<0,28.799371,0> translate<183.129200,-1.535000,46.253400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,-1.535000,45.999400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,-90.000000,0> translate<183.591200,-1.535000,45.999400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.129200,0.000000,64.287400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,65.049400>}
box{<0,0,-0.304800><0.891116,0.035000,0.304800> rotate<0,-58.767721,0> translate<183.129200,0.000000,64.287400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,65.049400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,70.129400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<183.591200,0.000000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,-1.535000,5.359400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,7.899400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<183.591200,-1.535000,5.359400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,8.915400>}
box{<0,0,-0.304800><1.016000,0.035000,0.304800> rotate<0,90.000000,0> translate<186.131200,0.000000,8.915400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,8.915400>}
box{<0,0,-0.304800><1.016000,0.035000,0.304800> rotate<0,90.000000,0> translate<186.131200,-1.535000,8.915400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,15.519400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,18.059400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<183.591200,0.000000,15.519400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,18.059400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,19.075400>}
box{<0,0,-0.304800><1.016000,0.035000,0.304800> rotate<0,90.000000,0> translate<186.131200,0.000000,19.075400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,19.075400>}
box{<0,0,-0.304800><0.254000,0.035000,0.304800> rotate<0,-90.000000,0> translate<186.131200,-1.535000,19.075400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,33.299400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,35.839400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<183.591200,0.000000,33.299400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,51.079400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<186.131200,0.000000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,54.889400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<183.591200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<183.591200,0.000000,70.129400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,72.669400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<183.591200,0.000000,70.129400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.385200,0.000000,26.695400>}
box{<0,0,-0.304800><1.047269,0.035000,0.304800> rotate<0,-75.958743,0> translate<186.131200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.385200,-1.535000,26.695400>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,44.997030,0> translate<186.131200,-1.535000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,35.839400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.385200,0.000000,36.855400>}
box{<0,0,-0.304800><1.047269,0.035000,0.304800> rotate<0,-75.958743,0> translate<186.131200,0.000000,35.839400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.385200,0.000000,36.855400>}
box{<0,0,-0.304800><0.359210,0.035000,0.304800> rotate<0,44.997030,0> translate<186.131200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,44.729400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<187.401200,-1.535000,43.459400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<186.131200,-1.535000,44.729400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<187.401200,-1.535000,61.239400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<186.131200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<188.671200,-1.535000,26.949400>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<186.131200,-1.535000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<187.401200,-1.535000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<188.671200,-1.535000,43.459400>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<187.401200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<188.671200,-1.535000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<188.671200,-1.535000,43.459400>}
box{<0,0,-0.304800><16.510000,0.035000,0.304800> rotate<0,90.000000,0> translate<188.671200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<189.941200,0.000000,7.899400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<186.131200,0.000000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<189.941200,0.000000,25.679400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<186.131200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<189.941200,0.000000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<189.941200,0.000000,25.679400>}
box{<0,0,-0.304800><17.780000,0.035000,0.304800> rotate<0,90.000000,0> translate<189.941200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<189.941200,0.000000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,7.899400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<189.941200,0.000000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,-1.535000,19.329400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<186.131200,-1.535000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<189.941200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,25.679400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<189.941200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,37.109400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<186.131200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<188.671200,-1.535000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,-1.535000,43.459400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<188.671200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,-1.535000,54.889400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<186.131200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,51.079400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,59.969400>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,-44.997030,0> translate<186.131200,0.000000,51.079400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<187.401200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,-1.535000,61.239400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<187.401200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<186.131200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,72.669400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<186.131200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,0.000000,7.010400>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,81.864495,0> translate<195.021200,0.000000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,-1.535000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,-1.535000,18.948400>}
box{<0,0,-0.304800><0.401609,0.035000,0.304800> rotate<0,71.560328,0> translate<195.021200,-1.535000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,0.000000,24.790400>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,81.864495,0> translate<195.021200,0.000000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,0.000000,36.728400>}
box{<0,0,-0.304800><0.401609,0.035000,0.304800> rotate<0,71.560328,0> translate<195.021200,0.000000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,-1.535000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,-1.535000,42.570400>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,81.864495,0> translate<195.021200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,-1.535000,54.508400>}
box{<0,0,-0.304800><0.401609,0.035000,0.304800> rotate<0,71.560328,0> translate<195.021200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,59.969400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,0.000000,60.350400>}
box{<0,0,-0.304800><0.401609,0.035000,0.304800> rotate<0,-71.560328,0> translate<195.021200,0.000000,59.969400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,-1.535000,60.350400>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,81.864495,0> translate<195.021200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.021200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<195.148200,0.000000,72.288400>}
box{<0,0,-0.304800><0.401609,0.035000,0.304800> rotate<0,71.560328,0> translate<195.021200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.340200,-1.535000,7.010400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,7.899400>}
box{<0,0,-0.304800><0.967203,0.035000,0.304800> rotate<0,-66.797001,0> translate<207.340200,-1.535000,7.010400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.340200,-1.535000,18.948400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,19.329400>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,-44.997030,0> translate<207.340200,-1.535000,18.948400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.340200,-1.535000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,25.679400>}
box{<0,0,-0.304800><0.967203,0.035000,0.304800> rotate<0,-66.797001,0> translate<207.340200,-1.535000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.340200,-1.535000,36.728400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,37.109400>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,-44.997030,0> translate<207.340200,-1.535000,36.728400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.340200,-1.535000,42.570400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,43.459400>}
box{<0,0,-0.304800><0.967203,0.035000,0.304800> rotate<0,-66.797001,0> translate<207.340200,-1.535000,42.570400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.340200,-1.535000,54.508400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,54.889400>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,-44.997030,0> translate<207.340200,-1.535000,54.508400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.340200,-1.535000,60.350400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,61.239400>}
box{<0,0,-0.304800><0.967203,0.035000,0.304800> rotate<0,-66.797001,0> translate<207.340200,-1.535000,60.350400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.340200,0.000000,72.288400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,0.000000,72.669400>}
box{<0,0,-0.304800><0.538815,0.035000,0.304800> rotate<0,-44.997030,0> translate<207.340200,0.000000,72.288400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<212.801200,-1.535000,7.899400>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<207.721200,-1.535000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<193.116200,-1.535000,12.979400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<212.801200,-1.535000,12.979400>}
box{<0,0,-0.304800><19.685000,0.035000,0.304800> rotate<0,0.000000,0> translate<193.116200,-1.535000,12.979400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<214.071200,-1.535000,19.329400>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,0.000000,0> translate<207.721200,-1.535000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<215.341200,-1.535000,25.679400>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,0.000000,0> translate<207.721200,-1.535000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<193.116200,-1.535000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<215.341200,-1.535000,30.759400>}
box{<0,0,-0.304800><22.225000,0.035000,0.304800> rotate<0,0.000000,0> translate<193.116200,-1.535000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<216.611200,-1.535000,37.109400>}
box{<0,0,-0.304800><8.890000,0.035000,0.304800> rotate<0,0.000000,0> translate<207.721200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<217.881200,-1.535000,43.459400>}
box{<0,0,-0.304800><10.160000,0.035000,0.304800> rotate<0,0.000000,0> translate<207.721200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<193.116200,-1.535000,48.539400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<217.881200,-1.535000,48.539400>}
box{<0,0,-0.304800><24.765000,0.035000,0.304800> rotate<0,0.000000,0> translate<193.116200,-1.535000,48.539400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<219.151200,-1.535000,54.889400>}
box{<0,0,-0.304800><11.430000,0.035000,0.304800> rotate<0,0.000000,0> translate<207.721200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<220.421200,-1.535000,61.239400>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<207.721200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<193.116200,-1.535000,66.319400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<220.421200,-1.535000,66.319400>}
box{<0,0,-0.304800><27.305000,0.035000,0.304800> rotate<0,0.000000,0> translate<193.116200,-1.535000,66.319400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<212.801200,-1.535000,7.899400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,16.789400>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,-44.997030,0> translate<212.801200,-1.535000,7.899400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<212.801200,-1.535000,12.979400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,21.869400>}
box{<0,0,-0.304800><12.572359,0.035000,0.304800> rotate<0,-44.997030,0> translate<212.801200,-1.535000,12.979400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<214.071200,-1.535000,19.329400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,26.949400>}
box{<0,0,-0.304800><10.776307,0.035000,0.304800> rotate<0,-44.997030,0> translate<214.071200,-1.535000,19.329400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<215.341200,-1.535000,25.679400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,32.029400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<215.341200,-1.535000,25.679400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<215.341200,-1.535000,30.759400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,37.109400>}
box{<0,0,-0.304800><8.980256,0.035000,0.304800> rotate<0,-44.997030,0> translate<215.341200,-1.535000,30.759400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<216.611200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,42.189400>}
box{<0,0,-0.304800><7.184205,0.035000,0.304800> rotate<0,-44.997030,0> translate<216.611200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<217.881200,-1.535000,43.459400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,47.269400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<217.881200,-1.535000,43.459400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<217.881200,-1.535000,48.539400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,52.349400>}
box{<0,0,-0.304800><5.388154,0.035000,0.304800> rotate<0,-44.997030,0> translate<217.881200,-1.535000,48.539400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<219.151200,-1.535000,54.889400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,57.429400>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<219.151200,-1.535000,54.889400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<220.421200,-1.535000,61.239400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,62.509400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<220.421200,-1.535000,61.239400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<220.421200,-1.535000,66.319400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,67.589400>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<220.421200,-1.535000,66.319400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<207.721200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,0.000000,72.669400>}
box{<0,0,-0.304800><13.970000,0.035000,0.304800> rotate<0,0.000000,0> translate<207.721200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,37.109400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.199200,-1.535000,37.432600>}
box{<0,0,-0.304800><0.602098,0.035000,0.304800> rotate<0,-32.463211,0> translate<221.691200,-1.535000,37.109400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,42.189400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.199200,-1.535000,42.432600>}
box{<0,0,-0.304800><0.563214,0.035000,0.304800> rotate<0,-25.580622,0> translate<221.691200,-1.535000,42.189400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,47.269400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.199200,-1.535000,47.432600>}
box{<0,0,-0.304800><0.533571,0.035000,0.304800> rotate<0,-17.808951,0> translate<221.691200,-1.535000,47.269400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,52.349400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.199200,-1.535000,52.432600>}
box{<0,0,-0.304800><0.514768,0.035000,0.304800> rotate<0,-9.300683,0> translate<221.691200,-1.535000,52.349400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,57.429400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.326200,-1.535000,57.397000>}
box{<0,0,-0.304800><0.635826,0.035000,0.304800> rotate<0,2.920712,0> translate<221.691200,-1.535000,57.429400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,62.509400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.326200,-1.535000,62.397000>}
box{<0,0,-0.304800><0.644871,0.035000,0.304800> rotate<0,10.037169,0> translate<221.691200,-1.535000,62.509400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,67.589400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.326200,-1.535000,67.397000>}
box{<0,0,-0.304800><0.663508,0.035000,0.304800> rotate<0,16.855283,0> translate<221.691200,-1.535000,67.589400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.326200,0.000000,72.397000>}
box{<0,0,-0.304800><0.690961,0.035000,0.304800> rotate<0,23.216657,0> translate<221.691200,0.000000,72.669400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,16.789400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.402400,-1.535000,17.722200>}
box{<0,0,-0.304800><1.172997,0.035000,0.304800> rotate<0,-52.673334,0> translate<221.691200,-1.535000,16.789400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,21.869400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.402400,-1.535000,22.722200>}
box{<0,0,-0.304800><1.110438,0.035000,0.304800> rotate<0,-50.169977,0> translate<221.691200,-1.535000,21.869400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,26.949400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.402400,-1.535000,27.722200>}
box{<0,0,-0.304800><1.050250,0.035000,0.304800> rotate<0,-47.373824,0> translate<221.691200,-1.535000,26.949400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<221.691200,-1.535000,32.029400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<222.402400,-1.535000,32.722200>}
box{<0,0,-0.304800><0.992863,0.035000,0.304800> rotate<0,-44.246238,0> translate<221.691200,-1.535000,32.029400> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
texture{col_pol}
}
#end
union{
cylinder{<86.131400,0.038000,19.293800><86.131400,-1.538000,19.293800>0.650000}
cylinder{<86.131400,0.038000,39.293800><86.131400,-1.538000,39.293800>0.650000}
cylinder{<136.702800,0.038000,25.628600><136.702800,-1.538000,25.628600>0.400000}
cylinder{<136.702800,0.038000,20.548600><136.702800,-1.538000,20.548600>0.400000}
cylinder{<139.674600,0.038000,51.003200><139.674600,-1.538000,51.003200>0.400000}
cylinder{<134.594600,0.038000,51.003200><134.594600,-1.538000,51.003200>0.400000}
cylinder{<139.547600,0.038000,20.548600><139.547600,-1.538000,20.548600>0.400000}
cylinder{<139.547600,0.038000,25.628600><139.547600,-1.538000,25.628600>0.400000}
cylinder{<142.443200,0.038000,20.599400><142.443200,-1.538000,20.599400>0.400000}
cylinder{<142.443200,0.038000,25.679400><142.443200,-1.538000,25.679400>0.400000}
cylinder{<186.131200,0.038000,19.075400><186.131200,-1.538000,19.075400>0.406400}
cylinder{<186.131200,0.038000,8.915400><186.131200,-1.538000,8.915400>0.406400}
cylinder{<186.385200,0.038000,36.855400><186.385200,-1.538000,36.855400>0.406400}
cylinder{<186.385200,0.038000,26.695400><186.385200,-1.538000,26.695400>0.406400}
cylinder{<186.131200,0.038000,54.889400><186.131200,-1.538000,54.889400>0.406400}
cylinder{<186.131200,0.038000,44.729400><186.131200,-1.538000,44.729400>0.406400}
cylinder{<186.131200,0.038000,72.669400><186.131200,-1.538000,72.669400>0.406400}
cylinder{<186.131200,0.038000,62.509400><186.131200,-1.538000,62.509400>0.406400}
cylinder{<119.354600,0.038000,37.769800><119.354600,-1.538000,37.769800>0.406400}
cylinder{<121.894600,0.038000,37.769800><121.894600,-1.538000,37.769800>0.406400}
cylinder{<124.434600,0.038000,37.769800><124.434600,-1.538000,37.769800>0.406400}
cylinder{<126.974600,0.038000,37.769800><126.974600,-1.538000,37.769800>0.406400}
cylinder{<129.514600,0.038000,37.769800><129.514600,-1.538000,37.769800>0.406400}
cylinder{<132.054600,0.038000,37.769800><132.054600,-1.538000,37.769800>0.406400}
cylinder{<134.594600,0.038000,37.769800><134.594600,-1.538000,37.769800>0.406400}
cylinder{<137.134600,0.038000,37.769800><137.134600,-1.538000,37.769800>0.406400}
cylinder{<139.674600,0.038000,37.769800><139.674600,-1.538000,37.769800>0.406400}
cylinder{<142.214600,0.038000,37.769800><142.214600,-1.538000,37.769800>0.406400}
cylinder{<144.754600,0.038000,37.769800><144.754600,-1.538000,37.769800>0.406400}
cylinder{<147.294600,0.038000,37.769800><147.294600,-1.538000,37.769800>0.406400}
cylinder{<149.834600,0.038000,37.769800><149.834600,-1.538000,37.769800>0.406400}
cylinder{<152.374600,0.038000,37.769800><152.374600,-1.538000,37.769800>0.406400}
cylinder{<152.374600,0.038000,45.389800><152.374600,-1.538000,45.389800>0.406400}
cylinder{<149.834600,0.038000,45.389800><149.834600,-1.538000,45.389800>0.406400}
cylinder{<147.294600,0.038000,45.389800><147.294600,-1.538000,45.389800>0.406400}
cylinder{<144.754600,0.038000,45.389800><144.754600,-1.538000,45.389800>0.406400}
cylinder{<142.214600,0.038000,45.389800><142.214600,-1.538000,45.389800>0.406400}
cylinder{<139.674600,0.038000,45.389800><139.674600,-1.538000,45.389800>0.406400}
cylinder{<137.134600,0.038000,45.389800><137.134600,-1.538000,45.389800>0.406400}
cylinder{<134.594600,0.038000,45.389800><134.594600,-1.538000,45.389800>0.406400}
cylinder{<132.054600,0.038000,45.389800><132.054600,-1.538000,45.389800>0.406400}
cylinder{<129.514600,0.038000,45.389800><129.514600,-1.538000,45.389800>0.406400}
cylinder{<126.974600,0.038000,45.389800><126.974600,-1.538000,45.389800>0.406400}
cylinder{<124.434600,0.038000,45.389800><124.434600,-1.538000,45.389800>0.406400}
cylinder{<121.894600,0.038000,45.389800><121.894600,-1.538000,45.389800>0.406400}
cylinder{<119.354600,0.038000,45.389800><119.354600,-1.538000,45.389800>0.406400}
cylinder{<108.864400,0.038000,21.463000><108.864400,-1.538000,21.463000>0.406400}
cylinder{<108.864400,0.038000,24.003000><108.864400,-1.538000,24.003000>0.406400}
cylinder{<108.864400,0.038000,26.543000><108.864400,-1.538000,26.543000>0.406400}
cylinder{<108.864400,0.038000,29.083000><108.864400,-1.538000,29.083000>0.406400}
cylinder{<101.244400,0.038000,29.083000><101.244400,-1.538000,29.083000>0.406400}
cylinder{<101.244400,0.038000,26.543000><101.244400,-1.538000,26.543000>0.406400}
cylinder{<101.244400,0.038000,24.003000><101.244400,-1.538000,24.003000>0.406400}
cylinder{<101.244400,0.038000,21.463000><101.244400,-1.538000,21.463000>0.406400}
cylinder{<128.143000,0.038000,21.259800><128.143000,-1.538000,21.259800>0.406400}
cylinder{<128.143000,0.038000,23.799800><128.143000,-1.538000,23.799800>0.406400}
cylinder{<128.143000,0.038000,26.339800><128.143000,-1.538000,26.339800>0.406400}
cylinder{<128.143000,0.038000,28.879800><128.143000,-1.538000,28.879800>0.406400}
cylinder{<120.523000,0.038000,28.879800><120.523000,-1.538000,28.879800>0.406400}
cylinder{<120.523000,0.038000,26.339800><120.523000,-1.538000,26.339800>0.406400}
cylinder{<120.523000,0.038000,23.799800><120.523000,-1.538000,23.799800>0.406400}
cylinder{<120.523000,0.038000,21.259800><120.523000,-1.538000,21.259800>0.406400}
cylinder{<9.296400,0.038000,27.711400><9.296400,-1.538000,27.711400>0.500000}
cylinder{<11.836400,0.038000,27.711400><11.836400,-1.538000,27.711400>0.500000}
cylinder{<9.296400,0.038000,25.171400><9.296400,-1.538000,25.171400>0.500000}
cylinder{<11.836400,0.038000,25.171400><11.836400,-1.538000,25.171400>0.500000}
cylinder{<9.296400,0.038000,22.631400><9.296400,-1.538000,22.631400>0.500000}
cylinder{<11.836400,0.038000,22.631400><11.836400,-1.538000,22.631400>0.500000}
cylinder{<9.296400,0.038000,20.091400><9.296400,-1.538000,20.091400>0.500000}
cylinder{<11.836400,0.038000,20.091400><11.836400,-1.538000,20.091400>0.500000}
cylinder{<9.296400,0.038000,17.551400><9.296400,-1.538000,17.551400>0.500000}
cylinder{<11.836400,0.038000,17.551400><11.836400,-1.538000,17.551400>0.500000}
cylinder{<59.766200,0.038000,60.756800><59.766200,-1.538000,60.756800>0.508000}
cylinder{<150.926800,0.038000,8.051800><150.926800,-1.538000,8.051800>0.508000}
cylinder{<153.466800,0.038000,8.051800><153.466800,-1.538000,8.051800>0.508000}
cylinder{<86.563200,0.038000,8.890000><86.563200,-1.538000,8.890000>0.508000}
cylinder{<84.023200,0.038000,8.890000><84.023200,-1.538000,8.890000>0.508000}
cylinder{<122.072400,0.038000,8.788400><122.072400,-1.538000,8.788400>0.508000}
cylinder{<119.532400,0.038000,8.788400><119.532400,-1.538000,8.788400>0.508000}
cylinder{<56.057800,0.038000,8.940800><56.057800,-1.538000,8.940800>0.508000}
cylinder{<53.517800,0.038000,8.940800><53.517800,-1.538000,8.940800>0.508000}
cylinder{<22.758400,0.038000,9.626600><22.758400,-1.538000,9.626600>0.508000}
cylinder{<25.298400,0.038000,9.626600><25.298400,-1.538000,9.626600>0.508000}
cylinder{<27.838400,0.038000,9.626600><27.838400,-1.538000,9.626600>0.508000}
cylinder{<30.378400,0.038000,9.626600><30.378400,-1.538000,9.626600>0.508000}
cylinder{<9.321800,0.038000,15.011400><9.321800,-1.538000,15.011400>0.508000}
cylinder{<11.861800,0.038000,15.011400><11.861800,-1.538000,15.011400>0.508000}
cylinder{<9.321800,0.038000,12.471400><9.321800,-1.538000,12.471400>0.508000}
cylinder{<11.861800,0.038000,12.471400><11.861800,-1.538000,12.471400>0.508000}
cylinder{<9.321800,0.038000,9.931400><9.321800,-1.538000,9.931400>0.508000}
cylinder{<11.861800,0.038000,9.931400><11.861800,-1.538000,9.931400>0.508000}
cylinder{<59.867800,0.038000,58.216800><59.867800,-1.538000,58.216800>0.508000}
cylinder{<195.148200,0.038000,7.010400><195.148200,-1.538000,7.010400>0.660400}
cylinder{<195.148200,0.038000,18.948400><195.148200,-1.538000,18.948400>0.660400}
cylinder{<207.340200,0.038000,18.948400><207.340200,-1.538000,18.948400>0.660400}
cylinder{<193.116200,0.038000,12.979400><193.116200,-1.538000,12.979400>0.660400}
cylinder{<207.340200,0.038000,7.010400><207.340200,-1.538000,7.010400>0.660400}
cylinder{<195.148200,0.038000,24.790400><195.148200,-1.538000,24.790400>0.660400}
cylinder{<195.148200,0.038000,36.728400><195.148200,-1.538000,36.728400>0.660400}
cylinder{<207.340200,0.038000,36.728400><207.340200,-1.538000,36.728400>0.660400}
cylinder{<193.116200,0.038000,30.759400><193.116200,-1.538000,30.759400>0.660400}
cylinder{<207.340200,0.038000,24.790400><207.340200,-1.538000,24.790400>0.660400}
cylinder{<195.148200,0.038000,42.570400><195.148200,-1.538000,42.570400>0.660400}
cylinder{<195.148200,0.038000,54.508400><195.148200,-1.538000,54.508400>0.660400}
cylinder{<207.340200,0.038000,54.508400><207.340200,-1.538000,54.508400>0.660400}
cylinder{<193.116200,0.038000,48.539400><193.116200,-1.538000,48.539400>0.660400}
cylinder{<207.340200,0.038000,42.570400><207.340200,-1.538000,42.570400>0.660400}
cylinder{<195.148200,0.038000,60.350400><195.148200,-1.538000,60.350400>0.660400}
cylinder{<195.148200,0.038000,72.288400><195.148200,-1.538000,72.288400>0.660400}
cylinder{<207.340200,0.038000,72.288400><207.340200,-1.538000,72.288400>0.660400}
cylinder{<193.116200,0.038000,66.319400><193.116200,-1.538000,66.319400>0.660400}
cylinder{<207.340200,0.038000,60.350400><207.340200,-1.538000,60.350400>0.660400}
cylinder{<53.644800,0.038000,73.228200><53.644800,-1.538000,73.228200>0.400000}
cylinder{<53.644800,0.038000,70.688200><53.644800,-1.538000,70.688200>0.400000}
cylinder{<180.035200,0.038000,16.027400><180.035200,-1.538000,16.027400>0.400000}
cylinder{<180.035200,0.038000,18.567400><180.035200,-1.538000,18.567400>0.400000}
cylinder{<180.035200,0.038000,34.061400><180.035200,-1.538000,34.061400>0.400000}
cylinder{<180.035200,0.038000,36.601400><180.035200,-1.538000,36.601400>0.400000}
cylinder{<180.289200,0.038000,52.095400><180.289200,-1.538000,52.095400>0.400000}
cylinder{<180.289200,0.038000,54.635400><180.289200,-1.538000,54.635400>0.400000}
cylinder{<180.543200,0.038000,69.875400><180.543200,-1.538000,69.875400>0.400000}
cylinder{<180.543200,0.038000,72.415400><180.543200,-1.538000,72.415400>0.400000}
cylinder{<53.797200,0.038000,60.477400><53.797200,-1.538000,60.477400>0.400000}
cylinder{<53.797200,0.038000,57.937400><53.797200,-1.538000,57.937400>0.400000}
cylinder{<142.290800,0.038000,31.521400><142.290800,-1.538000,31.521400>0.400000}
cylinder{<137.464800,0.038000,31.521400><137.464800,-1.538000,31.521400>0.400000}
cylinder{<116.357400,0.038000,30.937200><116.357400,-1.538000,30.937200>0.400000}
cylinder{<113.817400,0.038000,30.937200><113.817400,-1.538000,30.937200>0.400000}
cylinder{<149.301200,0.038000,65.536800><149.301200,-1.538000,65.536800>0.400000}
cylinder{<149.376200,0.038000,68.376800><149.376200,-1.538000,68.376800>0.400000}
cylinder{<149.301200,0.038000,71.216800><149.301200,-1.538000,71.216800>0.400000}
cylinder{<30.099000,0.038000,36.403000><30.099000,-1.538000,36.403000>0.400000}
cylinder{<30.174000,0.038000,39.243000><30.174000,-1.538000,39.243000>0.400000}
cylinder{<30.099000,0.038000,42.083000><30.099000,-1.538000,42.083000>0.400000}
cylinder{<177.195200,0.038000,10.693400><177.195200,-1.538000,10.693400>0.400000}
cylinder{<180.035200,0.038000,10.618400><180.035200,-1.538000,10.618400>0.400000}
cylinder{<182.875200,0.038000,10.693400><182.875200,-1.538000,10.693400>0.400000}
cylinder{<30.099000,0.038000,46.563000><30.099000,-1.538000,46.563000>0.400000}
cylinder{<30.174000,0.038000,49.403000><30.174000,-1.538000,49.403000>0.400000}
cylinder{<30.099000,0.038000,52.243000><30.099000,-1.538000,52.243000>0.400000}
cylinder{<177.449200,0.038000,29.235400><177.449200,-1.538000,29.235400>0.400000}
cylinder{<180.289200,0.038000,29.160400><180.289200,-1.538000,29.160400>0.400000}
cylinder{<183.129200,0.038000,29.235400><183.129200,-1.538000,29.235400>0.400000}
cylinder{<30.099000,0.038000,57.993000><30.099000,-1.538000,57.993000>0.400000}
cylinder{<30.174000,0.038000,60.833000><30.174000,-1.538000,60.833000>0.400000}
cylinder{<30.099000,0.038000,63.673000><30.099000,-1.538000,63.673000>0.400000}
cylinder{<177.449200,0.038000,46.253400><177.449200,-1.538000,46.253400>0.400000}
cylinder{<180.289200,0.038000,46.178400><180.289200,-1.538000,46.178400>0.400000}
cylinder{<183.129200,0.038000,46.253400><183.129200,-1.538000,46.253400>0.400000}
cylinder{<30.099000,0.038000,66.883000><30.099000,-1.538000,66.883000>0.400000}
cylinder{<30.174000,0.038000,69.723000><30.174000,-1.538000,69.723000>0.400000}
cylinder{<30.099000,0.038000,72.563000><30.099000,-1.538000,72.563000>0.400000}
cylinder{<177.449200,0.038000,64.287400><177.449200,-1.538000,64.287400>0.400000}
cylinder{<180.289200,0.038000,64.212400><180.289200,-1.538000,64.212400>0.400000}
cylinder{<183.129200,0.038000,64.287400><183.129200,-1.538000,64.287400>0.400000}
cylinder{<51.638200,0.038000,26.619200><51.638200,-1.538000,26.619200>0.500000}
cylinder{<61.798200,0.038000,26.619200><61.798200,-1.538000,26.619200>0.500000}
cylinder{<64.719200,0.038000,63.119000><64.719200,-1.538000,63.119000>0.500000}
cylinder{<64.719200,0.038000,73.279000><64.719200,-1.538000,73.279000>0.500000}
cylinder{<149.250400,0.038000,58.191400><149.250400,-1.538000,58.191400>0.500000}
cylinder{<159.410400,0.038000,58.191400><159.410400,-1.538000,58.191400>0.500000}
cylinder{<103.632000,0.038000,55.626000><103.632000,-1.538000,55.626000>0.500000}
cylinder{<113.792000,0.038000,55.626000><113.792000,-1.538000,55.626000>0.500000}
cylinder{<103.784400,0.038000,51.739800><103.784400,-1.538000,51.739800>0.500000}
cylinder{<113.944400,0.038000,51.739800><113.944400,-1.538000,51.739800>0.500000}
cylinder{<56.235600,0.038000,46.990000><56.235600,-1.538000,46.990000>0.400000}
cylinder{<53.695600,0.038000,49.530000><53.695600,-1.538000,49.530000>0.400000}
cylinder{<51.155600,0.038000,46.990000><51.155600,-1.538000,46.990000>0.400000}
cylinder{<37.363400,0.038000,58.318400><37.363400,-1.538000,58.318400>0.500000}
cylinder{<37.363400,0.038000,48.158400><37.363400,-1.538000,48.158400>0.500000}
cylinder{<25.019000,0.038000,41.783000><25.019000,-1.538000,41.783000>0.500000}
cylinder{<14.859000,0.038000,41.783000><14.859000,-1.538000,41.783000>0.500000}
cylinder{<35.179000,0.038000,44.323000><35.179000,-1.538000,44.323000>0.500000}
cylinder{<35.179000,0.038000,34.163000><35.179000,-1.538000,34.163000>0.500000}
cylinder{<25.019000,0.038000,36.703000><25.019000,-1.538000,36.703000>0.500000}
cylinder{<14.859000,0.038000,36.703000><14.859000,-1.538000,36.703000>0.500000}
cylinder{<170.535600,0.038000,8.483600><170.535600,-1.538000,8.483600>0.500000}
cylinder{<170.535600,0.038000,18.643600><170.535600,-1.538000,18.643600>0.500000}
cylinder{<173.329600,0.038000,8.432800><173.329600,-1.538000,8.432800>0.500000}
cylinder{<173.329600,0.038000,18.592800><173.329600,-1.538000,18.592800>0.500000}
cylinder{<25.019000,0.038000,51.943000><25.019000,-1.538000,51.943000>0.500000}
cylinder{<14.859000,0.038000,51.943000><14.859000,-1.538000,51.943000>0.500000}
cylinder{<38.989000,0.038000,44.323000><38.989000,-1.538000,44.323000>0.500000}
cylinder{<38.989000,0.038000,34.163000><38.989000,-1.538000,34.163000>0.500000}
cylinder{<25.019000,0.038000,46.863000><25.019000,-1.538000,46.863000>0.500000}
cylinder{<14.859000,0.038000,46.863000><14.859000,-1.538000,46.863000>0.500000}
cylinder{<170.586400,0.038000,26.466800><170.586400,-1.538000,26.466800>0.500000}
cylinder{<170.586400,0.038000,36.626800><170.586400,-1.538000,36.626800>0.500000}
cylinder{<173.583600,0.038000,26.466800><173.583600,-1.538000,26.466800>0.500000}
cylinder{<173.583600,0.038000,36.626800><173.583600,-1.538000,36.626800>0.500000}
cylinder{<25.019000,0.038000,62.103000><25.019000,-1.538000,62.103000>0.500000}
cylinder{<14.859000,0.038000,62.103000><14.859000,-1.538000,62.103000>0.500000}
cylinder{<38.989000,0.038000,72.263000><38.989000,-1.538000,72.263000>0.500000}
cylinder{<38.989000,0.038000,62.103000><38.989000,-1.538000,62.103000>0.500000}
cylinder{<25.019000,0.038000,57.023000><25.019000,-1.538000,57.023000>0.500000}
cylinder{<14.859000,0.038000,57.023000><14.859000,-1.538000,57.023000>0.500000}
cylinder{<170.586400,0.038000,44.424600><170.586400,-1.538000,44.424600>0.500000}
cylinder{<170.586400,0.038000,54.584600><170.586400,-1.538000,54.584600>0.500000}
cylinder{<173.558200,0.038000,44.450000><173.558200,-1.538000,44.450000>0.500000}
cylinder{<173.558200,0.038000,54.610000><173.558200,-1.538000,54.610000>0.500000}
cylinder{<25.019000,0.038000,72.263000><25.019000,-1.538000,72.263000>0.500000}
cylinder{<14.859000,0.038000,72.263000><14.859000,-1.538000,72.263000>0.500000}
cylinder{<35.179000,0.038000,72.263000><35.179000,-1.538000,72.263000>0.500000}
cylinder{<35.179000,0.038000,62.103000><35.179000,-1.538000,62.103000>0.500000}
cylinder{<25.019000,0.038000,67.183000><25.019000,-1.538000,67.183000>0.500000}
cylinder{<14.859000,0.038000,67.183000><14.859000,-1.538000,67.183000>0.500000}
cylinder{<170.967400,0.038000,62.103000><170.967400,-1.538000,62.103000>0.500000}
cylinder{<170.967400,0.038000,72.263000><170.967400,-1.538000,72.263000>0.500000}
cylinder{<173.939200,0.038000,62.179200><173.939200,-1.538000,62.179200>0.500000}
cylinder{<173.939200,0.038000,72.339200><173.939200,-1.538000,72.339200>0.500000}
cylinder{<56.235600,0.038000,36.652200><56.235600,-1.538000,36.652200>0.400000}
cylinder{<56.235600,0.038000,30.149800><56.235600,-1.538000,30.149800>0.400000}
cylinder{<51.714400,0.038000,36.652200><51.714400,-1.538000,36.652200>0.400000}
cylinder{<51.714400,0.038000,30.149800><51.714400,-1.538000,30.149800>0.400000}
cylinder{<138.582400,0.038000,62.722600><138.582400,-1.538000,62.722600>0.400000}
cylinder{<138.582400,0.038000,70.322600><138.582400,-1.538000,70.322600>0.400000}
cylinder{<75.284600,0.038000,72.525200><75.284600,-1.538000,72.525200>0.400000}
cylinder{<77.824600,0.038000,72.525200><77.824600,-1.538000,72.525200>0.400000}
cylinder{<80.364600,0.038000,72.525200><80.364600,-1.538000,72.525200>0.400000}
cylinder{<82.904600,0.038000,72.525200><82.904600,-1.538000,72.525200>0.400000}
cylinder{<85.444600,0.038000,72.525200><85.444600,-1.538000,72.525200>0.400000}
cylinder{<87.984600,0.038000,72.525200><87.984600,-1.538000,72.525200>0.400000}
cylinder{<90.524600,0.038000,72.525200><90.524600,-1.538000,72.525200>0.400000}
cylinder{<93.064600,0.038000,72.525200><93.064600,-1.538000,72.525200>0.400000}
cylinder{<95.604600,0.038000,72.525200><95.604600,-1.538000,72.525200>0.400000}
cylinder{<98.144600,0.038000,72.525200><98.144600,-1.538000,72.525200>0.400000}
cylinder{<100.684600,0.038000,72.525200><100.684600,-1.538000,72.525200>0.400000}
cylinder{<103.224600,0.038000,72.525200><103.224600,-1.538000,72.525200>0.400000}
cylinder{<105.764600,0.038000,72.525200><105.764600,-1.538000,72.525200>0.400000}
cylinder{<108.304600,0.038000,72.525200><108.304600,-1.538000,72.525200>0.400000}
cylinder{<110.844600,0.038000,72.525200><110.844600,-1.538000,72.525200>0.400000}
cylinder{<113.384600,0.038000,72.525200><113.384600,-1.538000,72.525200>0.400000}
cylinder{<8.509000,0.038000,36.823000><8.509000,-1.538000,36.823000>0.596900}
cylinder{<8.509000,0.038000,41.823000><8.509000,-1.538000,41.823000>0.596900}
cylinder{<8.509000,0.038000,46.823000><8.509000,-1.538000,46.823000>0.596900}
cylinder{<8.509000,0.038000,51.823000><8.509000,-1.538000,51.823000>0.596900}
cylinder{<8.509000,0.038000,57.143000><8.509000,-1.538000,57.143000>0.596900}
cylinder{<8.509000,0.038000,62.143000><8.509000,-1.538000,62.143000>0.596900}
cylinder{<8.509000,0.038000,67.143000><8.509000,-1.538000,67.143000>0.596900}
cylinder{<8.509000,0.038000,72.143000><8.509000,-1.538000,72.143000>0.596900}
cylinder{<222.402400,0.038000,17.722200><222.402400,-1.538000,17.722200>0.596900}
cylinder{<222.402400,0.038000,22.722200><222.402400,-1.538000,22.722200>0.596900}
cylinder{<222.402400,0.038000,27.722200><222.402400,-1.538000,27.722200>0.596900}
cylinder{<222.402400,0.038000,32.722200><222.402400,-1.538000,32.722200>0.596900}
cylinder{<222.199200,0.038000,37.432600><222.199200,-1.538000,37.432600>0.596900}
cylinder{<222.199200,0.038000,42.432600><222.199200,-1.538000,42.432600>0.596900}
cylinder{<222.199200,0.038000,47.432600><222.199200,-1.538000,47.432600>0.596900}
cylinder{<222.199200,0.038000,52.432600><222.199200,-1.538000,52.432600>0.596900}
cylinder{<222.326200,0.038000,57.397000><222.326200,-1.538000,57.397000>0.596900}
cylinder{<222.326200,0.038000,62.397000><222.326200,-1.538000,62.397000>0.596900}
cylinder{<222.326200,0.038000,67.397000><222.326200,-1.538000,67.397000>0.596900}
cylinder{<222.326200,0.038000,72.397000><222.326200,-1.538000,72.397000>0.596900}
//Holes(fast)/Vias
cylinder{<165.811200,0.038000,34.569400><165.811200,-1.538000,34.569400>0.304800 }
cylinder{<101.041200,0.038000,39.649400><101.041200,-1.538000,39.649400>0.304800 }
cylinder{<106.121200,0.038000,34.569400><106.121200,-1.538000,34.569400>0.304800 }
cylinder{<108.661200,0.038000,34.569400><108.661200,-1.538000,34.569400>0.304800 }
cylinder{<84.531200,0.038000,24.409400><84.531200,-1.538000,24.409400>0.304800 }
cylinder{<126.441200,0.038000,77.749400><126.441200,-1.538000,77.749400>0.304800 }
cylinder{<122.631200,0.038000,19.329400><122.631200,-1.538000,19.329400>0.304800 }
cylinder{<125.171200,0.038000,6.629400><125.171200,-1.538000,6.629400>0.304800 }
cylinder{<103.581200,0.038000,44.729400><103.581200,-1.538000,44.729400>0.304800 }
cylinder{<111.201200,0.038000,30.759400><111.201200,-1.538000,30.759400>0.304800 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//BAT1 silk screen
object{ARC(10.770328,0.203200,291.801409,608.198591,0.036000) translate<86.131400,0.000000,30.293800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.131400,0.000000,20.293800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.131400,0.000000,17.293800>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,-90.000000,0> translate<90.131400,0.000000,17.293800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.131400,0.000000,17.293800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<82.131400,0.000000,17.293800>}
box{<0,0,-0.101600><8.000000,0.036000,0.101600> rotate<0,0.000000,0> translate<82.131400,0.000000,17.293800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<82.131400,0.000000,17.293800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<82.131400,0.000000,20.293800>}
box{<0,0,-0.101600><3.000000,0.036000,0.101600> rotate<0,90.000000,0> translate<82.131400,0.000000,20.293800> }
difference{
cylinder{<86.231400,0,30.233800><86.231400,0.036000,30.233800>10.101600 translate<0,0.000000,0>}
cylinder{<86.231400,-0.1,30.233800><86.231400,0.135000,30.233800>9.898400 translate<0,0.000000,0>}}
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<137.337800,0.000000,23.393400>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.702800,0.000000,23.393400>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<136.702800,0.000000,23.393400> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.702800,0.000000,23.393400>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.067800,0.000000,23.393400>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<136.067800,0.000000,23.393400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.702800,0.000000,23.393400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.702800,0.000000,24.612600>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,90.000000,0> translate<136.702800,0.000000,24.612600> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<137.337800,0.000000,22.758400>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.702800,0.000000,22.758400>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<136.702800,0.000000,22.758400> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.702800,0.000000,22.758400>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.067800,0.000000,22.758400>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<136.067800,0.000000,22.758400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.702800,0.000000,22.758400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.702800,0.000000,21.564600>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,-90.000000,0> translate<136.702800,0.000000,21.564600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.718800,0.000000,26.771600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.686800,0.000000,26.771600>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.686800,0.000000,26.771600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.432800,0.000000,26.517600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.432800,0.000000,19.659600>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<135.432800,0.000000,19.659600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.686800,0.000000,19.405600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.718800,0.000000,19.405600>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<135.686800,0.000000,19.405600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.972800,0.000000,19.659600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.972800,0.000000,26.517600>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<137.972800,0.000000,26.517600> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<137.718800,0.000000,19.659600>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<135.686800,0.000000,19.659600>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<135.686800,0.000000,26.517600>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<137.718800,0.000000,26.517600>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<137.439400,0.000000,50.368200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<137.439400,0.000000,51.003200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<137.439400,0.000000,51.003200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<137.439400,0.000000,51.003200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<137.439400,0.000000,51.638200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<137.439400,0.000000,51.638200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.439400,0.000000,51.003200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.658600,0.000000,51.003200>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,0.000000,0> translate<137.439400,0.000000,51.003200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.804400,0.000000,50.368200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.804400,0.000000,51.003200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<136.804400,0.000000,51.003200> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.804400,0.000000,51.003200>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<136.804400,0.000000,51.638200>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,90.000000,0> translate<136.804400,0.000000,51.638200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.804400,0.000000,51.003200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<135.610600,0.000000,51.003200>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,0.000000,0> translate<135.610600,0.000000,51.003200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.817600,0.000000,49.987200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.817600,0.000000,52.019200>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,90.000000,0> translate<140.817600,0.000000,52.019200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.563600,0.000000,52.273200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.705600,0.000000,52.273200>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<133.705600,0.000000,52.273200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.451600,0.000000,52.019200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.451600,0.000000,49.987200>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,-90.000000,0> translate<133.451600,0.000000,49.987200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.705600,0.000000,49.733200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.563600,0.000000,49.733200>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,0.000000,0> translate<133.705600,0.000000,49.733200> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<133.705600,0.000000,49.987200>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<133.705600,0.000000,52.019200>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<140.563600,0.000000,52.019200>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<140.563600,0.000000,49.987200>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.912600,0.000000,22.783800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<139.547600,0.000000,22.783800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<138.912600,0.000000,22.783800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<139.547600,0.000000,22.783800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<140.182600,0.000000,22.783800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<139.547600,0.000000,22.783800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.547600,0.000000,22.783800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.547600,0.000000,21.564600>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.547600,0.000000,21.564600> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<138.912600,0.000000,23.418800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<139.547600,0.000000,23.418800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<138.912600,0.000000,23.418800> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<139.547600,0.000000,23.418800>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<140.182600,0.000000,23.418800>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<139.547600,0.000000,23.418800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.547600,0.000000,23.418800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.547600,0.000000,24.612600>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<139.547600,0.000000,24.612600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.531600,0.000000,19.405600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.563600,0.000000,19.405600>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<138.531600,0.000000,19.405600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.817600,0.000000,19.659600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.817600,0.000000,26.517600>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<140.817600,0.000000,26.517600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.563600,0.000000,26.771600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.531600,0.000000,26.771600>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<138.531600,0.000000,26.771600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.277600,0.000000,26.517600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.277600,0.000000,19.659600>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<138.277600,0.000000,19.659600> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<138.531600,0.000000,26.517600>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<140.563600,0.000000,26.517600>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<140.563600,0.000000,19.659600>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<138.531600,0.000000,19.659600>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<141.808200,0.000000,22.834600>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.443200,0.000000,22.834600>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<141.808200,0.000000,22.834600> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.443200,0.000000,22.834600>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.078200,0.000000,22.834600>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<142.443200,0.000000,22.834600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.443200,0.000000,22.834600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.443200,0.000000,21.615400>}
box{<0,0,-0.076200><1.219200,0.036000,0.076200> rotate<0,-90.000000,0> translate<142.443200,0.000000,21.615400> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<141.808200,0.000000,23.469600>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.443200,0.000000,23.469600>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<141.808200,0.000000,23.469600> }
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<142.443200,0.000000,23.469600>}
cylinder{<0,0,0><0,0.036000,0>0.152400 translate<143.078200,0.000000,23.469600>}
box{<0,0,-0.152400><0.635000,0.036000,0.152400> rotate<0,0.000000,0> translate<142.443200,0.000000,23.469600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.443200,0.000000,23.469600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.443200,0.000000,24.663400>}
box{<0,0,-0.076200><1.193800,0.036000,0.076200> rotate<0,90.000000,0> translate<142.443200,0.000000,24.663400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.427200,0.000000,19.456400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.459200,0.000000,19.456400>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.427200,0.000000,19.456400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.713200,0.000000,19.710400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.713200,0.000000,26.568400>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,90.000000,0> translate<143.713200,0.000000,26.568400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<143.459200,0.000000,26.822400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.427200,0.000000,26.822400>}
box{<0,0,-0.076200><2.032000,0.036000,0.076200> rotate<0,0.000000,0> translate<141.427200,0.000000,26.822400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.173200,0.000000,26.568400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.173200,0.000000,19.710400>}
box{<0,0,-0.076200><6.858000,0.036000,0.076200> rotate<0,-90.000000,0> translate<141.173200,0.000000,19.710400> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<141.427200,0.000000,26.568400>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<143.459200,0.000000,26.568400>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<143.459200,0.000000,19.710400>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<141.427200,0.000000,19.710400>}
//D1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,19.075400>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,18.186400>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,18.186400> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,8.915400>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,9.804400>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,90.000000,0> translate<186.131200,0.000000,9.804400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,13.360400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,13.995400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<186.131200,0.000000,13.995400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,15.011400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,15.011400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.496200,0.000000,15.011400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,15.011400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,13.995400>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<186.131200,0.000000,13.995400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,13.995400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,15.519400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<186.131200,0.000000,15.519400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,13.995400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,15.011400>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<185.496200,0.000000,15.011400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,13.995400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,13.995400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.496200,0.000000,13.995400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,13.995400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,13.995400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<186.131200,0.000000,13.995400> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<185.369200,0.000000,16.027400>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<185.369200,0.000000,11.963400>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<186.893200,0.000000,11.963400>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<186.893200,0.000000,16.027400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.893200,0.000000,16.281400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.369200,0.000000,16.281400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.369200,0.000000,16.281400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.369200,0.000000,11.709400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.893200,0.000000,11.709400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.369200,0.000000,11.709400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.115200,0.000000,11.963400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.115200,0.000000,16.027400>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<185.115200,0.000000,16.027400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.147200,0.000000,11.963400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.147200,0.000000,16.027400>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<187.147200,0.000000,16.027400> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-90.000000,0> translate<186.131200,0.000000,12.344400>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,17.233900>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,10.756900>}
//D2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.385200,0.000000,36.855400>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.385200,0.000000,35.966400>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.385200,0.000000,35.966400> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.385200,0.000000,26.695400>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.385200,0.000000,27.584400>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,90.000000,0> translate<186.385200,0.000000,27.584400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.385200,0.000000,31.140400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.385200,0.000000,31.775400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<186.385200,0.000000,31.775400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.750200,0.000000,32.791400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.020200,0.000000,32.791400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.750200,0.000000,32.791400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.020200,0.000000,32.791400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.385200,0.000000,31.775400>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<186.385200,0.000000,31.775400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.385200,0.000000,31.775400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.385200,0.000000,33.299400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<186.385200,0.000000,33.299400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.385200,0.000000,31.775400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.750200,0.000000,32.791400>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<185.750200,0.000000,32.791400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.750200,0.000000,31.775400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.385200,0.000000,31.775400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.750200,0.000000,31.775400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.385200,0.000000,31.775400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.020200,0.000000,31.775400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<186.385200,0.000000,31.775400> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<185.623200,0.000000,33.807400>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<185.623200,0.000000,29.743400>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<187.147200,0.000000,29.743400>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<187.147200,0.000000,33.807400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.147200,0.000000,34.061400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.623200,0.000000,34.061400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.623200,0.000000,34.061400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.623200,0.000000,29.489400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.147200,0.000000,29.489400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.623200,0.000000,29.489400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.369200,0.000000,29.743400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.369200,0.000000,33.807400>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<185.369200,0.000000,33.807400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.401200,0.000000,29.743400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.401200,0.000000,33.807400>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<187.401200,0.000000,33.807400> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-90.000000,0> translate<186.385200,0.000000,30.124400>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.385200,0.000000,35.013900>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.385200,0.000000,28.536900>}
//D3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,54.889400>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,54.000400>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,54.000400> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,44.729400>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,45.618400>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,90.000000,0> translate<186.131200,0.000000,45.618400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,49.174400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,49.809400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<186.131200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,50.825400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,50.825400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.496200,0.000000,50.825400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,50.825400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,49.809400>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<186.131200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,51.333400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<186.131200,0.000000,51.333400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,50.825400>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<185.496200,0.000000,50.825400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,49.809400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.496200,0.000000,49.809400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,49.809400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,49.809400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<186.131200,0.000000,49.809400> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<185.369200,0.000000,51.841400>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<185.369200,0.000000,47.777400>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<186.893200,0.000000,47.777400>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<186.893200,0.000000,51.841400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.893200,0.000000,52.095400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.369200,0.000000,52.095400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.369200,0.000000,52.095400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.369200,0.000000,47.523400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.893200,0.000000,47.523400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.369200,0.000000,47.523400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.115200,0.000000,47.777400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.115200,0.000000,51.841400>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<185.115200,0.000000,51.841400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.147200,0.000000,47.777400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.147200,0.000000,51.841400>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<187.147200,0.000000,51.841400> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-90.000000,0> translate<186.131200,0.000000,48.158400>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,53.047900>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,46.570900>}
//D4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,72.669400>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,71.780400>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,71.780400> }
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,62.509400>}
cylinder{<0,0,0><0,0.036000,0>0.254000 translate<186.131200,0.000000,63.398400>}
box{<0,0,-0.254000><0.889000,0.036000,0.254000> rotate<0,90.000000,0> translate<186.131200,0.000000,63.398400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,66.954400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,67.589400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,90.000000,0> translate<186.131200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,68.605400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,68.605400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.496200,0.000000,68.605400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,68.605400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,67.589400>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,-57.990789,0> translate<186.131200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,69.113400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,90.000000,0> translate<186.131200,0.000000,69.113400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,68.605400>}
box{<0,0,-0.076200><1.198116,0.036000,0.076200> rotate<0,57.990789,0> translate<185.496200,0.000000,68.605400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.496200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,67.589400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.496200,0.000000,67.589400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.131200,0.000000,67.589400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.766200,0.000000,67.589400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<186.131200,0.000000,67.589400> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<185.369200,0.000000,69.621400>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<185.369200,0.000000,65.557400>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<186.893200,0.000000,65.557400>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<186.893200,0.000000,69.621400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.893200,0.000000,69.875400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.369200,0.000000,69.875400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.369200,0.000000,69.875400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.369200,0.000000,65.303400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<186.893200,0.000000,65.303400>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<185.369200,0.000000,65.303400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.115200,0.000000,65.557400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<185.115200,0.000000,69.621400>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<185.115200,0.000000,69.621400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.147200,0.000000,65.557400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<187.147200,0.000000,69.621400>}
box{<0,0,-0.076200><4.064000,0.036000,0.076200> rotate<0,90.000000,0> translate<187.147200,0.000000,69.621400> }
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-90.000000,0> translate<186.131200,0.000000,65.938400>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,70.827900>}
box{<-0.952500,0,-0.254000><0.952500,0.036000,0.254000> rotate<0,-90.000000,0> translate<186.131200,0.000000,64.350900>}
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.322600,0.000000,40.944800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.322600,0.000000,38.785800>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<117.322600,0.000000,38.785800> }
object{ARC(0.635000,0.152400,270.000000,450.000000,0.036000) translate<117.322600,0.000000,41.579800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.322600,0.000000,38.785800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.406600,0.000000,38.785800>}
box{<0,0,-0.076200><37.084000,0.036000,0.076200> rotate<0,0.000000,0> translate<117.322600,0.000000,38.785800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.322600,0.000000,44.373800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.322600,0.000000,42.214800>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,-90.000000,0> translate<117.322600,0.000000,42.214800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<117.322600,0.000000,44.373800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.406600,0.000000,44.373800>}
box{<0,0,-0.076200><37.084000,0.036000,0.076200> rotate<0,0.000000,0> translate<117.322600,0.000000,44.373800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.406600,0.000000,44.373800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.406600,0.000000,38.785800>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.406600,0.000000,38.785800> }
//IC2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.133400,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.133400,0.000000,20.193000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<102.133400,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<107.975400,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<107.975400,0.000000,30.353000>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<107.975400,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.133400,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<107.975400,0.000000,30.353000>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<102.133400,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<102.133400,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<104.038400,0.000000,20.193000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<102.133400,0.000000,20.193000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<107.975400,0.000000,20.193000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.070400,0.000000,20.193000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.070400,0.000000,20.193000> }
object{ARC(1.016000,0.152400,0.000000,180.000000,0.036000) translate<105.054400,0.000000,20.193000>}
//IC3 silk screen
object{ARC(0.635000,0.152400,0.000000,180.000000,0.036000) translate<124.333000,0.000000,19.989800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<124.968000,0.000000,19.989800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.127000,0.000000,19.989800>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,0.000000,0> translate<124.968000,0.000000,19.989800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.127000,0.000000,19.989800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.127000,0.000000,30.149800>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,90.000000,0> translate<127.127000,0.000000,30.149800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.127000,0.000000,30.149800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.539000,0.000000,30.149800>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.539000,0.000000,30.149800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.539000,0.000000,30.149800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.539000,0.000000,19.989800>}
box{<0,0,-0.076200><10.160000,0.036000,0.076200> rotate<0,-90.000000,0> translate<121.539000,0.000000,19.989800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.539000,0.000000,19.989800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.698000,0.000000,19.989800>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.539000,0.000000,19.989800> }
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,28.981400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,28.346400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.026400,0.000000,28.346400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,27.076400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,26.441400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<8.026400,0.000000,27.076400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,26.441400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,25.806400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.026400,0.000000,25.806400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,24.536400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,23.901400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<8.026400,0.000000,24.536400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,23.901400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,23.266400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.026400,0.000000,23.266400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,21.996400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,21.361400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<8.026400,0.000000,21.996400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,21.361400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,20.726400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.026400,0.000000,20.726400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,19.456400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,18.821400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<8.026400,0.000000,19.456400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,28.981400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,28.981400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.661400,0.000000,28.981400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,28.981400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,28.346400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.471400,0.000000,28.981400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,28.346400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,27.076400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.106400,0.000000,27.076400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,27.076400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,26.441400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.471400,0.000000,26.441400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,26.441400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,25.806400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.471400,0.000000,26.441400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,25.806400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,24.536400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.106400,0.000000,24.536400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,24.536400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,23.901400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.471400,0.000000,23.901400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,23.901400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,23.266400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.471400,0.000000,23.901400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,23.266400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,21.996400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.106400,0.000000,21.996400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,21.996400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,21.361400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.471400,0.000000,21.361400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,21.361400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,20.726400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.471400,0.000000,21.361400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,20.726400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,19.456400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.106400,0.000000,19.456400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,19.456400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,18.821400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.471400,0.000000,18.821400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,26.441400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,26.441400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.661400,0.000000,26.441400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,23.901400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,23.901400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.661400,0.000000,23.901400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,21.361400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,21.361400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.661400,0.000000,21.361400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,18.821400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,18.821400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.661400,0.000000,18.821400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,20.726400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,19.456400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.026400,0.000000,19.456400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,23.266400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,21.996400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.026400,0.000000,21.996400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,25.806400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,24.536400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.026400,0.000000,24.536400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,28.346400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,27.076400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.026400,0.000000,27.076400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,18.821400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,18.186400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.026400,0.000000,18.186400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,16.916400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,16.281400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<8.026400,0.000000,16.916400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,18.821400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,18.186400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.471400,0.000000,18.821400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,18.186400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,16.916400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.106400,0.000000,16.916400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.106400,0.000000,16.916400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,16.281400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.471400,0.000000,16.281400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.471400,0.000000,16.281400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.661400,0.000000,16.281400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.661400,0.000000,16.281400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,18.186400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.026400,0.000000,16.916400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.026400,0.000000,16.916400> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<9.296400,0.000000,27.711400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<11.836400,0.000000,27.711400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<11.836400,0.000000,25.171400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<9.296400,0.000000,25.171400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<11.836400,0.000000,22.631400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<9.296400,0.000000,22.631400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<11.836400,0.000000,20.091400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<9.296400,0.000000,20.091400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<11.836400,0.000000,17.551400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<9.296400,0.000000,17.551400>}
//JP2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.131200,0.000000,62.026800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.401200,0.000000,62.026800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.131200,0.000000,62.026800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.401200,0.000000,62.026800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.036200,0.000000,61.391800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<60.401200,0.000000,62.026800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.036200,0.000000,61.391800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.036200,0.000000,60.121800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<61.036200,0.000000,60.121800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.036200,0.000000,60.121800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.401200,0.000000,59.486800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<60.401200,0.000000,59.486800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.496200,0.000000,61.391800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.496200,0.000000,60.121800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.496200,0.000000,60.121800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.131200,0.000000,62.026800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.496200,0.000000,61.391800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.496200,0.000000,61.391800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.496200,0.000000,60.121800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.131200,0.000000,59.486800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<58.496200,0.000000,60.121800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.401200,0.000000,59.486800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.131200,0.000000,59.486800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.131200,0.000000,59.486800> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<59.766200,0.000000,60.756800>}
//JP3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.291800,0.000000,9.321800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.561800,0.000000,9.321800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.291800,0.000000,9.321800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.561800,0.000000,9.321800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.196800,0.000000,8.686800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<151.561800,0.000000,9.321800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.196800,0.000000,8.686800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.196800,0.000000,7.416800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<152.196800,0.000000,7.416800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.196800,0.000000,7.416800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.561800,0.000000,6.781800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<151.561800,0.000000,6.781800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.656800,0.000000,8.686800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.656800,0.000000,7.416800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<149.656800,0.000000,7.416800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.291800,0.000000,9.321800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.656800,0.000000,8.686800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<149.656800,0.000000,8.686800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<149.656800,0.000000,7.416800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.291800,0.000000,6.781800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<149.656800,0.000000,7.416800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.561800,0.000000,6.781800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.291800,0.000000,6.781800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.291800,0.000000,6.781800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.196800,0.000000,8.686800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.831800,0.000000,9.321800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<152.196800,0.000000,8.686800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.831800,0.000000,9.321800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.101800,0.000000,9.321800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<152.831800,0.000000,9.321800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.101800,0.000000,9.321800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.736800,0.000000,8.686800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<154.101800,0.000000,9.321800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.736800,0.000000,8.686800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.736800,0.000000,7.416800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.736800,0.000000,7.416800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.736800,0.000000,7.416800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.101800,0.000000,6.781800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<154.101800,0.000000,6.781800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.101800,0.000000,6.781800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.831800,0.000000,6.781800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<152.831800,0.000000,6.781800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.831800,0.000000,6.781800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<152.196800,0.000000,7.416800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<152.196800,0.000000,7.416800> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<150.926800,0.000000,8.051800>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<153.466800,0.000000,8.051800>}
//JP4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.198200,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.928200,0.000000,7.620000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.928200,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.928200,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.293200,0.000000,8.255000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<85.293200,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.293200,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.293200,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<85.293200,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.293200,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.928200,0.000000,10.160000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<85.293200,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.833200,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.833200,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<87.833200,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.198200,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.833200,0.000000,8.255000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<87.198200,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.833200,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.198200,0.000000,10.160000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<87.198200,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.928200,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<87.198200,0.000000,10.160000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<85.928200,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.293200,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.658200,0.000000,7.620000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<84.658200,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.658200,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.388200,0.000000,7.620000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.388200,0.000000,7.620000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.388200,0.000000,7.620000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.753200,0.000000,8.255000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<82.753200,0.000000,8.255000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.753200,0.000000,8.255000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.753200,0.000000,9.525000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<82.753200,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<82.753200,0.000000,9.525000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.388200,0.000000,10.160000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<82.753200,0.000000,9.525000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.388200,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.658200,0.000000,10.160000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<83.388200,0.000000,10.160000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<84.658200,0.000000,10.160000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<85.293200,0.000000,9.525000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<84.658200,0.000000,10.160000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<86.563200,0.000000,8.890000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<84.023200,0.000000,8.890000>}
//JP5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.707400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.437400,0.000000,7.518400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.437400,0.000000,7.518400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.437400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.802400,0.000000,8.153400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<120.802400,0.000000,8.153400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.802400,0.000000,8.153400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.802400,0.000000,9.423400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<120.802400,0.000000,9.423400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.802400,0.000000,9.423400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.437400,0.000000,10.058400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<120.802400,0.000000,9.423400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.342400,0.000000,8.153400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.342400,0.000000,9.423400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<123.342400,0.000000,9.423400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.707400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.342400,0.000000,8.153400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<122.707400,0.000000,7.518400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<123.342400,0.000000,9.423400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.707400,0.000000,10.058400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<122.707400,0.000000,10.058400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.437400,0.000000,10.058400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.707400,0.000000,10.058400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.437400,0.000000,10.058400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.802400,0.000000,8.153400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.167400,0.000000,7.518400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<120.167400,0.000000,7.518400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.167400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.897400,0.000000,7.518400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<118.897400,0.000000,7.518400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.897400,0.000000,7.518400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.262400,0.000000,8.153400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<118.262400,0.000000,8.153400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.262400,0.000000,8.153400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.262400,0.000000,9.423400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<118.262400,0.000000,9.423400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.262400,0.000000,9.423400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.897400,0.000000,10.058400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<118.262400,0.000000,9.423400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<118.897400,0.000000,10.058400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.167400,0.000000,10.058400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<118.897400,0.000000,10.058400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.167400,0.000000,10.058400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<120.802400,0.000000,9.423400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<120.167400,0.000000,10.058400> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<122.072400,0.000000,8.788400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<119.532400,0.000000,8.788400>}
//JP6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.692800,0.000000,7.670800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.422800,0.000000,7.670800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.422800,0.000000,7.670800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.422800,0.000000,7.670800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.787800,0.000000,8.305800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<54.787800,0.000000,8.305800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.787800,0.000000,8.305800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.787800,0.000000,9.575800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<54.787800,0.000000,9.575800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.787800,0.000000,9.575800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.422800,0.000000,10.210800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<54.787800,0.000000,9.575800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.327800,0.000000,8.305800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.327800,0.000000,9.575800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<57.327800,0.000000,9.575800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.692800,0.000000,7.670800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.327800,0.000000,8.305800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<56.692800,0.000000,7.670800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.327800,0.000000,9.575800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.692800,0.000000,10.210800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<56.692800,0.000000,10.210800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.422800,0.000000,10.210800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<56.692800,0.000000,10.210800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.422800,0.000000,10.210800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.787800,0.000000,8.305800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.152800,0.000000,7.670800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<54.152800,0.000000,7.670800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.152800,0.000000,7.670800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.882800,0.000000,7.670800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.882800,0.000000,7.670800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.882800,0.000000,7.670800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.247800,0.000000,8.305800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<52.247800,0.000000,8.305800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.247800,0.000000,8.305800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.247800,0.000000,9.575800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<52.247800,0.000000,9.575800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.247800,0.000000,9.575800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.882800,0.000000,10.210800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<52.247800,0.000000,9.575800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.882800,0.000000,10.210800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.152800,0.000000,10.210800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<52.882800,0.000000,10.210800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.152800,0.000000,10.210800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.787800,0.000000,9.575800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<54.152800,0.000000,10.210800> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<56.057800,0.000000,8.940800>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-180.000000,0> translate<53.517800,0.000000,8.940800>}
//JP7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.568400,0.000000,10.261600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.203400,0.000000,10.896600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<26.568400,0.000000,10.261600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.203400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.473400,0.000000,10.896600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.203400,0.000000,10.896600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.473400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.108400,0.000000,10.261600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<28.473400,0.000000,10.896600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.108400,0.000000,10.261600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.108400,0.000000,8.991600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.108400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.108400,0.000000,8.991600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.473400,0.000000,8.356600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<28.473400,0.000000,8.356600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.473400,0.000000,8.356600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.203400,0.000000,8.356600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<27.203400,0.000000,8.356600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.203400,0.000000,8.356600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.568400,0.000000,8.991600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<26.568400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.123400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.393400,0.000000,10.896600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.123400,0.000000,10.896600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.393400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.028400,0.000000,10.261600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<23.393400,0.000000,10.896600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.028400,0.000000,10.261600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.028400,0.000000,8.991600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.028400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.028400,0.000000,8.991600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.393400,0.000000,8.356600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<23.393400,0.000000,8.356600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.028400,0.000000,10.261600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.663400,0.000000,10.896600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<24.028400,0.000000,10.261600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.663400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.933400,0.000000,10.896600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.663400,0.000000,10.896600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.933400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.568400,0.000000,10.261600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<25.933400,0.000000,10.896600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.568400,0.000000,10.261600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.568400,0.000000,8.991600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.568400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.568400,0.000000,8.991600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.933400,0.000000,8.356600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<25.933400,0.000000,8.356600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.933400,0.000000,8.356600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.663400,0.000000,8.356600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<24.663400,0.000000,8.356600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.663400,0.000000,8.356600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.028400,0.000000,8.991600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<24.028400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.488400,0.000000,10.261600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.488400,0.000000,8.991600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<21.488400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.123400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.488400,0.000000,10.261600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<21.488400,0.000000,10.261600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.488400,0.000000,8.991600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.123400,0.000000,8.356600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<21.488400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.393400,0.000000,8.356600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.123400,0.000000,8.356600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.123400,0.000000,8.356600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.743400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.013400,0.000000,10.896600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.743400,0.000000,10.896600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.013400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.648400,0.000000,10.261600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<31.013400,0.000000,10.896600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.648400,0.000000,10.261600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.648400,0.000000,8.991600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<31.648400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.648400,0.000000,8.991600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.013400,0.000000,8.356600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<31.013400,0.000000,8.356600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.743400,0.000000,10.896600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.108400,0.000000,10.261600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<29.108400,0.000000,10.261600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.108400,0.000000,8.991600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.743400,0.000000,8.356600>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<29.108400,0.000000,8.991600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.013400,0.000000,8.356600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.743400,0.000000,8.356600>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.743400,0.000000,8.356600> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<27.838400,0.000000,9.626600>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<25.298400,0.000000,9.626600>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<22.758400,0.000000,9.626600>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<30.378400,0.000000,9.626600>}
//JP8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,16.281400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,15.646400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.051800,0.000000,15.646400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,14.376400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,13.741400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<8.051800,0.000000,14.376400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,13.741400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,13.106400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.051800,0.000000,13.106400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,11.836400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,11.201400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<8.051800,0.000000,11.836400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,16.281400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,16.281400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.686800,0.000000,16.281400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,16.281400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,15.646400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.496800,0.000000,16.281400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,15.646400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,14.376400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.131800,0.000000,14.376400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,14.376400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,13.741400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.496800,0.000000,13.741400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,13.741400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,13.106400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.496800,0.000000,13.741400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,13.106400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,11.836400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.131800,0.000000,11.836400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,11.836400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,11.201400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.496800,0.000000,11.201400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,13.741400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,13.741400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.686800,0.000000,13.741400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,11.201400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,11.201400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.686800,0.000000,11.201400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,13.106400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,11.836400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.051800,0.000000,11.836400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,15.646400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,14.376400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.051800,0.000000,14.376400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,11.201400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,10.566400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.051800,0.000000,10.566400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,9.296400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,8.661400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<8.051800,0.000000,9.296400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,11.201400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,10.566400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<12.496800,0.000000,11.201400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,10.566400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,9.296400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<13.131800,0.000000,9.296400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.131800,0.000000,9.296400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,8.661400>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<12.496800,0.000000,8.661400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.496800,0.000000,8.661400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.686800,0.000000,8.661400>}
box{<0,0,-0.076200><3.810000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.686800,0.000000,8.661400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,10.566400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.051800,0.000000,9.296400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<8.051800,0.000000,9.296400> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<9.321800,0.000000,15.011400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<11.861800,0.000000,15.011400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<11.861800,0.000000,12.471400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<9.321800,0.000000,12.471400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<11.861800,0.000000,9.931400>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<9.321800,0.000000,9.931400>}
//JP9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.232800,0.000000,59.486800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.502800,0.000000,59.486800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.232800,0.000000,59.486800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.502800,0.000000,59.486800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.137800,0.000000,58.851800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<60.502800,0.000000,59.486800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.137800,0.000000,58.851800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.137800,0.000000,57.581800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<61.137800,0.000000,57.581800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.137800,0.000000,57.581800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.502800,0.000000,56.946800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<60.502800,0.000000,56.946800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.597800,0.000000,58.851800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.597800,0.000000,57.581800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.597800,0.000000,57.581800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.232800,0.000000,59.486800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.597800,0.000000,58.851800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<58.597800,0.000000,58.851800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.597800,0.000000,57.581800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.232800,0.000000,56.946800>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<58.597800,0.000000,57.581800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.502800,0.000000,56.946800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.232800,0.000000,56.946800>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.232800,0.000000,56.946800> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-0.000000,0> translate<59.867800,0.000000,58.216800>}
//K1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,21.234400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,21.234400>}
box{<0,0,-0.076200><22.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<190.576200,0.000000,21.234400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,4.724400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,21.234400>}
box{<0,0,-0.076200><16.510000,0.036000,0.076200> rotate<0,90.000000,0> translate<213.182200,0.000000,21.234400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,4.724400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,4.724400>}
box{<0,0,-0.076200><22.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<190.576200,0.000000,4.724400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,21.234400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,4.724400>}
box{<0,0,-0.076200><16.510000,0.036000,0.076200> rotate<0,-90.000000,0> translate<190.576200,0.000000,4.724400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<197.561200,0.000000,18.948400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,18.948400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<197.561200,0.000000,18.948400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,18.948400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,13.614400>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<198.196200,0.000000,13.614400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,13.614400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<196.926200,0.000000,13.614400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<196.926200,0.000000,13.614400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,13.614400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,12.344400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<196.926200,0.000000,12.344400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,13.614400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<199.466200,0.000000,13.614400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,13.614400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,13.614400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<198.196200,0.000000,13.614400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<196.926200,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,12.344400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<196.926200,0.000000,12.344400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,7.010400>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<198.196200,0.000000,7.010400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,12.344400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<198.196200,0.000000,12.344400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,7.010400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<197.561200,0.000000,7.010400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<197.561200,0.000000,7.010400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<199.466200,0.000000,13.614400>}
box{<0,0,-0.076200><2.839806,0.036000,0.076200> rotate<0,-26.563298,0> translate<196.926200,0.000000,12.344400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<200.101200,0.000000,12.979400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<206.705200,0.000000,12.979400>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<200.101200,0.000000,12.979400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<206.705200,0.000000,12.979400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.340200,0.000000,13.614400>}
box{<0,0,-0.127000><0.898026,0.036000,0.127000> rotate<0,-44.997030,0> translate<206.705200,0.000000,12.979400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,16.713200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,13.614400>}
box{<0,0,-0.076200><3.098800,0.036000,0.076200> rotate<0,-90.000000,0> translate<207.340200,0.000000,13.614400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,9.220200>}
box{<0,0,-0.076200><3.124200,0.036000,0.076200> rotate<0,-90.000000,0> translate<207.340200,0.000000,9.220200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.340200,0.000000,13.614400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.670400,0.000000,13.919200>}
box{<0,0,-0.127000><0.449372,0.036000,0.127000> rotate<0,-42.706571,0> translate<207.340200,0.000000,13.614400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<195.275200,0.000000,12.979400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.291200,0.000000,12.979400>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<195.275200,0.000000,12.979400> }
//K2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,39.014400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,39.014400>}
box{<0,0,-0.076200><22.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<190.576200,0.000000,39.014400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,22.504400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,39.014400>}
box{<0,0,-0.076200><16.510000,0.036000,0.076200> rotate<0,90.000000,0> translate<213.182200,0.000000,39.014400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,22.504400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,22.504400>}
box{<0,0,-0.076200><22.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<190.576200,0.000000,22.504400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,39.014400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,22.504400>}
box{<0,0,-0.076200><16.510000,0.036000,0.076200> rotate<0,-90.000000,0> translate<190.576200,0.000000,22.504400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<197.561200,0.000000,36.728400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,36.728400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<197.561200,0.000000,36.728400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,36.728400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,31.394400>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<198.196200,0.000000,31.394400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,31.394400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<196.926200,0.000000,31.394400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<196.926200,0.000000,31.394400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,31.394400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,30.124400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<196.926200,0.000000,30.124400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,31.394400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<199.466200,0.000000,31.394400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,31.394400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,31.394400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<198.196200,0.000000,31.394400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<196.926200,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,30.124400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<196.926200,0.000000,30.124400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,24.790400>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<198.196200,0.000000,24.790400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,30.124400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<198.196200,0.000000,30.124400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,24.790400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<197.561200,0.000000,24.790400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<197.561200,0.000000,24.790400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<199.466200,0.000000,31.394400>}
box{<0,0,-0.076200><2.839806,0.036000,0.076200> rotate<0,-26.563298,0> translate<196.926200,0.000000,30.124400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<200.101200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<206.705200,0.000000,30.759400>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<200.101200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<206.705200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.340200,0.000000,31.394400>}
box{<0,0,-0.127000><0.898026,0.036000,0.127000> rotate<0,-44.997030,0> translate<206.705200,0.000000,30.759400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,34.493200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,31.394400>}
box{<0,0,-0.076200><3.098800,0.036000,0.076200> rotate<0,-90.000000,0> translate<207.340200,0.000000,31.394400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,30.124400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,27.000200>}
box{<0,0,-0.076200><3.124200,0.036000,0.076200> rotate<0,-90.000000,0> translate<207.340200,0.000000,27.000200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.340200,0.000000,31.394400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.670400,0.000000,31.699200>}
box{<0,0,-0.127000><0.449372,0.036000,0.127000> rotate<0,-42.706571,0> translate<207.340200,0.000000,31.394400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<195.275200,0.000000,30.759400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.291200,0.000000,30.759400>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<195.275200,0.000000,30.759400> }
//K3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,56.794400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,56.794400>}
box{<0,0,-0.076200><22.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<190.576200,0.000000,56.794400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,40.284400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,56.794400>}
box{<0,0,-0.076200><16.510000,0.036000,0.076200> rotate<0,90.000000,0> translate<213.182200,0.000000,56.794400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,40.284400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,40.284400>}
box{<0,0,-0.076200><22.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<190.576200,0.000000,40.284400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,56.794400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,40.284400>}
box{<0,0,-0.076200><16.510000,0.036000,0.076200> rotate<0,-90.000000,0> translate<190.576200,0.000000,40.284400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<197.561200,0.000000,54.508400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,54.508400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<197.561200,0.000000,54.508400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,54.508400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,49.174400>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<198.196200,0.000000,49.174400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,49.174400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<196.926200,0.000000,49.174400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<196.926200,0.000000,49.174400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,49.174400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,47.904400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<196.926200,0.000000,47.904400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,47.904400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,49.174400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<199.466200,0.000000,49.174400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,49.174400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,49.174400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<198.196200,0.000000,49.174400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<196.926200,0.000000,47.904400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,47.904400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<196.926200,0.000000,47.904400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,47.904400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,42.570400>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<198.196200,0.000000,42.570400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,47.904400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,47.904400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<198.196200,0.000000,47.904400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,42.570400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<197.561200,0.000000,42.570400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<197.561200,0.000000,42.570400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,47.904400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<199.466200,0.000000,49.174400>}
box{<0,0,-0.076200><2.839806,0.036000,0.076200> rotate<0,-26.563298,0> translate<196.926200,0.000000,47.904400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<200.101200,0.000000,48.539400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<206.705200,0.000000,48.539400>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<200.101200,0.000000,48.539400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<206.705200,0.000000,48.539400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.340200,0.000000,49.174400>}
box{<0,0,-0.127000><0.898026,0.036000,0.127000> rotate<0,-44.997030,0> translate<206.705200,0.000000,48.539400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,52.273200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,49.174400>}
box{<0,0,-0.076200><3.098800,0.036000,0.076200> rotate<0,-90.000000,0> translate<207.340200,0.000000,49.174400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,47.904400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,44.780200>}
box{<0,0,-0.076200><3.124200,0.036000,0.076200> rotate<0,-90.000000,0> translate<207.340200,0.000000,44.780200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.340200,0.000000,49.174400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.670400,0.000000,49.479200>}
box{<0,0,-0.127000><0.449372,0.036000,0.127000> rotate<0,-42.706571,0> translate<207.340200,0.000000,49.174400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<195.275200,0.000000,48.539400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.291200,0.000000,48.539400>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<195.275200,0.000000,48.539400> }
//K4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,74.574400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,74.574400>}
box{<0,0,-0.076200><22.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<190.576200,0.000000,74.574400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,58.064400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,74.574400>}
box{<0,0,-0.076200><16.510000,0.036000,0.076200> rotate<0,90.000000,0> translate<213.182200,0.000000,74.574400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<213.182200,0.000000,58.064400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,58.064400>}
box{<0,0,-0.076200><22.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<190.576200,0.000000,58.064400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,74.574400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<190.576200,0.000000,58.064400>}
box{<0,0,-0.076200><16.510000,0.036000,0.076200> rotate<0,-90.000000,0> translate<190.576200,0.000000,58.064400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<197.561200,0.000000,72.288400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,72.288400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<197.561200,0.000000,72.288400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,72.288400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,66.954400>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<198.196200,0.000000,66.954400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,66.954400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<196.926200,0.000000,66.954400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<196.926200,0.000000,66.954400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,66.954400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,65.684400>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<196.926200,0.000000,65.684400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,65.684400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,66.954400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,90.000000,0> translate<199.466200,0.000000,66.954400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,66.954400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,66.954400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<198.196200,0.000000,66.954400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<196.926200,0.000000,65.684400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,65.684400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<196.926200,0.000000,65.684400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,65.684400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,60.350400>}
box{<0,0,-0.076200><5.334000,0.036000,0.076200> rotate<0,-90.000000,0> translate<198.196200,0.000000,60.350400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<198.196200,0.000000,65.684400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<199.466200,0.000000,65.684400>}
box{<0,0,-0.127000><1.270000,0.036000,0.127000> rotate<0,0.000000,0> translate<198.196200,0.000000,65.684400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<198.196200,0.000000,60.350400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<197.561200,0.000000,60.350400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<197.561200,0.000000,60.350400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.926200,0.000000,65.684400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<199.466200,0.000000,66.954400>}
box{<0,0,-0.076200><2.839806,0.036000,0.076200> rotate<0,-26.563298,0> translate<196.926200,0.000000,65.684400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<200.101200,0.000000,66.319400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<206.705200,0.000000,66.319400>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<200.101200,0.000000,66.319400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<206.705200,0.000000,66.319400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.340200,0.000000,66.954400>}
box{<0,0,-0.127000><0.898026,0.036000,0.127000> rotate<0,-44.997030,0> translate<206.705200,0.000000,66.319400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,70.053200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,66.954400>}
box{<0,0,-0.076200><3.098800,0.036000,0.076200> rotate<0,-90.000000,0> translate<207.340200,0.000000,66.954400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,65.684400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<207.340200,0.000000,62.560200>}
box{<0,0,-0.076200><3.124200,0.036000,0.076200> rotate<0,-90.000000,0> translate<207.340200,0.000000,62.560200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.340200,0.000000,66.954400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<207.670400,0.000000,67.259200>}
box{<0,0,-0.127000><0.449372,0.036000,0.127000> rotate<0,-42.706571,0> translate<207.340200,0.000000,66.954400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<195.275200,0.000000,66.319400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<196.291200,0.000000,66.319400>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<195.275200,0.000000,66.319400> }
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.739800,0.000000,69.418200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.549800,0.000000,69.418200>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<51.739800,0.000000,69.418200> }
object{ARC(3.175000,0.254000,306.869897,593.130103,0.036000) translate<53.644800,0.000000,71.958200>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<53.644800,0.000000,71.958200>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<53.644800,0.000000,71.958200>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<53.644800,0.000000,71.958200>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<53.644800,0.000000,71.958200>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<53.644800,0.000000,71.958200>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<53.644800,0.000000,71.958200>}
difference{
cylinder{<53.644800,0,71.958200><53.644800,0.036000,71.958200>2.616200 translate<0,0.000000,0>}
cylinder{<53.644800,-0.1,71.958200><53.644800,0.135000,71.958200>2.463800 translate<0,0.000000,0>}}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<181.940200,0.000000,19.837400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<178.130200,0.000000,19.837400>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<178.130200,0.000000,19.837400> }
object{ARC(3.175000,0.254000,126.869898,413.130102,0.036000) translate<180.035200,0.000000,17.297400>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<180.035200,0.000000,17.297400>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<180.035200,0.000000,17.297400>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<180.035200,0.000000,17.297400>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<180.035200,0.000000,17.297400>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<180.035200,0.000000,17.297400>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<180.035200,0.000000,17.297400>}
difference{
cylinder{<180.035200,0,17.297400><180.035200,0.036000,17.297400>2.616200 translate<0,0.000000,0>}
cylinder{<180.035200,-0.1,17.297400><180.035200,0.135000,17.297400>2.463800 translate<0,0.000000,0>}}
//LED3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<181.940200,0.000000,37.871400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<178.130200,0.000000,37.871400>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<178.130200,0.000000,37.871400> }
object{ARC(3.175000,0.254000,126.869897,413.130103,0.036000) translate<180.035200,0.000000,35.331400>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<180.035200,0.000000,35.331400>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<180.035200,0.000000,35.331400>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<180.035200,0.000000,35.331400>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<180.035200,0.000000,35.331400>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<180.035200,0.000000,35.331400>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<180.035200,0.000000,35.331400>}
difference{
cylinder{<180.035200,0,35.331400><180.035200,0.036000,35.331400>2.616200 translate<0,0.000000,0>}
cylinder{<180.035200,-0.1,35.331400><180.035200,0.135000,35.331400>2.463800 translate<0,0.000000,0>}}
//LED4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<182.194200,0.000000,55.905400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<178.384200,0.000000,55.905400>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<178.384200,0.000000,55.905400> }
object{ARC(3.175000,0.254000,126.869897,413.130103,0.036000) translate<180.289200,0.000000,53.365400>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<180.289200,0.000000,53.365400>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<180.289200,0.000000,53.365400>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<180.289200,0.000000,53.365400>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<180.289200,0.000000,53.365400>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<180.289200,0.000000,53.365400>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<180.289200,0.000000,53.365400>}
difference{
cylinder{<180.289200,0,53.365400><180.289200,0.036000,53.365400>2.616200 translate<0,0.000000,0>}
cylinder{<180.289200,-0.1,53.365400><180.289200,0.135000,53.365400>2.463800 translate<0,0.000000,0>}}
//LED5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<182.448200,0.000000,73.685400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<178.638200,0.000000,73.685400>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<178.638200,0.000000,73.685400> }
object{ARC(3.175000,0.254000,126.869897,413.130103,0.036000) translate<180.543200,0.000000,71.145400>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<180.543200,0.000000,71.145400>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<180.543200,0.000000,71.145400>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<180.543200,0.000000,71.145400>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<180.543200,0.000000,71.145400>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<180.543200,0.000000,71.145400>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<180.543200,0.000000,71.145400>}
difference{
cylinder{<180.543200,0,71.145400><180.543200,0.036000,71.145400>2.616200 translate<0,0.000000,0>}
cylinder{<180.543200,-0.1,71.145400><180.543200,0.135000,71.145400>2.463800 translate<0,0.000000,0>}}
//LED6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.892200,0.000000,56.667400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.702200,0.000000,56.667400>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<51.892200,0.000000,56.667400> }
object{ARC(3.175000,0.254000,306.869897,593.130103,0.036000) translate<53.797200,0.000000,59.207400>}
object{ARC(1.143000,0.152400,0.000000,90.000000,0.036000) translate<53.797200,0.000000,59.207400>}
object{ARC(1.143000,0.152400,180.000000,270.000000,0.036000) translate<53.797200,0.000000,59.207400>}
object{ARC(1.651000,0.152400,0.000000,90.000000,0.036000) translate<53.797200,0.000000,59.207400>}
object{ARC(1.651000,0.152400,180.000000,270.000000,0.036000) translate<53.797200,0.000000,59.207400>}
object{ARC(2.159000,0.152400,0.000000,90.000000,0.036000) translate<53.797200,0.000000,59.207400>}
object{ARC(2.159000,0.152400,180.000000,270.000000,0.036000) translate<53.797200,0.000000,59.207400>}
difference{
cylinder{<53.797200,0,59.207400><53.797200,0.036000,59.207400>2.616200 translate<0,0.000000,0>}
cylinder{<53.797200,-0.1,59.207400><53.797200,0.135000,59.207400>2.463800 translate<0,0.000000,0>}}
//Q1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<142.798800,0.000000,33.807400>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<136.956800,0.000000,33.807400>}
box{<0,0,-0.203200><5.842000,0.036000,0.203200> rotate<0,0.000000,0> translate<136.956800,0.000000,33.807400> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<142.798800,0.000000,29.235400>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<136.956800,0.000000,29.235400>}
box{<0,0,-0.203200><5.842000,0.036000,0.203200> rotate<0,0.000000,0> translate<136.956800,0.000000,29.235400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.798800,0.000000,33.299400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.956800,0.000000,33.299400>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.956800,0.000000,33.299400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<136.956800,0.000000,29.743400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<142.798800,0.000000,29.743400>}
box{<0,0,-0.076200><5.842000,0.036000,0.076200> rotate<0,0.000000,0> translate<136.956800,0.000000,29.743400> }
object{ARC(1.778000,0.152400,90.000000,270.000000,0.036000) translate<136.956800,0.000000,31.521400>}
object{ARC(2.286000,0.406400,90.000000,270.000000,0.036000) translate<136.956800,0.000000,31.521400>}
object{ARC(2.286000,0.406400,270.000000,450.000000,0.036000) translate<142.798800,0.000000,31.521400>}
object{ARC(1.778000,0.152400,270.000000,450.000000,0.036000) translate<142.798800,0.000000,31.521400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.131800,0.000000,30.632400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.623800,0.000000,30.632400>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.623800,0.000000,30.632400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.623800,0.000000,30.632400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.623800,0.000000,32.410400>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.623800,0.000000,32.410400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.623800,0.000000,32.410400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.131800,0.000000,32.410400>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.623800,0.000000,32.410400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.131800,0.000000,32.410400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.131800,0.000000,30.632400>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<140.131800,0.000000,30.632400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.242800,0.000000,30.632400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.242800,0.000000,31.521400>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.242800,0.000000,31.521400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.242800,0.000000,31.521400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.242800,0.000000,32.410400>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.242800,0.000000,32.410400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.512800,0.000000,30.632400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.512800,0.000000,31.521400>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<140.512800,0.000000,31.521400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.512800,0.000000,31.521400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.512800,0.000000,32.410400>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,90.000000,0> translate<140.512800,0.000000,32.410400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.242800,0.000000,31.521400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.607800,0.000000,31.521400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<138.607800,0.000000,31.521400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<140.512800,0.000000,31.521400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<141.147800,0.000000,31.521400>}
box{<0,0,-0.076200><0.635000,0.036000,0.076200> rotate<0,0.000000,0> translate<140.512800,0.000000,31.521400> }
//Q2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.484400,0.000000,29.286200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.690400,0.000000,29.286200>}
box{<0,0,-0.076200><2.794000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.690400,0.000000,29.286200> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<113.817400,0.000000,21.285200>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<116.357400,0.000000,21.285200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.357400,0.000000,21.031200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.817400,0.000000,21.031200>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.817400,0.000000,21.031200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.690400,0.000000,29.286200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.690400,0.000000,28.905200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<113.690400,0.000000,28.905200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.563400,0.000000,28.905200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.690400,0.000000,28.905200>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.563400,0.000000,28.905200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.563400,0.000000,28.905200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.563400,0.000000,21.285200>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,-90.000000,0> translate<113.563400,0.000000,21.285200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.484400,0.000000,29.286200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.484400,0.000000,28.905200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<116.484400,0.000000,28.905200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.611400,0.000000,28.905200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.484400,0.000000,28.905200>}
box{<0,0,-0.076200><0.127000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.484400,0.000000,28.905200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.611400,0.000000,28.905200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.611400,0.000000,21.285200>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,-90.000000,0> translate<116.611400,0.000000,21.285200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.690400,0.000000,28.905200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.484400,0.000000,28.905200>}
box{<0,0,-0.076200><2.794000,0.036000,0.076200> rotate<0,0.000000,0> translate<113.690400,0.000000,28.905200> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<114.528600,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<114.579400,0.000000,30.175200>}
box{<0,0,-0.203200><0.071842,0.036000,0.203200> rotate<0,44.997030,0> translate<114.528600,0.000000,30.226000> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<114.579400,0.000000,30.175200>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<114.579400,0.000000,29.794200>}
box{<0,0,-0.203200><0.381000,0.036000,0.203200> rotate<0,-90.000000,0> translate<114.579400,0.000000,29.794200> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<115.595400,0.000000,30.175200>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<115.595400,0.000000,29.921200>}
box{<0,0,-0.203200><0.254000,0.036000,0.203200> rotate<0,-90.000000,0> translate<115.595400,0.000000,29.921200> }
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<115.646200,0.000000,30.226000>}
cylinder{<0,0,0><0,0.036000,0>0.203200 translate<115.595400,0.000000,30.175200>}
box{<0,0,-0.203200><0.071842,0.036000,0.203200> rotate<0,-44.997030,0> translate<115.595400,0.000000,30.175200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.452400,0.000000,30.302200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<113.817400,0.000000,30.937200>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<113.817400,0.000000,30.937200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.722400,0.000000,30.302200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.357400,0.000000,30.937200>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<115.722400,0.000000,30.302200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.849400,0.000000,25.349200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.849400,0.000000,25.730200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<115.849400,0.000000,25.730200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.325400,0.000000,25.730200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.849400,0.000000,25.730200>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<114.325400,0.000000,25.730200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.325400,0.000000,25.730200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.325400,0.000000,25.349200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<114.325400,0.000000,25.349200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.849400,0.000000,25.349200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.325400,0.000000,25.349200>}
box{<0,0,-0.076200><1.524000,0.036000,0.076200> rotate<0,0.000000,0> translate<114.325400,0.000000,25.349200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.849400,0.000000,24.968200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.087400,0.000000,24.968200>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<115.087400,0.000000,24.968200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.849400,0.000000,26.111200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.087400,0.000000,26.111200>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<115.087400,0.000000,26.111200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.087400,0.000000,26.111200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.087400,0.000000,26.619200>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,90.000000,0> translate<115.087400,0.000000,26.619200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.087400,0.000000,26.111200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.325400,0.000000,26.111200>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<114.325400,0.000000,26.111200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.087400,0.000000,24.968200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.087400,0.000000,24.460200>}
box{<0,0,-0.076200><0.508000,0.036000,0.076200> rotate<0,-90.000000,0> translate<115.087400,0.000000,24.460200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<115.087400,0.000000,24.968200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<114.325400,0.000000,24.968200>}
box{<0,0,-0.076200><0.762000,0.036000,0.076200> rotate<0,0.000000,0> translate<114.325400,0.000000,24.968200> }
box{<-0.203200,0,-0.292100><0.203200,0.036000,0.292100> rotate<0,-180.000000,0> translate<114.579400,0.000000,29.629100>}
box{<-0.203200,0,-0.292100><0.203200,0.036000,0.292100> rotate<0,-180.000000,0> translate<115.595400,0.000000,29.629100>}
//Q3 silk screen
object{ARC(2.667022,0.127000,95.463924,128.244924,0.036000) translate<149.301150,0.000000,68.376797>}
object{ARC(2.667025,0.127000,17.146908,95.465408,0.036000) translate<149.301219,0.000000,68.376800>}
object{ARC(2.666953,0.127000,231.752892,342.852892,0.036000) translate<149.301191,0.000000,68.376788>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<147.650200,0.000000,70.471300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<147.650200,0.000000,66.282300>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,-90.000000,0> translate<147.650200,0.000000,66.282300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,70.630500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,68.663100>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<149.047200,0.000000,68.663100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,71.031700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,70.630500>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<149.047200,0.000000,70.630500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,68.663100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,68.090500>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,-90.000000,0> translate<149.047200,0.000000,68.090500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,66.123100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,65.721900>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<149.047200,0.000000,65.721900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,68.090500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<149.047200,0.000000,66.123100>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<149.047200,0.000000,66.123100> }
object{ARC(2.667044,0.127000,342.853200,377.146800,0.036000) translate<149.301200,0.000000,68.376800>}
//Q4 silk screen
object{ARC(2.667022,0.127000,95.463924,128.244924,0.036000) translate<30.098950,0.000000,39.242997>}
object{ARC(2.667025,0.127000,17.146908,95.465408,0.036000) translate<30.099019,0.000000,39.243000>}
object{ARC(2.666953,0.127000,231.752892,342.852892,0.036000) translate<30.098991,0.000000,39.242988>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.448000,0.000000,41.337500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.448000,0.000000,37.148500>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,-90.000000,0> translate<28.448000,0.000000,37.148500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,41.496700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,39.529300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,39.529300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,41.897900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,41.496700>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,41.496700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,39.529300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,38.956700>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,38.956700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,36.989300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,36.588100>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,36.588100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,38.956700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,36.989300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,36.989300> }
object{ARC(2.667044,0.127000,342.853200,377.146800,0.036000) translate<30.099000,0.000000,39.243000>}
//Q5 silk screen
object{ARC(2.667022,0.127000,5.463924,38.244924,0.036000) translate<180.035197,0.000000,10.693450>}
object{ARC(2.667025,0.127000,287.146908,365.465408,0.036000) translate<180.035200,0.000000,10.693381>}
object{ARC(2.666953,0.127000,141.752892,252.852892,0.036000) translate<180.035188,0.000000,10.693409>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.129700,0.000000,12.344400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<177.940700,0.000000,12.344400>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,0.000000,0> translate<177.940700,0.000000,12.344400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.288900,0.000000,10.947400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.321500,0.000000,10.947400>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,0.000000,0> translate<180.321500,0.000000,10.947400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.690100,0.000000,10.947400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.288900,0.000000,10.947400>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,0.000000,0> translate<182.288900,0.000000,10.947400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.321500,0.000000,10.947400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<179.748900,0.000000,10.947400>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,0.000000,0> translate<179.748900,0.000000,10.947400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<177.781500,0.000000,10.947400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<177.380300,0.000000,10.947400>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,0.000000,0> translate<177.380300,0.000000,10.947400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<179.748900,0.000000,10.947400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<177.781500,0.000000,10.947400>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,0.000000,0> translate<177.781500,0.000000,10.947400> }
object{ARC(2.667044,0.127000,252.853200,287.146800,0.036000) translate<180.035200,0.000000,10.693400>}
//Q6 silk screen
object{ARC(2.667022,0.127000,95.463924,128.244924,0.036000) translate<30.098950,0.000000,49.402997>}
object{ARC(2.667025,0.127000,17.146908,95.465408,0.036000) translate<30.099019,0.000000,49.403000>}
object{ARC(2.666953,0.127000,231.752892,342.852892,0.036000) translate<30.098991,0.000000,49.402988>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.448000,0.000000,51.497500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.448000,0.000000,47.308500>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,-90.000000,0> translate<28.448000,0.000000,47.308500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,51.656700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,49.689300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,49.689300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,52.057900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,51.656700>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,51.656700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,49.689300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,49.116700>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,49.116700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,47.149300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,46.748100>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,46.748100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,49.116700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,47.149300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,47.149300> }
object{ARC(2.667044,0.127000,342.853200,377.146800,0.036000) translate<30.099000,0.000000,49.403000>}
//Q7 silk screen
object{ARC(2.667022,0.127000,5.463924,38.244924,0.036000) translate<180.289197,0.000000,29.235450>}
object{ARC(2.667025,0.127000,287.146908,365.465408,0.036000) translate<180.289200,0.000000,29.235381>}
object{ARC(2.666953,0.127000,141.752892,252.852892,0.036000) translate<180.289187,0.000000,29.235409>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.383700,0.000000,30.886400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.194700,0.000000,30.886400>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,0.000000,0> translate<178.194700,0.000000,30.886400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.542900,0.000000,29.489400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.575500,0.000000,29.489400>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,0.000000,0> translate<180.575500,0.000000,29.489400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.944100,0.000000,29.489400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.542900,0.000000,29.489400>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,0.000000,0> translate<182.542900,0.000000,29.489400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.575500,0.000000,29.489400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.002900,0.000000,29.489400>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,0.000000,0> translate<180.002900,0.000000,29.489400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.035500,0.000000,29.489400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<177.634300,0.000000,29.489400>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,0.000000,0> translate<177.634300,0.000000,29.489400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.002900,0.000000,29.489400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.035500,0.000000,29.489400>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,0.000000,0> translate<178.035500,0.000000,29.489400> }
object{ARC(2.667044,0.127000,252.853200,287.146800,0.036000) translate<180.289200,0.000000,29.235400>}
//Q8 silk screen
object{ARC(2.667022,0.127000,95.463924,128.244924,0.036000) translate<30.098950,0.000000,60.832997>}
object{ARC(2.667025,0.127000,17.146908,95.465408,0.036000) translate<30.099019,0.000000,60.833000>}
object{ARC(2.666953,0.127000,231.752892,342.852892,0.036000) translate<30.098991,0.000000,60.832988>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.448000,0.000000,62.927500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.448000,0.000000,58.738500>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,-90.000000,0> translate<28.448000,0.000000,58.738500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,63.086700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,61.119300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,61.119300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,63.487900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,63.086700>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,63.086700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,61.119300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,60.546700>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,60.546700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,58.579300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,58.178100>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,58.178100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,60.546700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,58.579300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,58.579300> }
object{ARC(2.667044,0.127000,342.853200,377.146800,0.036000) translate<30.099000,0.000000,60.833000>}
//Q9 silk screen
object{ARC(2.667022,0.127000,5.463924,38.244924,0.036000) translate<180.289197,0.000000,46.253450>}
object{ARC(2.667025,0.127000,287.146908,365.465408,0.036000) translate<180.289200,0.000000,46.253381>}
object{ARC(2.666953,0.127000,141.752892,252.852892,0.036000) translate<180.289187,0.000000,46.253409>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.383700,0.000000,47.904400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.194700,0.000000,47.904400>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,0.000000,0> translate<178.194700,0.000000,47.904400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.542900,0.000000,46.507400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.575500,0.000000,46.507400>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,0.000000,0> translate<180.575500,0.000000,46.507400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.944100,0.000000,46.507400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.542900,0.000000,46.507400>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,0.000000,0> translate<182.542900,0.000000,46.507400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.575500,0.000000,46.507400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.002900,0.000000,46.507400>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,0.000000,0> translate<180.002900,0.000000,46.507400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.035500,0.000000,46.507400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<177.634300,0.000000,46.507400>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,0.000000,0> translate<177.634300,0.000000,46.507400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.002900,0.000000,46.507400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.035500,0.000000,46.507400>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,0.000000,0> translate<178.035500,0.000000,46.507400> }
object{ARC(2.667044,0.127000,252.853200,287.146800,0.036000) translate<180.289200,0.000000,46.253400>}
//Q10 silk screen
object{ARC(2.667022,0.127000,95.463924,128.244924,0.036000) translate<30.098950,0.000000,69.722997>}
object{ARC(2.667025,0.127000,17.146908,95.465408,0.036000) translate<30.099019,0.000000,69.723000>}
object{ARC(2.666953,0.127000,231.752892,342.852892,0.036000) translate<30.098991,0.000000,69.722988>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.448000,0.000000,71.817500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<28.448000,0.000000,67.628500>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,-90.000000,0> translate<28.448000,0.000000,67.628500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,71.976700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,70.009300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,70.009300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,72.377900>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,71.976700>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,71.976700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,70.009300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,69.436700>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,69.436700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,67.469300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,67.068100>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,67.068100> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,69.436700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<29.845000,0.000000,67.469300>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,-90.000000,0> translate<29.845000,0.000000,67.469300> }
object{ARC(2.667044,0.127000,342.853200,377.146800,0.036000) translate<30.099000,0.000000,69.723000>}
//Q11 silk screen
object{ARC(2.667022,0.127000,5.463924,38.244924,0.036000) translate<180.289197,0.000000,64.287450>}
object{ARC(2.667025,0.127000,287.146908,365.465408,0.036000) translate<180.289200,0.000000,64.287381>}
object{ARC(2.666953,0.127000,141.752892,252.852892,0.036000) translate<180.289187,0.000000,64.287409>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.383700,0.000000,65.938400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.194700,0.000000,65.938400>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,0.000000,0> translate<178.194700,0.000000,65.938400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.542900,0.000000,64.541400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.575500,0.000000,64.541400>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,0.000000,0> translate<180.575500,0.000000,64.541400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.944100,0.000000,64.541400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<182.542900,0.000000,64.541400>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,0.000000,0> translate<182.542900,0.000000,64.541400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.575500,0.000000,64.541400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.002900,0.000000,64.541400>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,0.000000,0> translate<180.002900,0.000000,64.541400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.035500,0.000000,64.541400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<177.634300,0.000000,64.541400>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,0.000000,0> translate<177.634300,0.000000,64.541400> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<180.002900,0.000000,64.541400>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<178.035500,0.000000,64.541400>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,0.000000,0> translate<178.035500,0.000000,64.541400> }
object{ARC(2.667044,0.127000,252.853200,287.146800,0.036000) translate<180.289200,0.000000,64.287400>}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<61.798200,0.000000,26.619200>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<60.782200,0.000000,26.619200>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<60.782200,0.000000,26.619200> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<51.638200,0.000000,26.619200>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<52.654200,0.000000,26.619200>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<51.638200,0.000000,26.619200> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<53.797200,0.000000,27.508200>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<53.797200,0.000000,25.730200>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<59.639200,0.000000,25.730200>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<59.639200,0.000000,27.508200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.543200,0.000000,25.730200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.543200,0.000000,27.508200>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<53.543200,0.000000,27.508200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.797200,0.000000,27.762200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.178200,0.000000,27.762200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.797200,0.000000,27.762200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.305200,0.000000,27.635200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.178200,0.000000,27.762200>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<54.178200,0.000000,27.762200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.797200,0.000000,25.476200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.178200,0.000000,25.476200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<53.797200,0.000000,25.476200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.305200,0.000000,25.603200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.178200,0.000000,25.476200>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<54.178200,0.000000,25.476200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.131200,0.000000,27.635200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.258200,0.000000,27.762200>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<59.131200,0.000000,27.635200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.131200,0.000000,27.635200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.305200,0.000000,27.635200>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.305200,0.000000,27.635200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.131200,0.000000,25.603200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.258200,0.000000,25.476200>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<59.131200,0.000000,25.603200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.131200,0.000000,25.603200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.305200,0.000000,25.603200>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.305200,0.000000,25.603200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.639200,0.000000,27.762200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.258200,0.000000,27.762200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.258200,0.000000,27.762200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.639200,0.000000,25.476200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.258200,0.000000,25.476200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<59.258200,0.000000,25.476200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.893200,0.000000,25.730200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<59.893200,0.000000,27.508200>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<59.893200,0.000000,27.508200> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<60.325000,0.000000,26.619200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<53.111400,0.000000,26.619200>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<64.719200,0.000000,73.279000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<64.719200,0.000000,72.263000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<64.719200,0.000000,72.263000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<64.719200,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<64.719200,0.000000,64.135000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<64.719200,0.000000,64.135000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<63.830200,0.000000,65.278000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<65.608200,0.000000,65.278000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<65.608200,0.000000,71.120000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<63.830200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.608200,0.000000,65.024000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.830200,0.000000,65.024000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.830200,0.000000,65.024000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.576200,0.000000,65.278000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.576200,0.000000,65.659000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<63.576200,0.000000,65.659000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.703200,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.576200,0.000000,65.659000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<63.576200,0.000000,65.659000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.862200,0.000000,65.278000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.862200,0.000000,65.659000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<65.862200,0.000000,65.659000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.735200,0.000000,65.786000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.862200,0.000000,65.659000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<65.735200,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.703200,0.000000,70.612000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.576200,0.000000,70.739000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<63.576200,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.703200,0.000000,70.612000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.703200,0.000000,65.786000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.703200,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.735200,0.000000,70.612000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.862200,0.000000,70.739000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<65.735200,0.000000,70.612000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.735200,0.000000,70.612000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.735200,0.000000,65.786000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.735200,0.000000,65.786000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.576200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.576200,0.000000,70.739000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.576200,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.862200,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.862200,0.000000,70.739000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.862200,0.000000,70.739000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.608200,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.830200,0.000000,71.374000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<63.830200,0.000000,71.374000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<64.719200,0.000000,71.805800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<64.719200,0.000000,64.592200>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<159.410400,0.000000,58.191400>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<158.394400,0.000000,58.191400>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<158.394400,0.000000,58.191400> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<149.250400,0.000000,58.191400>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<150.266400,0.000000,58.191400>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<149.250400,0.000000,58.191400> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<151.409400,0.000000,59.080400>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<151.409400,0.000000,57.302400>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<157.251400,0.000000,57.302400>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<157.251400,0.000000,59.080400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.155400,0.000000,57.302400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.155400,0.000000,59.080400>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<151.155400,0.000000,59.080400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.409400,0.000000,59.334400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.790400,0.000000,59.334400>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.409400,0.000000,59.334400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.917400,0.000000,59.207400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.790400,0.000000,59.334400>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<151.790400,0.000000,59.334400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.409400,0.000000,57.048400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.790400,0.000000,57.048400>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.409400,0.000000,57.048400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.917400,0.000000,57.175400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.790400,0.000000,57.048400>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<151.790400,0.000000,57.048400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.743400,0.000000,59.207400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.870400,0.000000,59.334400>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<156.743400,0.000000,59.207400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.743400,0.000000,59.207400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.917400,0.000000,59.207400>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.917400,0.000000,59.207400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.743400,0.000000,57.175400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.870400,0.000000,57.048400>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<156.743400,0.000000,57.175400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.743400,0.000000,57.175400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.917400,0.000000,57.175400>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.917400,0.000000,57.175400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.251400,0.000000,59.334400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.870400,0.000000,59.334400>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<156.870400,0.000000,59.334400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.251400,0.000000,57.048400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.870400,0.000000,57.048400>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<156.870400,0.000000,57.048400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.505400,0.000000,57.302400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<157.505400,0.000000,59.080400>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<157.505400,0.000000,59.080400> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<157.937200,0.000000,58.191400>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<150.723600,0.000000,58.191400>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<113.792000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<112.776000,0.000000,55.626000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<112.776000,0.000000,55.626000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<103.632000,0.000000,55.626000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<104.648000,0.000000,55.626000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<103.632000,0.000000,55.626000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<105.791000,0.000000,56.515000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<105.791000,0.000000,54.737000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<111.633000,0.000000,54.737000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<111.633000,0.000000,56.515000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.537000,0.000000,54.737000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.537000,0.000000,56.515000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.537000,0.000000,56.515000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,56.769000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.791000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.299000,0.000000,56.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,56.769000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<106.172000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.791000,0.000000,54.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,54.483000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.791000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.299000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.172000,0.000000,54.483000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<106.172000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,56.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.252000,0.000000,56.769000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<111.125000,0.000000,56.642000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,56.642000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.299000,0.000000,56.642000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.299000,0.000000,56.642000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.252000,0.000000,54.483000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<111.125000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.125000,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.299000,0.000000,54.610000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.299000,0.000000,54.610000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.633000,0.000000,56.769000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.252000,0.000000,56.769000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.252000,0.000000,56.769000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.633000,0.000000,54.483000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.252000,0.000000,54.483000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.252000,0.000000,54.483000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,54.737000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.887000,0.000000,56.515000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<111.887000,0.000000,56.515000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<112.318800,0.000000,55.626000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<105.105200,0.000000,55.626000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<113.944400,0.000000,51.739800>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<112.928400,0.000000,51.739800>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<112.928400,0.000000,51.739800> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<103.784400,0.000000,51.739800>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<104.800400,0.000000,51.739800>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<103.784400,0.000000,51.739800> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<105.943400,0.000000,52.628800>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<105.943400,0.000000,50.850800>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<111.785400,0.000000,50.850800>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<111.785400,0.000000,52.628800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.689400,0.000000,50.850800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.689400,0.000000,52.628800>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<105.689400,0.000000,52.628800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.943400,0.000000,52.882800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.324400,0.000000,52.882800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.943400,0.000000,52.882800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.451400,0.000000,52.755800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.324400,0.000000,52.882800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<106.324400,0.000000,52.882800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<105.943400,0.000000,50.596800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.324400,0.000000,50.596800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<105.943400,0.000000,50.596800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.451400,0.000000,50.723800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.324400,0.000000,50.596800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<106.324400,0.000000,50.596800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.277400,0.000000,52.755800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.404400,0.000000,52.882800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<111.277400,0.000000,52.755800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.277400,0.000000,52.755800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.451400,0.000000,52.755800>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.451400,0.000000,52.755800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.277400,0.000000,50.723800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.404400,0.000000,50.596800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<111.277400,0.000000,50.723800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.277400,0.000000,50.723800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<106.451400,0.000000,50.723800>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<106.451400,0.000000,50.723800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.785400,0.000000,52.882800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.404400,0.000000,52.882800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.404400,0.000000,52.882800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.785400,0.000000,50.596800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<111.404400,0.000000,50.596800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<111.404400,0.000000,50.596800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<112.039400,0.000000,50.850800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<112.039400,0.000000,52.628800>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<112.039400,0.000000,52.628800> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<112.471200,0.000000,51.739800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-0.000000,0> translate<105.257600,0.000000,51.739800>}
//R6 silk screen
difference{
cylinder{<53.695600,0,46.990000><53.695600,0.036000,46.990000>3.886200 translate<0,0.000000,0>}
cylinder{<53.695600,-0.1,46.990000><53.695600,0.135000,46.990000>3.733800 translate<0,0.000000,0>}}
difference{
cylinder{<53.695600,0,46.990000><53.695600,0.036000,46.990000>1.496100 translate<0,0.000000,0>}
cylinder{<53.695600,-0.1,46.990000><53.695600,0.135000,46.990000>1.343700 translate<0,0.000000,0>}}
box{<-1.016000,0,-0.254000><1.016000,0.036000,0.254000> rotate<0,-180.000000,0> translate<53.695600,0.000000,46.990000>}
box{<-0.254000,0,-1.016000><0.254000,0.036000,1.016000> rotate<0,-180.000000,0> translate<53.695600,0.000000,46.990000>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.363400,0.000000,48.158400>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.363400,0.000000,49.174400>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<37.363400,0.000000,49.174400> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.363400,0.000000,58.318400>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<37.363400,0.000000,57.302400>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<37.363400,0.000000,57.302400> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<38.252400,0.000000,56.159400>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<36.474400,0.000000,56.159400>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<36.474400,0.000000,50.317400>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<38.252400,0.000000,50.317400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.474400,0.000000,56.413400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.252400,0.000000,56.413400>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.474400,0.000000,56.413400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.506400,0.000000,56.159400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.506400,0.000000,55.778400>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<38.506400,0.000000,55.778400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.379400,0.000000,55.651400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.506400,0.000000,55.778400>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<38.379400,0.000000,55.651400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.220400,0.000000,56.159400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.220400,0.000000,55.778400>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.220400,0.000000,55.778400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.347400,0.000000,55.651400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.220400,0.000000,55.778400>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<36.220400,0.000000,55.778400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.379400,0.000000,50.825400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.506400,0.000000,50.698400>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<38.379400,0.000000,50.825400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.379400,0.000000,50.825400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.379400,0.000000,55.651400>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.379400,0.000000,55.651400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.347400,0.000000,50.825400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.220400,0.000000,50.698400>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.220400,0.000000,50.698400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.347400,0.000000,50.825400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.347400,0.000000,55.651400>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.347400,0.000000,55.651400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.506400,0.000000,50.317400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.506400,0.000000,50.698400>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<38.506400,0.000000,50.698400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.220400,0.000000,50.317400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.220400,0.000000,50.698400>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.220400,0.000000,50.698400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.474400,0.000000,50.063400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.252400,0.000000,50.063400>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<36.474400,0.000000,50.063400> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<37.363400,0.000000,49.631600>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<37.363400,0.000000,56.845200>}
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.859000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.875000,0.000000,41.783000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.859000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.019000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.003000,0.000000,41.783000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.003000,0.000000,41.783000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.860000,0.000000,40.894000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.860000,0.000000,42.672000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,42.672000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,42.672000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,40.894000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,40.894000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,40.640000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,40.640000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,42.926000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,42.926000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,40.640000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.399000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,40.767000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,42.926000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.399000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,42.799000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,42.799000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,42.799000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,40.640000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,42.926000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,42.926000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,42.926000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,42.672000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,40.894000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,40.894000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.332200,0.000000,41.783000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.545800,0.000000,41.783000>}
//R9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,34.163000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,35.179000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<35.179000,0.000000,35.179000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,44.323000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,43.307000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<35.179000,0.000000,43.307000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<36.068000,0.000000,42.164000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<34.290000,0.000000,42.164000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<34.290000,0.000000,36.322000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<36.068000,0.000000,36.322000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,42.418000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,42.418000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.290000,0.000000,42.418000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.322000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.195000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.036000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<34.036000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,36.703000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<36.195000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.195000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,36.703000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.036000,0.000000,36.703000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.163000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,36.322000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,36.703000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.322000,0.000000,36.703000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,36.322000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,36.703000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.036000,0.000000,36.703000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,36.068000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,36.068000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.290000,0.000000,36.068000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<35.179000,0.000000,35.636200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<35.179000,0.000000,42.849800>}
//R10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.859000,0.000000,36.703000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.875000,0.000000,36.703000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.859000,0.000000,36.703000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.019000,0.000000,36.703000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.003000,0.000000,36.703000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.003000,0.000000,36.703000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.860000,0.000000,35.814000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.860000,0.000000,37.592000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,37.592000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,35.814000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,37.592000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,35.814000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,35.814000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,35.560000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,35.560000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,37.846000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,37.719000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,37.846000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,37.719000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,35.560000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.399000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,35.687000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,35.687000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,35.687000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,37.719000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,37.846000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.399000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,37.719000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,37.719000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,37.719000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,35.560000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,37.846000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,37.846000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,37.846000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,37.592000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,35.814000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,35.814000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.332200,0.000000,36.703000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.545800,0.000000,36.703000>}
//R11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.535600,0.000000,18.643600>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.535600,0.000000,17.627600>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.535600,0.000000,17.627600> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.535600,0.000000,8.483600>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.535600,0.000000,9.499600>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<170.535600,0.000000,9.499600> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<169.646600,0.000000,10.642600>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<171.424600,0.000000,10.642600>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<171.424600,0.000000,16.484600>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<169.646600,0.000000,16.484600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.424600,0.000000,10.388600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.646600,0.000000,10.388600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<169.646600,0.000000,10.388600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.392600,0.000000,10.642600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.392600,0.000000,11.023600>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<169.392600,0.000000,11.023600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.519600,0.000000,11.150600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.392600,0.000000,11.023600>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<169.392600,0.000000,11.023600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.678600,0.000000,10.642600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.678600,0.000000,11.023600>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<171.678600,0.000000,11.023600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.551600,0.000000,11.150600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.678600,0.000000,11.023600>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<171.551600,0.000000,11.150600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.519600,0.000000,15.976600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.392600,0.000000,16.103600>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<169.392600,0.000000,16.103600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.519600,0.000000,15.976600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.519600,0.000000,11.150600>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<169.519600,0.000000,11.150600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.551600,0.000000,15.976600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.678600,0.000000,16.103600>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<171.551600,0.000000,15.976600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.551600,0.000000,15.976600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.551600,0.000000,11.150600>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<171.551600,0.000000,11.150600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.392600,0.000000,16.484600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.392600,0.000000,16.103600>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<169.392600,0.000000,16.103600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.678600,0.000000,16.484600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.678600,0.000000,16.103600>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<171.678600,0.000000,16.103600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.424600,0.000000,16.738600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.646600,0.000000,16.738600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<169.646600,0.000000,16.738600> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.535600,0.000000,17.170400>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.535600,0.000000,9.956800>}
//R12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.329600,0.000000,18.592800>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.329600,0.000000,17.576800>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.329600,0.000000,17.576800> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.329600,0.000000,8.432800>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.329600,0.000000,9.448800>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<173.329600,0.000000,9.448800> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<172.440600,0.000000,10.591800>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<174.218600,0.000000,10.591800>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<174.218600,0.000000,16.433800>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<172.440600,0.000000,16.433800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.218600,0.000000,10.337800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.440600,0.000000,10.337800>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<172.440600,0.000000,10.337800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.186600,0.000000,10.591800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.186600,0.000000,10.972800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<172.186600,0.000000,10.972800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.313600,0.000000,11.099800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.186600,0.000000,10.972800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<172.186600,0.000000,10.972800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.472600,0.000000,10.591800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.472600,0.000000,10.972800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<174.472600,0.000000,10.972800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.345600,0.000000,11.099800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.472600,0.000000,10.972800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<174.345600,0.000000,11.099800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.313600,0.000000,15.925800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.186600,0.000000,16.052800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<172.186600,0.000000,16.052800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.313600,0.000000,15.925800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.313600,0.000000,11.099800>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.313600,0.000000,11.099800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.345600,0.000000,15.925800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.472600,0.000000,16.052800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<174.345600,0.000000,15.925800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.345600,0.000000,15.925800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.345600,0.000000,11.099800>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<174.345600,0.000000,11.099800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.186600,0.000000,16.433800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.186600,0.000000,16.052800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.186600,0.000000,16.052800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.472600,0.000000,16.433800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.472600,0.000000,16.052800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<174.472600,0.000000,16.052800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.218600,0.000000,16.687800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.440600,0.000000,16.687800>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<172.440600,0.000000,16.687800> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.329600,0.000000,17.119600>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.329600,0.000000,9.906000>}
//R13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.859000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.875000,0.000000,51.943000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.859000,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.019000,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.003000,0.000000,51.943000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.003000,0.000000,51.943000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.860000,0.000000,51.054000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.860000,0.000000,52.832000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,52.832000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,51.054000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,52.832000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,51.054000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,51.054000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,50.800000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,50.927000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,50.800000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,50.927000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,53.086000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,53.086000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,52.959000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,50.927000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,50.800000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.399000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,50.927000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,50.927000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,50.927000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,53.086000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.399000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,52.959000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,52.959000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,52.959000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,50.800000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,50.800000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,50.800000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,53.086000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,53.086000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,53.086000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,52.832000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,51.054000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,51.054000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.332200,0.000000,51.943000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.545800,0.000000,51.943000>}
//R14 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.989000,0.000000,34.163000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.989000,0.000000,35.179000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<38.989000,0.000000,35.179000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.989000,0.000000,44.323000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.989000,0.000000,43.307000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<38.989000,0.000000,43.307000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<39.878000,0.000000,42.164000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<38.100000,0.000000,42.164000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<38.100000,0.000000,36.322000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<39.878000,0.000000,36.322000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,42.418000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,42.418000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,42.418000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.132000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.005000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,42.164000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.846000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<37.846000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,36.703000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<40.005000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.005000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,36.703000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<37.846000,0.000000,36.703000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.973000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,36.322000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,36.703000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.132000,0.000000,36.703000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,36.322000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,36.703000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.846000,0.000000,36.703000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,36.068000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,36.068000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,36.068000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<38.989000,0.000000,35.636200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<38.989000,0.000000,42.849800>}
//R15 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.859000,0.000000,46.863000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.875000,0.000000,46.863000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.859000,0.000000,46.863000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.019000,0.000000,46.863000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.003000,0.000000,46.863000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.003000,0.000000,46.863000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.860000,0.000000,45.974000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.860000,0.000000,47.752000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,47.752000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,45.974000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,47.752000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,45.974000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,45.974000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,45.720000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,45.847000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,45.720000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,45.847000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,48.006000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,47.879000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,48.006000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,47.879000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,45.847000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,45.720000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.399000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,45.847000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,45.847000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,45.847000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,47.879000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,48.006000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.399000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,47.879000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,47.879000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,47.879000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,45.720000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,48.006000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,48.006000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,48.006000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,47.752000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,45.974000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,45.974000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.332200,0.000000,46.863000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.545800,0.000000,46.863000>}
//R16 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.586400,0.000000,36.626800>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.586400,0.000000,35.610800>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.586400,0.000000,35.610800> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.586400,0.000000,26.466800>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.586400,0.000000,27.482800>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<170.586400,0.000000,27.482800> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<169.697400,0.000000,28.625800>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<171.475400,0.000000,28.625800>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<171.475400,0.000000,34.467800>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<169.697400,0.000000,34.467800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.475400,0.000000,28.371800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.697400,0.000000,28.371800>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<169.697400,0.000000,28.371800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,28.625800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,29.006800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<169.443400,0.000000,29.006800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.570400,0.000000,29.133800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,29.006800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<169.443400,0.000000,29.006800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,28.625800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,29.006800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<171.729400,0.000000,29.006800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.602400,0.000000,29.133800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,29.006800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<171.602400,0.000000,29.133800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.570400,0.000000,33.959800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,34.086800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<169.443400,0.000000,34.086800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.570400,0.000000,33.959800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.570400,0.000000,29.133800>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<169.570400,0.000000,29.133800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.602400,0.000000,33.959800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,34.086800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<171.602400,0.000000,33.959800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.602400,0.000000,33.959800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.602400,0.000000,29.133800>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<171.602400,0.000000,29.133800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,34.467800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,34.086800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<169.443400,0.000000,34.086800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,34.467800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,34.086800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<171.729400,0.000000,34.086800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.475400,0.000000,34.721800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.697400,0.000000,34.721800>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<169.697400,0.000000,34.721800> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.586400,0.000000,35.153600>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.586400,0.000000,27.940000>}
//R17 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.583600,0.000000,36.626800>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.583600,0.000000,35.610800>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.583600,0.000000,35.610800> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.583600,0.000000,26.466800>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.583600,0.000000,27.482800>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<173.583600,0.000000,27.482800> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<172.694600,0.000000,28.625800>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<174.472600,0.000000,28.625800>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<174.472600,0.000000,34.467800>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<172.694600,0.000000,34.467800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.472600,0.000000,28.371800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.694600,0.000000,28.371800>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<172.694600,0.000000,28.371800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.440600,0.000000,28.625800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.440600,0.000000,29.006800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<172.440600,0.000000,29.006800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.567600,0.000000,29.133800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.440600,0.000000,29.006800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<172.440600,0.000000,29.006800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.726600,0.000000,28.625800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.726600,0.000000,29.006800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<174.726600,0.000000,29.006800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.599600,0.000000,29.133800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.726600,0.000000,29.006800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<174.599600,0.000000,29.133800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.567600,0.000000,33.959800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.440600,0.000000,34.086800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<172.440600,0.000000,34.086800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.567600,0.000000,33.959800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.567600,0.000000,29.133800>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.567600,0.000000,29.133800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.599600,0.000000,33.959800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.726600,0.000000,34.086800>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<174.599600,0.000000,33.959800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.599600,0.000000,33.959800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.599600,0.000000,29.133800>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<174.599600,0.000000,29.133800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.440600,0.000000,34.467800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.440600,0.000000,34.086800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.440600,0.000000,34.086800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.726600,0.000000,34.467800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.726600,0.000000,34.086800>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<174.726600,0.000000,34.086800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.472600,0.000000,34.721800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.694600,0.000000,34.721800>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<172.694600,0.000000,34.721800> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.583600,0.000000,35.153600>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.583600,0.000000,27.940000>}
//R18 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.859000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.875000,0.000000,62.103000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.859000,0.000000,62.103000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.019000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.003000,0.000000,62.103000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.003000,0.000000,62.103000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.860000,0.000000,61.214000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.860000,0.000000,62.992000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,62.992000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,61.214000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,62.992000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,61.214000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,61.214000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,60.960000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,61.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,60.960000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,61.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,63.246000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,63.246000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,63.246000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,63.119000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,61.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,60.960000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.399000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,61.087000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,61.087000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,61.087000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,63.246000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.399000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,63.119000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,63.119000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,63.119000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,60.960000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,60.960000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,60.960000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,63.246000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,63.246000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,63.246000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,62.992000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,61.214000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,61.214000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.332200,0.000000,62.103000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.545800,0.000000,62.103000>}
//R19 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.989000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.989000,0.000000,63.119000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<38.989000,0.000000,63.119000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.989000,0.000000,72.263000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<38.989000,0.000000,71.247000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<38.989000,0.000000,71.247000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<39.878000,0.000000,70.104000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<38.100000,0.000000,70.104000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<38.100000,0.000000,64.262000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<39.878000,0.000000,64.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,70.358000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,70.358000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,70.358000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,69.723000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<40.132000,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,69.723000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<40.005000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,69.723000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<37.846000,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,69.723000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<37.846000,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,64.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<40.005000,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.005000,0.000000,69.596000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.005000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,64.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<37.846000,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.973000,0.000000,69.596000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.973000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,64.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<40.132000,0.000000,64.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<40.132000,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,64.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<37.846000,0.000000,64.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<37.846000,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<38.100000,0.000000,64.008000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<39.878000,0.000000,64.008000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<38.100000,0.000000,64.008000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<38.989000,0.000000,63.576200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<38.989000,0.000000,70.789800>}
//R20 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.859000,0.000000,57.023000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.875000,0.000000,57.023000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.859000,0.000000,57.023000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.019000,0.000000,57.023000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.003000,0.000000,57.023000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.003000,0.000000,57.023000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.860000,0.000000,56.134000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.860000,0.000000,57.912000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,57.912000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,56.134000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,57.912000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,56.134000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,56.134000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,55.880000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,55.880000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,56.007000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,58.166000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,58.166000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,58.166000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,55.880000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.399000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,56.007000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,56.007000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,56.007000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,58.166000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.399000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,58.039000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,58.039000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,58.039000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,55.880000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,55.880000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,55.880000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,58.166000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,58.166000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,58.166000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,57.912000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,56.134000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,56.134000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.332200,0.000000,57.023000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.545800,0.000000,57.023000>}
//R21 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.586400,0.000000,54.584600>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.586400,0.000000,53.568600>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.586400,0.000000,53.568600> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.586400,0.000000,44.424600>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.586400,0.000000,45.440600>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<170.586400,0.000000,45.440600> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<169.697400,0.000000,46.583600>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<171.475400,0.000000,46.583600>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<171.475400,0.000000,52.425600>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<169.697400,0.000000,52.425600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.475400,0.000000,46.329600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.697400,0.000000,46.329600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<169.697400,0.000000,46.329600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,46.583600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,46.964600>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<169.443400,0.000000,46.964600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.570400,0.000000,47.091600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,46.964600>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<169.443400,0.000000,46.964600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,46.583600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,46.964600>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<171.729400,0.000000,46.964600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.602400,0.000000,47.091600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,46.964600>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<171.602400,0.000000,47.091600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.570400,0.000000,51.917600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,52.044600>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<169.443400,0.000000,52.044600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.570400,0.000000,51.917600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.570400,0.000000,47.091600>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<169.570400,0.000000,47.091600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.602400,0.000000,51.917600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,52.044600>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<171.602400,0.000000,51.917600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.602400,0.000000,51.917600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.602400,0.000000,47.091600>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<171.602400,0.000000,47.091600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,52.425600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.443400,0.000000,52.044600>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<169.443400,0.000000,52.044600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,52.425600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.729400,0.000000,52.044600>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<171.729400,0.000000,52.044600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.475400,0.000000,52.679600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.697400,0.000000,52.679600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<169.697400,0.000000,52.679600> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.586400,0.000000,53.111400>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.586400,0.000000,45.897800>}
//R22 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.558200,0.000000,54.610000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.558200,0.000000,53.594000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.558200,0.000000,53.594000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.558200,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.558200,0.000000,45.466000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<173.558200,0.000000,45.466000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<172.669200,0.000000,46.609000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<174.447200,0.000000,46.609000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<174.447200,0.000000,52.451000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<172.669200,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.447200,0.000000,46.355000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.669200,0.000000,46.355000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<172.669200,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.415200,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.415200,0.000000,46.990000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<172.415200,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.542200,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.415200,0.000000,46.990000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<172.415200,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.701200,0.000000,46.609000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.701200,0.000000,46.990000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<174.701200,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.574200,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.701200,0.000000,46.990000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<174.574200,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.542200,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.415200,0.000000,52.070000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<172.415200,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.542200,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.542200,0.000000,47.117000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.542200,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.574200,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.701200,0.000000,52.070000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<174.574200,0.000000,51.943000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.574200,0.000000,51.943000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.574200,0.000000,47.117000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<174.574200,0.000000,47.117000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.415200,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.415200,0.000000,52.070000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.415200,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.701200,0.000000,52.451000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.701200,0.000000,52.070000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<174.701200,0.000000,52.070000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.447200,0.000000,52.705000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.669200,0.000000,52.705000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<172.669200,0.000000,52.705000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.558200,0.000000,53.136800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.558200,0.000000,45.923200>}
//R23 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.859000,0.000000,72.263000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.875000,0.000000,72.263000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.859000,0.000000,72.263000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.019000,0.000000,72.263000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.003000,0.000000,72.263000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.003000,0.000000,72.263000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.860000,0.000000,71.374000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.860000,0.000000,73.152000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,73.152000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,71.374000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,73.152000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,71.374000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,71.374000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,71.120000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,71.247000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,71.120000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,71.247000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,73.406000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,73.406000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,73.279000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,73.406000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,73.279000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,71.247000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,71.120000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.399000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,71.247000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,71.247000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,71.247000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,73.279000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,73.406000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.399000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,73.279000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,73.279000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,73.279000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,71.120000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,71.120000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,71.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,73.406000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,73.406000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,73.406000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,73.152000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,71.374000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,71.374000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.332200,0.000000,72.263000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.545800,0.000000,72.263000>}
//R24 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,63.119000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<35.179000,0.000000,63.119000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,72.263000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<35.179000,0.000000,71.247000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<35.179000,0.000000,71.247000> }
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<36.068000,0.000000,70.104000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<34.290000,0.000000,70.104000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<34.290000,0.000000,64.262000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<36.068000,0.000000,64.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,70.358000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,70.358000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.290000,0.000000,70.358000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,69.723000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<36.322000,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,69.723000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<36.195000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,69.723000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<34.036000,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,69.723000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<34.036000,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,64.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<36.195000,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.195000,0.000000,69.596000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.195000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,64.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.036000,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.163000,0.000000,69.596000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.163000,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,64.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.322000,0.000000,64.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<36.322000,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,64.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.036000,0.000000,64.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<34.036000,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,64.008000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<36.068000,0.000000,64.008000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.290000,0.000000,64.008000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<35.179000,0.000000,63.576200>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-270.000000,0> translate<35.179000,0.000000,70.789800>}
//R25 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.859000,0.000000,67.183000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<15.875000,0.000000,67.183000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<14.859000,0.000000,67.183000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<25.019000,0.000000,67.183000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<24.003000,0.000000,67.183000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,0.000000,0> translate<24.003000,0.000000,67.183000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<22.860000,0.000000,66.294000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<22.860000,0.000000,68.072000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<17.018000,0.000000,68.072000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<17.018000,0.000000,66.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,68.072000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<23.114000,0.000000,66.294000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<23.114000,0.000000,66.294000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,66.040000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,66.167000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,66.040000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<22.352000,0.000000,66.167000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.860000,0.000000,68.326000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,68.326000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<22.479000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,68.199000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.479000,0.000000,68.326000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<22.352000,0.000000,68.199000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,66.167000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,66.040000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<17.399000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,66.167000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,66.167000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,66.167000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,68.199000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,68.326000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<17.399000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.526000,0.000000,68.199000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<22.352000,0.000000,68.199000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.526000,0.000000,68.199000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,66.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,66.040000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,66.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.018000,0.000000,68.326000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.399000,0.000000,68.326000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<17.018000,0.000000,68.326000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,68.072000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<16.764000,0.000000,66.294000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<16.764000,0.000000,66.294000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<16.332200,0.000000,67.183000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-180.000000,0> translate<23.545800,0.000000,67.183000>}
//R26 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.967400,0.000000,72.263000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.967400,0.000000,71.247000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.967400,0.000000,71.247000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.967400,0.000000,62.103000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<170.967400,0.000000,63.119000>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<170.967400,0.000000,63.119000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<170.078400,0.000000,64.262000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<171.856400,0.000000,64.262000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<171.856400,0.000000,70.104000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<170.078400,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.856400,0.000000,64.008000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<170.078400,0.000000,64.008000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<170.078400,0.000000,64.008000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.824400,0.000000,64.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.824400,0.000000,64.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<169.824400,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.951400,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.824400,0.000000,64.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<169.824400,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.110400,0.000000,64.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.110400,0.000000,64.643000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<172.110400,0.000000,64.643000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.983400,0.000000,64.770000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.110400,0.000000,64.643000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<171.983400,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.951400,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.824400,0.000000,69.723000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<169.824400,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.951400,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.951400,0.000000,64.770000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<169.951400,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.983400,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.110400,0.000000,69.723000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<171.983400,0.000000,69.596000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.983400,0.000000,69.596000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.983400,0.000000,64.770000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<171.983400,0.000000,64.770000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.824400,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<169.824400,0.000000,69.723000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<169.824400,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.110400,0.000000,70.104000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.110400,0.000000,69.723000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.110400,0.000000,69.723000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<171.856400,0.000000,70.358000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<170.078400,0.000000,70.358000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<170.078400,0.000000,70.358000> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.967400,0.000000,70.789800>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<170.967400,0.000000,63.576200>}
//R27 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.939200,0.000000,72.339200>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.939200,0.000000,71.323200>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.939200,0.000000,71.323200> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.939200,0.000000,62.179200>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<173.939200,0.000000,63.195200>}
box{<0,0,-0.304800><1.016000,0.036000,0.304800> rotate<0,90.000000,0> translate<173.939200,0.000000,63.195200> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<173.050200,0.000000,64.338200>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<174.828200,0.000000,64.338200>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<174.828200,0.000000,70.180200>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<173.050200,0.000000,70.180200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.828200,0.000000,64.084200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<173.050200,0.000000,64.084200>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<173.050200,0.000000,64.084200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.796200,0.000000,64.338200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.796200,0.000000,64.719200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<172.796200,0.000000,64.719200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.923200,0.000000,64.846200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.796200,0.000000,64.719200>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<172.796200,0.000000,64.719200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<175.082200,0.000000,64.338200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<175.082200,0.000000,64.719200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<175.082200,0.000000,64.719200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.955200,0.000000,64.846200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<175.082200,0.000000,64.719200>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<174.955200,0.000000,64.846200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.923200,0.000000,69.672200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.796200,0.000000,69.799200>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<172.796200,0.000000,69.799200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.923200,0.000000,69.672200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.923200,0.000000,64.846200>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.923200,0.000000,64.846200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.955200,0.000000,69.672200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<175.082200,0.000000,69.799200>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<174.955200,0.000000,69.672200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.955200,0.000000,69.672200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.955200,0.000000,64.846200>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<174.955200,0.000000,64.846200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.796200,0.000000,70.180200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<172.796200,0.000000,69.799200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<172.796200,0.000000,69.799200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<175.082200,0.000000,70.180200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<175.082200,0.000000,69.799200>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<175.082200,0.000000,69.799200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<174.828200,0.000000,70.434200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<173.050200,0.000000,70.434200>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<173.050200,0.000000,70.434200> }
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.939200,0.000000,70.866000>}
box{<-0.431800,0,-0.304800><0.431800,0.036000,0.304800> rotate<0,-90.000000,0> translate<173.939200,0.000000,63.652400>}
//S1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.991000,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,30.353000>}
box{<0,0,-0.101600><1.524000,0.036000,0.101600> rotate<0,0.000000,0> translate<54.991000,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.023000,0.000000,30.861000>}
box{<0,0,-0.101600><0.718420,0.036000,0.101600> rotate<0,-44.997030,0> translate<56.515000,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.927000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.435000,0.000000,30.353000>}
box{<0,0,-0.101600><0.718420,0.036000,0.101600> rotate<0,44.997030,0> translate<50.927000,0.000000,30.861000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.435000,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.959000,0.000000,30.353000>}
box{<0,0,-0.101600><1.524000,0.036000,0.101600> rotate<0,0.000000,0> translate<51.435000,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.023000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,36.449000>}
box{<0,0,-0.101600><0.718420,0.036000,0.101600> rotate<0,44.997030,0> translate<56.515000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.515000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.991000,0.000000,36.449000>}
box{<0,0,-0.101600><1.524000,0.036000,0.101600> rotate<0,0.000000,0> translate<54.991000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.927000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.435000,0.000000,36.449000>}
box{<0,0,-0.101600><0.718420,0.036000,0.101600> rotate<0,-44.997030,0> translate<50.927000,0.000000,35.941000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<51.435000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.959000,0.000000,36.449000>}
box{<0,0,-0.101600><1.524000,0.036000,0.101600> rotate<0,0.000000,0> translate<51.435000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.927000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.927000,0.000000,31.242000>}
box{<0,0,-0.101600><0.381000,0.036000,0.101600> rotate<0,90.000000,0> translate<50.927000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.927000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.927000,0.000000,35.560000>}
box{<0,0,-0.101600><0.381000,0.036000,0.101600> rotate<0,-90.000000,0> translate<50.927000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.023000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.023000,0.000000,35.560000>}
box{<0,0,-0.101600><0.381000,0.036000,0.101600> rotate<0,-90.000000,0> translate<57.023000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.023000,0.000000,30.861000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.023000,0.000000,31.242000>}
box{<0,0,-0.101600><0.381000,0.036000,0.101600> rotate<0,90.000000,0> translate<57.023000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.023000,0.000000,31.242000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.023000,0.000000,35.560000>}
box{<0,0,-0.101600><4.318000,0.036000,0.101600> rotate<0,90.000000,0> translate<57.023000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.927000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<50.927000,0.000000,31.242000>}
box{<0,0,-0.101600><4.318000,0.036000,0.101600> rotate<0,-90.000000,0> translate<50.927000,0.000000,31.242000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.973000,0.000000,30.353000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.959000,0.000000,30.353000>}
box{<0,0,-0.101600><2.014000,0.036000,0.101600> rotate<0,0.000000,0> translate<52.959000,0.000000,30.353000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.003000,0.000000,36.449000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.959000,0.000000,36.449000>}
box{<0,0,-0.101600><2.044000,0.036000,0.101600> rotate<0,0.000000,0> translate<52.959000,0.000000,36.449000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.245000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.483000,0.000000,35.941000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<54.483000,0.000000,35.941000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.467000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.705000,0.000000,35.941000>}
box{<0,0,-0.101600><0.762000,0.036000,0.101600> rotate<0,0.000000,0> translate<52.705000,0.000000,35.941000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<54.483000,0.000000,35.941000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.594000,0.000000,35.560000>}
box{<0,0,-0.101600><0.967203,0.036000,0.101600> rotate<0,-23.197059,0> translate<53.594000,0.000000,35.560000> }
difference{
cylinder{<53.975000,0,33.401000><53.975000,0.036000,33.401000>1.879600 translate<0,0.000000,0>}
cylinder{<53.975000,-0.1,33.401000><53.975000,0.135000,33.401000>1.676400 translate<0,0.000000,0>}}
//SG1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.594400,0.000000,63.591600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<138.594400,0.000000,61.813600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<138.594400,0.000000,61.813600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.483400,0.000000,62.702600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<137.705400,0.000000,62.702600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<137.705400,0.000000,62.702600> }
difference{
cylinder{<138.582400,0,66.522600><138.582400,0.036000,66.522600>6.076200 translate<0,0.000000,0>}
cylinder{<138.582400,-0.1,66.522600><138.582400,0.135000,66.522600>5.923800 translate<0,0.000000,0>}}
difference{
cylinder{<138.582400,0,66.522600><138.582400,0.036000,66.522600>1.076200 translate<0,0.000000,0>}
cylinder{<138.582400,-0.1,66.522600><138.582400,0.135000,66.522600>0.923800 translate<0,0.000000,0>}}
difference{
cylinder{<138.594400,0,62.702600><138.594400,0.036000,62.702600>1.473200 translate<0,0.000000,0>}
cylinder{<138.594400,-0.1,62.702600><138.594400,0.135000,62.702600>1.320800 translate<0,0.000000,0>}}
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.284600,0.000000,39.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<147.284600,0.000000,39.065200>}
box{<0,0,-0.063500><80.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.284600,0.000000,39.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<147.284600,0.000000,39.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<147.284600,0.000000,75.065200>}
box{<0,0,-0.063500><36.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<147.284600,0.000000,75.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<147.284600,0.000000,75.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.284600,0.000000,75.065200>}
box{<0,0,-0.063500><80.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<67.284600,0.000000,75.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.284600,0.000000,75.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<67.284600,0.000000,39.065200>}
box{<0,0,-0.063500><36.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<67.284600,0.000000,39.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<71.284600,0.000000,69.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<143.284600,0.000000,69.065200>}
box{<0,0,-0.063500><72.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<71.284600,0.000000,69.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<143.284600,0.000000,69.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<143.284600,0.000000,45.065200>}
box{<0,0,-0.063500><24.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<143.284600,0.000000,45.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<143.284600,0.000000,45.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<71.284600,0.000000,45.065200>}
box{<0,0,-0.063500><72.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<71.284600,0.000000,45.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<71.284600,0.000000,45.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<71.284600,0.000000,69.065200>}
box{<0,0,-0.063500><24.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<71.284600,0.000000,69.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.284600,0.000000,67.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<141.284600,0.000000,67.065200>}
box{<0,0,-0.063500><68.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.284600,0.000000,67.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<141.284600,0.000000,67.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<141.284600,0.000000,66.065200>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<141.284600,0.000000,66.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<141.284600,0.000000,66.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.284600,0.000000,66.065200>}
box{<0,0,-0.063500><68.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.284600,0.000000,66.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.284600,0.000000,66.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.284600,0.000000,67.065200>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<73.284600,0.000000,67.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.284600,0.000000,47.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<141.284600,0.000000,47.065200>}
box{<0,0,-0.063500><68.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.284600,0.000000,47.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<141.284600,0.000000,47.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<141.284600,0.000000,48.065200>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<141.284600,0.000000,48.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<141.284600,0.000000,48.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.284600,0.000000,48.065200>}
box{<0,0,-0.063500><68.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.284600,0.000000,48.065200> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.284600,0.000000,48.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.284600,0.000000,47.065200>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<73.284600,0.000000,47.065200> }
object{ARC(3.000000,0.127000,90.000000,180.000000,0.036000) translate<78.284600,0.000000,61.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.284600,0.000000,61.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.284600,0.000000,53.065200>}
box{<0,0,-0.063500><8.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<75.284600,0.000000,53.065200> }
object{ARC(3.000000,0.127000,180.000000,270.000000,0.036000) translate<78.284600,0.000000,53.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<78.284600,0.000000,50.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<136.284600,0.000000,50.065200>}
box{<0,0,-0.063500><58.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<78.284600,0.000000,50.065200> }
object{ARC(3.000000,0.127000,270.000000,360.000000,0.036000) translate<136.284600,0.000000,53.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<139.284600,0.000000,53.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<139.284600,0.000000,61.065200>}
box{<0,0,-0.063500><8.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<139.284600,0.000000,61.065200> }
object{ARC(3.000000,0.127000,0.000000,90.000000,0.036000) translate<136.284600,0.000000,61.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<136.284600,0.000000,64.065200>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<78.284600,0.000000,64.065200>}
box{<0,0,-0.063500><58.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<78.284600,0.000000,64.065200> }
//X2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.525000,0.000000,35.832000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.518000,0.000000,37.839000>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<7.518000,0.000000,37.839000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.500000,0.000000,40.811000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.493000,0.000000,42.792000>}
box{<0,0,-0.127000><2.820002,0.036000,0.127000> rotate<0,44.623517,0> translate<7.493000,0.000000,42.792000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.525000,0.000000,45.840000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.518000,0.000000,47.847000>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<7.518000,0.000000,47.847000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.500000,0.000000,50.818000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.493000,0.000000,52.800000>}
box{<0,0,-0.127000><2.820704,0.036000,0.127000> rotate<0,44.637972,0> translate<7.493000,0.000000,52.800000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,34.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,54.324000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.700000,0.000000,54.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.505000,0.000000,54.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,54.324000>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.505000,0.000000,54.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.505000,0.000000,54.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.505000,0.000000,34.334000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.505000,0.000000,34.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,34.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,34.334000>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.312000,0.000000,34.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,34.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,35.934000>}
box{<0,0,-0.076200><1.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,35.934000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,35.934000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,37.712000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,37.712000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,37.712000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,40.938000>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,40.938000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,42.716000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,45.942000>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,45.942000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,47.720000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,50.945000>}
box{<0,0,-0.076200><3.225000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,50.945000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,52.723000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,54.324000>}
box{<0,0,-0.076200><1.601000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,54.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,34.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,34.334000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.708000,0.000000,34.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,54.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,54.324000>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.312000,0.000000,54.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,34.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,54.324000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.708000,0.000000,54.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,34.334000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.505000,0.000000,34.334000>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.505000,0.000000,34.334000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,54.324000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,54.324000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.708000,0.000000,54.324000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,40.938000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,42.716000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,42.716000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,45.942000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,47.720000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,47.720000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,50.945000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,52.723000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,52.723000> }
difference{
cylinder{<8.509000,0,36.823000><8.509000,0.036000,36.823000>1.574800 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,36.823000><8.509000,0.135000,36.823000>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<5.029200,0,36.823000><5.029200,0.036000,36.823000>0.584200 translate<0,0.000000,0>}
cylinder{<5.029200,-0.1,36.823000><5.029200,0.135000,36.823000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<8.509000,0,41.826800><8.509000,0.036000,41.826800>1.574800 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,41.826800><8.509000,0.135000,41.826800>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<5.029200,0,41.826800><5.029200,0.036000,41.826800>0.584200 translate<0,0.000000,0>}
cylinder{<5.029200,-0.1,41.826800><5.029200,0.135000,41.826800>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<8.509000,0,46.830600><8.509000,0.036000,46.830600>1.574800 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,46.830600><8.509000,0.135000,46.830600>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<5.029200,0,46.830600><5.029200,0.036000,46.830600>0.584200 translate<0,0.000000,0>}
cylinder{<5.029200,-0.1,46.830600><5.029200,0.135000,46.830600>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<8.509000,0,51.834400><8.509000,0.036000,51.834400>1.574800 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,51.834400><8.509000,0.135000,51.834400>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<5.029200,0,51.834400><5.029200,0.036000,51.834400>0.584200 translate<0,0.000000,0>}
cylinder{<5.029200,-0.1,51.834400><5.029200,0.135000,51.834400>0.431800 translate<0,0.000000,0>}}
//X3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.525000,0.000000,56.152000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.518000,0.000000,58.159000>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<7.518000,0.000000,58.159000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.500000,0.000000,61.131000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.493000,0.000000,63.112000>}
box{<0,0,-0.127000><2.820002,0.036000,0.127000> rotate<0,44.623517,0> translate<7.493000,0.000000,63.112000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.525000,0.000000,66.160000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.518000,0.000000,68.167000>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<7.518000,0.000000,68.167000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<9.500000,0.000000,71.138000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<7.493000,0.000000,73.120000>}
box{<0,0,-0.127000><2.820704,0.036000,0.127000> rotate<0,44.637972,0> translate<7.493000,0.000000,73.120000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,54.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,74.644000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<12.700000,0.000000,74.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.505000,0.000000,74.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,74.644000>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.505000,0.000000,74.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.505000,0.000000,74.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.505000,0.000000,54.654000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.505000,0.000000,54.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,54.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,54.654000>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.312000,0.000000,54.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,54.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,56.254000>}
box{<0,0,-0.076200><1.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,56.254000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,56.254000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,58.032000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,58.032000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,58.032000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,61.258000>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,61.258000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,63.036000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,66.262000>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,66.262000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,68.040000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,71.265000>}
box{<0,0,-0.076200><3.225000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,71.265000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,73.043000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,74.644000>}
box{<0,0,-0.076200><1.601000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,74.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,54.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,54.654000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.708000,0.000000,54.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,74.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.700000,0.000000,74.644000>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<10.312000,0.000000,74.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,54.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,74.644000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<3.708000,0.000000,74.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,54.654000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.505000,0.000000,54.654000>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.505000,0.000000,54.654000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.708000,0.000000,74.644000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,74.644000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.708000,0.000000,74.644000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,61.258000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,63.036000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,63.036000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,66.262000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,68.040000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,68.040000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,71.265000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.312000,0.000000,73.043000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<10.312000,0.000000,73.043000> }
difference{
cylinder{<8.509000,0,57.143000><8.509000,0.036000,57.143000>1.574800 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,57.143000><8.509000,0.135000,57.143000>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<5.029200,0,57.143000><5.029200,0.036000,57.143000>0.584200 translate<0,0.000000,0>}
cylinder{<5.029200,-0.1,57.143000><5.029200,0.135000,57.143000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<8.509000,0,62.146800><8.509000,0.036000,62.146800>1.574800 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,62.146800><8.509000,0.135000,62.146800>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<5.029200,0,62.146800><5.029200,0.036000,62.146800>0.584200 translate<0,0.000000,0>}
cylinder{<5.029200,-0.1,62.146800><5.029200,0.135000,62.146800>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<8.509000,0,67.150600><8.509000,0.036000,67.150600>1.574800 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,67.150600><8.509000,0.135000,67.150600>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<5.029200,0,67.150600><5.029200,0.036000,67.150600>0.584200 translate<0,0.000000,0>}
cylinder{<5.029200,-0.1,67.150600><5.029200,0.135000,67.150600>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<8.509000,0,72.154400><8.509000,0.036000,72.154400>1.574800 translate<0,0.000000,0>}
cylinder{<8.509000,-0.1,72.154400><8.509000,0.135000,72.154400>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<5.029200,0,72.154400><5.029200,0.036000,72.154400>0.584200 translate<0,0.000000,0>}
cylinder{<5.029200,-0.1,72.154400><5.029200,0.135000,72.154400>0.431800 translate<0,0.000000,0>}}
//X4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.418400,0.000000,16.731200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.411400,0.000000,18.738200>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<221.411400,0.000000,18.738200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.393400,0.000000,21.710200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.386400,0.000000,23.691200>}
box{<0,0,-0.127000><2.820002,0.036000,0.127000> rotate<0,44.623517,0> translate<221.386400,0.000000,23.691200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.418400,0.000000,26.739200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.411400,0.000000,28.746200>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<221.411400,0.000000,28.746200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.393400,0.000000,31.717200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.386400,0.000000,33.699200>}
box{<0,0,-0.127000><2.820704,0.036000,0.127000> rotate<0,44.637972,0> translate<221.386400,0.000000,33.699200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.593400,0.000000,15.233200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.593400,0.000000,35.223200>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<226.593400,0.000000,35.223200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398400,0.000000,35.223200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.601400,0.000000,35.223200>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.398400,0.000000,35.223200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398400,0.000000,35.223200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398400,0.000000,15.233200>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,-90.000000,0> translate<217.398400,0.000000,15.233200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.593400,0.000000,15.233200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,15.233200>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<224.205400,0.000000,15.233200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,15.233200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,16.833200>}
box{<0,0,-0.076200><1.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,16.833200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,16.833200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,18.611200>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,18.611200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,18.611200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,21.837200>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,21.837200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,23.615200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,26.841200>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,26.841200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,28.619200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,31.844200>}
box{<0,0,-0.076200><3.225000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,31.844200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,33.622200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,35.223200>}
box{<0,0,-0.076200><1.601000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,35.223200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,15.233200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.601400,0.000000,15.233200>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.601400,0.000000,15.233200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,35.223200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.593400,0.000000,35.223200>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<224.205400,0.000000,35.223200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.601400,0.000000,15.233200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.601400,0.000000,35.223200>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<217.601400,0.000000,35.223200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.601400,0.000000,15.233200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398400,0.000000,15.233200>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.398400,0.000000,15.233200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.601400,0.000000,35.223200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,35.223200>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.601400,0.000000,35.223200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,21.837200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,23.615200>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,23.615200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,26.841200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,28.619200>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,28.619200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,31.844200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.205400,0.000000,33.622200>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.205400,0.000000,33.622200> }
difference{
cylinder{<222.402400,0,17.722200><222.402400,0.036000,17.722200>1.574800 translate<0,0.000000,0>}
cylinder{<222.402400,-0.1,17.722200><222.402400,0.135000,17.722200>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.922600,0,17.722200><218.922600,0.036000,17.722200>0.584200 translate<0,0.000000,0>}
cylinder{<218.922600,-0.1,17.722200><218.922600,0.135000,17.722200>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.402400,0,22.726000><222.402400,0.036000,22.726000>1.574800 translate<0,0.000000,0>}
cylinder{<222.402400,-0.1,22.726000><222.402400,0.135000,22.726000>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.922600,0,22.726000><218.922600,0.036000,22.726000>0.584200 translate<0,0.000000,0>}
cylinder{<218.922600,-0.1,22.726000><218.922600,0.135000,22.726000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.402400,0,27.729800><222.402400,0.036000,27.729800>1.574800 translate<0,0.000000,0>}
cylinder{<222.402400,-0.1,27.729800><222.402400,0.135000,27.729800>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.922600,0,27.729800><218.922600,0.036000,27.729800>0.584200 translate<0,0.000000,0>}
cylinder{<218.922600,-0.1,27.729800><218.922600,0.135000,27.729800>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.402400,0,32.733600><222.402400,0.036000,32.733600>1.574800 translate<0,0.000000,0>}
cylinder{<222.402400,-0.1,32.733600><222.402400,0.135000,32.733600>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.922600,0,32.733600><218.922600,0.036000,32.733600>0.584200 translate<0,0.000000,0>}
cylinder{<218.922600,-0.1,32.733600><218.922600,0.135000,32.733600>0.431800 translate<0,0.000000,0>}}
//X5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.215200,0.000000,36.441600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.208200,0.000000,38.448600>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<221.208200,0.000000,38.448600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.190200,0.000000,41.420600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.183200,0.000000,43.401600>}
box{<0,0,-0.127000><2.820002,0.036000,0.127000> rotate<0,44.623517,0> translate<221.183200,0.000000,43.401600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.215200,0.000000,46.449600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.208200,0.000000,48.456600>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<221.208200,0.000000,48.456600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.190200,0.000000,51.427600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.183200,0.000000,53.409600>}
box{<0,0,-0.127000><2.820704,0.036000,0.127000> rotate<0,44.637972,0> translate<221.183200,0.000000,53.409600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.390200,0.000000,34.943600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.390200,0.000000,54.933600>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<226.390200,0.000000,54.933600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.195200,0.000000,54.933600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398200,0.000000,54.933600>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.195200,0.000000,54.933600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.195200,0.000000,54.933600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.195200,0.000000,34.943600>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,-90.000000,0> translate<217.195200,0.000000,34.943600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.390200,0.000000,34.943600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,34.943600>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<224.002200,0.000000,34.943600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,34.943600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,36.543600>}
box{<0,0,-0.076200><1.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,36.543600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,36.543600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,38.321600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,38.321600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,38.321600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,41.547600>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,41.547600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,43.325600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,46.551600>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,46.551600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,48.329600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,51.554600>}
box{<0,0,-0.076200><3.225000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,51.554600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,53.332600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,54.933600>}
box{<0,0,-0.076200><1.601000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,54.933600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,34.943600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398200,0.000000,34.943600>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.398200,0.000000,34.943600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,54.933600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.390200,0.000000,54.933600>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<224.002200,0.000000,54.933600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398200,0.000000,34.943600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398200,0.000000,54.933600>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<217.398200,0.000000,54.933600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398200,0.000000,34.943600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.195200,0.000000,34.943600>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.195200,0.000000,34.943600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.398200,0.000000,54.933600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,54.933600>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.398200,0.000000,54.933600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,41.547600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,43.325600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,43.325600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,46.551600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,48.329600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,48.329600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,51.554600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.002200,0.000000,53.332600>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.002200,0.000000,53.332600> }
difference{
cylinder{<222.199200,0,37.432600><222.199200,0.036000,37.432600>1.574800 translate<0,0.000000,0>}
cylinder{<222.199200,-0.1,37.432600><222.199200,0.135000,37.432600>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.719400,0,37.432600><218.719400,0.036000,37.432600>0.584200 translate<0,0.000000,0>}
cylinder{<218.719400,-0.1,37.432600><218.719400,0.135000,37.432600>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.199200,0,42.436400><222.199200,0.036000,42.436400>1.574800 translate<0,0.000000,0>}
cylinder{<222.199200,-0.1,42.436400><222.199200,0.135000,42.436400>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.719400,0,42.436400><218.719400,0.036000,42.436400>0.584200 translate<0,0.000000,0>}
cylinder{<218.719400,-0.1,42.436400><218.719400,0.135000,42.436400>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.199200,0,47.440200><222.199200,0.036000,47.440200>1.574800 translate<0,0.000000,0>}
cylinder{<222.199200,-0.1,47.440200><222.199200,0.135000,47.440200>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.719400,0,47.440200><218.719400,0.036000,47.440200>0.584200 translate<0,0.000000,0>}
cylinder{<218.719400,-0.1,47.440200><218.719400,0.135000,47.440200>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.199200,0,52.444000><222.199200,0.036000,52.444000>1.574800 translate<0,0.000000,0>}
cylinder{<222.199200,-0.1,52.444000><222.199200,0.135000,52.444000>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.719400,0,52.444000><218.719400,0.036000,52.444000>0.584200 translate<0,0.000000,0>}
cylinder{<218.719400,-0.1,52.444000><218.719400,0.135000,52.444000>0.431800 translate<0,0.000000,0>}}
//X6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.342200,0.000000,56.406000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.335200,0.000000,58.413000>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<221.335200,0.000000,58.413000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.317200,0.000000,61.385000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.310200,0.000000,63.366000>}
box{<0,0,-0.127000><2.820002,0.036000,0.127000> rotate<0,44.623517,0> translate<221.310200,0.000000,63.366000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.342200,0.000000,66.414000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.335200,0.000000,68.421000>}
box{<0,0,-0.127000><2.838327,0.036000,0.127000> rotate<0,44.997030,0> translate<221.335200,0.000000,68.421000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<223.317200,0.000000,71.392000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<221.310200,0.000000,73.374000>}
box{<0,0,-0.127000><2.820704,0.036000,0.127000> rotate<0,44.637972,0> translate<221.310200,0.000000,73.374000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.517200,0.000000,54.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.517200,0.000000,74.898000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<226.517200,0.000000,74.898000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.322200,0.000000,74.898000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.525200,0.000000,74.898000>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.322200,0.000000,74.898000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.322200,0.000000,74.898000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.322200,0.000000,54.908000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,-90.000000,0> translate<217.322200,0.000000,54.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.517200,0.000000,54.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,54.908000>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<224.129200,0.000000,54.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,54.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,56.508000>}
box{<0,0,-0.076200><1.600000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,56.508000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,56.508000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,58.286000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,58.286000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,58.286000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,61.512000>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,61.512000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,63.290000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,66.516000>}
box{<0,0,-0.076200><3.226000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,66.516000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,68.294000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,71.519000>}
box{<0,0,-0.076200><3.225000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,71.519000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,73.297000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,74.898000>}
box{<0,0,-0.076200><1.601000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,74.898000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,54.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.525200,0.000000,54.908000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.525200,0.000000,54.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,74.898000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<226.517200,0.000000,74.898000>}
box{<0,0,-0.076200><2.388000,0.036000,0.076200> rotate<0,0.000000,0> translate<224.129200,0.000000,74.898000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.525200,0.000000,54.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.525200,0.000000,74.898000>}
box{<0,0,-0.076200><19.990000,0.036000,0.076200> rotate<0,90.000000,0> translate<217.525200,0.000000,74.898000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.525200,0.000000,54.908000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.322200,0.000000,54.908000>}
box{<0,0,-0.076200><0.203000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.322200,0.000000,54.908000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<217.525200,0.000000,74.898000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,74.898000>}
box{<0,0,-0.076200><6.604000,0.036000,0.076200> rotate<0,0.000000,0> translate<217.525200,0.000000,74.898000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,61.512000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,63.290000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,63.290000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,66.516000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,68.294000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,68.294000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,71.519000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<224.129200,0.000000,73.297000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<224.129200,0.000000,73.297000> }
difference{
cylinder{<222.326200,0,57.397000><222.326200,0.036000,57.397000>1.574800 translate<0,0.000000,0>}
cylinder{<222.326200,-0.1,57.397000><222.326200,0.135000,57.397000>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.846400,0,57.397000><218.846400,0.036000,57.397000>0.584200 translate<0,0.000000,0>}
cylinder{<218.846400,-0.1,57.397000><218.846400,0.135000,57.397000>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.326200,0,62.400800><222.326200,0.036000,62.400800>1.574800 translate<0,0.000000,0>}
cylinder{<222.326200,-0.1,62.400800><222.326200,0.135000,62.400800>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.846400,0,62.400800><218.846400,0.036000,62.400800>0.584200 translate<0,0.000000,0>}
cylinder{<218.846400,-0.1,62.400800><218.846400,0.135000,62.400800>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.326200,0,67.404600><222.326200,0.036000,67.404600>1.574800 translate<0,0.000000,0>}
cylinder{<222.326200,-0.1,67.404600><222.326200,0.135000,67.404600>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.846400,0,67.404600><218.846400,0.036000,67.404600>0.584200 translate<0,0.000000,0>}
cylinder{<218.846400,-0.1,67.404600><218.846400,0.135000,67.404600>0.431800 translate<0,0.000000,0>}}
difference{
cylinder{<222.326200,0,72.408400><222.326200,0.036000,72.408400>1.574800 translate<0,0.000000,0>}
cylinder{<222.326200,-0.1,72.408400><222.326200,0.135000,72.408400>1.422400 translate<0,0.000000,0>}}
difference{
cylinder{<218.846400,0,72.408400><218.846400,0.036000,72.408400>0.584200 translate<0,0.000000,0>}
cylinder{<218.846400,-0.1,72.408400><218.846400,0.135000,72.408400>0.431800 translate<0,0.000000,0>}}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  V2_1(-159.375000,0,-50.000000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//BAT1		BATTCOM_20MM_PTH
//K1	G5L	G5LE
//K2	G5L	G5LE
//K3	G5L	G5LE
//K4	G5L	G5LE
//Q2		TC38H
//S1		TACTILE-PTH
//SG1	BMT1205XH7.5	BMT1205XH7.5
//X1	HD44780LCD-1602	LCD1602
//X2		W237-4
//X3		W237-4
//X4		W237-4
//X5		W237-4
//X6		W237-4
