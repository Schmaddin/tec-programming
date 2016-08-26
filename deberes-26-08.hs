-------- NEWTON

absolut::Double->Double
absolut x = if (x<0) then -x
                     else x
					 
newtonApp::Double->Double->Double
newtonApp y x = if(absolut((y * y)-x)<0.001) then y
								    else newtonApp ((y + x / y) / 2) x
								 
newton::(Double)->Double
newton x = if(x<=0) then -1.0
			        else newtonApp 1.0 x
			

------

quickSort::[Double]->[Double]
quickSort [] = []
quickSort [x] = [x]
quickSort list = quickSort(left(tail list,head list)) ++ [head list] ++ quickSort(right(tail list,head list))

left::([Double],Double)->[Double]
left ([],x) = []
left ([y],x) = if y < x then [y]
               else []
left (liste,x) = if head liste < x then [head liste] ++ left (tail liste,x)
                 else left(tail liste, x)
			   

right::([Double],Double)->[Double]
right ([],x) = []
right ([y],x) = if y >= x then [y]
              else []
right (liste,x) = if head liste >= x then [head liste] ++ right (tail liste,x)
                else right (tail liste, x)
  