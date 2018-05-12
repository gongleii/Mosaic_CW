































function [ result ] = getTileAvgs(tiles, nBlocks)


[height, width, colors, numTiles] = size(tiles);

if (nBlocks < 1) error('nBlocks must be greater than 0.'); end;
if (nBlocks > round(height)) error('nBlocks must be less than (height of tile).'); end;
if (nBlocks > round(width)) error('nBlocks must be less than (width of tile).'); end;
if ((nBlocks - floor(nBlocks)) ~= 0) error('nBlocks must be an integer.'); end;

result = zeros(nBlocks,nBlocks, numTiles, 3);
		
blockIndexes = floor(linspace(0, width, nBlocks+1));

for n = 1:numTiles
	for i = 1:length(blockIndexes)-1
		for j = 1:length(blockIndexes)-1
            for m = 1:colors
                result(i,j, n, m) = mean2(tiles(blockIndexes(i)+1:blockIndexes(i+1), blockIndexes(j)+1:blockIndexes(j+1), m, n));                
            end
		end
	end			
end	
	