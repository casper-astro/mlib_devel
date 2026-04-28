Please inspect this repository and help me generalize the Intel/Quartus support in the CASPER toolflow.

My priorities are:
1. make the code structurally support Intel boards beyond DE10-Nano
2. keep DE10-Nano working
3. then get a minimal adder demo working with casperfpga
4. then integrate an existing FFT block

Start by doing codebase analysis only. I want:
- where the generic Quartus logic lives
- where the DE10-Nano-specific assumptions live
- where paths/output handling are brittle
- where generated HDL/glue/QIP/constraints are being added
- what should move into board-specific abstractions
- a phased refactor plan

Be conservative. Do not rewrite code yet until you present the plan.