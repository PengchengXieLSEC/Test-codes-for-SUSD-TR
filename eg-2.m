N=100;X=zeros(2,3);f=zeros(N,3); v1=zeros(2,N); alpha=zeros(1,3); Delta=5;
X(1,1)=20; X(2,1)=0; X(1,2)=23; X(2,2)=4; X(1,3)=23; X(2,3)=-4;

hold on

[x,y]=meshgrid(-30:1:30,-25:1:30);
z=1*(y-x.^2).^2+(1-x).^2;
contour(x,y,z,100); colorbar;
 title('$f(x_1,x_2)=(x_2-x_1^2)^2+(1-x_1)^2$','interpreter','latex','Fontsize',65);
 set(gca,'FontSize',60);
 xlabel('$x_1$','interpreter','latex','Fontsize',65);
 ylabel('$x_2$','interpreter','latex','Fontsize',65);
%clabel(C,h,'FontSize',10,'Color','r','LabelSpacing',72,'Rotation',0);
%text_handle = clabel(C,h);
%set(text_handle,'BackgroundColor',[1 1 .6],'Edgecolor',[.7 .7 .7])
hold on

    for t=1:N-1
        X;  hold on
        plot(X(1,1),X(2,1),'*','color','g','MarkerFaceColor','g','MarkerSize',15);
        plot(X(1,2),X(2,2),'*','color','b','MarkerFaceColor','b','MarkerSize',15);
        plot(X(1,3),X(2,3),'*','color','cyan','MarkerFaceColor','cyan','MarkerSize',15); 
       
        %plot(xnew(1),xnew(2),'o','color','black','MarkerSize',15); 

        for i=1:3
            f(t,i)=square(X(:,i));
        end
        fmin=min(f(t,:)); alpha(1,:)=1*(1-exp(fmin-f(t,:)));
        Xc=(X(:,1)+X(:,2)+X(:,3))/3; C=zeros(2,2); 
        plot(Xc(1,1),Xc(2,1),'ro','color','r','MarkerFaceColor','r','MarkerSize',15); 
        for i=1:3
        C=C+(X(:,i)-Xc)*(X(:,i)-Xc)';
        end
        [U,V]=eig(C); [mu,index_eig]=min(diag(V));
        v1(:,t)=U(:,index_eig);
        for i=1:3
            X(:,i)=X(:,i)+alpha(1,i)*v1(:,t);
        end
        %a=Xc(1,1);b=Xc(2,1);
        %xnew = fminsearch(@(x) myfun(x,a,b),[a,b]);
        %[f_max,index_f_max]=max(f(t,:));
        %index_f_max;
        %X(:,index_f_max)=xnew;
        X;
    end


function f=square(x)
    f=(1-x(1))^2+1*(x(2)-x(1))^2;
end

function f = myfun(x,a,b)

f = (1-x(1))^2+1*(x(2)-x(1))^2+10*((x(1)-a)^2 + (x(2)-b)^2-1)^2;

end

