h = 
	getRand:(min,max)->
		Math.floor((Math.random() * ((max + 1) - min)) + min)

# $cover = $('#cover')
# setInterval ->
# 	$cover.attr 'transform', "rotate(#{h.getRand(-5,5)},16,2)"
# , 10


$fire 	= $('#fire-path')
$cover 	= $('#cover')

top 		= 30.808
bottom 	= 27.988

setInterval =>
	$fire.attr 'points', """
											
											24.714,#{top} 
											21.804,#{bottom}
											18.985,#{top}
											16.134,#{bottom}
											13.284,#{top}
											10.404,#{bottom}
											7.583,#{top}

											"""
	buf = top
	top = bottom
	bottom = buf
, 250

setInterval =>

	$cover.attr 'transform', "rotate(#{h.getRand(-4,4)},16,2)"

, 20

