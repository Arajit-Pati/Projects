function tanInv = i_tan(x, y)
    %to find the polar angle corresponding to a specific (x,y) coordinate
    %pair
    if x ~= 0
        tanInv = atand(y / x) + 90;
    else
        tanInv = 90;
    end
end
