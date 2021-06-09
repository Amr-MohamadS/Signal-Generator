fs=input('Enter the frequency sampling: ');
n=input('Enter the start of time scale: ');
m=input('Enter the end of time scale: ');
bp_number=input('Enter the number of break points: ');
bpt=zeros(1,bp_number);
signal=zeros(1,0);
t=linspace(n,m,((m-n)*fs));

for i= 1:bp_number
   fprintf('Enter the position of breakpoint %i: ',i);
   bpt(i)=input('');
end  

fprintf('\n');
T=[n bpt m];
poly=0;
for j=1:bp_number+1
    fprintf('----------------------------------------------------------------------\n');
    fprintf('1-DC signal\t 2-Ramp Signal\t3-General Order Polynomial\n4-Exponential Signal\t5-Sinusoidal Signal\n');
    fprintf('-----------------------------------------------------------------------\n\n');
    fprintf('for the interval %0.1f to %0.1f Enter the type of the signal: ',T(j),T(j+1));
    x=input('');
    
    switch x
        case 1
            fprintf('Enter the amplitude: ');
            amp=input('');
            fprintf('\n');
            DC=amp*ones(1,int16((T(j+1)-T(j))*fs));
            signal=[signal DC];
        case 2
            t1=linspace(T(j),T(j+1),(T(j+1)-T(j))*fs);
            fprintf('Enter the slope: ');
            slope=input('');
            fprintf('Enter the intercept: ');
            incpt=input('');
            fprintf('\n');
            ramp=slope*t1+incpt;
            signal=[signal ramp];
        case 3
            t2=linspace(T(j),T(j+1),(T(j+1)-T(j))*fs);
            fprintf('Enter equation in the form a(t^p)+b(t^(p-1))+...+c\n');
            fprintf('Power(p) = ');
            p=input('');
            z=p;
            for k=1:p
                fprintf('enter the coefficient of t^%i: ',z);
                a=input('');
                poly=poly+(a*(t2.^z));
                z=z-1;
            end
            fprintf('Intercept(c)= ');
            c=input('');
            poly=poly+c;
            signal=[signal poly];
        case 4
            t3=linspace(T(j),T(j+1),(T(j+1)-T(j))*fs);
            fprintf('Enter equation in the form A(e^Pt)\n');
            fprintf('Amplitude(A) = ');
            A=input('');
            fprintf('Power(P) = ');
            P=input('');
            expo=A*exp(P*t3);
            signal=[signal expo];
        case 5
             t4=linspace(T(j),T(j+1),(T(j+1)-T(j))*fs);
             fprintf('Enter equation in the form Asin(wt+phase)\n');
             fprintf('Amplitude(A) = ');
             amplitude=input('');
             fprintf('Frequency(w) = ');
             w=input('');
             fprintf('Phase (in degrees)= ');
             phase=deg2rad(input(''));
             sinusoidal=amplitude*sin((2*pi*w*t4)+phase);
             signal=[signal sinusoidal];
        otherwise 
            fprintf('Please enter a valid number\n');
    end    
end
plot(t,signal);
grid;

while true 
    fprintf('----------------------------------------------------------------------\n');
    fprintf('\t\t\t\t\t| Operations |\n');
    fprintf('----------------------------------------------------------------------\n');
    fprintf('1-Amplitude Scaling\t 2-Time Reversal\t3-Time Shift\n4-Expanding the signal\t5-Compressing the signal\t6-None\n');
    fprintf('-----------------------------------------------------------------------\n\n');
    fprintf('Choose an operation: ');
    y=input('');
    switch y
        case 1
            fprintf('Enter scaling value : ');
            v=input('');
            signal=v*signal;
        case 2
            t=-1*t;
        case 3
            fprintf('Enter time shift value : ');
            shift=input('');
            t=t-shift;
        case 4
            fprintf('Enter the expanding value : ');
            k=input('');
            t=t*k;
        case 5
            fprintf('Enter the compressing value : ');
            l=input('');
            t=t/l;
        case 6
            break
        otherwise
             fprintf('Please enter a valid number\n');    
    end
    fprintf('Done? 1-Yes  2-No ');
    yn=input('');
    if yn==1
        break
    end
end

plot(t,signal);
grid;