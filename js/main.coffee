`window.requestAnimFrame = (function(){
      return  window.requestAnimationFrame       || 
              window.webkitRequestAnimationFrame || 
              window.mozRequestAnimationFrame    || 
              window.oRequestAnimationFrame      || 
              window.msRequestAnimationFrame     || 
              function(/* function */ callback, /* DOMElement */ element){
                window.setTimeout(callback, 1000 / 60);
              };
    })();
`


main = 
	init:->
		@fire 	= @$ 'fire-boiling'
		@cover 	= @$ 'cover-boiling'
		@water 	= @$ 'water-boiling'

		@waterHeight = parseInt(@water.getAttribute('height'), 10) + .75
		@waterY 		 = parseInt(@water.getAttribute('y'), 10)

		@fireVariables()

		@animationLoop null, @


	fireVariables:->
		@top 		= 30.808
		@bottom 	= 27.988

		vector = @top - @bottom

		stepCount 	= 8
		@step 			= vector/stepCount

		@currTop 		= @bottom
		@currBottom = @top
		@direction1 = false
		@direction2 = false

	$:(id)-> document.getElementById id

	getRand:(min,max)->
		Math.floor((Math.random() * ((max + 1) - min)) + min)

	animateFire:->
		if !@direction1
			if @currTop <= @top
				@currTop += @step
			else @direction1 = true
		else
			if @currTop >= @bottom
				@currTop -= @step
			else @direction1 = false

		if !@direction2
			if @currBottom >= @bottom
				@currBottom -= @step
			else @direction2 = true
		else 
			if @currBottom <= @top
				@currBottom += @step
			else @direction2 = false


		@fire.setAttribute 'points', """
												
												23,#{@top-1} 
												21.804,#{@currTop}
												18.985,#{@currBottom}
												16.134,#{@currTop}
												13.284,#{@currBottom}
												10.404,#{@currTop}
												9,#{@top-1}

												"""


	animate:->
		@animateFire()

	animationLoop:(time)->
		@animate()
		requestAnimFrame(@animationLoop.bind(@))

main.init()






$fire 	= $('#fire-path')
$cover 	= $('#cover')
$water 	= $('#water')

waterHeight = parseInt($water.attr('height'), 10) + .75
waterY 			= parseInt($water.attr('y'), 10)

step = .05
setInterval =>
	waterHeight = waterHeight-step
	waterY = waterY+step
	$water.attr 'y', 			waterY
	$water.attr 'height', waterHeight
, 20

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
, 2

setInterval =>

	$cover.attr 'transform', "rotate(#{main.getRand(-4,4)},16,2)"

, 20

