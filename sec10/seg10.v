module SEC10(
        input CLK, RST,
        output reg [6:0] HEX0
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

    /* 10進カウンタ (1秒桁) */
    reg [3:0] sec;

    always @( posedge CLK ) begin
        if ( RST )
            sec <= 4'h0;
        else if (en1hz)
            if ( sec == 4'h9 )
                sec <= 4'h0;
            else
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
endmodule
