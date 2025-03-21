lappend search_path "/filespace/i/imoondra/'ECE 755'/MS_3_Synthesis"

analyze -library work -format sverilog { ReLU_v2.sv Neuron_v2.sv Output_layer_v2.sv Hidden_layer_v2.sv GNN.sv }
