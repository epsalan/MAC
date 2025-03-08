module unsig_altmult_accum_tb();
  
  // Define parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Signals
  reg clk;
  reg aclr;
  reg clken;
  reg sload;
  reg [7:0] dataa;
  reg [7:0] datab;
  wire [15:0] adder_out;

  // Instantiate the unsig_altmult_accum module
  unsig_altmult_accum uut (
      .dataa(dataa),
      .datab(datab),
      .clk(clk),
      .aclr(aclr),
      .clken(clken),
      .sload(sload),
      .adder_out(adder_out)
  );

  // Clock generation
  always #((CLK_PERIOD/2)) clk = ~clk;

  // Stimulus
  initial begin
    // Initialize signals
    clk = 0;
    aclr = 0;
    clken = 0;
    sload = 0;
    dataa = 8'h00;
    datab = 8'h00;

    // Apply reset
    #10 aclr = 1;
    #10 aclr = 0;
    
    // Load dataa and datab
    #10 dataa = 8'hFF;
    #10 datab = 8'hFF;
    
    // Enable accumulator
    #10 clken = 1;

    // Load data into accumulator
    #10 sload = 1;
    #10 sload = 0;
    
    // Check the result
    #10 if (adder_out !== 8'h02) $fatal("Test failed");
    
    


    // Finish simulation
    $finish;
  end

endmodule
