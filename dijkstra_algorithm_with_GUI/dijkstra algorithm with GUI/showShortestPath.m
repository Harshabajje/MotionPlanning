function [cost rute]=showShortestPath(graph,xy,s,d)

[cost rute]=dijkstra(graph,s,d);
if(cost ~= inf)
    EL=[0];
    index=size(rute,2);
    for i=1:size(rute,2)
        EL(1,index)=rute(1,i);
        index=index-1;
    end
    for i=1 : (size(EL,2)-1)
        drawarrow(xy(EL(1,i),1),xy(EL(1,i+1),1),xy(EL(1,i),2),xy(EL(1,i+1),2),1);
    end
end