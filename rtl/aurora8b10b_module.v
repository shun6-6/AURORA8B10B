`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 09:47:26
// Design Name: 
// Module Name: aurora8b10b_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module aurora8b10b_module(
    input           i_gtref_clk_p               ,
    input           i_gtref_clk_n               ,
    input           i_clk_100M                  ,
    input           i_rst                       ,
    output [1 :0]   gt_txp                      ,
    output [1 :0]   gt_txn                      ,
    input  [1 :0]   gt_rxp                      ,
    input  [1 :0]   gt_rxn                      ,

    input  [31:0]   s_axi_c0_tx_tdata           ,
    input  [3 :0]   s_axi_c0_tx_tkeep           ,
    input           s_axi_c0_tx_tlast           ,
    input           s_axi_c0_tx_tvalid          ,
    output          s_axi_c0_tx_tready          ,
    output [31:0]   m_axi_c0_rx_tdata           ,
    output [3 :0]   m_axi_c0_rx_tkeep           ,
    output          m_axi_c0_rx_tlast           ,
    output          m_axi_c0_rx_tvalid          ,

    input  [31:0]   s_axi_c1_tx_tdata           ,
    input  [3 :0]   s_axi_c1_tx_tkeep           ,
    input           s_axi_c1_tx_tlast           ,
    input           s_axi_c1_tx_tvalid          ,
    output          s_axi_c1_tx_tready          ,
    output [31:0]   m_axi_c1_rx_tdata           ,
    output [3 :0]   m_axi_c1_rx_tkeep           ,
    output          m_axi_c1_rx_tlast           ,
    output          m_axi_c1_rx_tvalid          ,

    output          o_c0_hard_err               ,
    output          o_c0_soft_err               ,
    output          o_c0_frame_err              ,
    output          o_c0_channel_up             ,
    output          o_c0_lane_up                ,
    input  [2 :0]   i_c0_loopback               ,
    output          o_c1_hard_err               ,
    output          o_c1_soft_err               ,
    output          o_c1_frame_err              ,
    output          o_c1_channel_up             ,
    output          o_c1_lane_up                ,
    input  [2 :0]   i_c1_loopback               ,

    output          o_c0_user_clk               ,
    output          o_c0_user_rst               ,
    output          o_c1_user_clk               ,
    output          o_c1_user_rst               
);

wire                gt_ref_clk                  ;
wire                gt_qplllock_in              ;
wire                gt_qpllrefclklost_in        ;
wire                gt_qpllreset_out            ;
wire                gt_qpllclk_quad3_in         ;
wire                gt_qpllrefclk_quad3_in      ; 

IBUFDS_GTE2 #(
    .CLKCM_CFG                  ("TRUE"                 ),
    .CLKRCV_TRST                ("TRUE"                 ),
    .CLKSWING_CFG               (2'b11                  )  
)                   
IBUFDS_GTE2_inst (                  
    .O                          (gt_ref_clk             ),         
    .ODIV2                      (                       ), 
    .CEB                        (0                      ),     
    .I                          (i_gtref_clk_p          ),         
    .IB                         (i_gtref_clk_n          )        
);

aurora_8b10b_0_gt_common_wrapper gt_common_support_u0
(
    .gt_qpllclk_quad3_i         (gt_qpllclk_quad3_in    ),
    .gt_qpllrefclk_quad3_i      (gt_qpllrefclk_quad3_in ),
    .gt0_gtrefclk0_common_in    (gt_ref_clk             ),
    .gt0_qplllock_out           (gt_qplllock_in         ),
    .gt0_qplllockdetclk_in      (i_clk_100M             ),
    .gt0_qpllrefclklost_out     (gt_qpllrefclklost_in   ),
    .gt0_qpllreset_in           (gt_qpllreset_out       )
);


aurora8b10b_channel aurora_channel_u0(
    .i_clk_100M                 (i_clk_100M             ),
    .i_rst                      (i_rst                  ),
    .i_gtref_clk                (gt_ref_clk             ),         
    .gt_txp                     (gt_txp[0]              ),
    .gt_txn                     (gt_txn[0]              ),
    .gt_rxp                     (gt_rxp[0]              ),
    .gt_rxn                     (gt_rxn[0]              ),
    .s_axi_tx_tdata             (s_axi_c0_tx_tdata      ),
    .s_axi_tx_tkeep             (s_axi_c0_tx_tkeep      ),
    .s_axi_tx_tlast             (s_axi_c0_tx_tlast      ),
    .s_axi_tx_tvalid            (s_axi_c0_tx_tvalid     ),
    .s_axi_tx_tready            (s_axi_c0_tx_tready     ),
    .m_axi_rx_tdata             (m_axi_c0_rx_tdata      ),
    .m_axi_rx_tkeep             (m_axi_c0_rx_tkeep      ),
    .m_axi_rx_tlast             (m_axi_c0_rx_tlast      ),
    .m_axi_rx_tvalid            (m_axi_c0_rx_tvalid     ),
    
    .o_hard_err                 (o_c0_hard_err          ),
    .o_soft_err                 (o_c0_soft_err          ),
    .o_frame_err                (o_c0_frame_err         ),
    .o_channel_up               (o_c0_channel_up        ),
    .o_lane_up                  (o_c0_lane_up           ),
    .i_loopback                 (i_c0_loopback          ),

    .o_user_clk                 (o_c0_user_clk          ),
    .o_user_rst                 (o_c0_user_rst          ),
    
    .gt0_qplllock_in            (gt_qplllock_in         ),
    .gt0_qpllrefclklost_in      (gt_qpllrefclklost_in   ),
    .gt0_qpllreset_out          (gt_qpllreset_out       ),
    .gt_qpllclk_quad3_in        (gt_qpllclk_quad3_in    ),
    .gt_qpllrefclk_quad3_in     (gt_qpllrefclk_quad3_in )
);


aurora8b10b_channel aurora_channel_u1(
    .i_clk_100M                 (i_clk_100M             ),
    .i_rst                      (i_rst                  ),
    .i_gtref_clk                (gt_ref_clk             ),
    .gt_txp                     (gt_txp[1]              ),
    .gt_txn                     (gt_txn[1]              ),
    .gt_rxp                     (gt_rxp[1]              ),
    .gt_rxn                     (gt_rxn[1]              ),
    .s_axi_tx_tdata             (s_axi_c1_tx_tdata      ),
    .s_axi_tx_tkeep             (s_axi_c1_tx_tkeep      ),
    .s_axi_tx_tlast             (s_axi_c1_tx_tlast      ),
    .s_axi_tx_tvalid            (s_axi_c1_tx_tvalid     ),
    .s_axi_tx_tready            (s_axi_c1_tx_tready     ),
    .m_axi_rx_tdata             (m_axi_c1_rx_tdata      ),
    .m_axi_rx_tkeep             (m_axi_c1_rx_tkeep      ),
    .m_axi_rx_tlast             (m_axi_c1_rx_tlast      ),
    .m_axi_rx_tvalid            (m_axi_c1_rx_tvalid     ),
    
    .o_hard_err                 (o_c1_hard_err          ),
    .o_soft_err                 (o_c1_soft_err          ),
    .o_frame_err                (o_c1_frame_err         ),
    .o_channel_up               (o_c1_channel_up        ),
    .o_lane_up                  (o_c1_lane_up           ),
    .i_loopback                 (i_c1_loopback          ),

    .o_user_clk                 (o_c1_user_clk          ),
    .o_user_rst                 (o_c1_user_rst          ),
    
    .gt0_qplllock_in            (gt_qplllock_in         ),
    .gt0_qpllrefclklost_in      (gt_qpllrefclklost_in   ),
    .gt0_qpllreset_out          (                       ),
    .gt_qpllclk_quad3_in        (gt_qpllclk_quad3_in    ),
    .gt_qpllrefclk_quad3_in     (gt_qpllrefclk_quad3_in )
);

endmodule
