module full_adder (input wire i0, i1, cin,output wire sum, cout); 
    wire t0, t1, t2; 
    xor3 _i0 (i0, i1, cin, sum);
    and2 _i1 (i0, i1, t0); 
    and2 _i2 (i1, cin, t1); 
    and2 _i3 (cin, i0, t2 );
    or3 _i4 (t0, t1, t2, cout); 
endmodule 


module addsub (  
    input wire addsub, i0, i1, cin, 
    output wire sumdiff, cout 
); 
    wire t; 
    full_adder _i0 (i0, t, cin, sumdiff, cout); 
    xor2 _i1 (i1, addsub, t); 
endmodule 

//--------------------------------  OVERFLOW    --------------------------
module overflow(
    input wire [15:0] i0 ,i1 ,o ,
    output wire oflow
);
    wire q,q1,q2,w1,w2;
    not(q,i0[15] );not(q1,i1[15] );not(q2,o[15] );
    and3 _i0(i0[15] ,i1[15] ,q2,w1);
    and3 _i1(q,q1,o[15] ,w2);
    or(oflow,w1,w2);
endmodule 
//------------------------------------------------------------------------

module Ap ( 
    input wire [1:0] op, 
    input wire i0, i1, cin, 
    output wire o, cout 
);
    wire t_sumdiff, t_and, t_or, t_andor; 
    addsub _i0 (op[0], i0, i1, cin, t_sumdiff, cout); 
    and2 _i1 (i0, i1, t_and ); 
    or2 _i2 (i0, i1, t_or); 
    mux2 _i3 (t_and, t_or,op[0], t_andor); 
    mux2 _i4 (t_sumdiff,t_andor,op[1],o); 
endmodule 


module alu ( 
    input wire [1:0] op, 
    input wire [15:0] i0, i1, 
    output wire [15:0] o, 
    output wire cout
); 
    wire [14:0] c; 
    Ap _i0 (op, i0[0], i1[0], op[0], o[0], c[0]); 
    Ap _i1 (op, i0[1], i1[1], c[0], o[1], c[1]); 
    Ap _i2 (op, i0[2], i1[2], c[1], o[2], c[2]); 
    Ap _i3 (op, i0[3], i1[3], c[2], o[3], c[3]); 
    Ap _i4 (op, i0[4], i1[4], c[3], o[4], c[4]); 
    Ap _i5 (op, i0[5], i1[5], c[4], o[5], c[5]); 
    Ap _i6 (op, i0[6], i1[6], c[5], o[6], c[6]); 
    Ap _i7 (op, i0[7], i1[7], c[6], o[7], c[7]); 
    Ap _i8 (op, i0[8], i1[8], c[7], o[8], c[8]); 
    Ap _i9 (op, i0[9], i1[9], c[8], o[9], c[9]); 
    Ap _i10 (op, i0[10], i1[10], c[9], o[10], c[10]); 
    Ap _i11 (op, i0[11], i1[11], c[10], o[11], c[11]); 
    Ap _i12 (op, i0[12], i1[12], c[11], o[12], c[12]); 
    Ap _i13 (op, i0[13], i1[13], c[12], o[13], c[13]); 
    Ap _i14 (op, i0[14], i1[14], c[13], o[14], c[14]); 
    Ap _i15 (op, i0[15], i1[15], c[14], o[15], cout); 
endmodule
