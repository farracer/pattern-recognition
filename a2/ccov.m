function a=ccov(x,y)
%calculate the cov between two column vectors
    
    if (size(x) ~= size(y))
        error ('x and y should be same size')
    end
        
    
    m_x=cmean(x);
    m_y=cmean(y);
    
    a = 1/length(x)*(x-m_x)'*(y-m_y);
    
 
    end