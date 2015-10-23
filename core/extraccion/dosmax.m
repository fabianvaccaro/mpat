%encuentra los dos picos máximos en un histograma
function [pmax1,vmax1,pmax2,vmax2]=dosmax(hist_in)
[pks,locs]=findpeaks(hist_in,'SORTSTR','descend');

if numel(pks)==0
    vmax1=0;
    pmax1=0;
    vmax2=0;
    pmax2=0;

elseif numel(pks)==1
    vmax1=pks(1);
    pmax1=locs(1);
    vmax2=vmax1;
    pmax2=pmax1;
else
    vmax1=pks(1);
    pmax1=locs(1);
    vmax2=pks(2);
    pmax2=locs(2);
end

end