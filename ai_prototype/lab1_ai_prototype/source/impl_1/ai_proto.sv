module led_blinker_2hz (
    output logic led  // Connect this to the physical LED in the constraints file
);

    // ============================================================
    // Internal High-Speed Oscillator (48 MHz) Instantiation
    // ============================================================
    logic clk_hsosc;

    // Lattice-specific oscillator primitive
    // CLKHF_DIV = "00" → No division → 48 MHz
    HSOSC #(
        .CLKHF_DIV("0b00")  // Divide by 1 = 48 MHz
    ) hsosc_inst (
        .CLKHFEN(1'b1),     // Enable oscillator
        .CLKHFPU(1'b1),     // Power up oscillator
        .CLKHF(clk_hsosc)   // Output clock
    );

    // ============================================================
    // Blink Logic (2 Hz Blink Rate)
    // ============================================================

    // For 2 Hz blink (toggle every 0.5 s) at 48 MHz:
    localparam int unsigned MAX_COUNT = 48_000_000 / 2;  // 0.5 seconds worth of cycles

    // Minimum width of counter needed
    logic [$clog2(MAX_COUNT)-1:0] counter = '0;

    always_ff @(posedge clk_hsosc) begin
        if (counter == MAX_COUNT - 1) begin
            counter <= '0;
            led <= ~led;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule