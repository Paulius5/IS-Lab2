clear;
x=1/20:1/20:1;
y = (1 + 0.6  * sin (2  * pi  * x / 0.7) + 0.3  * sin (2  * pi  * x)) / 2;
w11=randn(1);
w12=randn(1);
w13=randn(1);
w14=randn(1);
w15=randn(1);
w16=randn(1);
w17=randn(1);
w18=randn(1);
b11=randn(1);
b12=randn(1);
b13=randn(1);
b14=randn(1);
b15=randn(1);
b16=randn(1);
b17=randn(1);
b18=randn(1);
w21=randn(1);
w22=randn(1);
w23=randn(1);
w24=randn(1);
w25=randn(1);
w26=randn(1);
w27=randn(1);
w28=randn(1);
b2=randn(1);
n=0;
T=1;
z=10000;
s=0.2;
ndelay=0;
ndelay2=0;
cntdown=0;
delay_prev=0;
delay2_prev=0;
min_reached = 0;
while(T~=0)
    delay_prev=ndelay;
    delay2_prev=ndelay2;

Tprevious=T;
T=0;
tic;
for(k=1:20)
    v21(k)=w11*x(k)+b11;
    x21(k)=1/(1+exp(-v21(k)));
    v22(k)=w12*x(k)+b12;
    x22(k)=1/(1+exp(-v22(k)));
    v23(k)=w13*x(k)+b13;
    x23(k)=1/(1+exp(-v23(k)));
    v24(k)=w14*x(k)+b14;
    x24(k)=1/(1+exp(-v24(k)));
    v25(k)=w15*x(k)+b15;
    x25(k)=1/(1+exp(-v25(k)));
    v26(k)=w16*x(k)+b16;
    x26(k)=1/(1+exp(-v26(k)));
    v27(k)=w17*x(k)+b17;
    x27(k)=1/(1+exp(-v27(k)));
    v28(k)=w18*x(k)+b18;
    x28(k)=1/(1+exp(-v28(k)));
    v2(k)=x21(k)*w21+x22(k)*w22+x23(k)*w23+x24(k)*w24+x25(k)*w25+x26(k)*w26+x27(k)*w27+x28(k)*w28+b2;
    y2(k)=v2(k);
    e(k)=y(k)-y2(k);
    T=T+abs(e(k));

    w21=w21+x21(k)*s*e(k);
    w22=w22+x22(k)*s*e(k);
    w23=w23+x23(k)*s*e(k);
    w24=w24+x24(k)*s*e(k);
    w25=w25+x25(k)*s*e(k);
    w26=w26+x26(k)*s*e(k);
    w27=w27+x27(k)*s*e(k);
    w28=w28+x28(k)*s*e(k);
    b2=b2+s*e(k);
    w11=w11+s*e(k)*w21*x21(k)*(1-x21(k))*x(k);
    b11=b11+s*e(k)*w21*x21(k)*(1-x21(k));
    w12=w12+s*e(k)*w22*x22(k)*(1-x22(k))*x(k);
    b12=b12+s*e(k)*w22*x22(k)*(1-x22(k));
    w13=w13+s*e(k)*w23*x23(k)*(1-x23(k))*x(k);
    b13=b13+s*e(k)*w23*x23(k)*(1-x23(k));
    w14=w14+s*e(k)*w24*x24(k)*(1-x24(k))*x(k);
    b14=b14+s*e(k)*w24*x24(k)*(1-x24(k));
    w15=w15+s*e(k)*w25*x25(k)*(1-x25(k))*x(k);
    b15=b15+s*e(k)*w25*x25(k)*(1-x25(k));
    w16=w16+s*e(k)*w26*x26(k)*(1-x26(k))*x(k);
    b16=b16+s*e(k)*w26*x26(k)*(1-x26(k));
    w17=w17+s*e(k)*w27*x27(k)*(1-x27(k))*x(k);
    b17=b17+s*e(k)*w27*x27(k)*(1-x27(k));
    w18=w18+s*e(k)*w28*x28(k)*(1-x28(k))*x(k);
    b18=b18+s*e(k)*w28*x28(k)*(1-x28(k));
    
end

z=min(z,T);

n=n+1;
tsim=toc;

if (z ~= 0)
    if (T/z > 1)
    ndelay=ndelay+1;
    end
end
    if (s > 0.05)
        if (ndelay == 10000)
        ndelay=0;
        s=s-0.01;
        end 
    else
        ndelay=0;
    end
if (round(T,7,'significant')-round(Tprevious,7,'significant') == 0);
    if (min_reached == 0)    
    ndelay2=ndelay2+1;
        if (ndelay2 == 1000)
            ndelay2=0;
        if (s > 0.000005)
            s=s-0.000001;
        end
        if (s == 0.000005)
            min_reached = 1;
        end
        end
    else 
        s=0.2;
        min_reached=0;
    end
end

if (ndelay == delay_prev)
    ndelay = 0;
end
if (ndelay2 == delay2_prev)
    ndelay2=0;
end
if (ndelay == 0)
        cntdown = 0;
else
    cntdown=10000-ndelay;
end
if (ndelay2 == 0)
    cntdown2 = 0;
else
    cntdown2 = 1000-ndelay2;
end
fprintf('E(%.0f) = %.7f, min E = %.4f, step = %.6f, step decrease countdowns: %.0f, %.0f\n', n, T, z, s, cntdown, cntdown2);
end


    