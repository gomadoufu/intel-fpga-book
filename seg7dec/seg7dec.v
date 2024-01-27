module seg7dec (
        input [3:0] sw,
        output reg [6:0] hex0
    );

    /* 7セグメント表示デコーダ
       各セグメントはgfedcbaの並びで0で点灯 */
    always @* begin
        case(sw)
            4'h0: hex0 = 7'b1000000;
            4'h1: hex0 = 7'b0111101;
            4'h2: hex0 = 7'b0100100;
            4'h3: hex0 = 7'b0110000;
            4'h4: hex0 = 7'b0011001;
            4'h5: hex0 = 7'b0010010;
            4'h6: hex0 = 7'b0000010;
            4'h7: hex0 = 7'b1011000;
            4'h8: hex0 = 7'b0000000;
            4'h9: hex0 = 7'b0010000;
            4'ha: hex0 = 7'b0001000;
            4'hb: hex0 = 7'b0000011;
            4'hc: hex0 = 7'b1000110;
            4'hd: hex0 = 7'b0100001;
            4'he: hex0 = 7'b0000110;
            4'hf: hex0 = 7'b0001110;
            default:hex0 = 7'b1111111;
        endcase
    end

endmodule
