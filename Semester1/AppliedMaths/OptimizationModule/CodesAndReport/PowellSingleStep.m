function [x, e2, d1] = PowellSingleStep(testfunction, error, x0, e1, e2)

distance = 10*error;  %step distance

x1 = x0;
subplot(1,2,2);
plot(x0(1),x0(2),'--rs');

z1 = testfunction(x1(1),x1(2));
x_next = x1 + distance.*e1;
z_next = testfunction(x_next(1),x_next(2));
difference = z_next - z1;
if(difference < 0)
    while(abs(difference) > error) %search in one dimension, direction: unit vector e1, step distance: n error
        x1 = x_next;
        z1 = testfunction(x1(1),x1(2));
        x_next = x1 + distance.*e1;
        z_next = testfunction(x_next(1),x_next(2));
        difference = z_next - z1;
    end
else
    while(abs(difference) > error) %search in one dimension, direction: unit vector e1, step distance: n error
        x1 = x_next;
        z1 = testfunction(x1(1),x1(2));
        x_next = x1 - distance.*e1;
        z_next = testfunction(x_next(1),x_next(2));
        difference = z_next - z1;
    end
end

x1 = (x_next + x1)./2;   %x1 located
subplot(1,2,2);
plot(x1(1),x1(2),'--rs');

plot([x0(1),x1(1)],[x0(2),x1(2)],'-b');

x2 = x1;
z2 = testfunction(x2(1),x2(2));
x_next = x2 + distance.*e2;
z_next = testfunction(x_next(1),x_next(2));
difference = z_next - z2;
if(difference < 0)
    while(abs(difference) > error) %search in one dimension, direction: unit vector e2, step distance: n error
        x2 = x_next;
        z2 = testfunction(x2(1),x2(2));
        x_next = x2 + distance.*e2;
        z_next = testfunction(x_next(1),x_next(2));
        difference = z_next - z2;
    end
else
    while(abs(difference) > error) %search in one dimension, direction: unit vector e2, step distance: n error
        x2 = x_next;
        z2 = testfunction(x2(1),x2(2));
        x_next = x2 - distance.*e2;
        z_next = testfunction(x_next(1),x_next(2));
        difference = z_next - z2;
    end
end

x2 = (x_next + x2)./2;   %x2 located
subplot(1,2,2);
plot(x2(1),x2(2),'--rs');

plot([x1(1),x2(1)],[x1(2),x2(2)],'-b');

d1 = x2 - x0;
d1 = d1./norm(d1);

x = x2;
z = testfunction(x(1),x(2));
x_next = x + distance.*d1;
z_next = testfunction(x_next(1),x_next(2));
difference = z_next - z;
if(difference < 0)
    while(abs(difference) > error) %search in one dimension, direction: unit vector d1, step distance: n error
        x = x_next;
        z = testfunction(x(1),x(2));
        x_next = x + distance.*d1;
        z_next = testfunction(x_next(1),x_next(2));
        difference = z_next - z;
    end
else
    while(abs(difference) > error) %search in one dimension, direction: unit vector d1, step distance: n error
        x = x_next;
        z = testfunction(x(1),x(2));
        x_next = x - distance.*d1;
        z_next = testfunction(x_next(1),x_next(2));
        difference = z_next - z;
    end
end

x = (x + x_next)./2;
subplot(1,2,2);
plot(x(1),x(2),'--rs');
xlabel({['x = ', num2str(x(1))], ['y = ', num2str(x(2))],['z = ', num2str(z)]});

plot([x2(1),x(1)],[x2(2),x(2)],'-b');

end