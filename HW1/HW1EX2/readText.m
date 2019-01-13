function [lb,tex]=readText(ll)
c='a';
w=[];
i=1;
tex=cell(200,1);
while(c~=9)
   c=ll(i);
   w=[w c];
   i=i+1;
end
lb=cell(1,1);
lb{1}=w(1:end-1);
n=1;
while i<=length(ll)
 w=[];
 c=ll(i);
 while(c~=' ' && i<length(ll))
   w=[w c];
   i=i+1;
   c=ll(i); 
 end
 if(c~=' ')
     w=[w c];
 end
  tex{n}=w;
  n=n+1;
  i=i+1;
end
tex=tex(1:n-1);