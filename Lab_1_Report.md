# Task 1 - Simulating a Basic 8-bit Binary Counter

## TEST YOURSELF CHALLENGES:
1. Modify the testbench so that you stop counting for 3 cycles once the counter reaches `0x9`, and then resume counting. You may also need to change the stimulus for `rst`.

```cpp
#include "Vcounter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;
    int pause_cycles = 3;

    Verilated::commandArgs(argc, argv);
    Vcounter* top = new Vcounter;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("counter.vcd");

    top->clk = 1;
    top->rst = 1;
    top->en = 0;

    for (i = 0; i < 300; i++) {
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2 * i + clk);
            top->clk = !top->clk;
            top->eval();
        }
        top->rst = (i < 2);

        if (top->count == 0x9 && pause_cycles > 0) {
            top->en = 0;
            pause_cycles--;
        } else {
            top->en = (i > 4); 
        }

        if (Verilated::gotFinish()) exit(0);
    }

    tfp->close();
    exit(0);
}
