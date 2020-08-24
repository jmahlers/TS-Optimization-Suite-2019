
% Re-number connectivity matrix after node delete %

nodeDeleted = 5;

Con=[ 1  2 1 1; 1  3 1 1; 1  8 1 1; 1  6 1 1; 1  5 1 1; 2  5 1 1; 2  4 1 1; 2  7 1 1; 2  9 1 1; 3  4 1 1;
      3  8 1 1; 3 21 1 1; 3 13 1 1; 4  9 1 1; 4 22 1 1; 4 14 1 1; 5  7 1 1; 5  6 1 1; 6  8 1 1; 6 10 1 1;
      6 11 1 1; 7 11 1 1; 7 12 1 1; 7  9 1 1; 8 10 1 1; 8 17 1 1; 8 13 1 1; 9 12 1 1; 9 18 1 1; 9 14 1 1;
     10 11 1 1;10 15 1 1;10 17 1 1;11 12 1 1;11 16 1 1;11 15 1 1;12 16 1 1;12 18 1 1;13 17 1 1;13 19 1 1;
     13 21 1 1;14 18 1 1;14 20 1 1;14 22 1 1;15 17 1 1;15 24 1 1;15 23 1 1;16 18 1 1;16 25 1 1;16 24 1 1;
     17 19 1 1;17 23 1 1;17 26 1 1;18 27 1 1;18 25 1 1;18 20 1 1;19 26 1 1;19 21 1 1;20 22 1 1;20 27 1 1;
     21 22 1 1;21 26 1 1;22 27 1 1;23 26 1 1;23 61 1 1;23 28 1 1;23 24 1 1;24 25 1 1;24 29 1 1;24 28 1 1;
     25 27 1 1;25 29 1 1;25 62 1 1;26 61 1 1;26 30 1 1;27 62 1 1;27 31 1 1;28 61 1 1;28 29 1 1;28 30 1 1;  
     28 42 1 1;28 44 1 1;29 62 1 1;29 31 1 1;29 43 1 1;29 45 1 1;30 61 1 1;30 44 1 1;30 40 1 1;30 32 1 1;     
     30 38 1 1;31 62 1 1;31 33 1 1;31 39 1 1;31 41 1 1;31 45 1 1;32 38 1 1;32 34 1 1;33 39 1 1;33 35 1 1;     
     34 44 1 1;34 36 1 1;35 45 1 1;35 37 1 1;36 37 1 1;38 39 1 1;38 40 1 1;39 41 1 1;42 44 1 1;42 50 1 1;    
     42 46 1 1;42 55 1 1;43 45 1 1;43 47 1 1;43 51 1 1;44 52 1 1;44 48 1 1;44 58 1 1;44 50 1 1;45 51 1 1;    
     45 59 1 1;45 49 1 1;45 53 1 1;46 50 1 1;47 55 1 1;47 51 1 1;48 52 1 1;48 54 1 1;49 54 1 1;49 53 1 1;     
     50 58 1 1;50 56 1 1;51 57 1 1;51 59 1 1;52 58 1 1;52 54 1 1;53 54 1 1;53 59 1 1;54 59 1 1;54 58 1 1;
     55 57 1 1;56 58 1 1;56 60 1 1;57 60 1 1;57 59 1 1;58 60 1 1;58 59 1 1;59 60 1 1;
   %      1         2         3         4         5         6         7         8        9          0 
  
   % Tubes to simulate engine block
     40 41 1 1;40 46 1 1;40 47 1 1;40 48 1 1;40 49 1 1;
     41 46 1 1;41 47 1 1;41 48 1 1;41 49 1 1;
     46 47 1 1;46 48 1 1;46 49 1 1;
     47 48 1 1;47 49 1 1;
     48 49 1 1];


for i=1:length(Con)
    for j=1:4
        if Con(i,j) == nodeDeleted
            Con(i,j) = nan;
        else
            if Con(i,j) > nodeDeleted
            Con(i,j) = Con(i,j) - 1;
            end
        end
    end
end

Con