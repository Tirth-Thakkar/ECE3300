module top_pwm_leds(
    input  wire clk,      
    input  wire rst,
    input  wire [7:0]  d_cycle_sw,      
    input  wire [2:0]  load_sw,         
    input  wire [4:0]  speed_ctrl_sw,   

    output wire led1_r,
    output wire led1_g,
    output wire led1_b,

    output wire led2_r,
    output wire led2_g,
    output wire led2_b
);

    
    wire clk_8mhz;
    wire pll_locked;

    clk_wiz_2 pll_inst (
        .clk_in1(clk),
        .clk_out1(clk_8mhz),
        .reset(rst),
        .locked(pll_locked)
    );

   
    wire [7:0] duty_in = d_cycle_sw;   // 0-255
    wire load_r = load_sw[0];
    wire load_g = load_sw[1];
    wire load_b = load_sw[2];
    wire [4:0] speed_ctrl = speed_ctrl_sw;

    
    wire slow_clk;

    speed_controller speed_div_inst (
        .clk(clk_8mhz),
        .rst(rst),
        .speed(speed_ctrl),
        .clk_out(slow_clk)
    );

    
    wire [7:0] duty_r;
    wire [7:0] duty_g;
    wire [7:0] duty_b;

    counter_8bit ctr_r (.clk(slow_clk), .rst(rst), .load(load_r), .load_val(duty_in), .count(duty_r));
    counter_8bit ctr_g (.clk(slow_clk), .rst(rst), .load(load_g), .load_val(duty_in), .count(duty_g));
    counter_8bit ctr_b (.clk(slow_clk), .rst(rst), .load(load_b), .load_val(duty_in), .count(duty_b));

   
    pwm_8bit pwm_1_r (.clk(clk_8mhz), .duty(duty_r), .pwm_out(led1_r));
    pwm_8bit pwm_1_g (.clk(clk_8mhz), .duty(duty_g), .pwm_out(led1_g));
    pwm_8bit pwm_1_b (.clk(clk_8mhz), .duty(duty_b), .pwm_out(led1_b));

    
    wire [7:0] duty_r_shift = {duty_r[2:0], duty_r[7:3]};  
    wire [7:0] duty_g_shift = {duty_g[3:0], duty_g[7:4]};  
    wire [7:0] duty_b_shift = {duty_b[1:0], duty_b[7:2]};  

    
    pwm_8bit pwm_2_r (.clk(clk_8mhz), .duty(duty_r_shift), .pwm_out(led2_r));
    pwm_8bit pwm_2_g (.clk(clk_8mhz), .duty(duty_g_shift), .pwm_out(led2_g));
    pwm_8bit pwm_2_b (.clk(clk_8mhz), .duty(duty_b_shift), .pwm_out(led2_b));
endmodule