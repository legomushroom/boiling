h = 
	getRand:(min,max)->
		Math.floor((Math.random() * ((max + 1) - min)) + min)

# $cover = $('#cover')
# setInterval ->
# 	$cover.attr 'transform', "rotate(#{h.getRand(-5,5)},16,2)"
# , 10


$fire 	= $('#fire-path')
$cover 	= $('#cover')
$water 	= $('#water')

waterHeight = parseInt($water.attr('height'), 10) + .75
waterY 			= parseInt($water.attr('y'), 10)

console.log waterHeight, waterY

setInterval =>
	waterHeight = waterHeight-1
	waterY = waterY+1
	$water.attr 'y', 			waterY
	$water.attr 'height', waterHeight
, 100

top 		= 30.808
bottom 	= 27.988

vector1 = top - bottom
vector2 = bottom - top

stepCount = 20
step1 		= vector1/stepCount

dir1 = false
dir2 = false
currTop = bottom
currBottom = top
setInterval =>
	if !dir1
		if currTop <= top
			currTop += step1
		else dir1 = true
	else
		if currTop >= bottom
			currTop -= step1
		else dir1 = false

	if !dir2
		if currBottom >= bottom
			currBottom -= step1
		else dir2 = true
	else 
		if currBottom <= top
			currBottom += step1
		else dir2 = false


	$fire.attr 'points', """
											
											23,#{top-1} 
											21.804,#{currTop}
											18.985,#{currBottom}
											16.134,#{currTop}
											13.284,#{currBottom}
											10.404,#{currTop}
											9,#{top-1}

											"""
	# buf = top
	# top = bottom
	# bottom = buf
, 5

setInterval =>

	$cover.attr 'transform', "rotate(#{h.getRand(-4,4)},16,2)"

, 20

