# ModelSim Executable
VSIM=vsim
VLOG=vlog
VLIB=vlib
VMAP=vmap

# Directories
WORK_DIR=work
SRC_DIR=../Ishan
TB_DIR=../../MS_1_DNN_impl

# Testbenches
TB1=tb_top
TB2=milestone1_tb

# Log Files
LOG1=simulation1.log
LOG2=simulation2.log

# Default Target
all: compile

# Create the work library
$(WORK_DIR):
	$(VLIB) $(WORK_DIR)
	$(VMAP) $(WORK_DIR) $(WORK_DIR)

# Compile all design and testbench files
compile: $(WORK_DIR)
	$(VLOG) -work $(WORK_DIR) $(SRC_DIR)/*.sv
	$(VLOG) -work $(WORK_DIR) $(TB_DIR)/top_tb.sv
	$(VLOG) -work $(WORK_DIR) milestone1_tb.sv

# Run Testbench 1
run_tb1: compile
	@echo "Running $(TB1)..."
	$(VSIM) -c work.$(TB1) -do "run -all; quit" | tee $(LOG1)

# Run Testbench 2
run_tb2: compile
	@echo "Running $(TB2)..."
	$(VSIM) -c work.$(TB2) -do "run -all; quit" | tee $(LOG2)

# Run both testbenches
run_both: run_tb1 run_tb2
	@echo "Both testbenches completed."

# Clean compiled files
clean:
	rm -rf $(WORK_DIR) $(LOG1) $(LOG2) transcript vsim.wlf

.PHONY: all compile run_tb1 run_tb2 run_both clean
