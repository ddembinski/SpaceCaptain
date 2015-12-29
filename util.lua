--various functions useful in other programs

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

--returns x-axis vector of prev_ to cur_, given two sets of coordinates
function get_vector_x(prev_x, prev_y, cur_x, cur_y)
	vector_x = cur_x - prev_x
	vector_y = cur_y - prev_y
	vector_hyp = math.sqrt((vector_x*vector_x) + (vector_y*vector_y))
	vector_x = vector_x / vector_hyp
	return vector_x
end