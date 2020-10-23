%% configurations

% resonator
total_l = 0.006885414968703*1e6;

trace_w = 8;
gap_w = 5;

                
% horseshoe couplers

coupler_w = 20;
coupling_l_in = 20; %  to get 1.0953e-15 coupling C
coupling_l_out = 40; % to get 2.0274e-15 coupling C 
% feedlines
feedlines_l = 200;

% launchers
launcher_params.contact_size = 300; 
launcher_params.adiabatic_l = 1000;
%launcher_params.boundary_w = 200; 

% die
die_l = 4e3; %length of die
die_w = 12e3; %width of boundary  
width = 100;

frame_l = die_l + width;
frame_w= die_w + width;
%%
clf
resonator = coplanar_line(total_l, trace_w, gap_w, [1,1]);%.draw();
input_coupler = horseshoe_coupler(coupling_l_in).place('output', resonator.ports.input);%.draw();
output_coupler = horseshoe_coupler(coupling_l_out).reflect([0,1]).place('output', resonator.ports.output);%.draw();
input_feedline = coplanar_line(feedlines_l, trace_w, gap_w).place('output', input_coupler.ports.input);%.draw();
output_feedline = coplanar_line(feedlines_l, trace_w, gap_w).reflect([0,1]).place('output', output_coupler.ports.input);%.draw();
input_launcher = launcher(launcher_params).place('output', input_feedline.ports.input);%.draw();
output_launcher = launcher(launcher_params).reflect([0,1]).place('output', output_feedline.ports.input);%.draw();

design = compound_element(resonator, input_coupler, output_coupler, input_feedline, output_feedline, input_launcher, output_launcher);%.draw();

design_arr = design.duplicate([2,2], [4e3, 12e3]).draw();

dicing_frame = rect_frame(frame_w, frame_l, width);

dicing_frame_arr = dicing_frame.duplicate([2,2], [frame_l, frame_w]).draw();


