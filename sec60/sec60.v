module SEC60(
        input CLK, RST,
        output reg [6:0] HEX0,
        output reg [6:0] HEX1
    );

    /* 1Hzのイネーブル信号生成(クロック周波数: 50MHz) */

    reg [25:0] cnt;
    wire en1hz = (cnt == 26'd49_999_999); // 内部クロックが 50MHz / 50_000_000 = 1Hz

    always @( posedge CLK ) begin
        if ( RST )
            cnt <= 26'b0;
        else if (en1hz) // カウントが上限に達したらリセット
            cnt <= 26'b0;
        else
            cnt <= cnt + 26'b1;
    end

    /* カウンタ */
    reg [3:0] sec;
    reg [3:0] ten_sec;

    always @( posedge CLK ) begin
        if ( RST )begin
            sec <= 4'h0;
            ten_sec <= 4'h0;
        end
        else if (en1hz)
            if ( ten_sec == 4'h5 )
                ten_sec <= 4'h0;
        if ( sec == 4'h9 ) begin
            sec <= 4'h0;
            ten_sec <= ten_sec + 4'h1;
        end else
            sec <= sec + 4'h1;
    end


    /* 7セグメント表示デコーダ */
    /* 各セグメントはgfedcbaの並びで0が点灯 */
    always @* begin
        case ( sec )
            4'h0: HEX0 = 7'b100_0000;
            4'h1: HEX0 = 7'b111_1001;
            4'h2: HEX0 = 7'b010_0100;
            4'h3: HEX0 = 7'b011_0000;
            4'h4: HEX0 = 7'b001_1001;
            4'h5: HEX0 = 7'b001_0010;
            4'h6: HEX0 = 7'b000_0010;
            4'h7: HEX0 = 7'b111_1000;
            4'h8: HEX0 = 7'b000_0000;
            4'h9: HEX0 = 7'b001_0000;
            default: HEX0 = 7'bxxxxxxx;
        endcase
    end

    always @* begin
        case ( ten_sec )
            4'h0: HEX1 = 7'b100_0000;
            4'h1: HEX1 = 7'b111_1001;
            4'h2: HEX1 = 7'b010_0100;
            4'h3: HEX1 = 7'b011_0000;
            4'h4: HEX1 = 7'b001_1001;
            4'h5: HEX1 = 7'b001_0010;
            default: HEX1 = 7'bxxxxxxx;
        endcase
    end
endmodule
